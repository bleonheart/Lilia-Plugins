﻿lia.command.add("classbroadcast", {
    adminOnly = false,
    syntax = "<string text>",
    onRun = function(client, arguments)
        local message = table.concat(arguments, " ", 1)
        if not message then return L("classBroadcastInvalidArgument") end
        if not client:getChar():hasFlags("D") and not client:hasPrivilege("Staff Permissions - Can Use Class Broadcast") then
            client:notify(L("classBroadcastNoPermission"))
            return false
        end

        local options = {}
        for _, class in pairs(lia.class.list) do
            table.insert(options, class.name .. " (" .. class.uniqueID .. ")")
        end

        client:requestOptions(L("classBroadcastTitle"), L("selectClassesPrompt"), options, #options, function(selectedOptions)
            local classList = {}
            local classListSimple = {}
            for _, v in ipairs(selectedOptions) do
                local uniqueID = v:match("%((.-)%)")
                for m, n in pairs(lia.class.list) do
                    if n.uniqueID == uniqueID then
                        classList[m] = n.name
                        table.insert(classListSimple, n.name)
                    end
                end
            end

            if table.Count(classList) == 0 then
                client:notify(L("classBroadcastNoValidClasses"))
                return
            end

            for _, ply in player.Iterator() do
                if ply == client or (ply:getChar() and classList[ply:getChar():getClass()]) then
                    net.Start("classbroadcast_client")
                    net.WriteString(client:Nick())
                    net.WriteString(message)
                    net.WriteTable(classListSimple)
                    net.Send(ply)
                end
            end

            client:notify(L("classBroadcastSent"))
        end)
    end
})

lia.command.add("factionbroadcast", {
    adminOnly = false,
    syntax = "<string text>",
    onRun = function(client, arguments)
        local message = table.concat(arguments, " ", 1)
        if not message then return L("factionBroadcastInvalidArgument") end
        if not client:getChar():hasFlags("B") and not client:hasPrivilege("Staff Permissions - Can Use Faction Broadcast") then
            client:notify(L("factionBroadcastNoPermission"))
            return false
        end

        local options = {}
        for _, faction in pairs(lia.faction.indices) do
            table.insert(options, faction.name .. " (" .. faction.uniqueID .. ")")
        end

        client:requestOptions(L("factionBroadcastTitle"), L("selectFactionsPrompt"), options, #options, function(selectedOptions)
            local factionList = {}
            local factionListSimple = {}
            for _, v in ipairs(selectedOptions) do
                local uniqueID = v:match("%((.-)%)")
                for m, n in pairs(lia.faction.indices) do
                    if n.uniqueID == uniqueID then
                        factionList[m] = n.name
                        table.insert(factionListSimple, n.name)
                    end
                end
            end

            if table.Count(factionList) == 0 then
                client:notify(L("factionBroadcastNoValidFactions"))
                return
            end

            for _, ply in player.Iterator() do
                if ply == client or (ply:getChar() and factionList[ply:getChar():getFaction()]) then
                    net.Start("factionbroadcast_client")
                    net.WriteString(client:Nick())
                    net.WriteString(message)
                    net.WriteTable(factionListSimple)
                    net.Send(ply)
                end
            end

            client:notify(L("factionBroadcastSent"))
        end)
    end
})
