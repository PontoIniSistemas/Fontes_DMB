#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH" 
#INCLUDE "RWMAKE.CH" 
#INCLUDE "COLORS.CH"
#DEFINE ENTER Chr(13)+Chr(10) 

/*/{Protheus.doc}MA415BUT 
Tela demostrativa de preço ultimos por produto
Este ponto de entrada pertence à rotina de atualização de orçamentos de venda, MATA415(). 
Ele permite ao usuário adicionar botões à barra no topo da tela.
Exclusividade DMB Bombas. 
type function
@author Leonardo Alves - Mais Consultoria
@since 08/01/19
@version 1.0
@return 
/*/  

User Function MA415BUT()
/************************************************************************
*Tela demostrativa de pedidos compra ou venda em atraso
*
*****/

Local aArrayBut := {}                    

If(GetNewPar("MC_M415BUT",.T.))
	aArrayBut := {{"POSCLI",{||U_MCLIB002()},"Consulta Preço"}}    
	SetKey(VK_F2,{||U_MCLIB002()})
EndIf

Return(aArrayBut)



User Function MCLIB002()
/************************************************************************
*Tela demostrativa de preço de produtos
*
*****/                                                  

Local oFont      := TFont():New("Arial",,-13,.T.)       
Local aArrayBut  := {} 
Local aProdutos  := {}
Local cVersiona  := "1.1"
Local cRealease  := "1.0.1"
Local cQueryExc  := ""
Local cCodProdu  := TMP1->CK_PRODUTO
Local nValorPrc  := 0
Local aAreasOld  := GetArea()

Private oDlgPrd, oBrowser, oSay, oTMsgBar, oTMsgItem1, oTMsgItem2, oTMsgItem3  

cQueryExc := "SELECT TOP 3 D2_FILIAL AS 'FILIAL', D2_DOC AS 'NOTA', D2_SERIE AS 'SERIE', D2_EMISSAO AS 'EMISSAO', D2_ITEM AS 'ITEM', "
cQueryExc += " D2_COD AS 'PRODUTO', B1_DESC AS 'DESCRICAO', D2_PRCVEN AS 'PRCVEN'  FROM "+RetSqlName("SD2")+" A"
cQueryExc += " INNER JOIN "+RetSqlName("SF4")+" B ON(A.D2_TES = B.F4_CODIGO AND B.D_E_L_E_T_ = '')"
cQueryExc += " INNER JOIN "+RetSqlName("SB1")+" C ON(A.D2_COD = C.B1_COD AND C.D_E_L_E_T_ = '')"
cQueryExc += " WHERE D2_COD = '"+cCodProdu+"'"
cQueryExc += " AND F4_DUPLIC = 'S'"
cQueryExc += " AND A.D_E_L_E_T_ = ''"     
cQueryExc += " ORDER BY A.R_E_C_N_O_ DESC"

If(Select("TEMP")<>0)
	TEMP->(dbCloseArea())
EndIf                 
TcQuery cQueryExc New Alias "TEMP"

dbSelectArea("TEMP")
dbGoTop()
While(!Eof())        	                          
	dDataEmis := STod(TEMP->EMISSAO)                                   
	nValorPrc := Iif(ValType(TEMP->PRCVEN) <> "N", Val(TEMP->PRCVEN),TEMP->PRCVEN)	
	Aadd(aProdutos,{TEMP->PRODUTO,Left(TEMP->DESCRICAO,25),Transform(nValorPrc,"@E 999,999,999.9999"),TEMP->FILIAL,TEMP->NOTA,TEMP->SERIE,dDataEmis})
	dbSelectArea("TEMP")
	dbSkip()	
EndDo  
                                                            
If(Len(aProdutos)<>0)
	Define MSDialog oDlgPrd Title OemToAnsi("Preços de Venda por Produto") Style DS_MODALFRAME From 000,000 To 270,810 Pixel                         
	oDlgPrd:lEscClose := .F. 
	@ 005,005 Say oSay PROMPT "3 Ultimos Preços de Venda por Produto" FONT oFont Color CLR_HBLUE Of oDlgPrd Pixel  
	oSay:lTransparent:= .F. 	
	@ 035, 005 ListBox oListBox1 Var nListBox1 Fields, Header "PRODUTO","DESCRICAO","PRC.VENDA","EMPRESA","NOTA","SERIE","DT.EMISSAO" Size 410, 80 Of oDlgPrd  Pixel
	oListBox1:SetArray(aProdutos)
	oListBox1:bLine := {||{aProdutos[oListBox1:nAt][1],aProdutos[oListBox1:nAt][2],aProdutos[oListBox1:nAt][3],;
	aProdutos[oListBox1:nAt][4],aProdutos[oListBox1:nAt][5],aProdutos[oListBox1:nAt][6],aProdutos[oListBox1:nAt][7]}} 
	oTMsgBar := TMsgBar():New(oDlgPrd,".",.F.,.F.,.F.,.F., RGB(116,116,116),,,.F.)      
	oTMsgItem1 := TMsgItem():New( oTMsgBar,"RELEASE "+cRealease, 100,,,,.T., {||} )       
	oTMsgItem2 := TMsgItem():New( oTMsgBar,"VERSÃO: "+cVersiona, 100,,,,.T., {||} ) 
	oTMsgItem3 := TMsgItem():New( oTMsgBar,MsDate(), 100,,,,.T., {||} ) 
	Activate MsDialog oDlgPrd Centered  On Init EnchoiceBar(oDlgPrd,{||oDlgPrd:End()},{||oDlgPrd:End()},,aArrayBut)
Else
	MsgInfo("O produto não possui historico de vendas.")	
EndIf
                      
If(Len(aProdutos)<>0)
	FreeObj(oDlgPrd)
	TEMP->(dbCloseArea())
EndIf                 

RestArea(aAreasOld)

Return                                        