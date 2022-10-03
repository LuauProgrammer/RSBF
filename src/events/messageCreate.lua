--[[
    Author: LuauProgrammer
    Date: 10/2/2022
    Script: messageCreate.lua
]]

--//Main

return function(Discordia, Client, Message)
    local Arguments = Message.content:split(" ")
    if Message.author ~= Client.user and Arguments[1]:startswith(Client._configuration.Prefix) then
        local CommandName = Arguments[1]:lower():sub(2)
        table.remove(Arguments, 1)
        if Client._commands[CommandName] then
            Client._commands[CommandName]:Execute(Discordia, Client, Message, Arguments)
        end
    end
end
