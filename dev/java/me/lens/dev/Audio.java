package me.lens.dev;

import fmod.javafmod;
import me.zed_0xff.zombie_buddy.Exposer;
import zombie.core.Core;
import zombie.SoundManager;
import zombie.vehicles.BaseVehicle;

/** Test-only native audio inspection. Never included in the player mod. */
@Exposer.LuaClass(name = "OnlyKI5NativeAudio")
public final class Audio {
    private static boolean exposed;
    private Audio() {}

    public static void expose() {
        if (!exposed && zombie.Lua.LuaManager.env != null) {
            Exposer.exposeClass(Audio.class);
            exposed = true;
        }
    }

    /** Mute the output bus before enabling native game audio event processing. */
    public static String enableMutedProbe() {
        long bus = javafmod.FMOD_Studio_System_GetBus("bus:/");
        if (bus == 0 || javafmod.FMOD_Studio_Bus_SetMute(bus, true) != 0
                || !javafmod.FMOD_Studio_Bus_GetMute(bus)) {
            throw new IllegalStateException("Native master output bus was not muted");
        }
        Core.getInstance().setOptionSoundVolume(10);
        SoundManager.instance.setSoundVolume(1f);
        return status();
    }

    public static String status() {
        long bus = javafmod.FMOD_Studio_System_GetBus("bus:/");
        return "{\"masterMuted\":" + (bus != 0 && javafmod.FMOD_Studio_Bus_GetMute(bus))
            + ",\"soundDisabled\":" + Core.soundDisabled
            + ",\"soundVolume\":" + Core.getInstance().getOptionSoundVolume() + "}";
    }

    public static String inspect(BaseVehicle vehicle) {
        var sounds = vehicle.getVehicleSounds();
        var emitter = vehicle.getVehicleSoundEmitter();
        return "{\"managerPresent\":" + (sounds != null)
            + ",\"sirenSounding\":" + (sounds != null && sounds.isSirenSounding())
            + ",\"emitterEmpty\":" + (emitter == null || emitter.isEmpty()) + "}";
    }
}
