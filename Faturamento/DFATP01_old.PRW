#include "rwmake.ch"
#include "topconn.ch"
#include "ap5mail.ch"
#include "MSOLE.CH"
#Include "PROTHEUS.CH"


//--------------------------------------------------------------
/*/{Protheus.doc} AFATP01
Description                                                     
                                                                
@param xParam Parameter Description                             
@return xRet Return Description                                 
@author fTelaMix - Pedro Pignolati e Marcio Felipe                                             
@since 21/07/2011                                                   
/*/                                                             
//--------------------------------------------------------------
User Function DFATP01()                        
Private oNum
Private cNum := Space(6)
Private oGroup1
Private oSay1
Private oButton1
Private oButton2

Static oDlg

  DEFINE MSDIALOG oDlg TITLE "Orçamento" FROM 000, 000  TO 150, 320 COLORS 0, 16777215 PIXEL

    @ 008, 007 GROUP oGroup1 TO 066, 150 PROMPT "Orçamento" OF oDlg COLOR 0, 16777215 PIXEL
    @ 024, 080 MSGET oNum VAR cNum SIZE 039, 010 OF oDlg COLORS 0, 16777215 F3 "SCJ" PIXEL
    @ 045, 112 BUTTON oButton1 PROMPT "Ok" SIZE 028, 011 OF oDlg ACTION fWord(cNum) PIXEL
    @ 045, 081 BUTTON oButton2 PROMPT "Cancela" SIZE 028, 011 OF oDlg ACTION oDlg:End() PIXEL
    @ 028, 016 SAY oSay1 PROMPT "Selecione o Orçamento:" SIZE 063, 007 OF oDlg COLORS 0, 16777215 PIXEL

  ACTIVATE MSDIALOG oDlg CENTERED

Return

Static Function fWord(cNum)
Local cType    := "ORCAMENTO       | *.DOT"
Local cArquivo := ""
Local waItem	:= {}  //Item
Local waQuant	:= {}  //Quantidade
Local waUn		:= {}  //Unidade
Local waDesc	:= {}  //Descricao
Local waVlUnit	:= {}  //Valor Unitario
Local waTot		:= {}  //Valor Total
Local waEntrega	:= {}  //Entrega
Local nTotal  	:= 0   // somatiro do loop


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Copiar Arquivo .DOT do Server para Diretorio Local ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cArquivo := "\Orcamento\Orcamento.dot"

nPos := Rat("\",cArquivo)
If nPos > 0
	cArqLoc := AllTrim(Subst(cArquivo, nPos+1,20 ))
Else
	cArqLoc := cArquivo
EndIF

cPath := GETTEMPPATH()
If Right( AllTrim(cPath), 1 ) != "\"
	cPath += "\"
Endif

If !CpyS2T(cArquivo, cPath, .T.)
	MsgStop("Nao foi possivel ler o arquivo de origem " + cArqLoc)
	//	FErase(cPath+cArqLoc)
	Return
Endif

dbSelectArea("SCJ")
dbSetOrder(1)
If dbSeek(xFilial("SCJ")+AllTrim(cNum))
	
	// Inicializa o Ole com o MS-Word 97 ( 8.0 )
	oWord := OLE_CreateLink('TMsOleWord97')
	
	OLE_NewFile(oWord,cPath+cArqLoc)
	
	OLE_SetProperty( oWord, oleWdVisible,   .T. )
	OLE_SetProperty( oWord, oleWdPrintBack, .F. )
	
	// Carrega os dados no word
	cData := AllTrim(STR(DAY(DATE()))) + " de " + MesExtenso(DATE()) +  ",  " + AllTrim(STR(YEAR(DATE())))
	OLE_SetDocumentVar(oWord,"cNumero",			cNUM)  // TENTATIVA DE NUMERO DE ORCAMENTO
	OLE_SetDocumentVar(oWord,"cData",			cData)
	OLE_SetDocumentVar(oWord,"cCodCli",			SCJ->CJ_CLIENTE)
	OLE_SetDocumentVar(oWord,"cCotCli",			SCJ->CJ_COTCLI)
	OLE_SetDocumentVar(oWord,"cCondPag",		Posicione("SE4",1,xFilial("SE4")+SCJ->CJ_CONDPAG,"E4_DESCRI"))
	
//	OLE_SetDocumentVar(oWord,"cObs",			SCJ->CJ_OBS)	
	
	
	// Informações do Vendedor Externo
	OLE_SetDocumentVar(oWord,"cVendExt",		Posicione("SA3",1,xFilial("SA3")+SCJ->CJ_VEND,"A3_NOME"))
	OLE_SetDocumentVar(oWord,"cTelVendExt",	Posicione("SA3",1,xFilial("SA3")+SCJ->CJ_VEND,"A3_TEL"))
	OLE_SetDocumentVar(oWord,"cEmailVendExt",	Posicione("SA3",1,xFilial("SA3")+SCJ->CJ_VEND,"A3_EMAIL"))
	OLE_SetDocumentVar(oWord,"cCelVendExt",	Posicione("SA3",1,xFilial("SA3")+SCJ->CJ_VEND,"A3_CEL"))

	
	// informações do cliente
	dbSelectArea("SA1")
	dbSetOrder(1)
	If dbSeek(xFilial("SA1")+SCJ->CJ_CLIENTE)
		OLE_SetDocumentVar(oWord,"cCliente",	SA1->A1_NOME)
		OLE_SetDocumentVar(oWord,"cEndereco",	SA1->A1_END)
		OLE_SetDocumentVar(oWord,"cBairro",		SA1->A1_BAIRRO)
		OLE_SetDocumentVar(oWord,"cCidade",		SA1->A1_MUN)
		OLE_SetDocumentVar(oWord,"cUF",			SA1->A1_EST)
		OLE_SetDocumentVar(oWord,"cNomeCont",	SA1->A1_CONTATO)
		OLE_SetDocumentVar(oWord,"cCGC",		transform(SA1->A1_CGC,"@R 99.999.999/9999-99"))

		//		OLE_SetDocumentVar(oWord,"cNomeCont",	SA1->A1_CONTATO)
//		OLE_SetDocumentVar(oWord,"cEmailCont",	SA1->A1_EMAIL)
//		OLE_SetDocumentVar(oWord,"cTelCont",	SA1->A1_TEL)
//		OLE_SetDocumentVar(oWord,"cFaxCont",	SA1->A1_FAX)  

		OLE_SetDocumentVar(oWord,"cNomeCont",	SCJ->CJ_NOMCONT)
		OLE_SetDocumentVar(oWord,"cEmailCont",	SCJ->CJ_EMAILCO)
		OLE_SetDocumentVar(oWord,"cTelCont",	SCJ->CJ_TELCONT)
		OLE_SetDocumentVar(oWord,"cCelCont",	SCJ->CJ_CELCONT)
	EndIf
	dbCloseArea("SA1")
	
	//Loop para tipos de servicos igual a Furos
	dbSelectArea("SCK")
	dbSetOrder(1)
	If dbSeek(xFilial("SCK")+SCJ->CJ_NUM)
		
		While !Eof() .AND. SCK->CK_NUM == SCJ->CJ_NUM
			aAdd(waItem,SCK->CK_ITEM)
			aAdd(waQuant,SCK->CK_QTDVEN)
			aAdd(waUn,SCK->CK_UM)
			aAdd(waDesc,SCK->CK_DESCRI)
			aAdd(waVlUnit,SCK->CK_PRCVEN)
			aAdd(waTot,SCK->CK_VALOR)
			aAdd(waEntrega,DTOC(SCK->CK_ENTREG))
			dbSelectArea("SCK")
			dbSkip()
		EndDo
		
	EndIf
	
	OLE_SetDocumentVar(oWord,'prc_nroitens',str(Len(waQuant)))	//variavel para identificar o numero total de Itens
	
	//Montagem das variaveis dos Furos. No documento word estas variaveis serao criadas dinamicamente da seguinte forma:
	for nK := 1 to Len(waQuant)
		OLE_SetDocumentVar(oWord,"Prc_item"+AllTrim(Str(nK)),waItem[nK])
		OLE_SetDocumentVar(oWord,"Prc_quant"+AllTrim(Str(nK)),waQuant[nK])
		OLE_SetDocumentVar(oWord,"Prc_un"+AllTrim(Str(nK)),waUn[nK])
		OLE_SetDocumentVar(oWord,"Prc_desc"+AllTrim(Str(nK)),waDesc[nK])
		OLE_SetDocumentVar(oWord,"Prc_vlrunit"+AllTrim(Str(nK)),Transform(waVlUnit[nK],"@E 9,999,999,999.99"))
		OLE_SetDocumentVar(oWord,"Prc_tot"+AllTrim(Str(nK)),Transform(waTot[nK],"@E 9,999,999,999.99"))
		OLE_SetDocumentVar(oWord,"Prc_entrega"+AllTrim(Str(nK)),waEntrega[nK])
		
	next
	
	

	OLE_ExecuteMacro(oWord,"TabItens")
	
	//--Atualiza Variaveis
	OLE_UpDateFields(oWord)
	
	cArquivo:= SCJ->CJ_NUM+".DOT"

	APMsgInfo("Alterne para o programa do Ms-Word " + Chr(13) + Chr(10) +;
	"para visualizar o documento " + cArquivo + ;
	Chr(13) + Chr(10) + "Salve, porem NÃO feche o word. Depois confirme esta mensagem...")

	OLE_SaveAsFile( oWord, cArquivo )
	OLE_CloseLink( oWord )
		
	If File(cPath+cArqLoc)
		FErase(cPath+cArqLoc)
	Endif

Else
	APMsgAlert("Codigo de orçamento invalido!")
	cNum := ""
EndIf

dbCloseArea("SCJ")

oDlg:End()
  
Return
