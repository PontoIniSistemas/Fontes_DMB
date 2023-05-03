User Function MT116AGR()

/*/{Protheus.doc} MT116AGR
(Ponto de entrada para gravar os campos que não gravados diretamente via Execuato da rotina MATA116  )
/*/
If IsInCallStack("U_MTUFOPRO")
			                                                   						
	cQryExc :=" UPDATE "+RetSqlName("SF1")+" "+CHR(13)+CHR(10)
	cQryExc +=" SET F1_USUSMAR   = '"+cUserAbx+"',"+CHR(13)+CHR(10)		
	cQryExc +="    F1_EST     = '"+aCabec[aScan(aCabec,{|x| AllTrim(x[1]) == "F1_UFORITR"})][2]+"',"+CHR(13)+CHR(10)
	cQryExc +="    F1_UFORITR = '"+aCabec[aScan(aCabec,{|x| AllTrim(x[1]) == "F1_UFORITR"})][2]+"',"+CHR(13)+CHR(10)      
	cQryExc +="    F1_MUORITR = '"+aCabec[aScan(aCabec,{|x| AllTrim(x[1]) == "F1_MUORITR"})][2]+"',"+CHR(13)+CHR(10)      
	cQryExc +="    F1_UFDESTR = '"+aCabec[aScan(aCabec,{|x| AllTrim(x[1]) == "F1_UFDESTR"})][2]+"',"+CHR(13)+CHR(10)						
	cQryExc +="    F1_MUDESTR = '"+aCabec[aScan(aCabec,{|x| AllTrim(x[1]) == "F1_MUDESTR"})][2]+"',"+CHR(13)+CHR(10)		     
	cQryExc +="    F1_TPCTE   = '"+cTipCTE+"',"+CHR(13)+CHR(10)
	cQryExc +="    F1_CHVNFE  = '"+cCHVCTE+"',"+CHR(13)+CHR(10)
	cQryExc +="    F1_DTCPISS  = '"+Dtos(cDTCPiss)+"' "+CHR(13)+CHR(10)	
	cQryExc +=" WHERE F1_DOC = '"+cNFiscal+"'"+CHR(13)+CHR(10)		
	cQryExc +=" AND F1_SERIE = '"+cSerie+"'"+CHR(13)+CHR(10)			
	cQryExc +=" AND F1_FORNECE = '"+cA100For+"'"+CHR(13)+CHR(10)		
	cQryExc +=" AND F1_LOJA = '"+cLoja+"'"+CHR(13)+CHR(10)	  
	cQryExc +=" AND D_E_L_E_T_ <> '*'"+CHR(13)+CHR(10)
			
	If (TCSQLExec(cQryExc) < 0)		    	
		FWLogMsg("INFO",,"LOG",,,,"TCSQLError() " + TCSQLError(),,,)	
	EndIf
	      									
EndIf               

Return
