#Include "Protheus.ch" 
#Include "TopConn.ch"       
/*                                     
+-----------+------------+----------------+-------------------+-------+---------------+
| Programa  | AFATR02    | Desenvolvedor  | Pedro             | Data  | 26/03/2011    |
+-----------+------------+----------------+-------------------+-------+---------------+
| Descricao | Relação de vendedores auxiliares por item vendido.                      |
+-----------+-------------------------------------------------------------------------+
| Uso       | Exclusivo DMB /                                                         |
+-----------+-------------------------------------------------------------------------+
|                  Modificacoes desde a construcao inicial                            |
+-------------------------------------------------------------------------------------+
*/
User Function AFATR02() 

Local oReport
Local aArea	:= GetArea()

Private cDocFis  := "" 
//Private dDataEmis:= dDataBase 

oReport := ReportDef()
oReport:PrintDialog()

RestArea(aArea)  

Return


Static Function ReportDef()
Local cTitle   	:= "Relatorio" 
Local oReport
Local oSection1        
Local cReport 	:= "AFATR02" 				
Local cDescri 	:= "Este relatório imprime Pedidos de Vendas por Vendedor/Produtos" 					
Local cTitulo 	:= "Relatório Vendedores X Produtos" 
Local cPerg		:= "AFATR02"					


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1()
Pergunte("AFATR02",.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport:= TReport():New("AFATR02",cTitle,"AFATR02", {|oReport| ReportPrint(oReport)},"Relatorio")
oReport:SetPortrait()
oReport:HideParamPage()
oReport:HideFooter()
oReport:SetTotalInLine(.F.)
oReport:SetLandscape()	//Imprime o relatorio no formato paisagem

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                                                                        ³
//³                      Definicao das Secoes                              ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao 01 (Dados do Vendedor)                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oVendedor := TRSection():New(oReport,"Rel.Vendedor",{"SC5","SA3"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oVendedor:SetTotalInLine(.F.)
TRCell():New(oVendedor,"C5_VEND1"	,"","Codigo Vendedor"      ,/*Picture*/, TamSX3("C5_VEND1")[1]	,/*lPixel*/,{ || cVend } )
TRCell():New(oVendedor,"A3_NOME"	,"","Nome Vendedor"      ,/*Picture*/, TamSX3("A3_NOME")[1]	,/*lPixel*/,{ || cNomVend } )


oProduto := TRSection():New(oVendedor,"OXXXX",{"TRB","SB1"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
oProduto:SetTotalInLine(.F.)
TRCell():New(oProduto,"C6_PRODUTO"	,"","Codigo"      	,/*Picture*/,30 /* TamSX3("C6_PRODUTO")[1]*/	,/*lPixel*/,{ || cCod } 	,"CENTER",,"CENTER")	
TRCell():New(oProduto,"B1_DESC"    	,"","Produto"     	,/*Picture*/,90 /*TamSX3("B1_DESC")[1] */    ,/*lPixel*/,{ || cDesc }	,"LEFT",,"CENTER" )
TRCell():New(oProduto,"A1_NOME"    	,"","Cliente"     	,/*Picture*/,40 /* TamSX3("A1_NOME")[1]*/    ,/*lPixel*/,{ || cCliente }	,"LEFT",,"CENTER" )	
TRCell():New(oProduto,"C6_QTDVEN"  	,"","Quantidade"  	,/*Picture*/,10 /* TamSX3("C6_QTDVEN")[1]*/  ,/*lPixel*/,{ || nQuant   }	,"RIGHT",,"RIGHT" )
TRCell():New(oProduto,"C9_QTDLIB"  	,"","Qtd. Faturada" ,/*Picture*/,10 /* TamSX3("C9_QTDLIB")[1]*/  ,/*lPixel*/,{ || nQtdFat   }	,"RIGHT",,"RIGHT" )	
TRCell():New(oProduto,"C6_PRCVEN"  	,"","Vr.Unitário" 	,/*Picture*/,13 /* TamSX3("C6_PRCVEN")[1]*/  ,/*lPixel*/,{ || nPrcVen  }	,"RIGHT",,"RIGHT" )	
TRCell():New(oProduto,"C6_VALOR"	,"","Vr. Total"   	,/*lPixel*/ ,13 /*TamSX3("C6_VALOR")[1]*/	   ,/*lPixel*/,{ || nTotal }	,"RIGHT",,"RIGHT" )	


TRFunction():New(oProduto:Cell("Quantidade")	,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/,oVendedor)
TRFunction():New(oProduto:Cell("Vr.Unitário")	,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/,oVendedor)
TRFunction():New(oProduto:Cell("Vr. Total")		,/* cID */,"SUM",/*oBreak*/,/*cTitle*/,/*cPicture*/,/*uFormula*/,.T./*lEndSection*/,.F./*lEndReport*/,/*lEndPage*/,oVendedor)
                                                                            

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Secao Totalizadora                            	    			       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oTotal := TRSection():New(oReport,"","",/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "Faturamento por Cliente"
oTotal:SetTotalInLine(.F.)
oTotal:SetEdit(.F.)
     

TRCell():New(oTotal,"NTOTQUANT"		,,"Quant.Total"	,PesqPictQt("C6_QTDVEN",16)		,TamSx3("C6_QTDVEN")[1],/*lPixel*/,{|| nTotQuant },,,"RIGHT")
TRCell():New(oTotal,"NTOTUNIT"		,,"Total.Unit"	,PesqPictQt("C6_PRCVEN",16)		,TamSx3("C6_PRCVEN")[1],/*lPixel*/,{|| nTotUnit },,,"RIGHT")
TRCell():New(oTotal,"NTOTVAL"		,,"Total.Valor"	,PesqPict("SC6","C6_VALOR",16)	,TamSx3("C6_VALOR")[1]	,/*lPixel*/,{|| nTotVal },,,"RIGHT")

//oReport:Section(1):Section(1):SetHeaderPage(.T.)

Return oReport
                                               

Static Function ReportPrint(oReport)
*******************************************************************************
*** Fluxo principal do relatorio
***********************

Local oSection1   := oReport:Section(1)
Local oSection2   := oReport:Section(1):Section(1)
Local cCodVend := Space(06) 
Local nSubTotVLRITEM := 0 
Local aDadosDoc := {} 

Local nLin   := 50

cVendedor := ""

BeginSql Alias "TRB" 

	%noparser%
	 
	SELECT SC5.C5_FILIAL, SC5.C5_NUM, SC5.C5_CLIENTE, SC5.C5_LOJACLI, SC5.C5_VEND1, SC6.C6_ITEM, SC6.C6_PRODUTO, SC6.C6_UM, SUM(SC6.C6_QTDVEN) QTDVEN,  
			SUM(SC6.C6_QTDENT) QTDENT, SUM(SC6.C6_VALOR) VALOR, SUM(SC6.C6_PRCVEN) PRCVEN, SB1.B1_DESC, SA1.A1_NOME
	FROM %Table:SC5% SC5,
			%Table:SC6% SC6,
			%Table:SF4% SF4,
			%Table:SB1% SB1,
			%Table:SA1% SA1			
	 WHERE SC5.C5_NUM = SC6.C6_NUM
		AND SC5.C5_FILIAL	>= %Exp:mv_par01% AND SC5.C5_FILIAL		<= %Exp:mv_par02%
		AND SC5.C5_EMISSAO 	>= %Exp:mv_par03% AND SC5.C5_EMISSAO 	<= %Exp:mv_par04%
		AND SC6.C6_PRODUTO 	>= %Exp:mv_par05% AND SC6.C6_PRODUTO 	<= %Exp:mv_par06%
		AND SC5.C5_VEND1 	>= %Exp:mv_par07% AND SC5.C5_VEND1 		<= %Exp:mv_par08%
		AND SC5.C5_CLIENTE 	>= %Exp:mv_par09% AND SC5.C5_CLIENTE 	<= %Exp:mv_par10%
		AND SB1.B1_COD	= SC6.C6_PRODUTO
		AND SC5.C5_CLIENTE = SA1.A1_COD		
		AND SC5.C5_VEND1 <> %Exp:cVendedor% 
		AND SC5.C5_TIPO NOT IN ('D','B')
		AND SC6.C6_TES = SF4.F4_CODIGO
  		AND SF4.F4_DUPLIC <> 'N'
		AND SUBSTRING (SC6.C6_PRODUTO,1,2) <> 'SV'
		AND SC5.D_E_L_E_T_ <> '*'
		AND SC6.D_E_L_E_T_ <> '*'
		AND SF4.D_E_L_E_T_ <> '*'
		GROUP BY SC5.C5_FILIAL, SC5.C5_NUM, SC5.C5_CLIENTE, SC5.C5_LOJACLI, SC5.C5_VEND1, SA1.A1_NOME, SC6.C6_PRODUTO, SC6.C6_UM, SB1.B1_DESC, SC6.C6_ITEM//, SC9.C9_QTDLIB
	ORDER BY SC5.C5_VEND1, SC6.C6_PRODUTO, SA1.A1_NOME
			
EndSql	

dbSelectArea("TRB")
dbGoTop()

// Salta pagina na quebra de secao
oReport:Section(1):SetPageBreak(.T.)


// Secao totalizadora
oReport:Section(2):Cell("NTOTQUANT" ):SetBlock({|| nTotQuant })	
oReport:Section(2):Cell("NTOTUNIT" ):SetBlock({|| nTotUnit })	
oReport:Section(2):Cell("NTOTVAL" ):SetBlock({|| nTotVal })

cVendedor := ""  

nTotQuant := 0
nTotUnit  := 0
nTotVal   := 0	
While ! TRB->(Eof())
    
	cVend :=  TRB->C5_VEND1   
	cNomVend  	:= Posicione("SA3",1,xFilial("SA3")+AllTrim(cVend),"A3_NOME")
	oReport:Section(1):Init()
	oReport:Section(1):Section(1):Init()
	oReport:Section(1):PrintLine()
	cVend :=  TRB->C5_VEND1

	While ! TRB->(Eof()) .AND. TRB->C5_VEND1 == cVend 
		
		cVend		:= TRB->C5_VEND1

		cCliente	:= TRB->A1_NOME
	   	cCod 	 	:= TRB->C6_PRODUTO 
	   	nQuant 	  	:= TRB->QTDVEN 
	   	nQtdFat		:= TRB->QTDENT //fQtdeLib(TRB->C5_FILIAL, TRB->C5_CLIENTE, TRB->C5_LOJACLI, TRB->C5_NUM, TRB->C6_ITEM)// TRB->C9_QTDLIB
	   	nPrcVen 	:= TRB->PRCVEN 
	   	nTotal	  	:= TRB->VALOR
	   	cDesc 	   	:= TRB->B1_DESC
   		 
   		nTotQuant 	+= TRB->QTDVEN 
   		nTotUnit	+= TRB->PRCVEN
   		nTotVal		+= TRB->VALOR
   		
   		oReport:Section(1):Section(1):PrintLine()	
		oReport:IncMeter()
		dbSelectArea("TRB")
		dbSkip()
	EndDo
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Altera texto do Total para cada Vendedor                     		   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport:Section(1):SetTotalText("Total Vendedor: ")
	
	oReport:Section(1):Section(1):Finish()
	oReport:Section(1):Finish()	
   
EndDo         

oReport:EndPage() //-- Salta Pagina
oReport:Section(2):Init()	         
oReport:Section(2):PrintLine()
oReport:Section(2):Finish()

dbSelectArea("TRB")
dbCloseArea()

Return

Static Function AjustaSX1()
*******************************************************************************
****** Perguntas
********************************

PutSx1("AFATR02","01","Da Filial    ?","Da Filial Inicial    ?"	,"Da Filial Inicial	  ?","mv_ch01","C",06,00,01,"G","","SM0","","","mv_par01","","","","","","","","","","","","","","","","", {OemToAnsi("Define a Filial Inicial")}, {}, {})
PutSx1("AFATR02","02","Ate Filial   ?","Da Filial Final	     ?"	,"Da Filial Final	  ?","mv_ch02","C",06,00,01,"G","","SM0","","","mv_par02","","","","","","","","","","","","","","","","", {OemToAnsi("Define a Filial Final")}, {}, {})
PutSx1("AFATR02","03","Da Emissao   ?","Do Periodoe Inicial  ?"	,"Do Periodo Inicial  ?","mv_ch03","D",08,00,01,"G","",""   ,"","","mv_par03","","","","","","","","","","","","","","","","",{ OemToAnsi("Define o Periodo Inicial")}, {}, {} )
PutSx1("AFATR02","04","Ate Emissao  ?","Do Periodo Final     ?"	,"Do Periodo Final    ?","mv_ch04","D",08,00,01,"G","",""   ,"","","mv_par04","","","","","","","","","","","","","","","","",{ OemToAnsi("Define o Periodo Final")}  , {}, {} )
PutSx1("AFATR02","05","Do Produto   ?","Do Produto Inicial   ?"	,"Do Produto Inicial  ?","mv_ch05","C",30,00,01,"G","","SB1","","","mv_par05","","","","","","","","","","","","","","","","",{ OemToAnsi("Define o Produto Inicial")}, {}, {} )
PutSx1("AFATR02","06","Ate Produto  ?","Do Produto Final     ?"	,"Do Produto Final    ?","mv_ch06","C",30,00,01,"G","","SB1","","","mv_par06","","","","","","","","","","","","","","","","",{ OemToAnsi("Define o Produto Final")}, {}, {} )
PutSx1("AFATR02","07","Do Vendedor  ?","Do Vendedor Inicial  ?"	,"Do Vendedor Inicial ?","mv_ch07","C",06,00,01,"G","","SA3","","","mv_par07","","","","","","","","","","","","","","","","",{ OemToAnsi("Define o Vendedor Inicial")}, {}, {} )
PutSx1("AFATR02","08","Ate Vendedor ?","Do Vendedor Final    ?"	,"Do Vendedor Final   ?","mv_ch08","C",06,00,01,"G","","SA3","","","mv_par08","","","","","","","","","","","","","","","","",{ OemToAnsi("Define o Vendedor Final")}, {}, {} )
PutSx1("AFATR02","09","Do Cliente   ?","Do Cliente Inicial	 ?"	,"Do Cliente Inicial  ?","mv_ch09","C",06,00,01,"G","","SA1","","","mv_par09","","","","","","","","","","","","","","","","", {OemToAnsi("Define o Cliente Inicial")}, {}, {})
PutSx1("AFATR02","10","Ate Cliente  ?","Do Cliente Final	 ?" ,"Do Cliente Final	  ?","mv_ch10","C",06,00,01,"G","","SA1","","","mv_par10","","","","","","","","","","","","","","","","", {OemToAnsi("Define o Cliente Final")}, {}, {})

Return  
/*
Static Function fQtdeLib(cZFilial,cZCliente,cZLoja,cZPedido,cZItem)
*******************************************************************************

Local nZQtde := 0

dbSelectArea("SC9")
dbSetOrder(2)
if dbSeek(cZFilial+cZCliente+cZLoja+cZPedido+cZItem)
//	While !Eof("SC9")//... tudo igaulll
		if Empty(SC9->C9_BLEST) .And. Empty(SC9->C9_BLCRED)
			nZQtde := nZQtde + SC9->C9_QTDLIB
		endif
		dbSelectArea("SC9")
		dbSkip()
//	enddo
endif

return nZQtde
   */