#INCLUDE "PROTHEUS.CH"
    
User Function TestClient()
Local oSvc := NIL
      
oSvc := WSSERVERTIME():New()

If oSvc:GETSERVERTIME()
	alert('Hor�rio no Servidor : '+ oSvc:cGETSERVERTIMERESULT)
 Else
	alert('Erro de Execu��o : '+GetWSCError())
  Endif
     
Return