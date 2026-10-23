import java.nio.file.Files;
import java.nio.file.Path;
import zombie.ZomboidFileSystem;
import zombie.core.znet.SteamWorkshopItem;

/** Shared read-only uploader check. Does not initialize Steam, create or upload an item. */
public final class ValidateWorkshopStage {
    public static void main(String[] args) throws Exception {
        if (args.length != 5)
            throw new IllegalArgumentException("stage cache game expectedModId expectedVisibility");
        Path stage = Path.of(args[0]).toAbsolutePath().normalize();
        ZomboidFileSystem.instance.setCacheDir(args[1]);
        ZomboidFileSystem.instance.base.set(Path.of(args[2]).toFile());
        if (!Files.isRegularFile(stage.resolve("workshop.txt")))
            throw new IllegalStateException("Missing workshop.txt");
        SteamWorkshopItem item = new SteamWorkshopItem(stage.toString());
        if (!item.readWorkshopTxt() || item.getTitle().isBlank() || item.getDescription().isBlank())
            throw new IllegalStateException("Unreadable Workshop metadata");
        String error = item.validateContents();
        if (error != null) throw new IllegalStateException("Native uploader rejected content: " + error);
        if (!item.getSubmitDescription().contains("Mod ID: " + args[3]))
            throw new IllegalStateException("Native uploader did not discover expected mod: " + args[3]);
        if (!item.getVisibility().equals(args[4]))
            throw new IllegalStateException("Unexpected visibility: " + item.getVisibility());
        System.out.println("PASS native uploader metadata, preview, content and mod ID: " + item.getTitle());
        System.out.println("Visibility: " + item.getVisibility() + "; Mod ID: " + args[3]);
    }
}
