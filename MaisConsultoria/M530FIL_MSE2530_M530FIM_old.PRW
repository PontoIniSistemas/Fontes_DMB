#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH" 
#INCLUDE "RWMAKE.CH" 
#INCLUDE "COLORS.CH"
#DEFINE ENTER Chr(13)+Chr(10) 

/*/{Protheus.doc}M530FIL
O ponto de entrada M530FIL existe na função fa530Processa e será disparado para filtrar os vendedores conforme os parâmetros dos clientes.
Utilizado para criar a variavel de controle publica aPedidCmp 
Exclusividade DMB Bombas. 
type function
@author Leonardo Alves - Mais Consultoria
@since 28/01/19
@version 1.0
@return 
/*/  
User Function M530FIL()
/************************************************************************
*
*
*****/
Local cRetornar := ""

If(!GetNewPar("MC_M530FIM",.T.))
	Return
EndIf

Public aPedidCmp := {}

Return(cRetornar)
                 
    

/*/{Protheus.doc}MSE2530
Ponto de entrada está localizado na função fa530Proce (Atualiza a Data de Pagamento da Comissão dos Vendedores). 
É chamado antes da atualização do arquivo SE2 (Contas a Pagar) e antes da atualização dos Lançamentos Contábeis.
Utilizado para gravar informações dos titulos gerados no SE2 na variavel de controle aPedidCmp 
Exclusividade DMB Bombas. 
type function
@author Leonardo Alves - Mais Consultoria
@since 28/01/19
@version 1.0
@return 
/*/ 
User Function MSE2530()
/************************************************************************
*
*
*****/

If(!GetNewPar("MC_M530FIM",.T.))
	Return
EndIf

If(SA3->A3_GERASE2 == "S" .And. !Empty(SA3->A3_FORNECE)) 
	Aadd(aPedidCmp,{cNumero,cPrefixo,SA3->A3_FORNECE,SA3->A3_LOJA,SA3->A3_COD})	
EndIf                                             

Return
    


/*/{Protheus.doc}M530FIM
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
User Function M530FIM()
/************************************************************************
*
*
*****/

Local nXi          
Local aDadosPed := {}
Local aAreasOld := GetArea()
Local aAreasSE2 := SE2->(GetArea())
Local aAreasSA2 := SA2->(GetArea())
Local aAreasSA3 := SA3->(GetArea())
Local aAreasSB1 := SB1->(GetArea())

Default aPedidCmp := {}

If(!GetNewPar("MC_M530FIM",.T.))
	Return
EndIf

aDadosPed := aClone(aPedidCmp) 
aPedidCmp := Nil //Liberar a variavel
If(Len(aDadosPed) >0)
	Processa({||FGerarSC7(aDadosPed)},"Gerando Pedidos de Compra. Comissão de vendedores.","Aguarde...")	
EndIf   

RestArea(aAreasOld)
RestArea(aAreasSE2)
RestArea(aAreasSA2)
RestArea(aAreasSA3)        
RestArea(aAreasSB1)        

Return



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
Local aPediComp := {}
       
Local cNumPedid := ""
Local cCodProdu := AllTrim(GetNewPar("MC_PRDCOMI","SV000000000005"))
Local cCondPaga := AllTrim(GetNewPar("MC_CNDCOMI","001"))

Private lMsHelpAuto := .F.
Private lMsErroAuto := .F.

Default aDadosPed := {}

If(Len(aDadosPed)==0)
	Return
EndIf

Procregua(Len(aDadosPed))	
For nXi:= 1 To Len(aDadosPed) 			
    IncProc()    
    nValorTit := FBuscaTIT(AClone(aDadosPed[nXi]))
    If(nValorTit == 0)
		Loop    
    EndIf
    
	cNumPedid := GetSx8Num("SC7","C7_NUM")
	While(!MayIUseCode("SC7"+xFilial("SC7")+cNumPedid))    
	  cNumPedid := Soma1(cNumPedid)
	EndDo   
	
	SA2->(dbSetOrder(1))
	SA2->(dbSeek(xFilial("SA2")+aDadosPed[nXi,3]+aDadosPed[nXi,4]))
	aCabecSC7 := {}
	aCabecSC7 := {{"C7_NUM"         , cNumPedid    ,Nil},;
	              {"C7_EMISSAO"     , dDataBase    ,Nil},;
	              {"C7_FORNECE"     , SA2->A2_COD  ,Nil},;
	              {"C7_LOJA"        , SA2->A2_LOJA ,Nil},;
	              {"C7_COND"        , cCondPaga    ,Nil},;
	              {"C7_TXMOEDA"     , 1.00         ,Nil},; 
	              {"C7_CONTATO"     ,""            ,Nil},;
	              {"C7_MOEDA"       ,1             ,Nil}}    
	                                                     
	SB1->(dbSetOrder(1))	                                                                                                
	SB1->(dbSeek(xFilial("SB1")+cCodProdu))       
	
	cObservac := "PED.AUTO.COMIS.VEND. "+aDadosPed[nXi,5]	
	aItensSC7 := {}	
	aItensSC7 := {{"C7_ITEM"        ,"0001"             ,Nil},;
	              {"C7_PRODUTO"     ,SB1->B1_COD        ,Nil},;    
	              {"C7_UM"          ,SB1->B1_UM         ,Nil},;             
	              {"C7_DESCRI"      ,SB1->B1_DESC       ,Nil},;
	              {"C7_QUANT"       ,1                  ,Nil},;
	              {"C7_PRECO"       ,Round(nValorTit,2) ,Nil},;
	              {"C7_TOTAL"       ,Round(nValorTit,2) ,Nil},;
	              {"C7_LOCAL"       ,"01"               ,Nil},;    	                 
	              {"C7_OBS"         ,cObservac          ,Nil},; 	               
	              {"C7_DATPRF"      ,dDataBase          ,Nil},;	              
	              {"C7_EMISSAO"     ,dDataBase          ,Nil},;
	              {"C7_MOEDA"       ,1                  ,Nil}}                  
                               
	lMsErroAuto := .F.                    
	MATA120(1,aCabecSC7,aItensSC7,3)
	If(lMSErroAuto)   
		MostraErro()
		DisarmTransaction()
		RollBackSX8()  
	Else    
		aAdd(aPediComp,{cNumPedid, SA2->A2_COD+" - "+AllTrim(SA2->A2_NOME),nValorTit, aDadosPed[nXi,1], aDadosPed[nXi,2], aDadosPed[nXi,5]})              	    
		ConfirmSX8() 
	EndIf
Next nXi	

If(Len(aPediComp)>0)

EndIf	

Return



/*/{Protheus.doc}FBuscaTIT
Retornar o valor do titulo no SE2
Exclusividade DMB
type function
@author Leonardo Alves
@since 28/01/19
@version 1.0
@return nenhum
/*/ 
Static Function FBuscaTIT(aDadosTit)
/************************************************************************
*
*
*****/

Local nRetornar := 0
Local cQueryExc := ""

cQueryExc := "SELECT E2_VALOR AS VALOR FROM "+RetSqlName("SE2")+" WITH (NOLOCK)"
cQueryExc += " WHERE D_E_L_E_T_ = ''"
cQueryExc += " AND E2_FILIAL = '"+xFilial("SE2")+"'"
cQueryExc += " AND E2_NUM = '"+aDadosTit[1]+"'"
cQueryExc += " AND E2_PREFIXO = '"+aDadosTit[2]+"'"
cQueryExc += " AND E2_FORNECE = '"+aDadosTit[3]+"'"
cQueryExc += " AND E2_LOJA = '"+aDadosTit[4]+"'"
cQueryExc += " AND E2_EMISSAO = '"+DTos(dDataBase)+"'"
If(Select("TRBSE2") <> 0)
	TRBSE2->(dbCloseArea())	
EndIf
TcQuery cQueryExc New Alias "TRBSE2" 
nRetornar := TRBSE2->VALOR

If(Select("TRBSE2") <> 0)
	TRBSE2->(dbCloseArea())	
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
TRCell():New(oSecDetal,"TITULO"    ,"" ,"Num.Tit.CP"   ,"",TamSx3("E2_NUM")[1]) 
TRCell():New(oSecDetal,"PREFIX"    ,"" ,"Prefix. CP"   ,"",TamSx3("E2_PREFIXO")[1]) 
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
		oSecDetal:Cell("TITULO"):SetValue(aDadosRel[nXi,4])                  
		oSecDetal:Cell("PREFIX"):SetValue(aDadosRel[nXi,5])
		oSecDetal:Cell("VENDEDO"):SetValue(Posicione("SA3",1,xFilial("SA3")+aDadosRel[nXi,6],"A3_NREDUZ"))		
		oSecDetal:PrintLine()  			
	Next nXi			
	oSecDetal:Finish()	 	
EndIf

Return