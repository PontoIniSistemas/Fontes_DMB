#include "INKEY.CH"
#INCLUDE "RGPER13.CH"
#INCLUDE "PROTHEUS.CH"

/*
굇읕컴컴컴컴컴컨컴컴컴컴컴좔컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컴컴쩡컴컴컴컴컫컴컴컴컴컴컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴엽�
굇쿛rogramador  � Data     � FNC            �  Motivo da Alteracao                      낢�
굇쳐컴컴컴컴컴컴탠컴컴컴컴컵컴컴컴컴컴컴컴컴탠컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴낢�
굇쿟atiane V. M.�25/08/2009�00000020388/2009쿎ompatibilizacao dos fontes para aumento do낢�
굇�             �          �                쿬ampo filial e gest�o corporativa.         낢�
굇읕컴컴컴컴컴컴좔컴컴컴컴컨컴컴컴컴컴컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴袂�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � RGPER13  � Autor � R.H. - Silvia Taguti  � Data � 04.02.04 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Emissao de Recibos de Pagamento - URUGUAI                  낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � RGPER13                                                    낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
User Function RGPER13()
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Locais (Basicas)                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Local cString:="SRA"        		// alias do arquivo principal (Base)
Local aOrd   := {STR0001,STR0002,STR0003,STR0004,STR0005} //"Matricula"###"C.Custo"###"Nome"###"Chapa"###"C.Custo + Nome"
Local cDesc1 := STR0006				//"Emiss꼘 de Recibos de Pagamento."
Local cDesc2 := STR0007				//"Ser� impresso de acordo com os parametros solicitados pelo"
Local cDesc3 := STR0008				//"usu쟲io."

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Locais (Programa)                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Local cIndCond
Local cMesAnoRef

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Private(Basicas)                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private aReturn  := {STR0009, 1,STR0010, 2, 2, 1, "",1 }	//"Zebrado"###"Administra뇙o"
Private nomeprog :="RGPER13"
Private aLinha   := { }
Private nLastKey := 0
Private cPerg    :="RGPR13"
Private cCompac 
Private cNormal
Private aDriver 

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Private(Programa)                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Private aLanca := {}
Private aProve := {}
Private aDesco := {}
Private aBases := {}
Private aInfo  := {}
Private aCodFol:= {}
Private li     := 0
Private Titulo := STR0011		//"EMISS랳 DE RECIBOS DE PAGAMENTOS"

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica as perguntas selecionadas                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

pergunte("RGPR13",.F.)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Envia controle para a funcao SETPRINT                        �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
wnrel:="RGPER13"            //Nome Default do relatorio em Disco
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,'G')

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Inicializa Impressao                                         �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
If ! fInicia(cString)
    Return
Endif     

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Carregando variaveis mv_par?? para Variaveis do Sistema.     �           	
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros                         �
//� mv_par01        //  Data de Referencia para a impressao      �
//� mv_par02        //  Emitir Recibos(Adto/Folha/1�/2�/V.Extra) �
//� mv_par03        //  Numero da Semana                         �
//� mv_par04        //  Filial De                                �
//� mv_par05        //  Filial Ate                               �
//� mv_par06        //  Centro de Custo De                       �
//� mv_par07        //  Centro de Custo Ate                      �
//� mv_par08        //  Matricula De                             �
//� mv_par09        //  Matricula Ate                            �
//� mv_par10        //  Nome De                                  �
//� mv_par11        //  Nome Ate                                 �
//� mv_par12        //  Chapa De                                 �
//� mv_par13        //  Chapa Ate                                �
//� mv_par14        //  Situacoes a Imprimir                     �
//� mv_par15        //  Categorias a Imprimir                    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
nOrdem     := aReturn[8]
dDataRef   := mv_par01
Esc        := mv_par02
Semana     := mv_par03
cFilDe     := mv_par04
cFilAte    := mv_par05
cCcDe      := mv_par06
cCcAte     := mv_par07
cMatDe     := mv_par08
cMatAte    := mv_par09
cNomDe     := mv_par10
cNomAte    := mv_par11
ChapaDe    := mv_par12
ChapaAte   := mv_par13
cSituacao  := mv_par14
cCategoria := mv_par15

cMesAnoRef := StrZero(Month(dDataRef),2) + StrZero(Year(dDataRef),4)

RptStatus({|lEnd| R013Imp(@lEnd,wnRel,cString,cMesAnoRef)},Titulo)  // Chamada do Relatorio

Set Device To Screen

If aReturn[5] = 1
	Set Printer To
	Commit
	ourspool(wnrel)
Endif
MS_FLUSH()

Return

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    � R013IMP  � Autor � R.H. - Silvia Taguti  � Data � 04.02.04 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Processamento Para emissao do Recibo                       낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � R013IMP(lEnd,Wnrel,cString)                                낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
Static Function R013Imp(lEnd,WnRel,cString,cMesAnoRef)
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Define Variaveis Locais (Basicas)                            �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Local lIgual                 //Vari쟶el de retorno na compara놹o do SRC
Local cArqNew                //Vari쟶el de retorno caso SRC # SX3
Local tamanho     := "G"
Local limite      := 132
Local aOrdBag     := {}
Local cMesArqRef  
Local cArqMov     := ""
Local aCodBenef   := {}
Local cAcessaSR1  := &("{ || " + ChkRH("GPER030","SR1","2") + "}")
Local cAcessaSRA  := &("{ || " + ChkRH("GPER030","SRA","2") + "}")
Local cAcessaSRC  := &("{ || " + ChkRH("GPER030","SRC","2") + "}")
Local cAcessaSRI  := &("{ || " + ChkRH("GPER030","SRI","2") + "}")
Local nHoras      := 0 
Local nX				:=	0

Private cAliasMov := ""
Private nArredProv := 0
Private nArredDesc := 0
Private nLiqCob    := 0
Private cSE			 := "  "

If Esc == 3
	cMesArqRef := "13" + Right(cMesAnoRef,4)	
ElseIf Esc == 4
	cMesArqRef := "23" + Right(cMesAnoRef,4)		
Else
	cMesArqRef := cMesAnoRef
Endif		
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//| Verifica se existe o arquivo de fechamento do mes informado  |
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
If !OpenSrc( cMesArqRef, @cAliasMov, @aOrdBag, @cArqMov, dDataRef )
	Return .f.
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Selecionando a Ordem de impressao escolhida no parametro.    �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
dbSelectArea( "SRA")
If nOrdem == 1
	dbSetOrder(1)
ElseIf nOrdem == 2
	dbSetOrder(2)
ElseIf nOrdem == 3
	dbSetOrder(3)
Elseif nOrdem == 4
	cArqNtx  := CriaTrab(NIL,.f.)
	cIndCond :="RA_Filial + RA_Chapa + RA_Mat"
	IndRegua("SRA",cArqNtx,cIndCond,,,STR0012)		//"Selecionando Registros..."
ElseIf nOrdem == 5
	dbSetOrder(8)
Endif

dbGoTop()

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Selecionando o Primeiro Registro e montando Filtro.          �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
If nOrdem == 1
	dbSeek(cFilDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
	cFim    := cFilAte + cMatAte
ElseIf nOrdem == 2
	dbSeek(cFilDe + cCcDe + cMatDe,.T.)
	cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim     := cFilAte + cCcAte + cMatAte
ElseIf nOrdem == 3
	dbSeek(cFilDe + cNomDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
	cFim    := cFilAte + cNomAte + cMatAte
ElseIf nOrdem == 4
	dbSeek(cFilDe + ChapaDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_CHAPA + SRA->RA_MAT"
	cFim    := cFilAte + ChapaAte + cMatAte
ElseIf nOrdem == 5
	dbSeek(cFilDe + cCcDe + cNomDe,.T.)
	cInicio  := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_NOME"
	cFim     := cFilAte + cCcAte + cNomAte
Endif

dbSelectArea("SRA")
//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Carrega Regua Processamento                                  �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
SetRegua(RecCount())   // Total de elementos da regua

TOTVENC:= TOTDESC:= FLAG:= CHAVE := 0
nArredProv := 0
nArredDesc := 0
cFilialAnt := "  "

Vez        := 0
OrdemZ     := 0

dbSelectArea("SRA")
While !SRA->(EOF()) .And. &cInicio <= cFim
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Movimenta Regua Processamento                                �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
  	IncRegua()  // Anda a regua

	If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	Endif	 

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Consiste Parametrizacao do Intervalo de Impressao            �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If (SRA->RA_CHAPA < ChapaDe) .Or. (SRA->Ra_CHAPa > ChapaAte) .Or. ;
		(SRA->RA_NOME < cNomDe)    .Or. (SRA->Ra_NOME > cNomAte)    .Or. ;
		(SRA->RA_MAT < cMatDe)     .Or. (SRA->Ra_MAT > cMatAte)     .Or. ;
		(SRA->RA_CC < cCcDe)       .Or. (SRA->Ra_CC > cCcAte)
		SRA->(dbSkip(1))
		Loop
	EndIf

	aLanca:={}         // Zera Lancamentos
	aProve:={}         // Zera Lancamentos
	aDesco:={}         // Zera Lancamentos
	aBases:={}         // Zera Lancamentos
	Ordem_rel := 1     // Ordem dos Recibos

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Verifica Data Demissao         �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	cSitFunc := SRA->RA_SITFOLH
	dDtPesqAf:= CTOD("01/" + Left(cMesAnoRef,2) + "/" + Right(cMesAnoRef,4),"DDMMYY")
	If cSitFunc == "D" .And. (!Empty(SRA->RA_DEMISSA) .And. MesAno(SRA->RA_DEMISSA) > MesAno(dDtPesqAf))
		cSitFunc := " "
	Endif	

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Consiste situacao e categoria dos funcionarios			     |
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If !( cSitFunc $ cSituacao ) .OR.  ! ( SRA->RA_CATFUNC $ cCategoria )
		dbSkip()
		Loop
	Endif
	If cSitFunc $ "D" .And. Mesano(SRA->RA_DEMISSA) # Mesano(dDataRef)
		dbSkip()
		Loop
	Endif
	
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Consiste controle de acessos e filiais validas				 |
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
    If !(SRA->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
       dbSkip()
       Loop
    EndIf
	
	If SRA->RA_Filial # cFilialAnt
		If ! Fp_CodFol(@aCodFol,Sra->Ra_Filial) .Or. ! fInfo(@aInfo,Sra->Ra_Filial)
			Exit
		Endif
		dbSelectArea("SRA")
		cFilialAnt := SRA->RA_FILIAL
	Endif
	cSE    := Substr(SRA->RA_CC,1,4)
	
	Totvenc := Totdesc := 0
	
	If Esc == 1 .OR. Esc == 2
		dbSelectArea("SRC")
		dbSetOrder(1)
		If dbSeek(SRA->RA_FILIAL + SRA->RA_MAT)
			dDtPgto:= SRC->RC_DATA
			While !Eof() .And. SRC->RC_FILIAL+SRC->RC_MAT == SRA->RA_FILIAL+SRA->RA_MAT
				If SRC->RC_SEMANA # Semana
					dbSkip()
					Loop
				Endif
			 	If !Eval(cAcessaSRC)
			  		dbSkip()
			    	Loop
			  	EndIf
				If (SRC->RC_PD == aCodFol[43,1])
					nArredProv:= SRC->RC_VALOR
				ElseIf (SRC->RC_PD == aCodFol[44,1])
					nArredDesc := SRC->RC_VALOR
				ElseIf (Esc == 1) .And. (Src->Rc_Pd == aCodFol[7,1])      // Desconto de Adto
					fSomaPd("P",aCodFol[6,1],SRC->RC_HORAS,SRC->RC_VALOR)
					TOTVENC += Src->Rc_Valor
				Elseif (Esc == 1) .And. (Src->Rc_Pd == aCodFol[12,1])
					fSomaPd("D",aCodFol[9,1],SRC->RC_HORAS,SRC->RC_VALOR)
					TOTDESC += SRC->RC_VALOR
				Elseif (Esc == 1) .And. (Src->Rc_Pd == aCodFol[8,1])
					fSomaPd("P",aCodFol[8,1],SRC->RC_HORAS,SRC->RC_VALOR)
					TOTVENC += SRC->RC_VALOR
				Elseif (Src->Rc_Pd == aCodFol[47,1])
					nLiqCob:= SRC->RC_VALOR
				Else
					If PosSrv( Src->Rc_Pd , SRA->RA_FILIAL , "RV_TIPOCOD" ) == "1"
						If (Esc # 1) .Or. (Esc == 1 .And. PosSrv(Src->Rc_Pd,Sra->Ra_Filial,"RV_ADIANTA") == "S")
							nHoras := SRC->RC_HORAS
							fSomaPd("P",SRC->RC_PD,nHoras,SRC->RC_VALOR)
							TOTVENC += Src->Rc_Valor
						Endif
					Elseif SRV->RV_TIPOCOD == "2"
						If (Esc # 1) .Or. (Esc == 1 .And. PosSrv(Src->Rc_Pd,Sra->Ra_Filial,"RV_ADIANTA") == "S")
							fSomaPd("D",SRC->RC_PD,SRC->RC_HORAS,SRC->RC_VALOR)
							TOTDESC += Src->Rc_Valor
						Endif
					Endif
				Endif
				dbSelectArea("SRC")
				dbSkip()
			Enddo
		Endif
	Elseif Esc == 4 .or. Esc ==3
		dbSelectArea("SRI")
		dbSetOrder(2)
		If dbSeek(SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT)
			dDtPgto:= SRI->RI_DATA
			While !Eof() .And. SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT == SRI->RI_FILIAL + SRI->RI_CC + SRI->RI_MAT
			    If !Eval(cAcessaSRI)
			       dbSkip()
			       Loop
			    EndIf
				If Esc == 3 .And. (SRI->RI_Pd == aCodFol[202,1])
					nLiqCob:= SRC->RC_VALOR
				ElseIf Esc == 4 .And. (SRI->RI_Pd == aCodFol[021,1])
					nLiqCob:= SRC->RC_VALOR
				ElseIf (SRI->RI_PD == aCodFol[26,1])
					nArredProv:= SRI->RI_VALOR
				ElseIf (SRI->RI_PD == aCodFol[29,1])
					nArredDesc := SRI->RI_VALOR
				ElseIf PosSrv( SRI->RI_PD , SRA->RA_FILIAL , "RV_TIPOCOD" ) == "1"
					fSomaPd("P",SRI->RI_PD,SRI->RI_HORAS,SRI->RI_VALOR)
					TOTVENC = TOTVENC + SRI->RI_VALOR
				Elseif SRV->RV_TIPOCOD == "2"
					fSomaPd("D",SRI->RI_PD,SRI->RI_HORAS,SRI->RI_VALOR)
					TOTDESC = TOTDESC + SRI->RI_VALOR
				Endif
				dbSkip()
			Enddo
		Endif
	Elseif Esc == 5
		dbSelectArea("SR1")
		dbSetOrder(1)
		If dbSeek( SRA->RA_FILIAL + SRA->RA_MAT )
			dDtPgto:= SR1->R1_DATA
			While !Eof() .And. SRA->RA_FILIAL + SRA->RA_MAT ==	SR1->R1_FILIAL + SR1->R1_MAT
				If Semana # "99"			
					If SR1->R1_SEMANA # Semana
						dbSkip()
						Loop
					Endif
				Endif					
			    If !Eval(cAcessaSR1)
			       dbSkip()
			       Loop
			    EndIf
				If (SR1->R1_PD == aCodFol[179,1])
					nArredProv:= SR1->R1_VALOR
				ElseIf (SR1->R1_PD == aCodFol[180,1])
					nArredDesc := SR1->R1_VALOR
				ElseIf PosSrv( SR1->R1_PD , SRA->RA_FILIAL , "RV_TIPOCOD" ) == "1"
					fSomaPd("P",SR1->R1_PD,SR1->R1_HORAS,SR1->R1_VALOR)
					TOTVENC = TOTVENC + SR1->R1_VALOR
				Elseif SRV->RV_TIPOCOD == "2"
					fSomaPd("D",SR1->R1_PD,SR1->R1_HORAS,SR1->R1_VALOR)
					TOTDESC = TOTDESC + SR1->R1_VALOR
				Endif
				dbskip()
			Enddo
		Endif
	Endif
	
	dbSelectArea("SRA")
	
	If TOTVENC = 0 .And. TOTDESC = 0
		dbSkip()
		Loop
	Endif
	
	fImpressao()   // Impressao do Recibo de Pagamento
	TotDesc := TotVenc := 0
	DbSelectArea('SRA')
	dbSkip() 
ENDDO

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Seleciona arq. defaut do Siga caso Imp. Mov. Anteriores      �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
If !Empty( cAliasMov )
	fFimArqMov( cAliasMov , aOrdBag , cArqMov )
EndIf

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Termino do relatorio                                         �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
dbSelectArea("SRC")
dbSetOrder(1)          // Retorno a ordem 1
dbSelectArea("SRI")
dbSetOrder(1)          // Retorno a ordem 1
dbSelectArea("SRA")
dbClearFilter()
RetIndex("SRA")

If !(Type("cArqNtx") == "U")
	fErase(cArqNtx + OrdBagExt())
Endif

Return
/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯Impressao� Autor � Silvia Taguti         � Data � 04.02.04 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao do Recibo Formulario Continuo                    낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fImpre()                                                   낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
Static Function fImpressao()

Local nContr := nContrT:=0
Local aDriver	:=	ReadDriver()
Local nConta  := 0

Private nLinhas:= If(aReturn[5]<> 3,29,21)     // Numero de Linhas do Miolo do Recibo

Ordem_Rel := 1

fCabec()

aLanca := ASort (aLanca,,,{|x,y| x[1] > y[1]  }) // Sorteando Arrays
nPos := Ascan(aLanca,{ |X| X[1] = "D"})
aLanca := ASort(aLanca,,nPos-1,{|x,y| x[2] < y[2]  }) // Sorteando Arrays
aLanca := ASort(aLanca,nPos,,{|x,y| x[2] < y[2]  }) // Sorteando Arrays

For nConta = 1 To Len(aLanca)
	If nConta == nPos
		If aReturn[5] <> 3	
			@ Li,00 PSAY STR0014 + TRANS(TOTVENC,"@E 999,999,999.99")		//Total de Haberes
			@ Li,67 PSAY STR0014 + TRANS(TOTVENC,"@E 999,999,999.99")     //Total de Haberes
		Else
			@ Li,05 PSAY STR0014 + TRANS(TOTVENC,"@E 999,999,999.99")		//Total de Haberes
			@ Li,85 PSAY STR0014 + TRANS(TOTVENC,"@E 999,999,999.99")    //Total de Haberes
		Endif
		Li+=2
		nContr+=2
	Endif	
	fLanca(nConta)
	nContr ++
	nContrT ++
	If nContr = nLinhas .And. nContrT < Len(aLanca)
		nContr:=0
		Ordem_Rel ++
		fContinua()
		fCabec()
	Endif
Next
@ Li+=1       
nContr++
If aReturn[5] <> 3
	@ Li,00 PSAY STR0015 + TRANS(TOTDESC,"@E 999,999,999.99")    	//Total de Descontos
	@ Li,67 PSAY STR0015 + TRANS(TOTDESC,"@E 999,999,999.99")     //Total de Descontos
Else
	@ Li,05 PSAY STR0015 + TRANS(TOTDESC,"@E 999,999,999.99")    	//Total de Descontos
	@ Li,85 PSAY STR0015 + TRANS(TOTDESC,"@E 999,999,999.99")     //Total de Descontos
Endif 

Li+=(nLinhas-nContr)

fRodape()

Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯Cabec    � Autor � Silvia Taguti         � Data � 04.02.04 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � IMRESSAO Cabe놹lho                                         낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fCabec()                                                   낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
Static Function fCabec()   // Cabecalho do Recibo 
Local cDescr
Local cFuncao
Local cBSE
Local cCateg

If FpHist82(xFilial("SRX"),"99",SRA->RA_FILIAL+"01") .or. FpHist82(xFilial("SRX"),"99","  "+"01")
	cBSE:= Substr(SRX->RX_TXT,39,10)						//BSE
Endif
cCateg := SRA->RA_CODFUNC
cFuncao:= DescFun(SRA->RA_CODFUNC,SRA->RA_FILIAL)

If aReturn[5] <> 3 
	Li:= 5
	@ LI,25 PSAY cBSE
	@ LI,94 PSAY cBSE
	LI +=2
	@ LI,16 PSAY StrZero(Month(dDataRef),2)+"/"+ StrZero(Year(dDataRef),4)
	@ LI,37 PSAY dtoc(dDtPgto)
	@ LI,84 PSAY StrZero(Month(dDataRef),2)+"/"+ StrZero(Year(dDataRef),4)
	@ LI,105 PSAY dtoc(dDtPgto)
	LI ++
	@ LI,01 PSAY SRA->RA_MAT   
	@ LI,17 PSAY Substr(SRA->RA_NOME,1,40)
	@ LI,70 PSAY SRA->RA_MAT   
	@ LI,85 PSAY Substr(SRA->RA_NOME,1,40)
	LI +=1
	@ LI,02 PSAY Transform(SRA->RA_RG,PesqPict("SRA","RA_RG"))   
	@ LI,37 PSAY dtoc(SRA->RA_ADMISSA)
	@ LI,70 PSAY Transform(SRA->RA_RG,PesqPict("SRA","RA_RG"))   
	@ LI,105 PSAY dtoc(SRA->RA_ADMISSA)
	LI +=2
	@ LI,07 PSAY Alltrim(cCateg)+" - "+cFuncao
	@ LI,76 PSAY Alltrim(cCateg)+" - "+cFuncao
	Li += 3
	@ LI,00 PSAY STR0013   //SE/CAT DESCRIPCION           HORAS    DESCUENTOS     HABERES
	@ LI,67 PSAY STR0013   //SE/CAT DESCRIPCION           HORAS    DESCUENTOS     HABERES
	Li += 2
Else
	@ 00,000 PSAY &(aDriver[5])
	Li:= 6
	@ LI,35 PSAY cBSE
	@ LI,113 PSAY cBSE
	LI ++
	@ LI,26 PSAY StrZero(Month(dDataRef),2)+"/"+ StrZero(Year(dDataRef),4)
	@ LI,48 PSAY dtoc(dDtPgto)
	@ LI,103 PSAY StrZero(Month(dDataRef),2)+"/"+ StrZero(Year(dDataRef),4)
	@ LI,127 PSAY dtoc(dDtPgto)
	LI ++
	@ LI,08 PSAY SRA->RA_MAT   
	@ LI,27 PSAY Substr(SRA->RA_NOME,1,40)
	@ LI,87 PSAY SRA->RA_MAT   
	@ LI,105 PSAY Substr(SRA->RA_NOME,1,40)
	LI +=1
	@ LI,07 PSAY Transform(SRA->RA_RG,PesqPict("SRA","RA_RG"))   
	@ LI,48 PSAY dtoc(SRA->RA_ADMISSA)
	@ LI,86 PSAY Transform(SRA->RA_RG,PesqPict("SRA","RA_RG"))   
	@ LI,127 PSAY dtoc(SRA->RA_ADMISSA)
	LI +=1
	@ LI,14 PSAY Alltrim(cCateg)+" - "+cFuncao
	@ LI,93 PSAY Alltrim(cCateg)+" - "+cFuncao
	Li += 3
	@ LI,05 PSAY STR0013   //SE/CAT DESCRIPCION           HORAS    DESCUENTOS     HABERES
	@ LI,85 PSAY STR0013   //SE/CAT DESCRIPCION           HORAS    DESCUENTOS     HABERES
	Li += 2
Endif
Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯Lanca    � Autor � Silvia Taguti         � Data � 04.02.04 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao das Verbas                                       낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fLanca()                                                   낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
Static Function fLanca(nConta)   // Impressao dos Lancamentos

Local cString := Transform(aLanca[nConta,5],"@E 9,999,999.99")
Local nCol
Local nCol2

If aReturn[5] <> 3
	nCol := If(aLanca[nConta,1]="D",34,48)
	nCol2 := If(aLanca[nConta,1]="D",102,115)
	@ Li,00 PSAY cSE
//	@ Li,04 PSAY cCateg
	@ LI,07 PSAY aLanca[nConta,3]
   @ LI,28 PSAY TRANSFORM(aLanca[nConta,4],"999.99")
	@ LI,nCol PSAY cString   
	
	@ Li,67 PSAY cSE
//	@ Li,71 PSAY cCateg
	@ LI,74 PSAY aLanca[nConta,3]
	@ LI,95 PSAY TRANSFORM(aLanca[nConta,4],"999.99")
	@ LI,nCol2 PSAY cString   
Else
	nCol := If(aLanca[nConta,1]="D",39,53)
	nCol2 := If(aLanca[nConta,1]="D",119,133)

	@ Li,05 PSAY cSE
//	@ Li,08 PSAY cCateg                   		//Categoria
	@ LI,12 PSAY aLanca[nConta,3]         		//Descricao
   @ LI,33 PSAY TRANSFORM(aLanca[nConta,4],"999.99")
	@ LI,nCol PSAY cString   
	
	@ Li,85 PSAY cSE
//	@ Li,89 PSAY cCateg                    	//categoria
	@ LI,92 PSAY aLanca[nConta,3]          	//Descricao
	@ LI,113 PSAY TRANSFORM(aLanca[nConta,4],"999.99")
	@ LI,nCol2 PSAY cString   
Endif	
Li ++

Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  쿯RODAPE   튍utor  쿞ilvia Taguti       � Data �  02/05/04   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒esc.     � Imprime Rodape do Recibo                                   볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � AP                                                        볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/
Static Function fRodape()

If aReturn[5] <> 3
	@ LI,01 PSAY STR0016 + TRANS(nArredProv-nArredDesc ,"@E 999,999,999.99") 	//Redondeo
	@ LI,67 PSAY STR0016 + TRANS(nArredProv-nArredDesc ,"@E 999,999,999.99") 	//Redondeo
	Li++
	@ LI,01 PSAY STR0017 + TRANS(nLiqCob ,"@E 999,999,999.99")    //Total a Cobrar
	@ LI,67 PSAY STR0017 + TRANS(nLiqCob ,"@E 999,999,999.99")    //Total a Cobrar
	Li += 6
	@ LI,01 PSAY STR0018                                //Empresa al dia con bps
	@ LI,67 PSAY STR0018                                //Empresa al dia con bps
Else
	@ LI,05 PSAY STR0016 + TRANS(nArredProv-nArredDesc ,"@E 999,999,999.99") 	//Redondeo
	@ LI,85 PSAY STR0016 + TRANS(nArredProv-nArredDesc ,"@E 999,999,999.99") 	//Redondeo
	Li++
	@ LI,05 PSAY STR0017 + TRANS(nLiqCob ,"@E 999,999,999.99")    //Total a Cobrar
	@ LI,85 PSAY STR0017 + TRANS(nLiqCob ,"@E 999,999,999.99")    //Total a Cobrar
	Li += 6
	@ LI,05 PSAY STR0018                                //Empresa al dia con bps
	@ LI,85 PSAY STR0018                                //Empresa al dia con bps
Endif	

Return

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯SomaPd   � Autor � R.H. - Mauro          � Data � 24.09.95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Somar as Verbas no Array                                   낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fSomaPd(Tipo,Verba,Horas,Valor)                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
Static Function fSomaPd(cTipo,cPd,nHoras,nValor)

Local Desc_paga

Desc_paga := DescPd(cPd,Sra->Ra_Filial)  // mostra como pagto

If cTipo # 'B'
    //--Array para Recibo Pre-Impresso
    nPos := Ascan(aLanca,{ |X| X[2] = cPd })
    If nPos == 0
        Aadd(aLanca,{cTipo,cPd,Desc_Paga,nHoras,nValor})
    Else
       aLanca[nPos,4] += nHoras
       aLanca[nPos,5] += nValor
    Endif
Endif

//--Array para o Recibo Pre-Impresso
If cTipo = 'P'
   cArray := "aProve"
Elseif cTipo = 'D'
   cArray := "aDesco"
Elseif cTipo = 'B'
   cArray := "aBases"
Endif

nPos := Ascan(&cArray,{ |X| X[1] = cPd })
If nPos == 0
    Aadd(&cArray,{cPd+" "+Desc_Paga,nHoras,nValor })
Else
    &cArray[nPos,2] += nHoras
    &cArray[nPos,3] += nValor
Endif
Return

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  쿯Inicia   튍utor  쿙atie               � Data �  04/12/01   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒esc.     쿔nicializa parametros para impressao                        볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � AP5                                                        볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/
Static Function  fInicia(cString)

aDriver := ReadDriver()
If LastKey() = 27 .Or. nLastKey = 27
	Return  .F. 
Endif

SetDefault(aReturn,cString)
If LastKey() = 27 .Or. nLastKey = 27
	Return .F.
Endif 

Return .T. 

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯Continua � Autor � R.H. - Ze Maria       � Data � 14.03.95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressap da Continuacao do Recibo                         낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fContinua()                                                낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
Static Function fContinua()    // Continuacao do Recibo

Li+=1
   @ LI,05 PSAY STR0019		//"CONTINUA !!!"
Li+=1

Return Nil
