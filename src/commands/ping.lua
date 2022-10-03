local Command = {
    Name = "ping"
}

function Command:Execute(Discordia, Client, Message, Arguments)
    print(Discordia.Date:toSeconds())
end

return Command
