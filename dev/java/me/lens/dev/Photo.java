package me.lens.dev;

import me.zed_0xff.zombie_buddy.Exposer;
import zombie.characters.CheatType;
import zombie.characters.IsoPlayer;
import zombie.core.Core;
import zombie.debug.DebugOptions;
import zombie.ui.UIManager;

/** Owned photo viewport only; never shipped or used for gameplay acceptance. */
@Exposer.LuaClass(name = "OnlyKI5PhotoView")
public final class Photo {
    private static boolean exposed;
    private Photo() {}
    public static void expose() {
        if (!exposed && zombie.Lua.LuaManager.env != null) {
            Exposer.exposeClass(Photo.class);
            exposed = true;
        }
    }
    public static boolean enable() {
        UIManager.setShowLuaDebuggerOnError(false);
        // Enable after normal boot, avoiding unrelated startup debug dialogs.
        Core.debug = true;
        DebugOptions.instance.cheat.player.seeEveryone.setValue(true);
        IsoPlayer player = IsoPlayer.getInstance();
        if (player == null) throw new IllegalStateException("Photo player is not loaded");
        player.getCheats().set(CheatType.CAN_SEE_EVERYONE, true);
        return player.isSeeEveryone() && player.canSeeAll();
    }
}
