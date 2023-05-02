#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH" 
#INCLUDE "RWMAKE.CH" 
#INCLUDE "COLORS.CH"
#DEFINE ENTER Chr(13)+Chr(10) 

/*/{Protheus.doc}MCLIB001
Tela demostrativa de pedidos em atraso
Exclusividade DMB Bombas. 
type function
@author Leonardo Alves - Mais Consultoria
@since 06/11/18
@version 1.0
@return 
/*/  

User Function MCLIB001(cQueryExc)
/************************************************************************
*Tela demostrativa de pedidos compra ou venda em atraso
*
*****/

Local dDataEntr := CTod(Space(8)) 
Local nDayAtras := 0
Local aArrayBut := {} 
Local aPedidos  := {}
Local oFont := TFont():New("Arial",,-13,.T.)       
Local cVersiona := "1.1"
Local cRealease := "1.0.1"

Private oDlg4, oBrowser, oSay, oTMsgBar, oTMsgItem1, oTMsgItem2, oTMsgItem3  

Default cQueryExc := ""    

If(Empty(cQueryExc))
	Return
EndIf     
If(Select("TEMP")<>0)
	TEMP->(dbCloseArea())
EndIf                 
TcQuery cQueryExc New Alias "TEMP"

dbSelectArea("TEMP")
dbGoTop()
While(!Eof())        	                          
	dDataEntr := STod(TEMP->DTENTREGA) 
	nDayAtras := (dDataBase-dDataEntr)
	Aadd(aPedidos,{TEMP->NUMERO,TEMP->NOME,dDataEntr,nDayAtras})
	dbSelectArea("TEMP")
	dbSkip()	
EndDo  

Aadd(aArrayBut,{"HISTORIC",{||IMPATRASO(aPedidos)}, "Impressão Ped.Atraso", "Impressão Ped.Atraso" , {|| .T.}} )  
                                                            
If(Len(aPedidos)<>0)
	Define MSDialog oDlg4 Title OemToAnsi("Pedidos em Atraso") Style DS_MODALFRAME From 000,000 To 270,630 Pixel                         
	oDlg4:lEscClose := .F. 
	@ 005,005 Say oSay PROMPT "Pedidos em atraso" FONT oFont Color CLR_HBLUE Of oDlg4 Pixel  
	oSay:lTransparent:= .F. 	
	@ 035, 005 ListBox oListBox1 Var nListBox1 Fields, Header "PEDIDO","RAZAO SOCIAL","DT.ENTREGA","DIAS EM ATRASO" Size 310, 80 Of oDlg4  Pixel
	oListBox1:SetArray(aPedidos)
	oListBox1:bLine := {||{aPedidos[oListBox1:nAt][1],aPedidos[oListBox1:nAt][2],aPedidos[oListBox1:nAt][3],aPedidos[oListBox1:nAt][4]}} 
	oTMsgBar := TMsgBar():New(oDlg4,".",.F.,.F.,.F.,.F., RGB(116,116,116),,,.F.)      
	oTMsgItem1 := TMsgItem():New( oTMsgBar,"RELEASE "+cRealease, 100,,,,.T., {||} )       
	oTMsgItem2 := TMsgItem():New( oTMsgBar,"VERSÃO: "+cVersiona, 100,,,,.T., {||} ) 
	oTMsgItem3 := TMsgItem():New( oTMsgBar,MsDate(), 100,,,,.T., {||} ) 
	Activate MsDialog oDlg4 Centered  On Init EnchoiceBar(oDlg4,{||oDlg4:End()},{||oDlg4:End()},,aArrayBut)
EndIf

oDlg4 := Nil
                      
If(Select("TEMP")<>0)
	TEMP->(dbCloseArea())
EndIf                 

Return                                           



/*/{Protheus.doc}IMPATRASO
Relatorio de pedidos em atraso
Exclusividade DMB
type function
@author Leonardo Alves
@since 08/01/19
@version 1.0
@return nenhum
/*/  

Static Function IMPATRASO(aDadosRel)
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

oReport := TReport():New("IMPATRASO","Pedidos em atraso","",{|oReport| PrintReport(oReport,aDadosRel)},"Este relatorio irá imprimir Pedidos em atraso. Versão do relatório: 1.0")	
//Detalhes
oSecDetal := TRSection():New(oReport,OemToAnsi("Pedidos em atraso"),Nil)	
TRCell():New(oSecDetal,"PEDIDO"  ,"" ,"Nº. Pedido"   ,"",TamSx3("C5_NUM")[1])
TRCell():New(oSecDetal,"RAZAO"   ,"" ,"Razão Social" ,"",TamSx3("A1_NOME")[1])
TRCell():New(oSecDetal,"ENTREGA" ,"" ,"Dt. Entrega"  ,"",TamSx3("C5_EMISSAO")[1]) 
TRCell():New(oSecDetal,"DIASATR" ,"" ,"Dias Atraso"  ,"",14) 

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
		oSecDetal:Cell("RAZAO"):SetValue(aDadosRel[nXi,2])         
		oSecDetal:Cell("ENTREGA"):SetValue(aDadosRel[nXi,3])         
		oSecDetal:Cell("DIASATR"):SetValue(aDadosRel[nXi,4])                  
		oSecDetal:PrintLine()  			
	Next nXi			
	oSecDetal:Finish()	 	
EndIf

Return     