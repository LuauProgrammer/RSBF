# Really Simple Bot Framework (RSBF)

Simple bot framework written in lua using discordia. Do I recommend this over Discord.js? No, but if you have no other option, this is your best bet. This uses luvit, so if you don't have that installed, head over to [luvit's website](https://luvit.io/install.html) and install it.

## Installation (easy lol)

**Clone Repository:**
``git clone https://github.com/LuauProgrammer/RSBF.git || cd RSBF``

**Download Dependencies:**
``lit install``

**OR:** Download from zip.

## Configuration

You'll find that in the config.json file there are a few variables you can change. Here's what they all do.

```json
{
    "token": "" , (Your bots token)
    "prefix": "+", (The prefix to use commands)
    "presence": { (Bot presence, I myself barely understand this so figure this out on your own lmao)
        "status": "idle",
        "game": {
            "name": "with you",
            "type": 0
        }
    }
}
```

## Injected Client Variables

``_commands`` - Dictionary containing all commands and their contents.

``_utilities`` - Modules loaded from the utility directory for ease of access.

``_cooldowns`` - Dictionary containing all the guilds and their respective command cooldowns.

``_configuration`` - Literally config.json but easier to access.

## Commands

Command creation is very simple. I've gone ahead and provided two example commands in the commands folder.

They must all follow a structure like this:

```lua
local command = {
    name = "<Command Name>",
    description = "<Description>", --Optional
    usage = "<Command Usage>", --Optional
    category = "<Category>", --Optional, but commands without it won't be shown when running help unless they're specified in the first argument.
    cooldown = "<Cooldown, in seconds>"
    permissions = {
        requireAll = false,
    }
}

function command:execute(discordia, client, message, arguments)

end

return command
```

## Utilities

A cool feature I added was utilities. You can build your own modules and access them from ``_utilities`` without having to require them. It's not super important but its something I like to do when I program bots in JS.

## Events & Handlers

Kinda self explanatory but you can create your own handlers and create event files which the bot will connect to and call whenever an event is omitted.

Like the commands, they must have a structure like this:

```lua
return function(discordia, client)

end
```

## Disclaimer

I made this in about a day so I probably made mistakes here and there. Opening issues & pull requests is always appreciated.
