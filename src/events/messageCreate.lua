--[[
    Author: LuauProgrammer
    Date: 10/2/2022
    Script: messageCreate.lua
]]

--//Libraries

local timer = require("timer")

--//Main

local function cooldown(client, commandName, userId, guildId) --//Basic function remove command cooldown
	if client._cooldowns[guildId] then --//double check
		client._cooldowns[guildId][commandName][userId] = nil
	end
end

local function getPermissions(user, permissions) --//Checks if the player has the required permissions
	if #permissions > 0 then --//Make sure permissions actually exist for said command
		local userPermissions = {}
		for _, permission in ipairs(permissions) do
			if user:hasPermission(permission) then
				if not permissions.requireAll then --//If they only need one premission, skip the rest of the loop and return true
					return true
				else
					table.insert(userPermissions, permission) --//Otherwise, we'll insert that into our user permissions table for comparison later
				end
			end
		end
		if #userPermissions < #permissions then
			return false
		end
	end
	return true
end

return function(discordia, client, message) --//Main command handler
	if message.guild then
		local arguments = message.content:split(" ") --//Split the string for analysis
		if message.author ~= client.user and arguments[1]:startswith(client._configuration.prefix) then --//Check if the string starts with our predetermined prefix
			local commandName = arguments[1]:lower():sub(2)
			table.remove(arguments, 1) --//Remove the command name from our arguments table.
			if client._commands[commandName] then --//Ensure the command exists.
				if not client._cooldowns[message.guild.id] then
					client._cooldowns[message.guild.id] = {} --//Initialize cooldown table for guilds.
					for commandName in pairs(client._commands) do
						client._cooldowns[message.guild.id][commandName] = {}
					end
				end
				if not client._cooldowns[message.guild.id][commandName][message.author.id] then --//Make sure they aren't on a cooldown.
					if
						getPermissions(
							message.guild:getMember(message.author),
							client._commands[commandName].permissions
						) or message.author == client.owner
					then --//bypass if bot owner.
						client._cooldowns[message.guild.id][commandName][message.author.id] = true
						timer.setTimeout(
							client._commands[commandName].cooldown * 1000,
							cooldown,
							client,
							commandName,
							message.author.id,
							message.guild.id
						) --//set timeout for cooldown
						client._commands[commandName]:execute(discordia, client, message, arguments)
					else
						message:reply(
							message.author.mentionString
								.. ", You are lacking the appropriate permissions to run this command!"
						)
					end
				else
					message:reply(message.author.mentionString .. ", A little too quick there.")
				end
			end
		end
	end
end
