#INCLUDE "protheus.ch"
#INCLUDE "RTMSR19.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � RTMSR19  � Autor � Richard Anderson      � Data �21.12.2006���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Impressao Carta de Corre��o                                ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � RTMSR19                                                    ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � SIGATMS                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function RTMSR19()

Local titulo  := STR0001 //"Carta de Corre��o
Local cString := "DIC"
Local wnrel   := "RTMSR19"
Local cDesc1  := STR0002 //"Este programa ira imprimir a Carta de Corre��o"
Local cDesc2  := ""
Local cDesc3  := ""
Local tamanho := "P"
Local Limite  := 80
Local cPerg   := "RTMR19"
Local aOrd    := {}

Private aReturn  := {STR0003,1,STR0004,2, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private nLastKey := 0

//��������������������������������������������������������������Ŀ
//� Verifica as perguntas                                        �
//����������������������������������������������������������������
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01            	// Fil.Documento De                   �
//� mv_par02            	// Documento De       	         	  �
//� mv_par03            	// Serie De        	      		     �
//� mv_par04            	// Fil.Documento Ate  		           �
//� mv_par05            	// Documento Ate	   		           �
//� mv_par06            	// Serie Ate            	           �
//� mv_par07            	// Sequencia De         	           �
//� mv_par08            	// Sequencia Ate        	           �
//� mv_par09            	// Impressao / Reimpressao            �
//����������������������������������������������������������������
pergunte(cPerg,.F.)

wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,,Tamanho)

If nLastKey = 27
	Set Filter To
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Set Filter To
	Return
Endif

RptStatus({|lEnd| RTMSR19Imp(@lEnd,wnRel,titulo,tamanho,Limite)},titulo)

Return NIL

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �RTMSR19Imp� Autor � Richard Anderson      � Data �22.11.2006���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Chamada do Relat�rio                                       ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � RTMSR19			                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RTMSR19Imp(lEnd,wnRel,titulo,tamanho,Limite)
//��������������������������������������������������������������Ŀ
//� Define Variaveis                                             �
//����������������������������������������������������������������
Local   nX       := 0
Local   nLinAnt  := 0
Local   nObs     := 0
Local   cObs     := ''
Local   cAliasQry:= GetNextAlias()
Local   cQuery   := ''
Local   aAreaAtu := GetArea()
Local   aStruDIC := DIC->(dbStruct())
Local   aAreaDTC := DTC->(GetArea())
Local   nLin     := 99
Local   nPag     := 0
Local   aPages   := {}
Local   cChave   := ''
Local   lTem13   := .F.

SetRegua(DIC->(LastRec()))

cQuery := "SELECT DIC.*, DIC.R_E_C_N_O_ RECNODIC, DIM_CPODOC, DIM_CODODC, DIM_CODDVC, DT6_SIGTRA FROM "
cQuery += RetSqlName("DIC")+" DIC, "
cQuery += RetSqlName("DIM")+" DIM, "
cQuery += RetSqlName("DT6")+" DT6  "
cQuery += " WHERE DIC.DIC_FILIAL = '"+xFilial("DID")+"'"
cQuery += "   AND DIC.DIC_FILDOC BETWEEN '"+mv_par01+"' AND '"+mv_par04+"'"
cQuery += "   AND DIC.DIC_DOC    BETWEEN '"+mv_par02+"' AND '"+mv_par05+"'"
cQuery += "   AND DIC.DIC_SERIE  BETWEEN '"+mv_par03+"' AND '"+mv_par06+"'"
cQuery += "   AND DIC.DIC_SEQUEN BETWEEN '"+mv_par07+"' AND '"+mv_par08+"'"
cQuery += "   AND DIC.DIC_FIMP   IN "+Iif(mv_par09 == 1,"( ' ', '0')","( '1' )")
cQuery += "   AND DIC.D_E_L_E_T_ = ' '" 
cQuery += "   AND DIM.DIM_FILIAL = '"+xFilial('DIM')+"'"
cQuery += "   AND DIM.DIM_FILDOC = DIC_FILDOC"
cQuery += "   AND DIM.DIM_DOC    = DIC_DOC"
cQuery += "   AND DIM.DIM_SERIE  = DIC_SERIE"
cQuery += "   AND DIM.DIM_SEQUEN = DIC_SEQUEN"
cQuery += "   AND DIM.D_E_L_E_T_ = ' '"
cQuery += "   AND DT6.DT6_FILIAL = '"+xFilial('DT6')+"'"
cQuery += "   AND DT6.DT6_FILDOC = DIC_FILDOC"
cQuery += "   AND DT6.DT6_DOC    = DIC_DOC"
cQuery += "   AND DT6.DT6_SERIE  = DIC_SERIE"
cQuery += "   AND DT6.D_E_L_E_T_ = ' '"
cQuery += "   ORDER BY DIC_FILIAL,DIC_FILDOC,DIC_DOC,DIC_SERIE,DIC_SEQUEN"
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry)
For nX := 1 To Len(aStruDIC)
	If aStruDIC[nX][2]<>"C"
		TcSetField(cAliasQry,aStruDIC[nX][1],aStruDIC[nX][2],aStruDIC[nX][3],aStruDIC[nX][4])
	EndIf
Next nX  
	
While (cAliasQry)->(!Eof())

	cChave := (cAliasQry)->(DIC_FILIAL+DIC_FILDOC+DIC_DOC+DIC_SERIE+DIC_SEQUEN) 
	nLin:= 99
	
	While (cAliasQry)->(!Eof()) .And. cChave == (cAliasQry)->(DIC_FILIAL+DIC_FILDOC+DIC_DOC+DIC_SERIE+DIC_SEQUEN)		
		
		IncRegua()
					
		If Interrupcao(@lEnd)
			Exit
		EndIf
		
		If nLin > 62
			RTMSR19Cab(cAliasQry,@nLin,@nPag,@aPages,.T.,Limite)
		EndIf
		
		nLinAnt:= nLin
		aPages[nPag,2,nLin] := STR0015 //"Ref.Campo Onde Consta"
		nLin += 1
		aPages[nPag,2,nLin] := "--------- --------------------------------------------------------------------"
		nLin += 1
		aPages[nPag,2,nLin] := (cAliasQry)->DIM_CPODOC+Space(8)
		cObs   := StrTran(MsMM((cAliasQry)->DIM_CODODC,80),Chr(10),'')
		cDados := ''
		lTem13 := .F.
		For nObs := 1 To Len(cObs)
			If Substr(cObs,nObs,1) == Chr(13)
			   lTem13 := .T.
				If nLin > 62
					RTMSR19Cab(cAliasQry,@nLin,@nPag,@aPages,.F.,Limite)
					nLinAnt := nLin
				EndIf
				If Empty(aPages[nPag,2,nLin])
					aPages[nPag,2,nLin] += Space(10)
				EndIf
				aPages[nPag,2,nLin] += cDados
				nObs   += 1
				nLin   += 1
				cDados := ''
				//-- Verifica linhas em branco
				While Substr(cObs,nObs,1) == Chr(13)
					nObs += 1
				EndDo
			EndIf
			cDados += Substr(cObs,nObs,1)
		Next nObs   
		If !lTem13
			If nLin > 62
				RTMSR19Cab(cAliasQry,@nLin,@nPag,@aPages,.F.,Limite)
				nLinAnt := nLin
			EndIf
			If Empty(aPages[nPag,2,nLin])
				aPages[nPag,2,nLin] += Space(10)
			EndIf
			aPages[nPag,2,nLin] += cDados
		EndIf
		nLin += 1				
		aPages[nPag,2,nLin] := Space(10)+STR0016 //"Devera Constar"
		nLin += 1
		aPages[nPag,2,nLin] := Space(10)+"--------------------------------------------------------------------"
		nLin += 1
		cObs   := StrTran(MsMM((cAliasQry)->DIM_CODDVC,80),Chr(10),'')
		cDados := '' 
		lTem13 := .F.
		For nObs := 1 To Len(cObs)
			If Substr(cObs,nObs,1) == Chr(13) 
			   lTem13 := .T.
				If nLin > 62
					RTMSR19Cab(cAliasQry,@nLin,@nPag,@aPages,.F.,Limite)
					nLinAnt := nLin
				EndIf
				If Empty(aPages[nPag,2,nLin])
					aPages[nPag,2,nLin] += Space(10)
				EndIf
				aPages[nPag,2,nLin] += cDados
				nObs   += 1
				nLin   += 1
				cDados := ''
				//-- Verifica linhas em branco
				While Substr(cObs,nObs,1) == Chr(13)
					nObs += 1
				EndDo
			EndIf
			cDados += Substr(cObs,nObs,1)
		Next nObs
		If !lTem13
			If nLin > 62
				RTMSR19Cab(cAliasQry,@nLin,@nPag,@aPages,.F.,Limite)
				nLinAnt := nLin
			EndIf
			If Empty(aPages[nPag,2,nLin])
				aPages[nPag,2,nLin] += Space(10)
			EndIf
			aPages[nPag,2,nLin] += cDados
		EndIf
		
		If nLin <= nLinAnt
			nLin := nLinAnt
		EndIf
		
		nLin += 1
		
		If nLin > 62
			RTMSR19Cab(cAliasQry,@nLin,@nPag,@aPages,.T.,Limite)
		EndIf
		
		//-- Atualiza flag de impressao
		DIC->(dbGoTo((cAliasQry)->RECNODIC))
		RecLock('DIC',.F.)
		DIC->DIC_FIMP := '1' //-- Impresso
		MsUnLock()
		
		(cAliasQry)->(dbSkip())			
		
	EndDo	
EndDo

If nPag > 0
	nLin += 2
	aPages[nPag,2,nLin] := STR0012 //-- "Sem outro motivo para o momento, subscrevemo-nos."
	nLin += 3
	aPages[nPag,2,nLin] := Padl(STR0013,67) //-- "Atenciosamente"
EndIf

For nPag := 1 To Len(aPages)
	For nLin := 1 To Len(aPages[nPag,2])
		If nLin == 1
			@ nLin,00 PSay AvalImp(Limite)+__PrtLogo()
		ElseIf nLin == 3
		@ nLin,00 PSay Padl(STR0014+StrZero(nPag,2)+'/'+StrZero(Len(aPages),2),Limite) //-- "Folha "
		Else
			@ nLin,00 Psay aPages[nPag,2,nLin]
		EndIf
	Next nLin
Next nPag

(cAliasQry)->(dbCloseArea())

//��������������������������������������������������������������Ŀ
//� Se em disco, desvia para Spool                               �
//����������������������������������������������������������������
If aReturn[5] == 1
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
Endif

MS_FLUSH()

RestArea(aAreaDTC)
RestArea(aAreaAtu)

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �RTMSR19Cab� Autor � Richard Anderson      � Data �23.11.2007���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Impress�o do cabe�alho                                     ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � RTMSR19			                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RTMSR19Cab(cAliasQry,nLin,nPag,aPages,lImpCab,Limite)

Local   nI       := 0
Local   nObs     := 0
Local   cObs     := ''
Local   aDoctos  := Array(3)
Local   cDoctos  := ''
Local   cSeekDTC := ''
Default lImpCab  := .T.

nPag += 1
nLin := 5
Aadd(aPages,{ StrZero(nPag,2), Array(62) })
For nI := 1 To 62
	aPages[nPag,2,nI] := ''
Next nI
If lImpCab
	aPages[nPag,2,nLin] := Padl(AllTrim(SM0->M0_CIDCOB)+', '+AllTrim(Str(Day((cAliasQry)->DIC_DATCAR),2))+" de "+AllTrim(MesExtenso(Month((cAliasQry)->DIC_DATCAR)))+" de "+Str(Year((cAliasQry)->DIC_DATCAR),4),Limite)
	nLin += 2
	aPages[nPag,2,nLin] := 'A'
	nLin += 1
	cObs := StrTran(MsMM((cAliasQry)->DIC_CODENV,80),Chr(10),'')
	cDados := ''
	For nObs := 1 To Len(cObs)
		If Substr(cObs,nObs,1) == Chr(13)
			aPages[nPag,2,nLin] := cDados
			nObs   += 1
			nLin   += 1
			cDados := ''
			//-- Verifica linhas em branco
			While Substr(cObs,nObs,1) == Chr(13)
				nI   += 1
				nObs += 1
			EndDo
		EndIf
		cDados += Substr(cObs,nObs,1)
	Next nObs
	nLin += 2
	aPages[nPag,2,nLin] := Padc(STR0006,Limite) //-- 'CARTA DE CORRE��O'
	nLin += 1
	aPages[nPag,2,nLin] := Padc('-----------------',Limite)
	nLin += 2
	aPages[nPag,2,nLin] := STR0007 //-- 'Ref.: Confer�ncia de documento fiscal e comunica��o de incorre��es'
	nLin += 1
	aPages[nPag,2,nLin] := '      CRT  No.: '+Transform((cAliasQry)->(DT6_SIGTRA+DIC_SERIE+DIC_DOC),"@R AA.XXX.XXXXXX")
	nLin += 1
	aPages[nPag,2,nLin] := '      FACT.No.: '
	nI := 0
	cDoctos := ''
	aFill(aDoctos,Space(65))
	DTC->(dbSetOrder(3))
	DTC->(MsSeek(cSeekDTC := xFilial('DTC')+(cAliasQry)->(DIC_FILDOC+DIC_DOC+DIC_SERIE)))
	While DTC->(!Eof()) .And. DTC->(DTC_FILIAL+DTC_FILDOC+DTC_DOC+DTC_SERIE) == cSeekDTC
		If Len(cDoctos) > 65
			nI += 1
			If nI > 3
				Exit
			EndIf
			aDoctos[nI] := Substr(cDoctos,1,65)
			cDoctos     := AllTrim(Substr(cDoctos,66))
		EndIf			
		If !Empty(cDoctos)
			cDoctos += '/'
		EndIf
		cDoctos += DTC->DTC_NUMNFC
		DTC->(dbSkip())
	EndDo
	If !Empty(cDoctos) .And. (nI+1) <= 3
		nI += 1
		aDoctos[nI] := Substr(cDoctos,1,65)
	EndIf		
	For nI := 1 To Len(aDoctos)
		aPages[nPag,2,nLin] := aDoctos[nI]
	Next nI
	nLin += 3
	aPages[nPag,2,nLin] := STR0008 //-- "Em face do que determina a legisla��o fiscal  vigente  vimos  pela"
	nLin += 1
	aPages[nPag,2,nLin] := STR0009 //-- "presente comunicar que o conhecimento  em  refer�ncia  contem a(s)"
	nLin += 1
	aPages[nPag,2,nLin] := STR0010 //-- "irregularidade(s) que abaixo apontamos:"
	nLin += 3
EndIf

Return NIL
