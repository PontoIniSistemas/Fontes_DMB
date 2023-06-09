#INCLUDE "protheus.ch"
#INCLUDE "RTMSR21.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � RTMSR21  � Autor � Richard Anderson      � Data �21.12.2006���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Impressao Nota de Debito/Credito                           ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � RTMSR21                                                    ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � SIGATMS                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function RTMSR21()

Local titulo  := STR0001 //"Nota de D�bito/Cr�dito
Local cString := "DIH"
Local wnrel   := "RTMSR21"
Local cDesc1  := STR0002 //"Este programa ira imprimir a Nota de D�bito/Cr�dito
Local cDesc2  := ""
Local cDesc3  := ""
Local tamanho := "P"
Local Limite  := 80
Local cPerg   := "RTMR21"
Local aOrd    := {}

Private aReturn  := {STR0003,1,STR0004,2, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private nLastKey := 0

//��������������������������������������������������������������Ŀ
//� Verifica as perguntas                                        �
//����������������������������������������������������������������
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01            	// No.Nota de                         �
//� mv_par02            	// No.Nota Ate        	         	  �
//� mv_par03            	// Data Emissao de 	      		     �
//� mv_par04            	// Data Emissao Ate   		           �
//� mv_par05            	// Impressao / Reimpressao            �
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

RptStatus({|lEnd| RTMSR21Imp(@lEnd,wnRel,titulo,tamanho,Limite)},titulo)

Return NIL

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �RTMSR21Imp� Autor � Richard Anderson      � Data �22.11.2006���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Chamada do Relat�rio                                       ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � RTMSR21			                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RTMSR21Imp(lEnd,wnRel,titulo,tamanho,Limite)
//��������������������������������������������������������������Ŀ
//� Define Variaveis                                             �
//����������������������������������������������������������������
Local  nObs      := 0
Local  cObs      := ''
Local  cDados    := ''
Local  nLin      := 0, nI := 0, nX := 0
Local  cAliasQry := GetNextAlias()
Local  cQuery    := ''
Local  aAreaAtu  := GetArea()
Local  aStruDIH  := DIH->(dbStruct())
Local  cExtenso  := ''

SetRegua(DIH->(LastRec()))

cQuery := "SELECT DIH.*, DIH.R_E_C_N_O_ RECNODIH, DT6_SIGTRA, DT6_TIPTRA, DT6_CLIDEV, DT6_LOJDEV FROM "
cQuery += RetSqlName("DIH")+" DIH, "
cQuery += RetSqlName("DT6")+" DT6  "
cQuery += " WHERE DIH.DIH_FILIAL = '"+xFilial("DIH")+"'"
cQuery += "   AND DIH.DIH_NUMNDC BETWEEN '"+mv_par01+"' AND '"+mv_par02+"'"
cQuery += "   AND DIH.DIH_DATEMI BETWEEN '"+Dtos(mv_par03)+"' AND '"+Dtos(mv_par04)+"'"
cQuery += "   AND DIH.DIH_STATUS IN ( '1', '2' )"
cQuery += "   AND DIH.DIH_FIMP   IN "+Iif(mv_par05 == 1,"( ' ', '0')","( '1' )")
cQuery += "   AND DIH.D_E_L_E_T_ = ' '" 
cQuery += "   AND DT6.DT6_FILIAL = '"+xFilial('DT6')+"'"
cQuery += "   AND DT6.DT6_FILDOC = DIH_FILDOC"
cQuery += "   AND DT6.DT6_DOC    = DIH_DOC"
cQuery += "   AND DT6.DT6_SERIE  = DIH_SERIE"
cQuery += "   AND DT6.D_E_L_E_T_ = ' '"
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry)
For nX := 1 To Len(aStruDIH)
	If aStruDIH[nX][2]<>"C"
		TcSetField(cAliasQry,aStruDIH[nX][1],aStruDIH[nX][2],aStruDIH[nX][3],aStruDIH[nX][4])
	EndIf
Next nX
While (cAliasQry)->(!Eof())

	IncRegua()
	
	If Interrupcao(@lEnd)
		Exit
	EndIf
	
	nLin := 1
	@ nLin,00 PSay AvalImp(Limite)+__PrtLogo()
	nLin += 1
	
	@ nLin,00 PSay Padl(AllTrim(SM0->M0_CIDCOB)+', '+AllTrim(Str(Day((cAliasQry)->DIH_DATEMI),2))+" de "+AllTrim(MesExtenso(Month((cAliasQry)->DIH_DATEMI)))+" de "+Str(Year((cAliasQry)->DIH_DATEMI),4),Limite)
	nLin += 3
	@ nLin,02 PSay 'A'
	nLin += 1
	aDadCli := TMSDadCli((cAliasQry)->DT6_CLIDEV,(cAliasQry)->DT6_LOJDEV)
	For nI := 1 To Len(aDadCli)
		@ nLin,02 PSay aDadCli[nI]
		nLin+= 1
	Next nI
	nLin += 4
	@ nLin,00 PSay Padc('N O T A  D E  '+Iif((cAliasQry)->DIH_TIPNDC == '1','D E B I T O','C R E D I T O'),Limite)
	nLin += 1
	@ nLin,00 PSay Padc('--------------'+Iif((cAliasQry)->DIH_TIPNDC == '1','-----------','-------------'),Limite)
	nLin += 3
	@ nLin,02 PSay 'Referente Docto.: '+Iif((cAliasQry)->DT6_TIPTRA == '4',Transform((cAliasQry)->(DT6_SIGTRA+DIH_SERIE+DIH_DOC),"@R AA.XXX.XXXXXX"),Transform((cAliasQry)->(DIH_FILDOC+DIH_DOC+DIH_SERIE),"@R 99 999999-XXX"))
	nLin += 3
	@ nLin,02 PSay 'Motivo..........: '
	cObs   := StrTran(MsMM((cAliasQry)->DIH_CODMOT,80),Chr(10),'')
	cDados := ''
	For nObs := 1 To Len(cObs)
		If Substr(cObs,nObs,1) == Chr(13)
			@ nLin,20 PSay cDados
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
	nLin += 3
	@ nLin,02 PSay 'Valor...........: '+Transform((cAliasQry)->DIH_VALOR,"@E 99,999,999.99")
	nLin += 1
	cExtenso := Extenso((cAliasQry)->DIH_VALOR)
	@ nLin,18 PSay '('+Padr(cExtenso,60,'*')+' )'
	nLin += 1
	@ nLin,18 PSay '('+Replicate('*',60)+' )'
	nLin += 3
	@ nLin,02 PSay 'Sem outro motivo para o momento, subscrevemo-nos.'
	nLin += 3
	@ nLin,00 PSay Padl('Atenciosamente',67)

	//-- Atualiza flag de impressao
	DIH->(dbGoTo((cAliasQry)->RECNODIH))
	RecLock('DIH',.F.)
	DIH->DIH_FIMP := '1' //-- Impresso
	MsUnLock()
		
	(cAliasQry)->(dbSkip())
	
EndDo	

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

RestArea(aAreaAtu)

Return
