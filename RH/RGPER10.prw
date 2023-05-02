#INCLUDE "rwmake.ch"
#include "RGPER10.ch"
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


/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  쿝GPER10   � Autor � AP6 IDE            � Data �  08/07/03   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒escricao � Recibo de Descargo                                         볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � AP6 IDE                                                    볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

User Function RGPER10

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de Variaveis                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

Local cPict          := ""
Local titulo       := STR0003
Local nLin         := 80

Local imprime      := .T.
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite           := 80
Private tamanho          := "P"
Private nomeprog         := "RGPER10" // Coloque aqui o nome do programa para impressao no cabecalho
Private nTipo            := 18
Private aReturn          := { STR0001, 1, STR0002, 2, 2, 1, "", 1}
Private nLastKey        := 0
Private npag      := 0
Private wnrel      := "RGPER10" // Coloque aqui o nome do arquivo usado para impressao em disco
Private nVlrLiq 	 := 0
Private cString := "SRA"
Private cDescMoeda 	:= SubStr(GetMV("MV_SIMB1"),1,3)
Private cPerg    :="RGPR10"
Private aCodFol:= {}
Private li     := 5
Private cPict1	:= TM(9999999999,16,MsDecimais(1))
Private cPict2	:= PesqPict("SRR","RR_HORAS",10)

dbSelectArea("SRA")
dbSetOrder(1)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica as perguntas selecionadas                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Pergunte("RGPR10",.T.)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Variaveis utilizadas para parametros                         �
//� mv_par01        //  Filial De                                �
//� mv_par02        //  Filial Ate                               �
//� mv_par03        //  Centro de Custo De                       �
//� mv_par04        //  Centro de Custo Ate                      �
//� mv_par05        //  Matricula De                             �
//� mv_par06        //  Matricula Ate                            �
//� mv_par07        //  Nome De                                  �
//� mv_par08        //  Nome Ate                                 �
//� mv_par09        //  Chapa De                                 �
//� mv_par10        //  Chapa Ate                                �
//� mv_par11        //  Categorias                               �
//� mv_par12        //  Situa뉏es                                �
//| mv_par13		  //  Data de Referencia							  |
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

If nLastKey == 27
   Return
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
wnrel:="RGPER10"            //Nome Default do relatorio em Disco

RptStatus({|lEnd|RGPR10Imp(@lEnd,wnRel,cString)},Titulo)

Return

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튔un뇙o    쿝GPR10IMP � Autor � AP6 IDE            � Data �  08/07/03   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒escri뇙o 쿛rocessamento para Impressao de Relatorio                   볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � Programa principal                                         볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

Static Function RGPR10Imp(lEnd,WnRel,cString)

Local nOrdem
Local aOrdBag     := {}
Local cMesArqRef  
Local cArqMov     := ""
Local dChkDtRef
Local aInfo	 	:= {}

Private cAliasMov := ""
Private nMesesTrab:= 0
Private aLanca := {}
Private aProve := {}
Private aDesco := {}
Private cFPag
Private dDtEntra:= ctod("  /  /  ")          
Private oPrn := TMSPrinter():New()

// Crea los objetos con las configuraciones de fuentes
oFont09  := TFont():New( "Corrier New",,09,,.f.,,,,,.f. )
oFont09b := TFont():New( "Corrier New",,09,,.t.,,,,,.f. )
oFont10  := TFont():New( "Corrier New",,10,,.f.,,,,,.f. )
oFont10b := TFont():New( "Corrier New",,10,,.t.,,,,,.f. )
oFont13b := TFont():New( "Corrier New",,13,,.t.,,,,,.f. )

cFilDe     := mv_par01
cFilAte    := mv_par02
cCcDe      := mv_par03
cCcAte     := mv_par04
cMatDe     := mv_par05
cMatAte    := mv_par06
cNomeDe    := mv_par07
cNomeAte   := mv_par08
cChapaDe   := mv_par09
cChapaAte  := mv_par10
cCategoria := mv_par11
cSituacao  := mv_par12						//  Situacao Funcionario
dDataImp   := mv_par13        			//  Data Referencia                          
nOrdem := aReturn[8]

If nOrdem == 1
	dbSeek(cFilDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_MAT"
	cFim    := cFilAte + cMatAte
ElseIf nOrdem == 2
	dbSeek(cFilDe + cCcDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_CC + SRA->RA_MAT"
	cFim    := cFilAte + cCcAte + cMatAte
ElseIf nOrdem == 3
	DbSeek(cFilDe + cNomeDe + cMatDe,.T.)
	cInicio := "SRA->RA_FILIAL + SRA->RA_NOME + SRA->RA_MAT"
	cFim    := cFilAte + cNomeAte + cMatAte
Endif

cAnoMes    := AnoMes(dDataImp)
cMesAnoRef := StrZero(Month(dDataImp),2) + StrZero(Year(dDataImp),4)
dChkDtRef   := CTOD("01/"+Right(cAnoMes,2)+"/"+Left(cAnoMes,4),"DDMMYY")
cMesArqRef  := cMesAnoRef
cFilialAnt := "  "
Desc_Fil := ""
TOTVENC:= TOTDESC:= 0

If !OpenSrc( cMesAnoRef, @cAliasMov, @aOrdBag, @cArqMov, dChkDtRef)
	Return .f.
Endif

dbSelectArea(cString)
dbSetOrder(1)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� SETREGUA -> Indica quantos registros serao processados para a regua �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

SetRegua(RecCount())
dbGoTop()

While SRA->( !Eof() .And. &cInicio <= cFim )

   //旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
   //� Verifica o cancelamento pelo usuario...                             �
   //읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�

   If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif

  	IncRegua()  // Anda a regua
   If lEnd
		@Prow()+1,0 PSAY cCancel
		Exit
	Endif
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Consiste Parametrizacao do Intervalo de Impressao            �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If (SRA->RA_CHAPA < cChapaDe).Or. (SRA->Ra_CHAPa > cChapaAte).Or. ;
	   (SRA->RA_NOME < cNomeDe)  .Or. (SRA->Ra_NOME > cNomeAte)  .Or. ;
	   (SRA->RA_MAT < cMatDe)    .Or. (SRA->Ra_MAT > cMatAte)    .Or. ;
	   (SRA->RA_CC < cCcDe)      .Or. (SRA->Ra_CC > cCcAte)
		SRA->(dbSkip(1))
		Loop
	EndIf
	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
	//� Testa Situacao do Funcionario na Folha						 �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
	If !( SRA->RA_SITFOLH $ cSituacao ) .Or. !( SRA->RA_CATFUNC $ cCategoria )
		dbSkip()
		Loop
	EndIf
	
	If SRA->RA_FILIAL # cFilialAnt
		If ! Fp_CodFol(@aCodFol,Sra->Ra_Filial)
	       Exit
	   Endif
    	If ! fInfo(@aInfo,SRA->RA_FILIAL)
			Exit
		Endif
		Desc_Fil := aInfo[3]

	   dbSelectArea( "SRA" )
	   cFilialAnt := SRA->RA_FILIAL
	Endif
 	cFPag 	:= DescFun(Sra->Ra_Codfunc,Sra->Ra_Filial) // Cargo
   dDtEntra := SRA->RA_DTENTRA                                      // Admissao

	nMesesTrab:= Int((dDataImp - SRA->RA_ADMISSA) / 30)
	nDiasTrab := dDataImp - SRA->RA_ADMISSA                             //Meses Trabalhados
	If nMesesTrab > 12
		nMesesTrab:= 12.0
	Else	
		nMesesTrab += (nDiasTrab-(nMesesTrab * 30))/100
   Endif
	

	aProve:={}         // Zera Lancamentos
	aDesco:={}         // Zera Lancamentos
	aLanca:={}         // Zera Lancamentos
   
	dbSelectArea("SRG") 
	dbSetOrder(1)
	If dbSeek( SRA->RA_FILIAL + SRA->RA_MAT ) 
		While !Eof() .And. (SRA->RA_FILIAL+SRA->RA_MAT==SRG->RG_FILIAL+SRG->RG_MAT)
 			If(SRA->RA_FILIAL+SRA->RA_MAT==SRG->RG_FILIAL+SRG->RG_MAT) .And.;
 				SRG->RG_DATADEM==dDataImp 
  				dbSelectArea("SRR")
				If SRR->( dbSeek( SRA->RA_FILIAL+SRA->RA_MAT+ "R" ) )
					While SRR->( !Eof() .And. ( SRA->RA_FILIAL+SRA->RA_MAT + "R" ) == ( RR_FILIAL + RR_MAT + RR_TIPO3 ) )
						If ( SRR->RR_DATA == SRG->RG_DTGERAR )
							If SRR->RR_PD == aCodFol[126,1] 									//Regalia
							   nVlrLiq := SRR->RR_VALOR
							ElseIf PosSrv( SRR->RR_PD , SRA->RA_FILIAL , "RV_TIPOCOD" ) == "1"
								fSomaPd("P",SRR->RR_PD,(SRR->RR_HORAS/SRA->RA_HRSDIA),SRR->RR_VALOR)
								TOTVENC = TOTVENC + SRR->RR_VALOR
							Elseif PosSrv( SRR->RR_PD , SRA->RA_FILIAL , "RV_TIPOCOD" ) == "2"
								fSomaPd("D",SRR->RR_PD,SRR->RR_HORAS,SRR->RR_VALOR)
								TOTDESC = TOTDESC + SRR->RR_VALOR
							Endif	
	   				Endif
						dbSelectArea("SRR")
	   				dbSkip()
	   			Enddo	
	   		Endif	
			Endif
			dbSelectArea("SRG")
			dbSkip()
	   Enddo
	Endif	
	If TOTVENC = 0 .And. TOTDESC = 0
		dbSelectArea("SRA")
		dbSkip()
		Loop
	Endif
	RGImprime()
	SRA->( dbSkip() )
	TOTDESC := TOTVENC := 0
EndDo

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Finaliza a execucao do relatorio...                                 �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
// Cerra la pagina
oPrn:EndPage()
// Mostra la pentalla de Setup
oPrn:Setup()
// Mostra la pentalla de preview
oPrn:Preview()

MS_FLUSH()

Return Nil

/*
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튡rograma  쿝GImprime 튍utor  쿘icrosiga           � Data �  07/08/03   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒esc.     쿔mprime Recibo de Descargo                                  볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � AP                                                        볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
*/

Static Function RgImprime()
Local nTamExt

// Crea un nuevo objeto para impresion
If Li > 2000
	// Cerra la pagina
	oPrn:EndPage()
 	oPrn:StartPage()
Endif
nTamExt := Len(Extenso(nVlrLiq,.F.,1,,,.T.,.T.,.T.,"2"))
nPag += 1
Li := 100

oPrn:Say(Li+=50,200,StrZero(nPag,4),oFont10,50) 
oPrn:Say(Li+=50,200,DescCc(SRA->RA_CC,SRA->RA_FILIAL),oFont10,50) 
oPrn:Say(Li+=50,200,OemToAnsi(STR0018)+dtoc(dDtEntra),oFont10,50) 
oPrn:Say(Li,900,OemToAnsi(STR0010),oFont13b ,100)   		//RECIBO DE DESCARGO
oPrn:Line(Li+=80,200,Li,2200)
oPrn:Say(Li+=150,200,OemToAnsi(STR0004),oFont10,50) 
oPrn:Say(Li,500,Desc_Fil,oFont10b,50)
oPrn:Say(Li,1890,OemToAnsi(STR0005),oFont10,50)              //la suma de 
oPrn:Say(Li+=50,200,cDescMoeda+" "+Transform(nVlrLiq,cPict1),oFont10,50)
oPrn:Say(Li,650,+" "+Substr(Extenso(nVlrLiq,.F.,1,,,.T.,.T.,.T.,"2"),1,68),oFont10,50) 
If Len(Extenso(nVlrLiq,.F.,1,,,.T.,.T.,.T.,"2")) > 68
	oPrn:Say(Li+=50,200,Substr(Extenso(nVlrLiq,.F.,1,,,.T.,.T.,.T.,"2"),69,nTamExt),oFont10,50)
Endif
oPrn:Say(Li+=50,200,OemToAnsi(STR0006),oFont10,50)
oPrn:Say(Li+=50,200,OemToAnsi(STR0007)+Alltrim(Transform(nMesesTrab,cPict1)),oFont10,50)
oPrn:Say(Li,500,OemToAnsi(STR0008)+cFPag+".",oFont10,50)
oPrn:Say(Li+=50,200,OemToAnsi(STR0009),oFont10,50)

fLanca()

oPrn:Say(Li+=50,200,OemToAnsi(STR0011),oFont10,50)      //Al expedir  el presente
oPrn:Say(Li+=50,200,OemToAnsi(STR0012),oFont10,50)      //ex-empleador      
oPrn:Say(Li+=50,200,OemToAnsi(STR0013),oFont10,50)      //y definitivo     o
oPrn:Say(Li+=50,200,OemToAnsi(STR0014),oFont10,50)
oPrn:Say(Li+=50,200,StrZero(Month(dDataImp),2)+" "+OemToAnsi(STR0015)+MesExtenso(Month(dDataImp))+STR0016+"(" +Str(Year(dDataImp),4)+ ").",oFont10,50)
oPrn:Say(Li+=200,200,REPLICATE("_",Len(SRA->RA_NOME)),oFont10,50)
oPrn:Say(Li+=50,220,SRA->RA_NOME,oFont10b,50)

oPrn:Say(Li+=250,200,OemToAnsi(STR0017),oFont10,50)
oPrn:Say(Li+=50,200,OemToAnsi(STR0019),oFont10,50)
oPrn:Say(Li+=50,200,OemToAnsi(STR0020),oFont10,50)
oPrn:Say(Li+=50,200,OemToAnsi(STR0021),oFont10,50)
oPrn:Say(Li+=50,200,OemToAnsi(STR0022),oFont10,50)
oPrn:Say(Li+=50,200,OemToAnsi(STR0023),oFont10,50)
oPrn:Say(Li+=50,200,OemToAnsi(STR0024)+"(" +Str(Year(dDataImp),4)+ ").",oFont10,50)

oPrn:Say(Li+=250,1130,REPLICATE("_",24),oFont10,50)
oPrn:Say(Li+=50,1200,OemToAnsi(STR0025),oFont10,50)

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
굇旼컴컴컴컴컫컴컴컴컴컴쩡컴컴컴쩡컴컴컴컴컴컴컴컴컴컴컴쩡컴컴컫컴컴컴컴컴엽�
굇쿑un뇚o    쿯Lanca    � Autor � Silvia Taguti         � Data � 14.03.95 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴좔컴컴컴좔컴컴컴컴컴컴컴컴컴컴컴좔컴컴컨컴컴컴컴컴눙�
굇쿏escri뇚o � Impressao das Verbas 							                 낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿞intaxe   � fLancaZ()                                                  낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇쿛arametros�                                                            낢�
굇쳐컴컴컴컴컵컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇� Uso      � Generico                                                   낢�
굇쳐컴컴컴컴컨컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴눙�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�*/
Static Function fLanca()   // Impressao dos Lancamentos

Local nTermina  := 0
Local nCont     := 0

nTermina := Max(LEN(aProve),LEN(aDesco))
Li+=50

For nCont := 1 To nTermina
	IF nCont <= LEN(aProve)
		oPrn:Say(Li+=50,200,aProve[nCont,1]+SPACE(4)+TRANSFORM(aProve[nCont,2],"@R 999.99")+SPACE(05)+TRANSFORM(aProve[nCont,3],"@R 999,999.99"),oFont09,50)
	ENDIF
	IF nCont <= LEN(aDesco)
		oPrn:Say(Li,1200,aDesco[nCont,1]+SPACE(4)+TRANSFORM(aDesco[nCont,2],"@R 999.99")+SPACE(05)+TRANSFORM(aDesco[nCont,3],"@R 999,999.99"),oFont09,50)
	ENDIF
Next

If nTermina *50 < (7 *50)
	Li:= Li + ((7*50) - (nTermina*50))
Endif
	
Return Nil
