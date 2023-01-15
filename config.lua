config = {
    VelocidadeCaixas = 50, 
    TimerAnimacao = 1000, 
    TimerMin = 50, 
    TimerMax = 100,
}

outputMessage = function(elem, mess, tipo)--- Função de exportação da sua notify.
    return exports["[HS]Notify_System"]:notify(elem, mess, tipo)
  end
