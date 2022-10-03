--[[
    Author: LuauProgrammer
    Date: 10/2/2022
    Script: commandHandler.lua
]]

--//Libraries

local FileSystem = require("fs")

--//Main

return function(Discordia, Client)
    for _, FileName in ipairs(FileSystem.readdirSync("./src/commands/")) do
        if FileName:endswith(".lua") then
            local Module = require("../commands/" .. FileName)
            local Type = type(Module)
            assert(Type == "table", "Expected table, got " .. Type)
            assert(Module.Execute and Module.Name, "Missing Execute or Name from command table")
            Client._commands[Module.Name] = Module
        end
    end
end
