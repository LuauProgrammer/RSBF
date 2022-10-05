local command = {
    name = "ping",
    description = "Ping Pong!",
    category = "Misc",
    cooldown = 0,
    permissions = {
        requireAll = false,
    }
}

function command:execute(discordia, client, message, arguments)
    message:reply("Pong!")
end

return command
