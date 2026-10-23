-- Disposable photo profile only. Reveal loaded scenery in the native renderer;
-- no vehicle, object placement, texture or gameplay payload is edited.
local p=assert(getPlayer())
if OnlyKI5GalleryReveal then Events.OnRenderTick.Remove(OnlyKI5GalleryReveal) end
OnlyKI5GalleryReveal=nil
assert(OnlyKI5PhotoView.enable(),'The owned native photo viewport must enable visibility')
assert(p:isSeeEveryone(),'Native photo visibility option was not enabled')
getDebugOptions():getOptionByName('FBORenderChunk.NoLighting'):setValue(true)
return {photoVisibilityReveal=true,vehiclesChanged=false}
