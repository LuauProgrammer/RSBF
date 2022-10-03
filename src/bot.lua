--[[
    Author: LuauProgrammer
    Date: 10/2/2022
    Script: bot.lua
]]

--//Libraries

local JSON = require("json")
local Discordia = require('discordia')
local FileSystem = require("fs")

--//Variables

local Configuration = assert(io.open("./config.json", "r"))
local Client = Discordia.Client()

--//Get all useful extensions

Discordia.extensions()

--//Initialize client variables

Client._configuration = JSON.decode(Configuration:read("*all")) --//We can only use _configuration because for some reason it HAS to have a leading underscore.
Client._utilities = {}
Client._commands = {}

--//Load utilities

for _, FileName in ipairs(FileSystem.readdirSync("./src/utilities")) do --//FS is weird and we have to do ./src/utilities
    if FileName:endswith(".lua") then --//Only get lua files.
        Client._utilities[FileName] = require("./utilities/" .. FileName)
    end
end

--//Setup our handlers

for _, FileName in ipairs(FileSystem.readdirSync("./src/handlers")) do
    if FileName:endswith(".lua") then --//Again, only get lua files.
        local Module = require("./handlers/" .. FileName)
        local Type = type(Module)
        assert(Type == "function", "Expected function, got " .. Type)
        Module(Discordia, Client) --//These should ALWAYS be functions and not a table.
    end
end


--//Finish everything up

Configuration:close() --//Close our file.
Client:run('Bot ' .. Client._configuration.Token)
