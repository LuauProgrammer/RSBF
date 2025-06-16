--[[
    Author: LuauProgrammer
    Date: 10/2/2022
    Script: commandHandler.lua
]]

--//Libraries

local fs = require("fs")

--//Main

return function(discordia, client)
	for _, fileName in ipairs(fs.readdirSync("./src/commands/")) do --//Loop thru folder to check for commands
		if fileName:endswith(".lua") then
			local module = require("../commands/" .. fileName)
			local type = type(module)
			local lower = module.name:lower() --//Internally make these lowercase.
			assert(type == "table", "Expected table, got " .. type)
			assert(
				module.execute and module.name and module.cooldown and module.permissions,
				"Missing required fields from command table (ie: name, execute function, permissions,  cooldown)"
			) --//Bare-bones properties/functions needed to operate.
			assert(not client._commands[lower], "Duplicate commands are not allowed.") --//Ensure duplicates do not persist
			client._commands[lower] = module
		end
	end
end
