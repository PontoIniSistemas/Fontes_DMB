#INCLUDE "rwmake.ch"
#include "RGPER11.ch"
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
굇튡rograma  쿝GPER11   � Autor � AP6 IDE            � Data �  11/07/03   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒escricao � Recibo de Descargo Bonificacion / Regalia                  볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � AP6 IDE                                                    볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

User Function RGPER11

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Declaracao de Variaveis                                             �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
Local cPict          := ""
Local titulo       := STR0001
Local nLin         := 80
Local imprime      := .T.
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite       := 80
Private tamanho      := "P"
Private nomeprog     := "RGPER11" // Coloque aqui o nome do programa para impressao no cabecalho
Private aReturn      := { STR0002, 1, STR0003, 2, 2, 1, "", 1}
Private nLastKey     := 0
Private npag      	:= 0
Private wnrel      	:= "RGPER11" // Coloque aqui o nome do arquivo usado para impressao em disco
Private nVlrBonif 	:= 0
Private nVlrLiqReg	:= 0
Private nVlrLiqBon	:= 0
Private cString := "SRA"
Private cDescMoeda 	:= SubStr(GetMV("MV_SIMB1"),1,3)
Private cPerg    :="RGPR11"
Private aCodFol:= {}
Private li     := 5
Private cPict1	:= TM(9999999999,16,MsDecimais(1))
Private cPict2	:= PesqPict("SRC","RC_HORAS",10)

dbSelectArea("SRA")
dbSetOrder(1)

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴커
//� Verifica as perguntas selecionadas                           �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸
Pergunte("RGPR11",.T.)

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
//| mv_par13		  //  Mes/Ano Referencia							  |
//| mv_par14		  //  Semana            							  |
//| mv_par15		  //  Tipo de Recibo    							  |
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴켸

If nLastKey == 27
   Return
Endif

//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
//� Processamento. RPTSTATUS monta janela com a regua de processamento. �
//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
wnrel:="RGPER11"            //Nome Default do relatorio em Disco

RptStatus({|lEnd|RGPR11Imp(@lEnd,wnRel,cString)},Titulo)


Return

/*/
複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複複�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
굇�袴袴袴袴袴佶袴袴袴袴藁袴袴袴錮袴袴袴袴袴袴袴袴袴袴箇袴袴錮袴袴袴袴袴袴敲굇
굇튔un뇙o    쿝GPR11IMP � Autor � AP6 IDE            � Data �  08/07/03   볍�
굇勁袴袴袴袴曲袴袴袴袴袴姦袴袴袴鳩袴袴袴袴袴袴袴袴袴菰袴袴袴鳩袴袴袴袴袴袴묽�
굇튒escri뇙o 쿛rocessamento para Impressao de Relatorio                   볍�
굇�          �                                                            볍�
굇勁袴袴袴袴曲袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴묽�
굇튧so       � Programa principal                                         볍�
굇훤袴袴袴袴賈袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴袴선�
굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇굇�
賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽賽�
/*/

Static Function RGPR11Imp(lEnd,WnRel,cString)

Local nOrdem
Local aOrdBag     := {}
Local cArqMov     := ""
Local dChkDtRef
Local aInfo	 	:= {}

Private cAliasMov := ""
Private cFPag
Private cDocum
Private cSemana
Private oPrn := TMSPrinter():New()

// Crea los objetos con las configuraciones de fuentes
oFont09  := TFont():New( "Corrier New",,09,,.f.,,,,,.f. )
oFont09b := TFont():New( "Corrier New",,09,,.t.,,,,,.f. )
oFont12  := TFont():New( "Corrier New",,10,,.f.,,,,,.f. )
oFont12b := TFont():New( "Corrier New",,10,,.t.,,,,,.f. )
oFont18b := TFont():New( "Times New Roman",,18,,.T.,,,,.F.,.F. )

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
cMesAno    := mv_par13        			//  Data Referencia                          
cSemana	  := mv_par14
lTipoRec   :=If(mv_par15 == 1,.T.,.F.) // .T. -Bonificacao  .F.- Relalia
 
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

cMesAnoRef := If(lTipoRec,cMesAno,"13"+Right(cMesAno,4))
dChkDtRef   := CTOD("01/"+Left(cMesAno,2)+"/"+Right(cMesAno,4),"DDMMYY")
cFilialAnt := "  "
Desc_Fil := ""

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
	cDocum   := SRA->RA_RG
   
	If lTipoRec
		dbSelectArea("SRC")
		If dbSeek( SRA->RA_FILIAL + SRA->RA_MAT )
			While !Eof() .And. (SRA->RA_FILIAL+SRA->RA_MAT==SRC->RC_FILIAL+SRC->RC_MAT)
 				If SRC->RC_SEMANA <> cSemana 
 					DbSkip()
			 		Loop
 				Endif	
				If SRC->RC_PD == aCodFol[151,1] 				//Bonificacao
					nVlrBonif := SRC->RC_VALOR
				Endif	
				If SRC->RC_PD == aCodFol[047,1]
					nVlrLiqBon := SRC->RC_VALOR
				Endif
				dbSelectArea("SRC")
		   	dbSkip()
		  	Enddo	
	   Endif
	   nVlrLiqBon := If(nVlrBonif > 0,nVlrLiqBon,0)
	Else
		dbSelectArea("SRI")
		If dbSeek( SRA->RA_FILIAL + SRA->RA_MAT )
			While !Eof() .And. (SRA->RA_FILIAL+SRA->RA_MAT==SRI->RI_FILIAL+SRI->RI_MAT)
   			If SRI->RI_PD == aCodFol[21,1]
            	nVlrLiqReg := SRI->RI_VALOR
            Endif
            dbSkip()
   		EndDo		
		Endif	     
	Endif   
	If nVlrLiqBon == 0 .And. nVlrLiqReg == 0
		dbSelectArea("SRA")
		dbSkip()
		Loop
	Endif
	RGImprime()
	SRA->( dbSkip() )
	nVlrBonif := nVlrRega := 0
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
If lTipoRec
	nTamExt := Len(Extenso(nVlrLiqBon,.F.,1,,,.T.,.T.,.T.,"2"))
Else
	nTamExt := Len(Extenso(nVlrLiqReg,.F.,1,,,.T.,.T.,.T.,"2"))
Endif
// Crea un nuevo objeto para impresion
If Li > 1000
	// Cerra la pagina
	oPrn:EndPage()
 	oPrn:StartPage()
Endif
nPag += 1
Li := 100

oPrn:Say(Li+=50,700,Desc_Fil,oFont18b ,100)   						//Corporacion Avic. Y Gan.
oPrn:Say(Li+=70,600,OemToAnsi(STR0004),oFont18b ,100)  			//RECIBO DE DESCARGO
If lTipoRec
	oPrn:Say(Li+=70,1100,OemToAnsi(STR0005),oFont18b ,100)  	//Bonificacao
Else
	oPrn:Say(Li+=70,1100,OemToAnsi(STR0006),oFont18b ,100)  	//Regalia
Endif
oPrn:Line(Li+=90,200,Li,2150)
oPrn:Say(Li+=300,200,StrZero(nPag,4),oFont12,50) 					//Pagina
oPrn:Say(Li+=50,200,DescCc(SRA->RA_CC,SRA->RA_FILIAL),oFont12,50) //Centro de Custo

oPrn:Say(Li+=300,200,OemToAnsi(STR0007)+SRA->RA_NOME,oFont12,50)     //El suscrito
oPrn:Say(Li,1495,OemToAnsi(STR0008),oFont12,50) 						     //mayor de edad
oPrn:Say(Li+=50,200,cFPag,oFont12,50)
oPrn:Say(Li,900,OemToAnsi(STR0009),oFont12,50)
oPrn:Say(Li,1845,cDocum,oFont12,50)
oPrn:Say(Li+=50,200,OemToAnsi(STR0010),oFont12,50)
oPrn:Say(Li+=50,200,OemToAnsi(STR0011),oFont12,50)
If lTipoRec
	oPrn:Say(Li,420,cDescMoeda+" "+Transform(nVlrLiqBon,cPict1),oFont12,50)
	oPrn:Say(Li,855,+" "+Substr(Extenso(nVlrLiqBon,.F.,1,,,.T.,.T.,.T.,"2"),1,57),oFont12,50) 
	If Len(Extenso(nVlrLiqBon,.T.,1,,,.T.,.T.,.T.,"2")) > 57
		oPrn:Say(Li+=50,200,Substr(Extenso(nVlrLiqBon,.F.,1,,,.T.,.T.,.T.,"2"),58,nTamExt)+".",oFont12,50)
	Endif
Else
	oPrn:Say(Li,420,cDescMoeda+" "+Transform(nVlrLiqReg,cPict1),oFont12,50)
	oPrn:Say(Li,855,+" "+Substr(Extenso(nVlrLiqReg,.F.,1,,,.T.,.T.,.T.,"2"),1,57),oFont12,50) 
	If Len(Extenso(nVlrLiqReg,.F.,1,,,.T.,.T.,.T.,"2")) > 57
		oPrn:Say(Li+=50,200,Substr(Extenso(nVlrLiqReg,.F.,1,,,.T.,.T.,.T.,"2"),58,nTamExt)+".",oFont12,50)
	Endif
Endif           

oPrn:Say(Li+=50,200,OemToAnsi(STR0012)+"  "+Desc_Fil,oFont12,50)            
oPrn:Say(Li+=50,200,OemToAnsi(STR0013)+If(lTipoRec,OemToAnsi(STR0014),OemToAnsi(STR0015))+;
		   OemToAnsi(STR0016)+Right(cMesAno,4)+".",oFont12,50)

oPrn:Say(Li+=250,200,REPLICATE("_",Len(SRA->RA_NOME)),oFont12,50)            
oPrn:Say(Li+=050,220,SRA->RA_NOME,oFont12b,50)            
Li+=100
Return


