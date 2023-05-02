#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH" 
#INCLUDE "RWMAKE.CH" 
#INCLUDE "COLORS.CH"
#DEFINE ENTER Chr(13)+Chr(10) 

/*/{Protheus.doc}ENCMA530
Encapsulamento da rotina padrão MATA530 para gerar os pedidos de compra referente aos 
vendedores autonomos...
Utilizado para gerar os pedidos de compras conforme variavel de controle aPedidCmp
Exclusividade DMB Bombas. 
type function
@author Leonardo Alves - Mais Consultoria
@since 29/03/19
@version 1.0
@return 
/*/ 
User Function ENCMA530()
/************************************************************************
*
*
*****/

Private aPedidCmp := {} 

//Rotina Padrão Atualização da comissão
MATA530()                                          

Pergunte("MTA530",.F.)
If(Len(aPedidCmp) > 0)
	Processa({||FGerarSC7(aPedidCmp)},"Gerando Pedidos de Compra. Comissão de vendedores.","Aguarde...")	
EndIf

Return



/*/{Protheus.doc}M530AGL
Este ponto de entrada e executado ao final do processamento da rotina (MATA530) 
que atualiza a data para pagamento das comissões dos Vendedores.
Utilizado para gerar os pedidos de compras conforme variavel de controle aPedidCmp
Exclusividade DMB Bombas. 
type function
@author Leonardo Alves - Mais Consultoria
@since 06/11/18
@version 1.0
@return 
/*/ 
User Function M530AGL()
/************************************************************************
*
*
*****/

Local lRetornar := .F. //Não aglutina....  
Local nXi          
Local aDadosPed := {}
Local aAreasOld := GetArea()
Local aAreasSE2 := SE2->(GetArea())
Local aAreasSA2 := SA2->(GetArea())
Local aAreasSA3 := SA3->(GetArea())
Local aAreasSB1 := SB1->(GetArea())
Local nRegistro := 0        
Local cCodVende := SE3->E3_VEND

If(!GetNewPar("MC_M530AGL",.T.))
	Return	
EndIf

If(Mv_Par07 == 1) //Gera Financeiro igual a sim, não gera pedido de compras.
	Return
EndIf

SA3->(dbSetOrder(1))
SA3->(dbSeek(xFilial("SA3")+cCodVende))
If(!SA3->(Eof())) 
	If(SA3->A3_GERASE2 == "S" .And. !Empty(SA3->A3_FORNECE)) 
		nRegistro := Ascan(aPedidCmp,{|x|x[1] == SA3->A3_FORNECE})
		If(nRegistro == 0)	
			Aadd(aPedidCmp,{SA3->A3_FORNECE,SA3->A3_LOJA,SA3->A3_COD,SE3->E3_FILIAL})	
		EndIf	
	EndIf
EndIf

RestArea(aAreasOld)
RestArea(aAreasSE2)
RestArea(aAreasSA2)
RestArea(aAreasSA3)        
RestArea(aAreasSB1)        

Return(lRetornar)



/*/{Protheus.doc}FGerarSC7
Rotina para gerar o pedido de compras para os titulos gerados.
Exclusividade DMB Bombas. 
type function
@author Leonardo Alves - Mais Consultoria
@since 28/01/19
@version 1.0
@return 
/*/ 
Static Function FGerarSC7(aDadosPed)
/************************************************************************
*
*
*****/

Local aCabecSC7 := {}
Local aItensSC7 := {}
Local aLinhaSC7 := {}
Local aPediComp := {}
Local cQueryExc := ""       
Local cNumPedid := ""                       
Local cVendedor := ""
Local lGravouC7 := .F.
Local cCodProdu := AllTrim(GetNewPar("MC_PRDCOMI","SV000000000005"))
Local cCondPaga := AllTrim(GetNewPar("MC_CNDCOMI","001"))
Local cCodUsr		:= RetCodUsr()
Local nXi

Private lMsHelpAuto := .F.
Private lMsErroAuto := .F.

Default aDadosPed := {}

If(Len(aDadosPed)==0)
	Return
EndIf

Procregua(Len(aDadosPed))	
For nXi:= 1 To Len(aDadosPed) 			
    IncProc()    
    nValorTit := FBuscaTIT(aDadosPed[nXi,3])
    If(nValorTit == 0)
		Loop    
    EndIf
    
	cNumPedid := fNumPedCmp(aDadosPed[nXi,4])	
	If(Empty(cNumPedid))
		cNumPedid := StrZero(1,TamSx3("C7_NUM")[1])
	EndIf
	cObservac := "PED.AUTO.COMIS.VEND. "+aDadosPed[nXi,3]	
	cVendedor := aDadosPed[nXi,3]	
	
	SA2->(dbSetOrder(1))
	SA2->(dbSeek(xFilial("SA2")+aDadosPed[nXi,1]+aDadosPed[nXi,2]))
	
	SB1->(dbSetOrder(1))	                                                                                                
	SB1->(dbSeek(xFilial("SB1")+cCodProdu))       

    If(GetNewPar("MC_SC7AUTO",.F.))
		aCabecSC7 := {}                  	
		Aadd(aCabecSC7,{"C7_FILIAL"  ,aDadosPed[nXi,4]})  	              
		Aadd(aCabecSC7,{"C7_FILENT"  ,aDadosPed[nXi,4]})
		Aadd(aCabecSC7,{"C7_NUM"     ,cNumPedid})  
		Aadd(aCabecSC7,{"C7_EMISSAO" ,dDataBase}) 
		Aadd(aCabecSC7,{"C7_FORNECE" ,SA2->A2_COD}) 
		Aadd(aCabecSC7,{"C7_LOJA"    ,SA2->A2_LOJA}) 
		Aadd(aCabecSC7,{"C7_TXMOEDA" ,1})
		Aadd(aCabecSC7,{"C7_MOEDA"   ,1})			 
		Aadd(aCabecSC7,{"C7_COND"    ,"001"})			
					                                                    		
		aLinhaSC7 := {}	
		aLinhaSC7 := {{"C7_ITEM"        ,StrZero(1,TamSx3("C7_ITEM")[1]) ,Nil},;
		              {"C7_PRODUTO"     ,SB1->B1_COD        ,Nil},;    
		              {"C7_UM"          ,SB1->B1_UM         ,Nil},;             
		              {"C7_DESCRI"      ,SB1->B1_DESC       ,Nil},;
		              {"C7_QUANT"       ,1                  ,Nil},;
		              {"C7_PRECO"       ,Round(nValorTit,2) ,Nil},;
		              {"C7_TOTAL"       ,Round(nValorTit,2) ,Nil},;
		              {"C7_LOCAL"       ,"01"               ,Nil},;    	                 
		              {"C7_OBS"         ,cObservac          ,Nil},; 	                  
		              {"C7_CONAPRO"     ,"L"                ,Nil},; 		              
		              {"C7_USER"        ,cCodUsr        		,Nil},; 
		              {"C7_FLUXO"       ,"S"                ,Nil},;		              		              		              
		              {"C7_DATPRF"      ,dDataBase          ,Nil}}                  
		 
		Aadd(aItensSC7,aLinhaSC7)                               
		lMsErroAuto := .F.                    
		MSExecAuto({|v,w,x,y| MATA120(v,w,x,y)},1,aCabecSC7,aItensSC7,3)
		If(lMSErroAuto)   
			MostraErro()
			DisarmTransaction()
			RollBackSX8()  
		Else  
			ConfirmSX8() 
			//Atualiza o SE3 com o numero do pedido de compras gerado.
			cQueryExc := "UPDATE "+RetSqlName("SE3")+" SET E3_ZNUMPED = '"+cNumPedid+"'" 
			cQueryExc += " WHERE D_E_L_E_T_ = ''"
			cQueryExc += " AND E3_VEND = '"+cVendedor+"'"  
			cQueryExc += " AND E3_ZNUMPED = ''"
			cQueryExc += " AND E3_EMISSAO >= '"+DTos(Mv_Par02)+"' AND E3_EMISSAO <='"+DTos(Mv_Par03)+"'"
			cQueryExc += " AND E3_VENCTO >= '"+DTos(Mv_Par10)+"' AND E3_VENCTO <='"+DTos(Mv_Par11)+"'"
			If(Mv_Par13 == 1)
				cQueryExc += " AND E3_FILIAL >= '"+Mv_Par14+"' AND E3_FILIAL <= '"+Mv_Par15+"'"
			Else
				cQueryExc += " AND E3_FILIAL = '"+xFilial("SE3")+"'"		
			EndIf		
			TcCommit(1,ProcName())    //Begin Transaction	
			If(TcSQLExec(cQueryExc) < 0)
				MsgInfo("ErrAo na gravação do numero do pedido de compras."+ENTER+"Favor informar a TI enviando o print da mensagem a seguir.")
				MsgStop("SE3 - TCSQLError() " + TcSQLError())
				TcCommit(3) //RollBack
			 	TcCommit(4) //End Transaction
			Else                                           
				aAdd(aPediComp,{cNumPedid, SA2->A2_COD+" - "+AllTrim(SA2->A2_NOME),nValorTit, aDadosPed[nXi,3]})              	    
			 	TcCommit(2,ProcName())    //Commit
			 	TcCommit(4)               //End Transaction
			EndIf		  	
		EndIf	
	Else  //Erro de SigaAuto MATA120 (precisa atualizar), quando atulizar habilitar o parametro MC_SC7AUTO no configurador  
		dbSelectArea("SC7")
		dbSetOrder(1)
		dbSeek(aDadosPed[nXi,4]+cNumPedid)
		If(SC7->(Eof()))
		    RecLock("SC7",.T.)
			Replace C7_FILIAL   With aDadosPed[nXi,4]
			Replace C7_FILENT   With aDadosPed[nXi,4]
			Replace C7_NUM      With cNumPedid
			Replace C7_EMISSAO  With dDataBase
			Replace C7_FORNECE  With SA2->A2_COD
			Replace C7_LOJA     With SA2->A2_LOJA
			Replace C7_TXMOEDA  With 1
			Replace C7_MOEDA    With 1
			Replace C7_COND     With "001" 					                                                    		
			Replace C7_ITEM     With StrZero(1,TamSx3("C7_ITEM")[1])
			Replace C7_PRODUTO  With SB1->B1_COD      
			Replace C7_UM       With SB1->B1_UM                
			Replace C7_DESCRI   With SB1->B1_DESC    
			Replace C7_QUANT    With 1               
			Replace C7_PRECO    With Round(nValorTit,2) 
			Replace C7_TOTAL    With Round(nValorTit,2) 
			Replace C7_LOCAL    With "01"             	                 
			Replace C7_OBS      With cObservac       
			Replace C7_DATPRF   With dDataBase       
			Replace C7_CONAPRO  With "L" 
			Replace C7_USER     With cCodUsr
			Replace C7_FLUXO    With "S"  
			SC7->(MsUnLock())
			lGravouC7 := .T.
		Else
			lGravouC7 := .F.		
		EndIf
		If(lGravouC7) 
			//Atualiza o SE3 com o numero do pedido de compras gerado.
			cQueryExc := "UPDATE "+RetSqlName("SE3")+" SET E3_ZNUMPED = '"+cNumPedid+"'" 
			cQueryExc += " WHERE D_E_L_E_T_ = ''"
			cQueryExc += " AND E3_VEND = '"+cVendedor+"'"  
			cQueryExc += " AND E3_ZNUMPED = ''"
			cQueryExc += " AND E3_EMISSAO >= '"+DTos(Mv_Par02)+"' AND E3_EMISSAO <='"+DTos(Mv_Par03)+"'"
			cQueryExc += " AND E3_VENCTO >= '"+DTos(Mv_Par10)+"' AND E3_VENCTO <='"+DTos(Mv_Par11)+"'"
			If(Mv_Par13 == 1)
				cQueryExc += " AND E3_FILIAL >= '"+Mv_Par14+"' AND E3_FILIAL <= '"+Mv_Par15+"'"
			Else
				cQueryExc += " AND E3_FILIAL = '"+xFilial("SE3")+"'"		
			EndIf		
			TcCommit(1,ProcName())    //Begin Transaction	
			If(TcSQLExec(cQueryExc) < 0)
				MsgInfo("ErrAo na gravação do numero do pedido de compras."+ENTER+"Favor informar a TI enviando o print da mensagem a seguir.")
				MsgStop("SE3 - TCSQLError() " + TcSQLError())
				TcCommit(3) //RollBack
			 	TcCommit(4) //End Transaction
			Else                                           
				aAdd(aPediComp,{cNumPedid, SA2->A2_COD+" - "+AllTrim(SA2->A2_NOME),nValorTit, aDadosPed[nXi,3]})              	    
			 	TcCommit(2,ProcName())    //Commit
			 	TcCommit(4)               //End Transaction
			EndIf		  	
		EndIf
	EndIf		
	
Next nXi	

If(Len(aPediComp)>0)
	IMPEDCOM(aPediComp)
EndIf	

Return



/*/{Protheus.doc}FBuscaTIT
Retornar o valor do SE3
Exclusividade DMB
type function
@author Leonardo Alves
@since 28/01/19
@version 1.0
@return nenhum
/*/ 
Static Function FBuscaTIT(cVendedor)
/************************************************************************
*
*
*****/

Local nRetornar := 0
Local cQueryExc := ""

cQueryExc := "SELECT COALESCE(SUM(E3_COMIS),0) AS COMISSAO FROM "+RetSqlName("SE3")+" WITH (NOLOCK)"
cQueryExc += " WHERE D_E_L_E_T_ = ''"
cQueryExc += " AND E3_VEND = '"+cVendedor+"'"  
cQueryExc += " AND E3_ZNUMPED = ''"
cQueryExc += " AND E3_EMISSAO >= '"+DTos(Mv_Par02)+"' AND E3_EMISSAO <='"+DTos(Mv_Par03)+"'"
cQueryExc += " AND E3_VENCTO >= '"+DTos(Mv_Par10)+"' AND E3_VENCTO <='"+DTos(Mv_Par11)+"'"
If(Mv_Par13 == 1)
	cQueryExc += " AND E3_FILIAL >= '"+Mv_Par14+"' AND E3_FILIAL <= '"+Mv_Par15+"'"
Else
	cQueryExc += " AND E3_FILIAL = '"+xFilial("SE3")+"'"		
EndIf
If(Select("TRBSE3") <> 0)
	TRBSE3->(dbCloseArea())	
EndIf            
TcQuery cQueryExc New Alias "TRBSE3" 
nRetornar := TRBSE3->COMISSAO

If(Select("TRBSE3") <> 0)
	TRBSE3->(dbCloseArea())	
EndIf

Return(nRetornar)



/*/{Protheus.doc}IMPEDCOM
Relatorio de pedidos de compras gerados via calculo de comissão
Exclusividade DMB
type function
@author Leonardo Alves
@since 28/01/19
@version 1.0
@return nenhum
/*/  
Static Function IMPEDCOM(aDadosRel)
/************************************************************************
*
*
*****/                             			

Local oReport
Local aAreasOld := GetArea()

Default aDadosRel := {}          

If(Len(aDadosRel) <> 0)
	oReport := ReportDef(aDadosRel)
	oReport:PrintDialog()
EndIf                                          

RestArea(aAreasOld)

Return



Static Function ReportDef(aDadosRel)
/************************************************************************
*
*                       
*****/                 

Local nXi
Local oReport                                              
Local oSecDetal                                        

oReport := TReport():New("IMPEDCOM","Pedidos de compras gerados via comissão de vendas.","",{|oReport| PrintReport(oReport,aDadosRel)},"Este relatorio irá imprimir Pedidos de compras gerados via calculo comissão vendas. Versão do relatório: 1.0")	
//Detalhes
oSecDetal := TRSection():New(oReport,OemToAnsi("Pedido de Compra"),Nil)	
TRCell():New(oSecDetal,"PEDIDO"    ,"" ,"Nº. Pedido"   ,"",TamSx3("C7_NUM")[1])
TRCell():New(oSecDetal,"FORNECE"   ,"" ,"Fornecedor"   ,"",TamSx3("A2_NOME")[1])
TRCell():New(oSecDetal,"VALORPC"   ,"" ,"Valor PC"     ,"",TamSx3("C7_TOTAL")[1])  
TRCell():New(oSecDetal,"VENDEDO"   ,"" ,"Vendedor"     ,"",TamSx3("A3_NREDUZ")[1]) 
                                                                                 
Return(oReport)



Static Function PrintReport(oReport,aDadosRel)
/************************************************************************
*Imprime Relatório
*                       
*****/                 

Local oSecDetal	:= oReport:Section(1) 
Local nXi 
 
nQtdRegis := Len(aDadosRel)
If(nQtdRegis >0)   	
	oReport:SetMeter(nQtdRegis)		
	//Detalhes
	oSecDetal:Init()
	oSecDetal:lAutoSize := .T.
	oSecDetal:PrintLine()   	 		
	For nXi := 1 To Len(aDadosRel)
		oReport:IncMeter()
		If(oReport:Cancel())
			Exit                                                                 
		EndIf                                                                    
		oSecDetal:Cell("PEDIDO"):SetValue(aDadosRel[nXi,1])         
		oSecDetal:Cell("FORNECE"):SetValue(aDadosRel[nXi,2])         
		oSecDetal:Cell("VALORPC"):SetValue(aDadosRel[nXi,3])         
		oSecDetal:Cell("VENDEDO"):SetValue(Posicione("SA3",1,xFilial("SA3")+aDadosRel[nXi,4],"A3_NREDUZ"))		
		oSecDetal:PrintLine()  			
	Next nXi			
	oSecDetal:Finish()	 	
EndIf

Return



Static Function fNumPedCmp(cCodFilia)
/************************************************************************
*
*                       
*****/                 

Local cRetornar := ""
Local cQueryExc := ""

cQueryExc := "SELECT MAX(C7_NUM) NUM_PC FROM "+RetSqlName("SC7")
cQueryExc += " WHERE D_E_L_E_T_ = ''"
cQueryExc += " AND C7_FILIAL = '"+cCodFilia+"'" 
If(Select("TEMPC7") <> 0)
	TEMPC7->(dbCloseArea())	
EndIf                     
TcQuery cQueryExc New Alias "TEMPC7"
If(Select("TEMPC7") <> 0) 
	cRetornar := Soma1(Iif(ValType(TEMPC7->NUM_PC)<>"C",AllTrim(Str(TEMPC7->NUM_PC)),TEMPC7->NUM_PC))
	While(!MayIUseCode("SC7"+xFilial("SC7")+cRetornar))    
	  cRetornar := Soma1(cRetornar)
	EndDo   
	TEMPC7->(dbCloseArea())	
EndIf       
              
Return(cRetornar)
