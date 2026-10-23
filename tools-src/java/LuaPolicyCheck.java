import java.nio.file.*;
import java.lang.reflect.*;
import java.util.*;

/** Executes production Lua with mocked game services; not a native gameplay test. */
public final class LuaPolicyCheck {
    public static void main(String[] args) throws Exception {
        Path lua = Path.of(args[0]);
        StringBuilder code = new StringBuilder("loaders = {}; loaded = {}; function require(n) if loaded[n] then return loaded[n] end; assert(loaders[n], n); local v = loaders[n](); loaded[n] = v or true; return loaded[n] end\n");
        String order = args.length > 2 ? args[2] : "native";
        if (!Set.of("native", "ascending", "descending").contains(order)) throw new IllegalArgumentException(order);
        code.append("ONLY_KI5_TEST_ZONE_ORDER = \"").append(order).append("\"\n");
        String trafficShape = args.length > 3 ? args[3] : "shared";
        if (!Set.of("shared", "copied", "singleplayer", "client").contains(trafficShape)) throw new IllegalArgumentException(trafficShape);
        code.append("ONLY_KI5_TEST_TRAFFIC_SHAPE = \"").append(trafficShape).append("\"\n");
        try (var paths = Files.walk(lua)) {
            for (Path path : paths.filter(p -> p.toString().endsWith(".lua")).toList()) {
                String name = path.getFileName().toString().replace(".lua", "");
                if (!name.startsWith("OnlyKI5VehicleSpawnLiveryOverhaul_")) continue;
                code.append("loaders[\"").append(name).append("\"] = function()\n")
                    .append(Files.readString(path)).append("\nend\n");
            }
        }
        code.append(Files.readString(Path.of(args[1])));
        Class<?> platformType = Class.forName("se.krka.kahlua.vm.Platform");
        Class<?> tableType = Class.forName("se.krka.kahlua.vm.KahluaTable");
        Class<?> platformImpl = Class.forName("se.krka.kahlua.j2se.J2SEPlatform");
        Object platform = platformImpl.getMethod("getInstance").invoke(null);
        Object env = platformImpl.getMethod("newEnvironment").invoke(platform);
        Class<?> compiler = Class.forName("se.krka.kahlua.luaj.compiler.LuaCompiler");
        Object closure = compiler.getMethod("loadstring", String.class, String.class, tableType)
            .invoke(null, code.toString(), "only-ki5-policy-check", env);
        Class<?> threadType = Class.forName("se.krka.kahlua.vm.KahluaThread");
        Object thread = threadType.getConstructor(platformType, tableType).newInstance(platform, env);
        Field owner = threadType.getDeclaredField("debugOwnerThread");
        owner.setAccessible(true);
        owner.set(thread, Thread.currentThread());
        Object[] result = (Object[]) threadType.getMethod("pcall", Object.class, Object[].class)
            .invoke(thread, closure, new Object[0]);
        if (!Boolean.TRUE.equals(result[0])) throw new AssertionError(Arrays.toString(result));
        System.out.println("PASS: production Lua policy callback regression checks (mocked game services, " + order + " zone order, " + trafficShape + " highway table).");
    }
}
