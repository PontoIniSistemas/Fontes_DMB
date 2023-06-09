#INCLUDE "protheus.ch"
#INCLUDE "RTMSR18.ch"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � RTMSR18  � Autor � Richard Anderson      � Data �21.12.2006���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Impressao MIC/DTA                                          ���
�������������������������������������������������������������������������Ĵ��
���Sintaxe   � RTMSR18                                                    ���
�������������������������������������������������������������������������Ĵ��
���Parametros�                                                            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � SIGATMS                                                    ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function RTMSR18()

Local titulo  := STR0001 //"MIC/DTA"
Local cString := "DID"
Local wnrel   := "RTMSR18"
Local cDesc1  := STR0002 //"Este programa ira imprimir o MIC/DTA"
Local cDesc2  := ""
Local cDesc3  := ""
Local nZ      := 0
Local cPerg   := "RTMR18"
Local aOrd    := {}

Private aReturn  := {STR0003,1,STR0004,2, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private nLastKey := 0
Private Tamanho  := "M"
Private Limite   := 132 // 80/132/220

//��������������������������������������������������������������Ŀ
//� Verifica as perguntas                                        �
//����������������������������������������������������������������
//��������������������������������������������������������������Ŀ
//� Variaveis utilizadas para parametros                         �
//� mv_par01            	// Fil.Origem De		                 �
//� mv_par02            	// Viagem De          	         	  �
//� mv_par03            	// Fil.Origem Ate  	      		     �
//� mv_par04            	// Viagem Ate         		           �
//� mv_par05            	// Veiculo De   	   		           �
//� mv_par06            	// Veiculo Ate          	           �
//� mv_par07            	// Item MIC/DTA De      	           �
//� mv_par08            	// Item MIC/DTA Ate     	           �
//� mv_par09            	// Impressao / Reimpressao            �
//����������������������������������������������������������������
pergunte("RTMR18",.F.)

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

RptStatus({|lEnd| RTMSR18Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

Return NIL

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    �RTMSR18Imp� Autor � Richard Anderson      � Data �22.11.2006���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Chamada do Relat�rio                                       ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � RTMSR18			                                            ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function RTMSR18Imp(lEnd,wnRel,titulo,tamanho)
//��������������������������������������������������������������Ŀ
//� Define Variaveis                                             �
//����������������������������������������������������������������
Local  nLin         := 0, nI := 0
Local  cAliasQry    := GetNextAlias()
Local  cQuery       := ''
Local  aAreaAtu     := GetArea()
Local  aAreaSM0     := SM0->(GetArea())
Local  cReboque     := ''
Local  aDadCli      := {}
Local  aDocAne      := {}
Local  aObsDoc      := {}
Local  nQtdDoc      := 0
Local  nTotVol      := 0
Local  nTotPes      := 0
Local  nVolAnt      := 0
Local  nPesAnt      := 0
Local  nVolAcu      := 0
Local  nPesAcu      := 0
Local  aDadMIC      := {}
Local	 cFilMIC      := ''
Local  cNumMIC      := ''
Local	 cCodVei      := ''
Local	 cIteMIC      := ''

SetRegua(DID->(LastRec()))

cQuery := "SELECT * FROM ("
cQuery += "SELECT DT6_FILDOC, DT6_DOC  , DT6_SERIE , DID_FILORI, DID_VIAGEM, DID_CODVEI, DII_ITEMIC, DII_CDAORI, DII_CDADES, DID_QTDDOC , "
cQuery += "       DT6_QTDVOL, DT6_PESO , DT6_PESOM3, DT6_VALMER, DID_FILMIC, DID_NUMMIC, DID_DATMIC, DTQ_ROTA  , DII.R_E_C_N_O_ RECNODII, "
cQuery += "       DT6_SIGTRA, DT6_MOEDA, DT6_VALTOT, DID_QTDFOL, DII_NUMFOL "
cQuery += " FROM "
cQuery += RetSqlName("DID")+" DID, "
cQuery += RetSqlName("DII")+" DII, "
cQuery += RetSqlName("DT6")+" DT6, "
cQuery += RetSqlName("DTQ")+" DTQ  "
cQuery += " WHERE DID.DID_FILIAL = '"+xFilial("DID")+"'"
cQuery += "   AND DID.DID_FILORI BETWEEN '"+mv_par01+"' AND '"+mv_par03+"'"
cQuery += "   AND DID.DID_VIAGEM BETWEEN '"+mv_par02+"' AND '"+mv_par04+"'"
cQuery += "   AND DID.DID_CODVEI BETWEEN '"+mv_par05+"' AND '"+mv_par06+"'"
cQuery += "   AND DID.D_E_L_E_T_  = ' '" 
cQuery += "   AND DII.DII_FILIAL  = '"+xFilial("DII")+"'"
cQuery += "   AND DII.DII_FILMIC  = DID_FILMIC"
cQuery += "   AND DII.DII_NUMMIC  = DID_NUMMIC"
cQuery += "   AND DII.DII_CODVEI  = DID_CODVEI"
cQuery += "   AND DII.DII_IMPMIC IN "+Iif(mv_par09 == 1,"( ' ', '0')","( '1' )")
cQuery += "   AND DII.D_E_L_E_T_  = ' '"
cQuery += "   AND DT6.DT6_FILIAL  = '"+xFilial("DT6")+"'"
cQuery += "   AND DT6.DT6_FILDOC  = DII_FILDOC"
cQuery += "   AND DT6.DT6_DOC     = DII_DOC"
cQuery += "   AND DT6.DT6_SERIE   = DII_SERIE"
cQuery += "   AND DT6.DT6_DOCTMS <> 'K'"
cQuery += "   AND DT6.D_E_L_E_T_  = ' '"
cQuery += "   AND DTQ.DTQ_FILIAL  = '"+xFilial("DTQ")+"'"
cQuery += "   AND DTQ.DTQ_FILORI  = DID_FILORI"
cQuery += "   AND DTQ.DTQ_VIAGEM  = DID_VIAGEM"
cQuery += "   AND DTQ.DTQ_TIPVIA IN ( '1', '3' )"
cQuery += "   AND DTQ.D_E_L_E_T_  = ' '"
cQuery += " UNION ALL "
cQuery += "SELECT DT6_FILDCO DT6_FILDOC, DT6_DOCDCO DT6_DOC  , DT6_SERDCO DT6_SERIE , DID_FILORI, DID_VIAGEM, DID_CODVEI, DII_ITEMIC, DII_CDAORI, DII_CDADES, DID_QTDDOC , "
cQuery += "       DT6_QTDVOL           , DT6_PESO            , DT6_PESOM3           , DT6_VALMER, DID_FILMIC, DID_NUMMIC, DID_DATMIC, DTQ_ROTA  , DII.R_E_C_N_O_ RECNODII, "
cQuery += "       DT6_SIGTRA           , DT6_MOEDA           , DT6_VALTOT           , DID_QTDFOL, DII_NUMFOL "
cQuery += " FROM "
cQuery += RetSqlName("DID")+" DID, "
cQuery += RetSqlName("DII")+" DII, "
cQuery += RetSqlName("DT6")+" DT6, "
cQuery += RetSqlName("DTQ")+" DTQ  "
cQuery += " WHERE DID.DID_FILIAL = '"+xFilial("DID")+"'"
cQuery += "   AND DID.DID_FILORI BETWEEN '"+mv_par01+"' AND '"+mv_par03+"'"
cQuery += "   AND DID.DID_VIAGEM BETWEEN '"+mv_par02+"' AND '"+mv_par04+"'"
cQuery += "   AND DID.DID_CODVEI BETWEEN '"+mv_par05+"' AND '"+mv_par06+"'"
cQuery += "   AND DID.D_E_L_E_T_  = ' '" 
cQuery += "   AND DII.DII_FILIAL  = '"+xFilial("DII")+"'"
cQuery += "   AND DII.DII_FILMIC  = DID_FILMIC"
cQuery += "   AND DII.DII_NUMMIC  = DID_NUMMIC"
cQuery += "   AND DII.DII_CODVEI  = DID_CODVEI"
cQuery += "   AND DII.DII_IMPMIC IN "+Iif(mv_par09 == 1,"( ' ', '0')","( '1' )")
cQuery += "   AND DII.D_E_L_E_T_  = ' '"
cQuery += "   AND DT6.DT6_FILIAL  = '"+xFilial("DT6")+"'"
cQuery += "   AND DT6.DT6_FILDOC  = DII_FILDOC"
cQuery += "   AND DT6.DT6_DOC     = DII_DOC"
cQuery += "   AND DT6.DT6_SERIE   = DII_SERIE"
cQuery += "   AND DT6.DT6_DOCTMS  = 'K'"
cQuery += "   AND DT6.D_E_L_E_T_  = ' '"
cQuery += "   AND DTQ.DTQ_FILIAL  = '"+xFilial("DTQ")+"'"
cQuery += "   AND DTQ.DTQ_FILORI  = DID_FILORI"
cQuery += "   AND DTQ.DTQ_VIAGEM  = DID_VIAGEM"
cQuery += "   AND DTQ.DTQ_TIPVIA IN ( '1', '3' )"
cQuery += "   AND DTQ.D_E_L_E_T_  = ' '" 
cQuery += " UNION ALL "
cQuery += "SELECT ' ' DT6_FILDOC, ' ' DT6_DOC  , ' ' DT6_SERIE  ,   DID_FILORI  , DID_VIAGEM, DID_CODVEI, '"+StrZero(1,Len(DII->DII_ITEMIC))+"' DII_ITEMIC, ' ' DII_CDAORI, ' ' DII_CDADES, 0 DID_QTDDOC , "
cQuery += "       0   DT6_QTDVOL, 0   DT6_PESO , 0   DT6_PESOM3 , 0 DT6_VALMER  , DID_FILMIC, DID_NUMMIC, DID_DATMIC, DTQ_ROTA  , 0 RECNODII, "
cQuery += "       ' ' DT6_SIGTRA, 0   DT6_MOEDA, 0   DT6_VALTOT,   DID_QTDFOL   , ' ' DII_NUMFOL "
cQuery += " FROM "
cQuery += RetSqlName("DID")+" DID, "
cQuery += RetSqlName("DTQ")+" DTQ  "
cQuery += " WHERE DID.DID_FILIAL = '"+xFilial("DID")+"'"
cQuery += "   AND DID.DID_FILORI BETWEEN '"+mv_par01+"' AND '"+mv_par03+"'"
cQuery += "   AND DID.DID_VIAGEM BETWEEN '"+mv_par02+"' AND '"+mv_par04+"'"
cQuery += "   AND DID.DID_CODVEI BETWEEN '"+mv_par05+"' AND '"+mv_par06+"'"
cQuery += "   AND DID.D_E_L_E_T_  = ' '" 
cQuery += "   AND DTQ.DTQ_FILIAL  = '"+xFilial("DTQ")+"'"
cQuery += "   AND DTQ.DTQ_FILORI  = DID_FILORI"
cQuery += "   AND DTQ.DTQ_VIAGEM  = DID_VIAGEM"
cQuery += "   AND DTQ.DTQ_TIPVIA IN ( '2', '4' )"
cQuery += "   AND DTQ.D_E_L_E_T_  = ' ') MIC_QRY" 
cQuery += " ORDER BY DID_FILORI,DID_VIAGEM,DID_CODVEI,DII_ITEMIC"
cQuery := ChangeQuery(cQuery)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasQry)
TcSetField(cAliasQry,"DT6_QTDVOL","N",TamSX3("DT6_QTDVOL")[1],TamSX3("DT6_QTDVOL")[2])
TcSetField(cAliasQry,"DT6_PESO"  ,"N",TamSX3("DT6_PESO"  )[1],TamSX3("DT6_PESO"  )[2])
TcSetField(cAliasQry,"DT6_PESOM3","N",TamSX3("DT6_PESOM3")[1],TamSX3("DT6_PESOM3")[2])
TcSetField(cAliasQry,"DT6_VALMER","N",TamSX3("DT6_VALMER")[1],TamSX3("DT6_VALMER")[2])
TcSetField(cAliasQry,"DID_DATMIC","D",TamSX3("DID_DATMIC")[1],TamSX3("DID_DATMIC")[2])
TcSetField(cAliasQry,"DT6_MOEDA" ,"N",TamSX3("DT6_MOEDA" )[1],TamSX3("DT6_MOEDA" )[2])
TcSetField(cAliasQry,"DT6_VALTOT","N",TamSX3("DT6_VALTOT")[1],TamSX3("DT6_VALTOT")[2])
While (cAliasQry)->(!Eof())

	cFilOri := (cAliasQry)->DID_FILORI
	cViagem := (cAliasQry)->DID_VIAGEM
	cCodVei := (cAliasQry)->DID_CODVEI
	nTotVol := 0
	nTotPes := 0
	nVolAnt := 0
	nPesAnt := 0
	nVolAcu := 0
	nPesAcu := 0
	nQtdDoc := 0
	
	While (cAliasQry)->(!Eof()) .And. (cAliasQry)->(DID_FILORI+DID_VIAGEM+DID_CODVEI) == cFilOri+cViagem+cCodVei
	
		IncRegua()
	
		If Interrupcao(@lEnd)
			Exit
		EndIf
		
		//-- Soma Volume e Peso de paginas anteriores
		If (cAliasQry)->DII_ITEMIC < mv_par07 .Or. (cAliasQry)->DII_ITEMIC > mv_par08
			nVolAnt += (cAliasQry)->DT6_QTDVOL
			nPesAnt += (cAliasQry)->DT6_PESO
			(cAliasQry)->(dbSkip())
			Loop
		EndIf			
		
		SM0->(dbSetOrder(1))
		SM0->(dbSeek(cEmpAnt+(cAliasQry)->DID_FILMIC))
		
		cFilMIC := (cAliasQry)->DID_FILMIC
		cNumMIC := (cAliasQry)->DID_NUMMIC
		cIteMIC := (cAliasQry)->DII_ITEMIC
		
		//-- Controle de Impressao
		nLin := 0
		@ nLin,000 PSay AvalImp(Limite)
			
		If (cAliasQry)->DII_ITEMIC == StrZero(1,Len(DII->DII_ITEMIC)) //-- Caratola
		   //-- Campo 03: Transporte Aduaneiro
		   nLin := 4				
		   If DID->DID_TRANAD == '1'
				@ nLin,050 PSay "X"
			Else
				@ nLin,057 PSay "X"			
			EndIf				
		ElseIf nQtdDoc == 0 .Or. nQtdDoc == 2
			nLin := 4
			nQtdDoc := 0
		EndIf
					
		//-- Campo 04: Numero MIC/DTA
		@ nLin,070 PSay Transform((cAliasQry)->DID_NUMMIC,PesqPict("DID","DID_NUMMIC"))
		
		nLin += 2
		//-- Campo 05: Folha
		@ nLin,050 PSay (cAliasQry)->DII_NUMFOL+"/"+(cAliasQry)->DID_QTDFOL
		
		//-- Campo 06: Data de emiss�o
		@ nLin,070 PSay (cAliasQry)->DID_DATMIC
		
		If (cAliasQry)->DII_ITEMIC == StrZero(1,Len(DII->DII_ITEMIC)) //-- Caratola
			nLin += 2
			//-- Campo 07: Alf�ndega
			aDadMIC := TmsDadMIC('07',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,050 PSay aDadMIC[1]+' '+aDadMIC[2]
			                
			nLin += 2
			//-- Campo 08: Cidade e pais de destino final
			aDadMIC := TmsDadMIC('08',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,050 PSay aDadMIC[1]
			
			nLin += 2
			//-- Campo 09: Caminh�o Original
			aDadMIC := TmsDadMIC('09',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			
			@ nLin,002 PSay aDadMIC[1]
			nLin += 1
			@ nLin,002 PSay aDadMIC[2]                                                     

			//-- Campo 16: Caminh�o Substituto
			aDadMIC := TmsDadMIC('16',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			
			@ nLin,050 PSay aDadMIC[1]
			nLin += 1
			@ nLin,050 PSay aDadMIC[2]
			
			nLin += 2
			//-- Campo 10: Cadastro geral do contribuinte
			aDadMIC := TmsDadMIC('10',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,010 PSay aDadMIC[1]
			
			//-- Campo 11: Placa do caminh�o
			aDadMIC := TmsDadMIC('11',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,020 PSay aDadMIC[1]
			
			//-- Campo 17: Cadastro geral do contribuinte
			aDadMIC := TmsDadMIC('17',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,050 PSay aDadMIC[1]

			//-- Campo 18: Placa do caminh�o
			aDadMIC := TmsDadMIC('18',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,060 PSay aDadMIC[1]

			nLin += 2
			//-- Campo 12: Marca e numero
			aDadMIC := TmsDadMIC('12',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,010 PSay aDadMIC[1]
			nLin += 1
			@ nLin,010 PSay aDadMIC[2]
			
			//-- Campo 13: Capacidade de tra��o
			aDadMIC := TmsDadMIC('13',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,020 PSay aDadMIC[1]

			//-- Campo 19: Marca e numero
			aDadMIC := TmsDadMIC('19',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,050 PSay aDadMIC[1]
			nLin += 1
			@ nLin,050 PSay aDadMIC[2]

			//-- Campo 20: Capacidade de tra��o
			aDadMIC := TmsDadMIC('20',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,060 PSay aDadMIC[1]
			
			nLin += 2
			//-- Campo 15: Reboque
			DTR->(dbSetOrder(3))
			If DTR->(dbSeek(xFilial('DTR')+(cAliasQry)->(DID_FILORI+DID_VIAGEM+DID_CODVEI))) .And. !Empty(DTR->DTR_CODRB1)
				cReboque := 'X'
			Else
				cReboque := ''
			EndIf
			@ nLin,015 PSay cReboque  
			
			//-- Campo 22: Reboque
			DTR->(dbSetOrder(3))
			If DTR->(dbSeek(xFilial('DTR')+(cAliasQry)->(DID_FILORI+DID_VIAGEM+DID_CODVEI))) .And. !Empty(DTR->DTR_CODRB1)
				cReboque := 'X'
			Else
				cReboque := ''
			EndIf
			@ nLin,055 PSay cReboque
			
			//-- Campo 14: Ano
			nLin += 2
			aDadMIC := TmsDadMIC('14',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,020 PSay aDadMIC[1]
			
			//-- Campo 15: Reboque
			aDadMIC := TmsDadMIC('15',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,020 PSay aDadMIC[1]

			//-- Campo 21: Ano
			nLin += 2
			aDadMIC := TmsDadMIC('21',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,020 PSay aDadMIC[1]
			
			//-- Campo 22: Reboque
			aDadMIC := TmsDadMIC('22',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			@ nLin,020 PSay aDadMIC[1]			
			
		Else
			nQtdDoc += 1
		EndIf
		
		//-- Campo 23: Numero do Conhecimento
		//-- Campo 24: Alfandega de destino  
		//-- Campo 33: Dados do Cliente Remetente
		nLin += 2
		aDadCli := TmsDadMIC('33',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
		aDadMIC := TmsDadMIC('24',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
		@ nLin,015 PSay aDadMIC[1]+' '+aDadMIC[2]
		@ nLin,050 PSay aDadCli[1]
		nLin += 1
		@ nLin,002 PSay Transform((cAliasQry)->(DT6_SIGTRA+DT6_SERIE+DT6_DOC),"@R AA.999.999999")
		@ nLin,017 Psay aDadMIC[2]
		@ nLin,050 PSay aDadCli[2]
		nLin += 1       
		@ nLin,050 PSay aDadCli[3]
		
		//-- Campo 25: Moeda
		//-- Campo 26: Origem das Mercadorias
		//-- Campo 34: Dados do Cliente Destinatario
		nLin += 2
		aDadCli := TmsDadMIC('34',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
		@ nLin,050 PSay aDadCli[1]
		nLin += 1
		aDadMIC := TmsDadMIC('25',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
		@ nLin,002 PSay aDadMIC[1]
		
		aDadMIC := TmsDadMIC('26',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
		@ nLin,015 PSay aDadMIC[1]
		
		@ nLin,050 PSay aDadCli[2]
		nLin += 1
		@ nLin,050 PSay aDadCli[3]
		
		//-- Campo 27: Valor FOT
		//-- Campo 28: Frete
		//-- Campo 29: Seguro
		//-- Campo 35: Dados do Cliente Consignat�rio
		nLin += 2
		aDadCli := TmsDadMIC('35',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
		@ nLin,050 PSay aDadCli[1]
		nLin += 1
		aDadMIC := TmsDadMIC('27',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
		@ nLin,002 PSay aDadMIC[1]
		@ nLin,015 PSay Transform((cAliasQry)->DT6_VALTOT,"@E 9,999,999.99")
		
		aDadMIC := TmsDadMIC('29',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
		@ nLin,035 PSay aDadMIC[1]
		
		@ nLin,050 PSay aDadCli[2]
		nLin += 1
		@ nLin,050 PSay aDadCli[3]
		
		//-- Campo 30: Tipo de Volumes
		//-- Campo 31: Qtde.de Volumes
		//-- Campo 32: Peso Bruto / Peso Liquido
		//-- Campo 36: Documentos Anexos
		nLin += 2
		aDocAne := TmsDadMIC('36',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
		@ nLin,050 PSay aDocAne[1]
		nLin += 1
		@ nLin,002 PSay TmsDadMIC('30',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)[1]
		
		aDadMIC := TmsDadMIC('31',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
		@ nLin,015 PSay StrZero(aDadMIC[1],2)
		
		@ nLin,035 PSay 'Bruto..: '+Transform(Posicione('DT6',1,xFilial('DT6')+(cAliasQry)->(DT6_FILDOC+DT6_DOC+DT6_SERIE),'DT6_PESO'),"@E 999,999.999")

		@ nLin,050 PSay aDocAne[2]
		nLin += 1
		@ nLin,010 PSay Left(Posicione('DTC',3,xFilial('DTC')+(cAliasQry)->(DT6_FILDOC+DT6_DOC+DT6_SERIE),'DTC_CODEMB'),2)
		
		@ nLin,035 PSay 'Neto...: '+Transform(DT6->DT6_PESLIQ,"@E 999,999.999")
		
		@ nLin,050 PSay aDocAne[3]
		nLin += 1
		@ nLin,050 PSay aDocAne[4]
		nLin += 1
		@ nLin,050 PSay aDocAne[5]
		
		//-- Campo 38: Marcas e numeros dos volumes
		nLin += 2
		aObsDoc:= TmsDadMIC('38',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
		For nI := 1 To Len(aObsDoc)
			@ nLin,002 PSay aObsDoc[nI]
			nLin += 1
			If nI > 7
				Exit
			EndIf					
		Next nI

		If (cAliasQry)->DII_ITEMIC == StrZero(1,Len(DII->DII_ITEMIC)) //-- Caratola
			//-- Campo 40: Rota e prazo de transporte
			nLin += 2
			aPercRt:= TmsDadMIC('40',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			For nI := 1 To Len(aPercRt)
				@ nLin,050 PSay aPercRt[nI]
				nLin += 1
			Next nI
			//-- Campo 39: Assinatura e carimbo do transportador
			nLin += 2
			@ nLin,020 PSay (cAliasQry)->DID_DATMIC
		ElseIf nQtdDoc == 2
			aPercRt:= TmsDadMIC('40',cAliasQry,cFilMIC,cNumMIC,cCodVei,cIteMIC)
			nLin += 2
			//-- Campo 42: Subtotal de volume
			@ nLin,020 PSay Transform(nTotVol,PesqPict('DT6','DT6_QTDVOL'))
			//-- Campo 43: Subtotal Peso Bruto
			@ nLin,035 PSay Transform(nTotPes,PesqPict('DT6','DT6_PESO'  ))
			//-- Campo 40: Rota e prazo de transporte
			@ nLin,050 PSay aPercRt[1]
			nLin += 1
			@ nLin,050 PSay aPercRt[2]
			nLin += 1
			@ nLin,050 PSay aPercRt[3]
			nLin += 1
			@ nLin,050 PSay aPercRt[4]
			
			nLin += 2
			//-- Campo 44: Total folha anterior (Volume)
			@ nLin,020 PSay Transform(nVolAnt,PesqPict('DT6','DT6_QTDVOL'))
			//-- Campo 45: Total folha anterior (Peso Bruto)
			@ nLin,035 PSay Transform(nPesAnt,PesqPict('DT6','DT6_PESO'  ))
			//-- Campo 40: Rota e prazo de transporte
			@ nLin,050 PSay aPercRt[5]
			nLin += 1
			@ nLin,050 PSay aPercRt[6]
			nLin += 1
			@ nLin,050 PSay aPercRt[7]
			
			nVolAcu := nTotVol + nVolAnt
			nPesAcu := nTotPes + nPesAnt
			
			nLin += 1
			//-- Campo 46: Total folha anterior (Volume)
			@ nLin,020 PSay Transform(nVolAcu,PesqPict('DT6','DT6_QTDVOL'))
			//-- Campo 47: Total folha anterior (Peso Bruto)
			@ nLin,035 PSay Transform(nPesAcu,PesqPict('DT6','DT6_PESO'  ))
			//-- Campo 40: Rota e prazo de transporte
			@ nLin,050 PSay aPercRt[8]
			
			//-- Campo 39: Assinatura e carimbo do transportador
			nLin += 2
			@ nLin,020 PSay (cAliasQry)->DID_DATMIC
			
			nVolAnt := nVolAcu
			nPesAnt := nPesAcu
			nVolAcu := 0
			nPesAcu := 0
			nTotVol := 0
			nTotPes := 0
		EndIf
		
		//-- Atualiza flag de impresso do MIC/DTA
		If (cAliasQry)->RECNODII > 0
			DII->(dbGoTo((cAliasQry)->RECNODII))
			RecLock('DII',.F.)
			DII->DII_IMPMIC := '1' //-- Impresso
			MsUnLock()
		EndIf			
		
		If (cAliasQry)->DII_ITEMIC == StrZero(1,Len(DII->DII_ITEMIC)) //-- Caratola
			//-- Soma Volume e Peso
			nVolAnt += (cAliasQry)->DT6_QTDVOL
			nPesAnt += (cAliasQry)->DT6_PESO
		ElseIf nQtdDoc < 2
			//-- Soma Volume e Peso
			nTotVol += (cAliasQry)->DT6_QTDVOL
			nTotPes += (cAliasQry)->DT6_PESO
		EndIf
		
		(cAliasQry)->(dbSkip())
	
	EndDo
	
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

RestArea(aAreaSM0)
RestArea(aAreaAtu)

Return
