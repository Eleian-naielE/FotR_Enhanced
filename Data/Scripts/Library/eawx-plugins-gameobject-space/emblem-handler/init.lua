require("deepcore/std/plugintargets")

return {
    type = "plugin",
    target = PluginTargets.never(),
    init = function(self, ctx)
        EmblemHandler = require("eawx-plugins-gameobject-space/emblem-handler/EmblemHandler")
        local unit_entry = ModContentLoader.get_object_script(Object.Get_Type().Get_Name())
        return EmblemHandler(unit_entry)
    end
}
