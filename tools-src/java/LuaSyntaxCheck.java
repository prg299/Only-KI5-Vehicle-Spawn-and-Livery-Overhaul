import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.FileVisitResult;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.SimpleFileVisitor;
import java.nio.file.attribute.BasicFileAttributes;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.lang.reflect.Constructor;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;

/**
 * Compiles Lua sources with the same Kahlua compiler shipped by Project
 * Zomboid. It deliberately checks syntax only: game globals are unresolved at
 * compile time and need a hosted-game test.
 */
public final class LuaSyntaxCheck {
    private LuaSyntaxCheck() { }

    private static Object createEnvironment(Class<?> tableClass) throws Exception {
        Throwable lastError = null;
        StringBuilder signatures = new StringBuilder();
        for (Constructor<?> constructor : tableClass.getDeclaredConstructors()) {
            Class<?>[] parameterTypes = constructor.getParameterTypes();
            if (!signatures.isEmpty()) {
                signatures.append(", ");
            }
            signatures.append('(');
            for (int index = 0; index < parameterTypes.length; index++) {
                if (index > 0) {
                    signatures.append(", ");
                }
                signatures.append(parameterTypes[index].getTypeName());
            }
            signatures.append(')');
            Object[] arguments = new Object[parameterTypes.length];
            boolean supported = true;
            for (int index = 0; index < parameterTypes.length; index++) {
                Class<?> type = parameterTypes[index];
                if (type == int.class || type == short.class || type == byte.class || type == long.class) {
                    arguments[index] = 0;
                } else if (type == boolean.class) {
                    arguments[index] = false;
                } else if (type == float.class || type == double.class) {
                    arguments[index] = 0.0;
                } else if (Map.class.isAssignableFrom(type)) {
                    arguments[index] = new HashMap<>();
                } else {
                    supported = false;
                    break;
                }
            }
            if (!supported) {
                continue;
            }
            try {
                constructor.setAccessible(true);
                return constructor.newInstance(arguments);
            } catch (Throwable error) {
                lastError = error;
            }
        }
        throw new IllegalStateException("Could not create a Kahlua environment for syntax checking. Constructors: " + signatures, lastError);
    }

    public static void main(String[] args) throws Exception {
        if (args.length != 1) {
            System.err.println("Usage: LuaSyntaxCheck <lua-root>");
            System.exit(2);
        }

        Path root = Path.of(args[0]).toAbsolutePath().normalize();
        if (!Files.isDirectory(root)) {
            throw new IOException("Lua root is not a directory: " + root);
        }

        List<String> failures = new ArrayList<>();
        final int[] checked = {0};
        Class<?> compilerClass = Class.forName("se.krka.kahlua.luaj.compiler.LuaCompiler");
        Class<?> tableClass = Class.forName("se.krka.kahlua.j2se.KahluaTableImpl");
        Method loadString = null;
        for (Method method : compilerClass.getMethods()) {
            if (method.getName().equals("loadstring") && Modifier.isStatic(method.getModifiers()) && method.getParameterCount() == 3) {
                loadString = method;
                break;
            }
        }
        if (loadString == null) {
            throw new IllegalStateException("Project Zomboid's LuaCompiler.loadstring(String, String, KahluaTable) was not found.");
        }
        final Method compiler = loadString;
        Files.walkFileTree(root, new SimpleFileVisitor<>() {
            @Override
            public FileVisitResult visitFile(Path file, BasicFileAttributes attrs) throws IOException {
                if (!file.getFileName().toString().toLowerCase().endsWith(".lua")) {
                    return FileVisitResult.CONTINUE;
                }
                checked[0]++;
                try {
                    String source = Files.readString(file, StandardCharsets.UTF_8);
                    Object environment = createEnvironment(tableClass);
                    compiler.invoke(null, source, file.toString(), environment);
                } catch (Throwable error) {
                    failures.add(root.relativize(file) + ": " + error.getMessage());
                }
                return FileVisitResult.CONTINUE;
            }
        });

        if (!failures.isEmpty()) {
            System.err.println("Lua syntax failures:");
            failures.forEach(failure -> System.err.println("- " + failure));
            System.exit(1);
        }
        System.out.println("PASS: Project Zomboid Kahlua compiled " + checked[0] + " Lua files.");
    }
}
