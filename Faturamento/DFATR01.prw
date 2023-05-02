#INCLUDE "Protheus.CH"
#INCLUDE "Topconn.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³AFATR01   ºAutor  ³Hollerbach          º Data ³  19/07/11   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio para impressao dos orcamentos                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function DFATR01()

Local oReport
Private oSection1
Private oSection2

//Interface de impressao
oReport:= ReportDef()
oReport:PrintDialog()

Return



Static Function ReportDef()
*******************************************************************************
*
**
Local cTitle   := "Relatorio Orçamentos " 


//Variaveis utilizadas para parametros
//mv_par01               Data Inicial
//mv_par02               Data Final
//mv_par03               Produto Inicial
//mv_par04               Produto Final

AjustaSX1()
Pergunte("DFATR01",.T.)
                               

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport:= TReport():New("DFATR01",cTitle,"DFATR01", {|oReport| ReportPrint(oReport)},"Orçamentos por Vendedor..")
oReport:SetPortrait()
//oReport:HideHeader()
oReport:HideParamPage()
oReport:HideFooter()
oReport:SetTotalInLine(.F.)

oSection1:= TRSection():New(oReport,"Orcamentos X Vendedor ",{"SCJ","SM0","SCK","SA1"},/*aOrdem*/)
oSection1:SetReadOnly()
oSection1:SetCellBorder("ALL",,,.T.)
oSection1:SetCellBorder("RIGHT")
oSection1:SetCellBorder("LEFT")
oSection1:SetCellBorder("BOTTOM")

TRCell():New(oSection1,"CODIGO"    	,"","Cod. Orcamento"    ,/*Picture*/,15,/*lPixel*/,{|| cCodAten }   	,"CENTER",,"CENTER")
TRCell():New(oSection1,"REFERENCIA" ,"","Ref. Cliente"    	,/*Picture*/,15,/*lPixel*/,{|| cRef }      		,"CENTER",,"CENTER")
TRCell():New(oSection1,"CLIENTE"   	,"","Nome Cliente"      ,/*Picture*/,25,/*lPixel*/,{|| cCliente }   	,"CENTER",,"CENTER")
TRCell():New(oSection1,"DATA"       ,"","Data Emissao"    	,/*Picture*/,20,/*lPixel*/,{|| cData }      	,"CENTER",,"CENTER")
TRCell():New(oSection1,"PRODUTO"   	,"","Produto"           ,/*Picture*/,20,/*lPixel*/,{|| cProduto }   	,"CENTER",,"CENTER")
TRCell():New(oSection1,"DESCRICAO" 	,"","Descricao Prod."   ,/*Picture*/,30,/*lPixel*/,{|| cDescProd }  	,"LEFT",,"LEFT")
TRCell():New(oSection1,"QUANTIDADE"	,"","Quantidade"     	,/*Picture*/,10,/*lPixel*/,{|| cQuantidade }  	,"LEFT",,"LEFT")
TRCell():New(oSection1,"VALOR"		,"","Vlr. Unitario"    	,/*Picture*/,10,/*lPixel*/,{|| cVlrUnit }  		,"LEFT",,"LEFT")
TRCell():New(oSection1,"TOTAL"		,"","Vlr. Total"	   	,/*Picture*/,15,/*lPixel*/,{|| cVlrTotal }  	,"LEFT",,"LEFT")
TRCell():New(oSection1,"VENDEDOR" 	,"","Cod. Vendedor"     ,/*Picture*/,20,/*lPixel*/,{|| cCodVen }   		,"LEFT",,"LEFT")

oBreak1 := TRBreak():New(oSection1,"","TOTAL ") 
TRFunction():New(oSection1:Cell("TOTAL")   	,NIL,"SUM",oBreak1,,,,.f.,.T.)
                     
                     
oSection2 := TRSection():New(oSection1,"Observacoes",{"SCJ","SCK","SB1"})

TRCell():New(oSection2,"OBSERVACAO" 	,"","Observacao"     ,/*Picture*/,200,/*lPixel*/,{|| cObs }   		,"LEFT",,"LEFT")
oSection2:SetHeaderSection(.F.)
                                                                                
Return(oReport)



Static Function ReportPrint(oReport)
*******************************************************************************
* Fluxo principal do relatorio
*
**

//Local oSection1   := oReport:Section(1)
//Local oSection2   := oReport:Section(1):Section(1)
Local oFont1      := TFont():New( "Arial",,16,,.T.,,,,.F.,.F. )
Local oFont2      := TFont():New( "Arial",,12,,.T.,,,,.F.,.F. )

Local cQuery 	:= ""
Local nLin   	:= 50
Local cStatus   := "A"

Local aAreaSM0 := SM0->(GetArea())

//oReport:SayBitMap(100,050,GetSrvProfString('Startpath','') + 'Imagens\LogoNutra' + '.bmp',370,100)
	     
If	mv_par05 == 1
	
	BeginSql Alias "TRBSAC"
	                                                          
		%noparser%
		
		SELECT SCJ.CJ_FILIAL, SCJ.CJ_VEND, SCJ.CJ_NUM, SCJ.CJ_COTCLI, SCJ.CJ_CLIENTE, SCJ.CJ_LOJA, SCJ.CJ_EMISSAO, SCJ.CJ_VEND, SCJ.CJ_OBS, SCK.CK_PRODUTO, SCK.CK_QTDVEN, SCK.CK_PRCVEN, SCK.CK_VALOR
		FROM %Table:SCJ% SCJ, 
		     %Table:SCK% SCK 	
		WHERE SCJ.CJ_EMISSAO >= %Exp:mv_par01%
			AND SCJ.CJ_EMISSAO <= %Exp:mv_par02%
			AND SCJ.CJ_VEND >= %Exp:mv_par03%
			AND SCJ.CJ_VEND <= %Exp:mv_par04%     
			AND SCJ.CJ_NUM = SCK.CK_NUM		
			AND SCJ.%notdel%
			AND SCK.%notdel%
		ORDER BY SCJ.CJ_VEND,SCJ.CJ_NUM
			
	EndSql	
Else
    
		Do Case
			Case mv_par06 == 1
				cStatus	:=	"A"	
			Case mv_par06 == 2
				cStatus	:=	"B"	
			Case mv_par06 == 3
				cStatus	:=	"C"		
			Case mv_par06 == 4
				cStatus	:=	"D"		
			Case mv_par06 == 5
				cStatus	:=	"F"						
		End Case	
				    
	BeginSql Alias "TRBSAC"
	                                                          
		%noparser%
		
		SELECT SCJ.CJ_FILIAL, SCJ.CJ_VEND, SCJ.CJ_NUM, SCJ.CJ_COTCLI, SCJ.CJ_CLIENTE, SCJ.CJ_LOJA, SCJ.CJ_EMISSAO, SCJ.CJ_VEND, SCJ.CJ_OBS, SCK.CK_PRODUTO, SCK.CK_QTDVEN, SCK.CK_PRCVEN, SCK.CK_VALOR
		FROM %Table:SCJ% SCJ, 
		     %Table:SCK% SCK 	
		WHERE SCJ.CJ_EMISSAO >= %Exp:mv_par01%
			AND SCJ.CJ_EMISSAO <= %Exp:mv_par02%
			AND SCJ.CJ_VEND >= %Exp:mv_par03%
			AND SCJ.CJ_VEND <= %Exp:mv_par04%     
			AND SCJ.CJ_NUM = SCK.CK_NUM		
			AND SCJ.CJ_STATUS  = %Exp:cStatus%
			AND SCJ.%notdel%
			AND SCK.%notdel%
		ORDER BY SCJ.CJ_VEND,SCJ.CJ_NUM
			
	EndSql	
	
EndIf

dbSelectArea("TRBSAC")
dbGoTop()

oSection1:Init()	
nLin := oReport:Row()
oReport:SkipLine()
oReport:SkipLine()    

//cCdLinha 	:= AllTrim(TRBSAC->B1_LINHA)                             
//cCdGrupo	:= AllTrim(TRBSAC->B1_GRUPO)
//cCdProdut	:= AllTrim(TRBSAC->Z6_CODPRO)

cVendedor 	:= TRBSAC->CJ_VEND
cNumOrc		:= TRBSAC->CJ_NUM
cObs 		:= AllTrim(TRBSAC->CJ_OBS)

While ! TRBSAC->(Eof())

	
	
	//Controle da Impressao da Observação
	If AllTrim(cNumOrc) <> AllTrim(TRBSAC->CJ_NUM)
		If AllTrim(cObs) <> ""
			oSection2:Init()
			oSection2:PrintLine()    
			oReport:SkipLine()    
		EndIf             
		cNumOrc := TRBSAC->CJ_NUM 
		cObs 	:= AllTrim(TRBSAC->CJ_OBS)
	EndIf	
	
	If AllTrim(cVendedor) <> AllTrim(TRBSAC->CJ_VEND)
		
		oSection1:Finish()
		oSection1:Init()	
		nLin := oReport:Row()
		oReport:SkipLine()
		oReport:SkipLine()    
		cVendedor := AllTrim(TRBSAC->CJ_VEND)
	EndIf
		
    cCodAten 	:= TRBSAC->CJ_NUM
   	cRef 		:= TRBSAC->CJ_COTCLI
   	cCliente	:= Posicione("SA1",1,xFilial("SA1")+TRBSAC->CJ_CLIENTE+TRBSAC->CJ_LOJA,"A1_NOME")   	
   	cData 		:= SubStr(TRBSAC->CJ_EMISSAO,7,2) + "/" + SubStr(TRBSAC->CJ_EMISSAO,5,2) + "/" + SubStr(TRBSAC->CJ_EMISSAO,1,4)   	
   	cProduto	:= TRBSAC->CK_PRODUTO
   	cDescProd	:= Posicione("SB1",1,xFilial("SB1")+TRBSAC->CK_PRODUTO,"B1_DESC")   
   	cQuantidade := Transform(TRBSAC->CK_QTDVEN,"@E 999,999.99")
   	cVlrUnit 	:= Transform(TRBSAC->CK_PRCVEN,"@E 999,999.99")
   	cVlrTotal 	:= Transform(TRBSAC->CK_VALOR,"@E 999,999.99")
   	cCodVen		:= TRBSAC->CJ_VEND
   
   	oSection1:PrintLine()
   	
   	dbSelectArea("TRBSAC")
   	dbskip()
End

//Realizando impressao ultima observação
If AllTrim(cObs) <> ""
	oSection2:Init()
	oSection2:PrintLine()    
	oReport:SkipLine()    
EndIf 
		
oSection1:Finish()

dbSelectArea("TRBSAC")
dbCloseArea()

RestArea(aAreaSM0)

Return


Static Function AjustaSX1()
*******************************************************************************
*
**

	PutSx1("DFATR01","01","Data Inicial     ?","Data Inicial Dados ?","Data Inicial Dados  ?","mv_ch01","D",08,00,01,"G","",""   ,"","","mv_par01","","","","","","","","","","","","","","","","",{ OemToAnsi("Define a Data Inicial para busca")}, { OemToAnsi("dos dados")}, {} )
	PutSx1("DFATR01","02","Data Final       ?","Data Final Dados   ?","Data Final Dados    ?","mv_ch02","D",08,00,01,"G","",""   ,"","","mv_par02","","","","","","","","","","","","","","","","",{ OemToAnsi("Define a Data Final para busca")}  , { OemToAnsi("dos dados")}, {} )
	PutSx1("DFATR01","03","Vendedor Inicial ?","Vendedor Inicial   ?","Vendedor Inicial    ?","mv_ch03","C",06,00,01,"G","","SA3","","","mv_par03","","","","","","","","","","","","","","","","",{ OemToAnsi("Define os Vendedores"),OemToAnsi("que devem ser filtrados no"),OemToAnsi("relatorio!")}, {}, {} )
	PutSx1("DFATR01","04","Vendedor Final   ?","Vendedor Final     ?","Vendedor Final      ?","mv_ch04","C",06,00,01,"G","","SA3","","","mv_par04","","","","","","","","","","","","","","","","",{ OemToAnsi("Define os Vendedores"),OemToAnsi("que devem ser filtrados no"),OemToAnsi("relatorio!")}, {}, {} )
	PutSx1("DFATR01","05","Considerar Status?","Considerar Status  ?","Considerar Status   ?","mv_ch05","N",01,00,01,"C","","","","","mv_par05","Nao","Nao","Nao","", "Sim","Sim","Sim","","","","","","","","","",{"Considera parametros abaixo", " para impressao",""},{"",""} ,	{"",""})
	PutSx1("DFATR01","06","Qual Status      ?","Qual Status        ?","Qual Status         ?","mv_ch06","N",01,00,01,"C","","","","","mv_par06","Aberto","Aberto","Aberto","", "Baixado","Baixado","Baixado","Cancelado","Cancelado","Cancelado","Nao Orcado","Nao Orcado","Nao Orcado","Bloqueado","Bloqueado","Bloqueado",{"Define os Status dos Orcamentos", "que deverao ser impressos",""},{"",""} ,	{"",""})

Return