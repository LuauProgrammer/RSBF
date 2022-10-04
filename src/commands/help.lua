local command = {
    name = "help",
    description = "Get all command info.",
    category = "Misc",
    cooldown = 0
}

function command:execute(discordia, client, message, arguments)
    local categories = {}
    local embed = {
        title = "Commands",
        fields = {},
    }
    for _, commandModule in pairs(client._commands) do
        if not categories[commandModule.category] then
            categories[commandModule.category] = ""
        end
        categories[commandModule.category] = categories[commandModule.category] .. "\n\n**Name:** " ..
            commandModule.name ..
            "\n**Cooldown:** " ..
            commandModule.cooldown .. " Seconds" .. "\n**Description:** " .. commandModule.description
    end
    for category, field in pairs(categories) do
        table.insert(embed.fields, {
            name = category,
            value = field,
            inline = false
        })
    end
    message:reply { embed = embed }
end

return command
