#INCLUDE "PROTHEUS.CH"
    
User Function TestClient()
Local oSvc := NIL
      
oSvc := WSSERVERTIME():New()

If oSvc:GETSERVERTIME()
	alert('Horário no Servidor : '+ oSvc:cGETSERVERTIMERESULT)
 Else
	alert('Erro de Execução : '+GetWSCError())
  Endif
     
Return