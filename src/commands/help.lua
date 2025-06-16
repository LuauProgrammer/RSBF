local command = {
	name = "help",
	usage = "<command name>",
	description = "Get all command info.",
	category = "Misc",
	cooldown = 0,
	permissions = {
		requireAll = false,
	},
}

local function tableToString(table) --//Converts a table to a string, seperated by commas.
	if #table > 0 then
		local string = table[1]
		for index, value in ipairs(table) do
			if index > 1 then
				string = string .. ", " .. value
			end
		end
		return string
	end
end

function command:execute(discordia, client, message, arguments)
	local asLower = arguments[1] and arguments[1]:lower()
	if asLower and not client._commands[asLower] then
		return message:reply("I could not find a command with the name ``" .. arguments[1] .. "``.")
	end
	local embed = {
		title = "Commands",
		fields = {},
	}
	if not arguments[1] then
		local categories = {}
		for _, commandModule in pairs(client._commands) do --//Search through existing commands
			if not command.category then
				return
			end
			if not categories[commandModule.category] then
				categories[commandModule.category] = ""
			end
			categories[commandModule.category] = categories[commandModule.category]
				.. "\n``"
				.. client._configuration.prefix
				.. commandModule.name
				.. " "
				.. (commandModule.usage or "")
				.. (commandModule.description and "`` - " .. commandModule.description or "")
		end
		for category, field in pairs(categories) do --//Seperate by category
			table.insert(embed.fields, {
				name = category,
				value = field,
				inline = false,
			})
		end
	else
		local commandModule = client._commands[asLower]
		embed.title = commandModule.name
		embed.description = commandModule.description or nil
		embed.fields = {
			commandModule.usage and {
				name = "Usage",
				value = "``"
					.. client._configuration.prefix
					.. commandModule.name
					.. " "
					.. commandModule.usage
					.. "``",
				inline = true,
			} or nil,
			commandModule.cooldown > 0 and {
				name = "Cooldown",
				value = commandModule.cooldown .. " Seconds",
				inline = true,
			} or nil,
			#commandModule.permissions > 0 and {
				name = "Permissions",
				value = tableToString(commandModule.Permissions),
				inline = true,
			} or nil,
		}
	end
	message:reply({ embed = embed })
end

return command
