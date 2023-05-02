#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH" 
#INCLUDE "RWMAKE.CH" 
#INCLUDE "COLORS.CH"
#DEFINE ENTER Chr(13)+Chr(10) 

/*/{Protheus.doc}MT410BRW
Este ponto de entrada é chamado antes da apresentação da mbrowse.
Utilizado para chamar a tela demostrativa de pedidos em aberto.
Exclusividade DMB Bombas. 
type function
@author Leonardo Alves - Mais Consultoria
@since 06/11/18
@version 1.0
@return 
/*/  
User Function MT410BRW()
/************************************************************************
*
*
*****/

Local cQueryExc := ""  
Local aAreasOld := GetArea()
Local aAreasSC5 := SC5->(GetArea())
Local nDiasRetr := GetNewPar("MC_DIASRET",90)

If(!GetNewPar("MC_M410BRW",.T.))
	Return
EndIf

cQueryExc := "SELECT DISTINCT C6_NUM AS NUMERO, A1_NOME AS NOME, C6_ENTREG AS DTENTREGA FROM "+RetSqlName("SC6")+" A"
cQueryExc += " INNER JOIN "+RetSqlName("SA1")+" B ON(A.C6_CLI = B.A1_COD AND A.C6_LOJA = B.A1_LOJA AND B.D_E_L_E_T_ = '')"
cQueryExc += " WHERE A.D_E_L_E_T_ = ''"       
cQueryExc += " AND C6_ENTREG >= '"+DTos(dDataBase-nDiasRetr)+"'"
cQueryExc += " AND C6_ENTREG < '"+DTos(dDataBase)+"'"
cQueryExc += " AND C6_NOTA = ''"
cQueryExc += " AND C6_FILIAL = '"+xFilial("SC6")+"'"
cQueryExc += " ORDER BY C6_NUM"

If(GetNewPar("MC_BRWPEDI",.T.))
	U_MCLIB001(cQueryExc) //Tela demostratriva de pedidos em aberto... 
EndIf	         

RestArea(aAreasOld)
RestArea(aAreasSC5)

Return