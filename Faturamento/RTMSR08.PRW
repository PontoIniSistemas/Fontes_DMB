#INCLUDE "Rtmsr08.ch"
#INCLUDE "protheus.ch"

Static lAWBRepete := DT8->(FieldPos("DT8_CODCIA")) > 0 .And. DT8->(FieldPos("DT8_LOJCIA")) > 0

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � RTMSR08  � Autor �Patricia A. Salomao    � Data �18.03.2002���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Impressao da AWB                                           ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � RTMSR08                                                    ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � Gestao de Transporte                                       ���
�������������������������������������������������������������������������Ĵ��
���         ATUALIZACOES SOFRIDAS DESDE A CONSTRU�AO INICIAL.             ���
�������������������������������������������������������������������������Ĵ��
���Programador � Data   � BOPS �  Motivo da Alteracao                     ���
�������������������������������������������������������������������������Ĵ��
���            �        �      �                                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function RTMSR08()
Local titulo   := STR0001 //"Impressao da AWB"
Local cString  := "DTV"
Local wnrel    := "RTMSR08"
Local cDesc1   := STR0002 //"Este programa ira emitir a AWB."
Local cDesc2   := ""
Local cDesc3   := ""
Local tamanho  := "P"

Private NomeProg := "RTMSR08"
Private aReturn  := {STR0003,1,STR0004,2, 2, 1, "",1 }  //"Zebrado"###"Administracao"
Private cPerg    := "RTMR08"
Private nLastKey := 0

If lAWBRepete
	AjustaSX1()
EndIf
//��������������������������������������������������������������Ŀ
//� Verifica as perguntas                                        �
//����������������������������������������������������������������
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01        	// De AWB       ?	                     �
//� mv_par02        	// Ate AWB      ?     	                 �
//� mv_par03        	// Tipo de LayOut                        �
//� mv_par04        	// Companhia Aerea De ?                  �
//� mv_par05        	// Companhia Aerea Ate?                  �
//� mv_par06        	// Loja De ?                             �
//� mv_par07        	// Loja Ate ?                            �
//����������������������������������������������������������������
pergunte("RTMR08",.F.)

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)

If nLastKey = 27
	Set Filter To
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Set Filter To
	Return
Endif

RptStatus({|lEnd| RTMSR08Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �RTMSR08Imp� Autor �Patricia A. Salomao    � Data �18.03.2002���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Chamada do Relat�rio                                       ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � RTMSR06			                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RTMSR08Imp(lEnd,wnRel,titulo,tamanho)
//��������������������������������������������������������������Ŀ
//� Define Variaveis                                             �
//����������������������������������������������������������������
Local cNomAge  := GetMv("MV_AGENOM")  // Nome Agente
Local cCodIATA := GetMv("MV_AGEIAT") // Cod. IATA
Local cNumMat  := GetMv("MV_AGEMAT")  // Matricula
Local aNotas   := {}
Local aArray   := {}
Local Li       := 10
Local nLinha:=nBegin:=0
Local cCliente:=cLoja:=cForInscr:=cForCGC:=cMens:= ""
Local aAreaSA2 := SA2->(GetArea())
Local aAreaSM0	:= SM0->(GetArea())
Local nBegin   := 0
Local cAliasDTV := GetNextAlias()   
Local cAliasQRY := ""
Local bBloco := {||.F.}
Local bBloco2 := {||.F.}
Local bBloco3 := {||.F.}
Local bWhile := {||.F.}

Inclui := .F.
AADD(aArray, { SM0->M0_NOME, SM0->M0_CGC, SM0->M0_INSC, SM0->M0_ENDCOB, SM0->M0_BAIRCOB, SM0->M0_CIDCOB,;
SM0->M0_CEPCOB, SM0->M0_ESTCOB ,SM0->M0_TEL ,SM0->M0_FAX })

/*
dbSelectArea("DTV")
dbSetOrder(1)
dbSeek(xFilial()+mv_par01, .T.)*/
SetRegua(LastRec())

cQuery := " SELECT * FROM "+RetSqlName("DTV")+ " DTV "
cQuery += " WHERE DTV_NUMAWB BETWEEN '"+mv_par01+"' AND '"+mv_par02+"'"
If lAWBRepete
	cQuery += " AND DTV_CODCIA BETWEEN '" + mv_par04 + "' AND '"+mv_par05+"'"   
	cQuery += " AND DTV_LOJCIA BETWEEN '" + mv_par06 + "' AND '"+mv_par07+"'"
EndIf
cQuery += " AND D_E_L_E_T_ = '' " 

DbUseArea(.T.,'TOPCONN',TCGENQRY(,,cQuery),cAliasDTV,.T.,.T.)	                                        	             

Do While (cAliasDTV)->(!Eof())
	aNotas := {}
	
	SA2->(dbSetOrder(1))
	If SA2->(MsSeek(xFilial("SA2")+(cAliasDTV)->DTV_CODCIA+(cAliasDTV)->DTV_LOJCIA)) .And. SA2->A2_TIPAWB <> mv_par03
		(cAliasDTV)->(dbSkip())
		Loop
	Else
		cForInscr := SA2->A2_INSCR
		cForCGC   := SA2->A2_CGC
	EndIf
	
	DTX->(dbSetOrder(4))
	If lAWBRepete
		DTX->(MsSeek(xFilial("DTX")+ (cAliasDTV)->DTV_NUMAWB + (cAliasDTV)->DTV_CODCIA + (cAliasDTV)->DTV_LOJCIA) )
		bWhile := {||DTX->(!Eof()) .And. DTX->DTX_FILIAL+DTX->DTX_NUMAWB+DTX->DTX_CODCIA+DTX->DTX_LOJCIA == xFilial("DTX") + (cAliasDTV)->DTV_NUMAWB + (cAliasDTV)->DTV_CODCIA + (cAliasDTV)->DTV_LOJCIA}		
	Else
		DTX->(MsSeek(xFilial("DTX")+ (cAliasDTV)->DTV_NUMAWB ) )
		bWhile := {||DTX->(!Eof()) .And. DTX->DTX_FILIAL+DTX->DTX_NUMAWB == xFilial("DTX") + (cAliasDTV)->DTV_NUMAWB}		
	EndIf
	Do While Eval(bWhile)
			DUD->(dbSetOrder(2))
			DUD->(MsSeek(xFilial("DUD")+ DTX->DTX_FILORI + DTX->DTX_VIAGEM))		
			Do While !DUD->(Eof()) .And. DUD->DUD_FILIAL+DUD->DUD_FILORI+DUD->DUD_VIAGEM == xFilial("DUD")+ DTX->DTX_FILORI + DTX->DTX_VIAGEM
				DTC->(dbSetOrder(3))
				DTC->(MsSeek(xFilial("DTC")+DUD->DUD_FILDOC+DUD->DUD_DOC+DUD->DUD_SERIE))			
				Do While !DTC->(Eof()) .And. DTC->DTC_FILIAL+DTC->DTC_FILDOC+DTC->DTC_DOC+DTC->DTC_SERIE ==xFilial("DUD")+DUD->DUD_FILDOC+DUD->DUD_DOC+DUD->DUD_SERIE
					AADD(aNotas, {DTC->DTC_NUMNFC} )
					DTC->(dbSkip())
				EndDo			
				DUD->(dbSkip())
			EndDo		
		DTX->(dbSkip())		
	EndDo   
	
	If mv_par03 == StrZero(1,Len(SA2->A2_TIPAWB))
		IncRegua()
		If Interrupcao(@lEnd)
			Exit
		Endif		
		//-- Imprime Dados do Expedidor
		@Li,010 PSay aArray[1][1] Picture PesqPict("SA1","A1_NOME")
		Imp_nota(Li,aNotas)
		VerLin(@Li,1)
		@Li,010 PSay aArray[1][2] Picture PesqPict("SA1","A1_CGC")
		VerLin(@Li,1)
		@Li,010 PSay aArray[1][3] Picture PesqPict("SA1","A1_INSCR")
		VerLin(@Li,1)
		@Li,010 PSay aArray[1][4] Picture PesqPict("SA1","A1_END")
		VerLin(@Li,1)
		@Li,010 PSay aArray[1][5] Picture PesqPict("SA1","A1_BAIRRO")
		@Li,035 PSay aArray[1][6] Picture PesqPict("SA1","A1_MUN")
		VerLin(@Li,1)
		@Li,010 PSay aArray[1][7] Picture PesqPict("SA1","A1_CEP")
		@Li,030 PSay aArray[1][8] Picture PesqPict("SA1","A1_EST")
		@Li,035 PSay aArray[1][9] Picture PesqPict("SA1","A1_TEL")
		VerLin(@Li,1)
		@Li,010 PSay aArray[1][10] Picture PesqPict("SA1","A1_FAX")
		VerLin(@Li,2)

/*		
		//-- Imprime Dados do Destinatario
		SA1->(MsSeek(xFilial()+DTV->DTV_CLIDES+DTV->DTV_LOJDES) )
		@Li,010 PSay SA1->A1_NOME Picture PesqPict("SA1","A1_NOME")
		VerLin(@Li,1)
		@Li,010 PSay SA1->A1_CGC Picture PesqPict("SA1","A1_CGC")
		VerLin(@Li,1)
		@Li,010 PSay SA1->A1_INSCR Picture PesqPict("SA1","A1_INSCR")
		@Li,070 PSay DTV->DTV_NUMAWB
		VerLin(@Li,1)
		@Li,010 PSay SA1->A1_END Picture PesqPict("SA1","A1_END")
		VerLin(@Li,1)
		@Li,010 PSay SA1->A1_BAIRRO Picture PesqPict("SA1","A1_BAIRRO")
		@Li,035 PSay SA1->A1_MUN  Picture PesqPict("SA1","A1_MUN")
		@Li,045 PSay cForInscr Picture PesqPict("SA2","A2_INSCR") // Inscricao Estadual VarigLog
		@Li,068 PSay cForCGC   Picture PesqPict("SA2","A2_CGC")   // CNPJ
		VerLin(@Li,1)
		@Li,010 PSay SA1->A1_CEP Picture PesqPict("SA1","A1_CEP")
		@Li,030 PSay SA1->A1_EST Picture PesqPict("SA1","A1_EST")
		@Li,040 PSay SA1->A1_TEL Picture PesqPict("SA1","A1_TEL")
		VerLin(@Li,1)
		@Li,010 PSay SA1->A1_FAX Picture PesqPict("SA1","A1_FAX")
*/
		//-- Imprime Dados do Destinatario
		SM0->(MsSeek(cEmpAnt+(cAliasDTV)->DTV_FILDES))
		@Li,010 PSay SM0->M0_NOME		Picture PesqPict('SA1','A1_NOME')
		VerLin(@Li,1)
		@Li,010 PSay SM0->M0_CGC		Picture PesqPict('SA1','A1_CGC')
		VerLin(@Li,1)
		@Li,010 PSay SM0->M0_INSC		Picture PesqPict('SA1','A1_INSCR')
		@Li,070 PSay (cAliasDTV)->DTV_NUMAWB
		VerLin(@Li,1)
		@Li,010 PSay SM0->M0_ENDCOB	Picture PesqPict('SA1','A1_END')
		VerLin(@Li,1)
		@Li,010 PSay SM0->M0_BAIRCOB	Picture PesqPict('SA1','A1_BAIRRO')
		@Li,035 PSay SM0->M0_CIDCOB	Picture PesqPict('SA1','A1_MUN')
		@Li,045 PSay cForInscr			Picture PesqPict('SA2','A2_INSCR') // Inscricao Estadual VarigLog
		@Li,068 PSay cForCGC				Picture PesqPict('SA2','A2_CGC')   // CNPJ
		VerLin(@Li,1)
		@Li,010 PSay SM0->M0_CEPCOB	Picture PesqPict('SA1','A1_CEP')
		@Li,030 PSay SM0->M0_ESTCOB	Picture PesqPict('SA1','A1_EST')
		@Li,040 PSay SM0->M0_TEL		Picture PesqPict('SA1','A1_TEL')
		VerLin(@Li,1)
		@Li,010 PSay SM0->M0_FAX		Picture PesqPict('SA1','A1_FAX')
		
		
		@Li,040 PSay STR0005 	 //"SEGURO PROPRIO"
		VerLin(@Li,2)
		@Li,010 PSay (cAliasDTV)->DTV_AERORI Picture PesqPict("DTV","DTV_AERORI") //--Origem
		DUY->(dbSetOrder(1))
		DUY->(MsSeek(xFilial("DUY")+(cAliasDTV)->DTV_CDRDES) )
		@Li,025 PSay DUY->DUY_DESCRI Picture PesqPict("DUY","DUY_DESCRI")	//-- Cidade de Destino
		@Li,058 PSay (cAliasDTV)->DTV_AERDES Picture PesqPict("DTV","DTV_AERDES")	//-- Sigla
		@Li,065 PSay (cAliasDTV)->DTV_CODEMB Picture PesqPict("DTV","DTV_CODEMB")	//-- Descricao das Embalagens
		VerLin(@Li,5)
		@Li,010 PSay (cAliasDTV)->DTV_QTDVOL Picture PesqPict("DTV","DTV_QTDVOL")	//-- Quant. de Volumes
		@Li,018 PSay (cAliasDTV)->DTV_PESO   Picture PesqPict("DTV","DTV_PESO")	//-- Peso Real KG
		@Li,031 PSay (cAliasDTV)->DTV_PESOM3 Picture PesqPict("DTV","DTV_PESOM3")	//-- Peso Taxado KG
		@Li,043 PSay (cAliasDTV)->DTV_AERORI+"/"+(cAliasDTV)->DTV_AERDES  //-- Trecho
		@Li,070 PSay (cAliasDTV)->DTV_DESPRO
		VerLin(@Li,5)
		If !Empty((cAliasDTV)->DTV_CODOBS)
			cMens := E_MsMM((cAliasDTV)->DTV_CODOBS,50)
		EndIf
		
		//-- Imprime Observacoes
		nLinha:= MLCount(cMens,40)
		@Li,035 PSAY MemoLine(cMens,40,1)
		For nBegin := 2 To nLinha
			VerLin(@Li,1)
			@Li,035 PSAY Memoline(cMens,40,nBegin)
		Next nBegin
		VerLin(@Li,2)
		@Li, 035 Psay STR0006 + " " + (cAliasDTV)->DTV_FILORI +" - "+ (cAliasDTV)->DTV_VIAGEM
		VerLin(@Li,2)
		@Li,010 PSay STR0005 //"SEGURO PROPRIO"
		VerLin(@Li,1)
		
		//-- Verifica se Retira no Aeroporto
		If (cAliasDTV)->DTV_RETAER == "1" // Se Sim
			@Li,040 PSay "XX"
		Else
			@Li,050 PSay "XX"
			VerLin(@Li,1)
			@Li,040 PSay (cAliasDTV)->DTV_LOCENT Picture PesqPict("DTV","DTV_LOCENT")	//Local de Retirada
		EndIf
		VerLin(@Li,10)
		@Li,035 PSay cNomAge	//--Nome Agente
		@Li,050 PSay cCodIATA  //--Codigo IATA
		VerLin(@Li,2)
		@Li,040 PSay (cAliasDTV)->DTV_DATEMI Picture PesqPict("DTV","DTV_DATEMI") //-- Data de Emissao
		@Li,060 PSay (cAliasDTV)->DTV_HOREMI Picture PesqPict("DTV","DTV_HOREMI") //-- Hora da Emissao
		VerLin(@Li,2)
		
		//-- Imprime a composicao do frete
		DT8->(DbSetOrder(3))		
		If lAWBRepete
			bBloco2 := { || DT8->(MsSeek(cSeek := xFilial("DT8") + (cAliasDTV)->DTV_NUMAWB + (cAliasDTV)->DTV_CODCIA + (cAliasDTV)->DTV_LOJCIA +  "WB")) }
		Else
			bBloco2 := { || DT8->(MsSeek(cSeek := xFilial("DT8") + (cAliasDTV)->DTV_NUMAWB +  "WB")) }
		EndIf

		If Eval(bBloco2)
			@ Li,01 PSay RetTitle('DT3_CODPAS')
			@ Li,22 PSay RetTitle('DT8_VALPAS')
			@ Li,37 PSay RetTitle('DT8_VALIMP')
			@ Li,52 PSay RetTitle('DT8_VALPAS') + ' + ' + RetTitle('DT8_VALIMP')
			VerLin(@Li,2)      
			
			If lAWBRepete     
				bBloco3 := { || DT8->( ! Eof() .And. DT8->DT8_FILIAL + DT8->DT8_NUMAWB + DT8->DT8_CODCIA + DT8->DT8_LOJCIA == ;
				 xFilial('DT8') + (cAliasDTV)->DTV_NUMAWB + (cAliasDTV)->DTV_CODCIA + (cAliasDTV)->DTV_LOJCIA ) }
			Else
				bBloco3 := { || DT8->( ! Eof() .And. DT8->DT8_FILIAL + DT8->DT8_NUMAWB == xFilial('DT8') + (cAliasDTV)->DTV_NUMAWB ) }				
			EndIf

			While Eval(bBloco3)
				If	DT8->DT8_CODPAS == '98'
					@ Li,01 PSay 'Seguro'
				ElseIf	DT8->DT8_CODPAS == 'TF'
					@ Li,01 PSay 'Total do Frete'
				Else
					@ Li,01 PSay Posicione('DT3', 1, xFilial('DT3') + DT8->DT8_CODPAS, 'DT3_DESCRI')
				EndIf				
				@ Li,22 PSay DT8->DT8_VALPAS Picture PesqPict('DT8','DT8_VALPAS')
				@ Li,37 PSay DT8->DT8_VALIMP Picture PesqPict('DT8','DT8_VALIMP')
				@ Li,52 PSay DT8->DT8_VALTOT Picture PesqPict('DT8','DT8_VALTOT')			
				VerLin(@Li,1)
				DT8->(DbSkip())
			EndDo

			VerLin(@Li,2)
				@Li,040 PSay UsrRetName((cAliasDTV)->DTV_USER) //--Nome e Assinatura do Emissor
			@Li,065 PSay cNumMat //--Numero da Matricula
		EndIf
	EndIf
	(cAliasDTV)->(dbSkip())
	Li:=10
EndDo
(cAliasDTV)->(dbCloseArea()	)
RestArea(aAreaSM0)
//��������������������������������������������������������������Ŀ
//� Se em disco, desvia para Spool                               �
//����������������������������������������������������������������
If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

RestArea ( aAreaSA2 )

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �VerLin    � Autor �Patricia A. Salomao    � Data �18.03.2002���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Soma Linha                                                 ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � VerLin(ExpN1,ExpN2)                                        ���
�������������������������������������������������������������������������Ĵ��
���Parametro � ExpN1 - No. da Linha atual                                 ���
���          � ExpN2 - No. de Linhas que devera ser somado                ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � RTMSR06			                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VerLin(Li,nSoma)
Li+=nSoma
Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �Imp_Nota  � Autor �Patricia A. Salomao    � Data �18.03.2002���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Imprime Notas Fiscais                                      ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � Imp_Nota(ExpN1)                                            ���
�������������������������������������������������������������������������Ĵ��
���Parametro � ExpN1 - No. da Linha atual                                 ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � RTMSR06			                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Imp_Nota(Li,aNotas)
Local nCol:=50
Local n   :=0

For n:= 1 To Len(aNotas)
	@Li,nCol PSay aNotas[n][1]+"/"
	nCol+=Len(aNotas[n][1])+2
Next
Return
      

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �AjustaSX1 � Autor �Raphael Zampieri       � Data �26/11/2008���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ajusta SX1                                                 ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � AjustaSX1()                                                ���
�������������������������������������������������������������������������Ĵ��
���Parametro �                                                            ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � RTMSR08                			                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AjustaSX1()

Local aRegs 	:= {}
Local aHelp 	:= {}
Local aHelpE 	:= {}
Local aHelpI 	:= {}
Local cHelp		:= ""
Local cPerg 	:= "RTMR08    "         
Local nTamFor	:= TamSX3("A2_COD")[1] 
Local nTamLoj	:= TamSX3("A2_LOJA")[1] 

dbSelectArea("SX1")  
dbSetOrder(1)          
If !SX1->(dbSeek("RTMR0804"))
//"X1_GRUPO","X1_ORDEM","X1_PERGUNT","X1_PERSPA","X1_PERENG","X1_VARIAVL","X1_TIPO","X1_TAMANHO","X1_DECIMAL","X1_PRESEL","X1_GSC","X1_VALID","X1_VAR01","X1_DEF01","X1_DEFSPA1","X1_DEFENG1","X1_CNT01","X1_VAR02","X1_DEF02","X1_DEFSPA2","X1_DEFENG2","X1_CNT02","X1_VAR03","X1_DEF03","X1_DEFSPA3","X1_DEFENG3","X1_CNT03","X1_VAR04","X1_DEF04","X1_DEFSPA4","X1_DEFENG4","X1_CNT04","X1_VAR05","X1_DEF05","X1_DEFSPA5","X1_DEFENG5","X1_CNT05","X1_F3","X1_PYME","X1_GRPSXG","X1_HELP","X1_PICTURE"}
	Aadd(aRegs,{cPerg,"04","Codigo da Companhia De","Codigo da Companhia De","Codigo da Companhia De","mv_ch4","C",nTamFor,0,0,"G","","mv_par04"   ,"","","","","","","","","","","","","","","","","","","","","","","","","SA2","N","",aHelp,aHelpI,aHelpE,cHelp})
	Aadd(aRegs,{cPerg,"05","Codigo da Companhia At�","Codigo da Companhia At�","Codigo da Companhia At�","mv_ch5","C",nTamFor,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","SA2","N","",aHelp,aHelpI,aHelpE,cHelp})	
	Aadd(aRegs,{cPerg,"06","Loja da Companhia De","Loja da Companhia De","Loja da Companhia De","mv_ch6","C",nTamLoj,0,0,"G","","mv_par06"         ,"","","","","","","","","","","","","","","","","","","","","","","","","SA2","N","",aHelp,aHelpI,aHelpE,cHelp})
	Aadd(aRegs,{cPerg,"07","Loja da Companhia At�","Loja da Companhia At�","Loja da Companhia At�","mv_ch7","C",nTamLoj,0,0,"G","","mv_par7"     ,"","","","","","","","","","","","","","","","","","","","","","","","","SA2","N","",aHelp,aHelpI,aHelpE,cHelp})

ValidPerg(aRegs,cPerg,.T.)
EndIf

Return