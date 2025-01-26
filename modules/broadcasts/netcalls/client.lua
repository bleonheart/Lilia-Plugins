﻿net.Receive("factionbroadcast_client", function()
    local nick = net.ReadString()
    local message = net.ReadString()
    local factionListSimple = net.ReadTable()
    chat.AddText(Color(200, 200, 100), L("factionBroadcastLabel"), Color(255, 255, 255), ": ", Color(180, 180, 100), nick, Color(255, 255, 255), ": ", message)
    chat.AddText(Color(200, 200, 100), L("factionBroadcastLabel"), Color(255, 255, 255), ": ", string.format(L("factionBroadcastSentTo"), table.concat(factionListSimple, ", ")))
end)

net.Receive("classbroadcast_client", function()
    local nick = net.ReadString()
    local message = net.ReadString()
    local classListSimple = net.ReadTable()
    chat.AddText(Color(200, 200, 100), L("classBroadcastLabel"), Color(255, 255, 255), ": ", Color(180, 180, 100), nick, Color(255, 255, 255), ": ", message)
    chat.AddText(Color(200, 200, 100), L("classBroadcastLabel"), Color(255, 255, 255), ": ", string.format(L("classBroadcastSentTo"), table.concat(classListSimple, ", ")))
end)
