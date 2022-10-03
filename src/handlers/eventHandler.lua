--[[
    Author: LuauProgrammer
    Date: 10/2/2022
    Script: eventHandler.lua
]]

--//Libraries

local FileSystem = require("fs")

--//Main

return function(Discordia, Client)
    for _, FileName in ipairs(FileSystem.readdirSync("./src/events/")) do
        if FileName:endswith(".lua") then
            local Module = require("../events/" .. FileName)
            local Type = type(Module)
            assert(Type == "function", "Expected function, got " .. Type)
            Client:on(FileName:match("(.+)%..+$"), function(...)
                Module(Discordia, Client, ...) --//Cannot directly pass in the function as we need to pass in the client and discordia.
            end)
        end
    end
end
