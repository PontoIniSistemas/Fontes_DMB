#INCLUDE "Protheus.ch"
#INCLUDE "SCROLLBX.CH"

#define NAME_PROC "Meu Update"
#DEFINE CGETFILE_TYPE GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_NETWORKDRIVE

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³          ºAutor  ³Alessandro de Fariasº Data ³  08/12/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Programa para atualizar a base de dados com base em uma    º±±
±±º          ³ tabela DTC salva pelo configurador                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MeuUpdate()

cArqEmp 					:= "SigaMat.Emp"
nModulo					:= 44
__cInterNet 			:= Nil
__lPyme     			:= Nil
PRIVATE cMessage
PRIVATE aArqUpd	 	:= {}
PRIVATE aREOPEN	 	:= {}
PRIVATE oMainWnd

cEmpAnt := ""

#IFDEF TOP
	TCInternal(5,'*OFF') //-- Desliga Refresh no Lock do Top
#ENDIF

Set Deleted On
SET(_SET_DELETED, .T.)

OpenSm0()
DbGoTop()

If Aviso("Atualização do Dicionario - "+NAME_PROC,"Deseja efetuar a atualização do dicionário de Dados?"+CHR(13)+CHR(10)+;
	"Para maior segurança, é importante realizar um backup completo dos dicionários e base de dados do sistema antes da execução desta rotina. Esta rotina deverá será executada no modo exclusivo.",{"Continuar","Sair"})==1
	lEmpenho	:= .F.
	lAtuMnu	:= .F.
	
	DEFINE WINDOW oMainWnd FROM 0, 0 TO 1, 1 TITLE "Efetuando Atualizacao do Dicionario - "+NAME_PROC
	ACTIVATE WINDOW oMainWnd ICONIZED ON INIT (OpenSm0Excl(),lHistorico 	:= MsgYesNo("Sistema em modo exclusivo - Ok !"+CHR(13)+CHR(10)+;
	"Deseja continuar com a atualizacao do Dicionario neste momento ? ", "Atenção"),If(lHistorico,(Processa({|lEnd| ProMeuUpdate(@lEnd)},;
	"Processando Atualizações em "+NAME_PROC,"Aguarde, processando preparacao dos arquivos",.F.) , oMainWnd:End()),oMainWnd:End()))
EndIf

Return

Static Function ProMeuUpdate(lEnd)
Local cTexto   := ''
Local cFile    := ""
Local cMask    := "Arquivos Texto (*.TXT) |*.txt|"
Local nRecno   := 0
Local nX       := 0
Local cTargetDir  := ''

ProcRegua(1)
IncProc("Verificando integridade dos dicionarios....")

dbSelectArea("SM0")
dbGotop()
Do While SM0->(!Eof())
	nRecno := SM0->(Recno())
	RpcSetType(3)
	RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL)
	SM0->(DbGoTo(nRecno))
	SM0->(dbSkip())
	nRecno := SM0->(Recno())
	SM0->(dbSkip(-1))
	RpcClearEnv()
	OpenSm0Excl()
	SM0->(DbGoTo(nRecno))
EndDo
IncProc("Verificando integridade dos dicionarios....")

/*
cGetFile ( ExpC1, ExpC2, ExpN1, ExpC3, ExpL1, ExpN2 )

ExpC1 -> Mascara para filtro (Ex: "Informes Protheus (*.##R) | *.##R")
ExpC2 -> Titulo da Janela
ExpN1 -> Numero da mascara default ( Ex: 1 p/ *.exe )
ExpC3 -> Diretorio inicial se necessario
Expl1 -> .T. para mostrar botao como "Salvar" e .F. para botao "Abrir"
ExpN2 -> Mascara de bits para escolher as opcoes de visualizacao do Objeto. Mascaras possiveis:

GETF_OVERWRITEPROMPT - Solicita confirmacao para sobrescrever
GETF_MULTISELECT - Permite selecionar multiplos arquivos
GETF_NOCHANGEDIR - Nao permite mudar o diretorio inicial
GETF_LOCALFLOPPY - Exibe o(s) Drive(s) de diskete da maquina local
GETF_LOCALHARD - Exibe o(s) HardDisk(s) Local(is)
GETF_NETWORKDRIVE - Exibe os drives da rede ( Mapeamentos )
GETF_SHAREWARE - Nao implementado
GETF_RETDIRECTORY - Retorna um diretorio
*/

nMaskDef		:= 2 								// Mascara JPEG como default
cDirAtu		:= "SERVIDOR\CFGLOG"       // Diretoria atual
cFile 		:= ""								// path + arquivo
lRet 	 		:= .T.							// Retorno da funcao
cDrive		:= Space(255)					// Drive onde esta o arquivo
cDir	 	   := Space(255)					// Diretorio onde esta o arquivo
cMask 		:= "Arquivos CTREE (*.DTC) |*.dtc|"

__cFile := cGetFile( cMask,"Selecione arquivo...",@nMaskDef    , cDirAtu   ,.T., CGETFILE_TYPE )

If Empty(__cFile)
	Final("Arquivo Vazio")
Endif

dbSelectArea("SM0")
dbGotop()
Do While !Eof()
	
	nRecno := SM0->(Recno())
	RpcSetType(3)
	RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL)
	cTexto += Replicate("-",128)+CHR(13)+CHR(10)
	cTexto += "Empresa : "+SM0->M0_CODIGO+" Filial : "+SM0->M0_CODFIL+"-"+SM0->M0_NOME+CHR(13)+CHR(10)
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Atualiza o dicionario de dados.   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	IncProc("[" + AllTrim(SM0->M0_CODIGO) + "/" + AllTrim(SM0->M0_CODFIL) + "] " + "Atualizando Dicionario de Dados...")
	cTexto += U_mYAtuSX3(__cFile)
	
	ProcRegua(Len(aArqUpd))
	__SetX31Mode(.F.)
	For nX := 1 To Len(aArqUpd)
		IncProc("Atualizando estruturas. Aguarde... ["+aArqUpd[nx]+"]"+"Empresa : "+SM0->M0_CODIGO+" Filial : "+SM0->M0_CODFIL+"-"+SM0->M0_NOME)
		If Select(aArqUpd[nx])>0
			dbSelecTArea(aArqUpd[nx])
			dbCloseArea()
		EndIf
		X31UpdTable(aArqUpd[nx])
		If __GetX31Error()
			Alert(__GetX31Trace())
			Aviso("Atencao!","Ocorreu um erro desconhecido durante a atualizacao da tabela : "+ aArqUpd[nx] + ;
			". Verifique a integridade do dicionario e da tabela.",{"Continuar"},2)
			cTexto += "Ocorreu um erro desconhecido durante a atualizacao da estrutura da tabela : "+aArqUpd[nx] +CHR(13)+CHR(10)
		EndIf
	Next nX
	SM0->(DbGoTo(nRecno))
	SM0->(dbSkip())
	nRecno := SM0->(Recno())
	SM0->(dbSkip(-1))
	RpcClearEnv()
	OpenSm0Excl()
	SM0->(DbGoTo(nRecno))
	
EndDo

dbSelectArea("SM0")
dbGotop()
RpcSetEnv(SM0->M0_CODIGO, SM0->M0_CODFIL,,,,, { "AE1" })

cTexto := "Log da atualizacao "+CHR(13)+CHR(10)+cTexto
__cFileLog := MemoWrite(Criatrab(,.f.)+".LOG",cTexto)
DEFINE FONT oFont NAME "Mono AS" SIZE 5,12   //6,15
DEFINE MSDIALOG oDlg TITLE "Atualizacao concluida." From 3,0 to 340,417 PIXEL
@ 5,5 GET oMemo  VAR cTexto MEMO SIZE 200,145 OF oDlg PIXEL
oMemo:bRClicked := {||AllwaysTrue()}
oMemo:oFont:=oFont

DEFINE SBUTTON  FROM 153,175 TYPE 1 ACTION oDlg:End() ENABLE OF oDlg PIXEL //Apaga
DEFINE SBUTTON  FROM 153,145 TYPE 13 ACTION (cFile:=cGetFile(cMask,""),If(cFile="",.T.,MemoWrite(cFile,cTexto))) ENABLE OF oDlg PIXEL

ACTIVATE MSDIALOG oDlg CENTER

Return(.T.)

User Function mYAtuSX3(__cFile)

Local aSX3   		:= {}
Local cOrdem
Local aPHelpPor	:={}
Local aPHelpEng	:={}
Local aPHelpEsp	:={}
Local aEstrut		:= {}
Local i      		:= 0
Local j      		:= 0
Local lSX3	 		:= .F.
Local cTexto 		:= ''
Local cAlias 		:= ''

DbUseArea(.T.,"CTREECDX",__cFile,"TEMP",.F.,.F.)
aEstrut := {}
DbSelectArea("TEMP")
aStrSTRU := TEMP->(dbStruct())
For nStr := 1 to Len(aStrSTRU)
	If !Alltrim(aStrSTRU[nStr][1]) $ "_F_L_A_G*_R_E_C_N_O*_M_0_E_M_P"
		Aadd(aEstrut, aStrSTRU[nStr][1] )
	Endif
Next

DbSelectArea("SX3")
aSX3STRU := SX3->(dbStruct())
aSX3     := {}

DbSelectArea("TEMP")
DbGoTop()
Do While ! Eof()
	// TEMP->_F_L_A_G == 0 //novo campo
	// TEMP->_F_L_A_G == 1 //campo ja criado
	aadd(aSX3,Array(Len(aEstrut)+1))
	For nStr := 1 to Len(aSX3STRU)
		If Ascan( aEstrut, aSX3STRU[nStr][1] ) > 0
			For nLi := 1 to Len(aEstrut)
				aSX3[Len(aSX3)][nLi] := TEMP->&(aEstrut[nLi])
			Next nLi
		Endif
	Next
	DbSkip()
Enddo

DbSelectArea("TEMP")
DbCloseArea()

ProcRegua(Len(aSX3))

dbSelectArea("SX3")
dbSetOrder(2)

For i:= 1 To Len(aSX3)
	If !Empty(aSX3[i][1])
		If !dbSeek(aSX3[i,3])
			dbSelectArea("SX3")
			dbSetOrder(1)
			dbSeek(aSX3[i,1]+"ZZ",.T.)
			If SX3->X3_ARQUIVO+SX3->X3_ORDEM == aSX3[i,1]+"ZZ"
				cOrdem := "ZZ"
			Else
				dbSkip(-1)
				If SX3->X3_ARQUIVO == aSX3[i,1]
					cOrdem := Soma1(SX3->X3_ORDEM)
				Else
					cOrdem := "01"
				EndIf
			EndIf
			dbSelectArea("SX3")
			dbSetOrder(2)
			lSX3	:= .T.
			If !(aSX3[i,1]$cAlias)
				cAlias += aSX3[i,1]+"/"
				aAdd(aArqUpd,aSX3[i,1])
			EndIf
			
			RecLock("SX3",.T.)
			For j:=1 To Len(aEstrut)
				If SX3->( FieldPos(aEstrut[j]) ) > 0
					SX3->( FieldPut(FieldPos(aEstrut[j]),aSX3[i,j] ) )
				EndIf
			Next j
			SX3->X3_ORDEM   := cOrdem
			MsUnLock()
			dbCommit()
			
			cTexto += "Criado " + aSx3[i][1] + " - " + aSx3[i][3] + Chr(13) + Chr(10)
		Else
			lSX3	:= .T.
			If !(aSX3[i,1]$cAlias)
				cAlias += aSX3[i,1]+"/"
				aAdd(aArqUpd,aSX3[i,1])
			EndIf
			
			RecLock("SX3",.F.)
			For j:=1 To Len(aEstrut)
				If SX3->( FieldPos(aEstrut[j]) ) > 0
					SX3->( FieldPut(FieldPos(aEstrut[j]),aSX3[i,j] ) )
				EndIf
			Next j
			MsUnLock()
			dbCommit()
			
			cTexto += "O campo "  + aSx3[i][3] + " ja existe em " + aSx3[i][1] + " e foi alterado." + Chr(13) + Chr(10)
		EndIf
	EndIf
Next i

cTexto := "Tabelas atualizadas : " + cAlias + Chr(13) + Chr(10) + cTexto

Return cTexto
