import java.lang.reflect.*;

/** Read-only installed-build API evidence; does not create a world or spawn content. */
public final class NativeWorldContractCheck {
    private static Class<?> type(String name) throws Exception {
        return switch (name) {
            case "int" -> int.class; case "float" -> float.class; case "boolean" -> boolean.class;
            case "String" -> String.class; case "Integer" -> Integer.class;
            default -> Class.forName(name, false, NativeWorldContractCheck.class.getClassLoader());
        };
    }
    private static int checks;
    private static void method(String owner, String name, String... args) throws Exception {
        Class<?>[] parameters = new Class<?>[args.length];
        for (int i = 0; i < args.length; i++) parameters[i] = type(args[i]);
        type(owner).getMethod(name, parameters);
        checks++;
    }
    public static void main(String[] args) throws Exception {
        String sq = "zombie.iso.IsoGridSquare", zone = "zombie.iso.zones.Zone";
        String vehicle = "zombie.vehicles.BaseVehicle", chunk = "zombie.iso.IsoChunk";
        String table = "se.krka.kahlua.vm.KahluaTable";
        String world = "zombie.randomizedWorld.RandomizedWorldBase";
        type(world).getConstructor();
        method(world, "addVehicle", zone, "float", "float", "float", "float",
               "String", "String", "Integer", "String");
        method(world, "addVehicleFlipped", zone, "float", "float", "float", "float",
               "String", "String", "Integer", "String");
        method(world, "addTrailer", vehicle, zone, chunk, "String", "String", "String");
        method(world, "addZombiesOnVehicle", "int", "String", "Integer", vehicle);
        method(world, "createRandomDeadBody", sq, "zombie.iso.IsoDirections", "boolean",
               "int", "int", "String", "Integer");
        method(world, "addTileObject", sq, "zombie.iso.IsoObject", "boolean");
        method("zombie.iso.IsoWorld", "registerVehiclesZone",
               "String", "String", "int", "int", "int", "int", "int", table);
        method(chunk, "isNewChunk"); method(chunk, "getGridSquare", "int", "int", "int");
        method("zombie.Lua.LuaManager$GlobalObject", "getChunkSizeInSquares");
        for (String name : new String[]{"getModData", "isVehicleIntersecting", "isWaterSquare",
                                       "getBuilding", "getChunk", "getZone"})
            method(sq, name);
        method(sq, "addFloor", "String");
        method(sq, "AddWorldInventoryItem", "String", "float", "float", "float");
        method("zombie.iso.IsoDirections", "ToVector");
        method("zombie.iso.Vector2", "getDirection");
        for (String name : new String[]{"getAngleX", "getAngleY", "getAngleZ", "isCreated"})
            method(vehicle, name);
        method(vehicle, "setAngles", "float", "float", "float");
        method(vehicle, "hasLightbar");
        method(vehicle, "setLightbarLightsMode", "int");
        method("zombie.inventory.ItemPickerJava", "getItemContainer",
               "String", "String", "String", "boolean");
        method("zombie.inventory.ItemPickerJava", "rollItem",
               "zombie.inventory.ItemPickerJava$ItemPickerContainer",
               "zombie.inventory.ItemContainer", "boolean", "zombie.characters.IsoGameCharacter",
               "zombie.inventory.ItemPickerJava$ItemPickerRoom");
        method("zombie.inventory.ItemContainer", "isEmpty");
        method("zombie.iso.zones.Zone", "setLastActionTimestamp", "int");
        method("zombie.iso.zones.Zone", "isRectangle");
        System.out.println("PASS: " + checks + " installed-build native world API signatures; no game world modified.");
    }
}
