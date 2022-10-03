--[[
    Author: LuauProgrammer
    Date: 10/2/2022
    Script: commandHandler.lua
]]

--//Libraries

local fs = require("fs")

--//Main

return function(discordia, client)
    for _, fileName in ipairs(fs.readdirSync("./src/commands/")) do
        if fileName:endswith(".lua") then
            local module = require("../commands/" .. fileName)
            local type = type(module)
            assert(type == "table", "Expected table, got " .. type)
            assert(module.execute and module.name and module.cooldown,
                "Missing required fields from command table (ie: name, execute function, cooldown)") --//Bare-bones properties/functions needed to operate.
            client._commands[module.name] = module
        end
    end
end
