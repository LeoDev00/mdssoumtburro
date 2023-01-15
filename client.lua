screenW, screenH = guiGetScreenSize()
x, y = (screenW/1366), (screenH/768)
renderTgt = dxCreateRenderTarget(x * 873, y * 241, true)
local font = dxCreateFont("files/Roboto-Regular.ttf", y * 8)
local font2 = dxCreateFont("files/Roboto-Regular.ttf", y * 10)
local texto = createElement("dxEditChatSystem")
local tick = getTickCount()
tablepos = {}
posx = {}
for i=0, 9 do 
    tablepos[i] = (27 + (i-1) * 120)
end 




function dxDraw()
    dxDrawImage(x * 296, y * 246, x * 883, y * 247, 'files/base.png')
    dxSetRenderTarget(renderTgt, true)
    for i,v in ipairs(tableitens) do
        if i <= #tablepos then 
            if i ~= 1 then 
                if not animation1 then 
                    posx[i] = interpolateBetween(tablepos[i], 0, 0, tablepos[i-1], 0, 0, ((getTickCount() - tick) / config.TimerAnimacao), (animation3 and "OutBack" or "InBack"))
                    setTimer(
                    function ()
                        animation1 = true
                    end, config.TimerAnimacao, 1
                    )
                else 
                    posx[i] = interpolateBetween(0, 0, 0, 120, 0, 0, ((getTickCount() - tick) / config.VelocidadeCaixas), "Linear")
                end 
                
                dxDrawImage(x * (animation1 and (tablepos[i] - (posx[i])) - 10 or  posx[i] - 10), y * 80, x * 115, y * 115, "files/"..v[2]..".png")
                dxDrawImage(x *  (animation1 and (tablepos[i] - (posx[i])) or  posx[i]), y * 91, x * 95, y * 93, v[1])
            else 
                if not animation2 then 
                    posx[i] = interpolateBetween(tablepos[i], 0, 0, -100, 0, 0, ((getTickCount() - tick) / config.TimerAnimacao), (animation3 and "OutBack" or "InBack"))
                    setTimer(
                    function ()
                        animation2 = true
                    end, config.TimerAnimacao, 1
                    )
                else 
                    posx[i] = interpolateBetween(0, 0, 0, 120, 0, 0, ((getTickCount() - tick) / config.VelocidadeCaixas), "Linear")
                end  

                dxDrawImage(x * (animation1 and (tablepos[i] - (posx[i])) - 10 or  posx[i] - 10) , y * 80, x * 115, y * 115, "files/"..v[2]..".png")
                dxDrawImage(x * (animation1 and (tablepos[i] - (posx[i]))  or  posx[i]), y * 91, x * 95, y * 93, v[1])
            end 
        end 
    end 
    dxSetRenderTarget()
    dxDrawImage(x * 296+5, y * 246, x * 873, y * 241, renderTgt)
end 

function iniciarRoleta()
    if not isEventHandlerAdded("onClientRender", root, dxDraw) then 
        local comumChance = 60
        local raroChance = 24.2
        local epicoChance = 14.4
        local lendarioChance = 0.9
        local heroicoChance = 0.5
        local sorteio = math.random(0.5, 100)
        tableitens = {

            ---------------------------ITENS COMUNS----------------------------------------------------------------
            {":[HS]Inventory_system_2/nui/Itens/pizza.png", "comum", "pizza", "Pizza", 1, comumChance},

            ---------------------------ITENS RAROS-----------------------------------------------------------------
            {":[HS]Inventory_system_2/nui/Itens/kit_reparo.png", "raro", "kit_reparo", "Kit de Reparo", 3, comumChance + raroChance},

            ---------------------------ITENS EPICO-----------------------------------------------------------------
            {":[HS]Inventory_system_2/nui/Itens/ak-47.png", "epico", "ak-47", "Fuzil AK 47", 1000, comumChance + raroChance + epicoChance},

            ---------------------------ITENS LENDARIOS-------------------------------------------------------------
            {":[HS]Inventory_system_2/nui/Itens/dinheiro_sujo.png", "lendario", "dinheiro_sujo", "Dinheiro Sujo", 3000, comumChance + raroChance + epicoChance + lendarioChance},
            ---------------------------ITENS HEROICOS--------------------------------------------------------------
            {":[HS]Inventory_system_2/nui/Itens/dinheiro_sujo.png", "lendario", "dinheiro_sujo", "Dinheiro Sujo", 10000, comumChance + raroChance + epicoChance + lendarioChance + heroicoChance},
      
			--{"diretorio da imagem", "Tipo raro epico etc", "nome img do item", "Nome exibição", quantidade, chance},			
        }
        addEventHandler("onClientRender", root, dxDraw)
        
        randomtimer = math.random(config.TimerMin, config.TimerMax)

    setTimer(
        function()
            newtable = {}
                    local sorteio = math.random(0.5, 100)
                    local itemSelecionado = {}
                    for i,v in ipairs(tableitens) do 
                        if sorteio <= v[6] then
                            itemSelecionado = v
                            break
                        end
                    end
                    
                    tick = getTickCount()
            TimerCaixa = setTimer(
                function ()  
                    newtable = {}
                    local sorteio = math.random(0.5, 100)
                    local itemSelecionado = {}
                    for i,v in ipairs(tableitens) do 
                        if sorteio <= v[6] then
                            itemSelecionado = v
                            break
                        end
                    end
                    
                    local _,  quantidade = getTimerDetails(TimerCaixa)
                    if quantidade == 1 then 
                        triggerServerEvent("MeloSCR:GivePlayerItem", localPlayer, localPlayer, itemSelecionado[2], itemSelecionado[3], itemSelecionado[4], itemSelecionado[5])
                        animation1 = false
                        animation2 = false 
                        animation3 = true 
                        setTimer(
                            function  ()
                                iniciarRoleta()
                            end, 3000, 1
                        )
                        
                    end     
                    tick = getTickCount()
                end, config.VelocidadeCaixas, randomtimer
            )
        end, config.TimerAnimacao, 1)
    else 
        removeEventHandler("onClientRender", root, dxDraw)
    end 
end 
addEvent("MeloSCR:ExecuteMisteryBox", true)
addEventHandler("MeloSCR:ExecuteMisteryBox", root, iniciarRoleta)


----------------------------------------------------------------------------------------
function isMouseInPosition ( x, y, width, height )
    if ( not isCursorShowing ( ) ) then
        return false
    end

    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end


function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
    if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
        local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
        if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
            for i, v in ipairs( aAttachedFunctions ) do
                if v == func then
                    return true
                end
            end
        end
    end
    return false
end
