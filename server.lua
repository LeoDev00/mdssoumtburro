addEvent("MeloSCR:GivePlayerItem", true)
addEventHandler("MeloSCR:GivePlayerItem", root, 
function (player, raridade, NomeItem, RealName, Quantidade)
    --triggerEvent('Schootz.giveItem', thePlayer, thePlayer, RealName, Quantidade)
	--exports['[HS]Inventory_system_2']:giveItem(player, Quantidade, 100, NomeItem, "none", false)
    exports['[HS]Inventory_system_2']:giveItem(player, NomeItem, Quantidade, 100, "none", false)
    --outputChatBox("O Player: "..getPlayerName(player).." Ganhou "..RealName.."("..Quantidade.."x) de raridade "..raridade, root, tocolor(255, 255, 255))
    outputMessage(root, "O Player: "..getPlayerName(player).." Ganhou "..RealName.."("..Quantidade.."x) de raridade "..raridade.."", "info")
end)

