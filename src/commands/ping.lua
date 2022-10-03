local command = {
    name = "ping",
    description = "the funny",
    category = "Misc",
    cooldown = 0
}

function command:execute(discordia, client, message, arguments)
    message:reply("Pong!")
end

return command
