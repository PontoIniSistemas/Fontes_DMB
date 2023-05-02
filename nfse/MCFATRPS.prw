#INCLUDE "TOPCONN.CH"
#INCLUDE "RWMAKE.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "VKEY.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#DEFINE CLRF CHR(13)+CHR(10)
//---------------------------------------------------------------------------
/*/{Protheus.doc} MCFATRPS

@protected
@author    Rodrigo Carvalho
@since     07/11/2019
@Obs       Relat�rio NFS-e, Nota Fiscal de Servi�os Eletronica

Alteracoes Realizadas desde a Estruturacao Inicial
Data       Programador     Motivo
/*/ 
//---------------------------------------------------------------------------
User Function MCFATRPS()

Local   nQtd

Private nLin    := 0100 //variavel para tratar graficamente as linhas
Private nCol    := 0100 //variavel para tratar graficamente as colunas
Private nNumLin := 3000 //variavel para tratar o numero de linhas que cada pagina suporta
Private cRelNome:= "NFS-e - NOTA FISCAL DE SERVI�OS ELETR�NICA"
Private nPagina := 1 	//contador das paginas
Private oPrint	:= TMSPrinter():New(cRelNome) // essa variavel � para imprimir relatorio grafico
Private nBottom	:= oPrint:nVertRes()-100//X
Private	nWidth 	:= oPrint:nHorzRes()-100//X

Private cMsgSimpl := "EMPRESA OPTANTE PELO SIMPLES NACIONAL"
Private oFTreb7   := TFont():New("Trebuchet MS",07,07,,.F.,,,,.F.,.F.)
Private oFTreb7n  := TFont():New("Trebuchet MS",07,07,,.T.,,,,.T.,.F.)
Private oFTreb8   := TFont():New("Trebuchet MS",08,08,,.F.,,,,.F.,.F.)
Private oFTreb8n  := TFont():New("Trebuchet MS",08,08,,.T.,,,,.T.,.F.)
Private oFTreb9   := TFont():New("Trebuchet MS",09,09,,.F.,,,,.F.,.F.)
Private oFTreb9n  := TFont():New("Trebuchet MS",09,09,,.T.,,,,.T.,.F.)
Private oFTreb10  := TFont():New("Trebuchet MS",10,10,,.F.,,,,.F.,.F.)
Private oFTreb10n := TFont():New("Trebuchet MS",10,10,,.T.,,,,.T.,.F.)
Private oFArial10 := TFont():New("Arial",,-10,,.F.,,,,.F.,.F.)
Private oFArial10n:= TFont():New("Arial",,-10,,.T.,,,,.T.,.F.)
Private oFArial11 := TFont():New("Arial",,-11,,.F.,,,,.F.,.F.)
Private oFArial11n:= TFont():New("Arial",,-11,,.T.,,,,.T.,.F.)
Private oFArial12 := TFont():New("Arial",,-12,,.F.,,,,.F.,.F.)
Private oFArial12n:= TFont():New("Arial",,-12,,.T.,,,,.T.,.F.)
Private oFArial14 := TFont():New("Arial",,-14,,.F.,,,,.F.,.F.)
Private oFArial14n:= TFont():New("Arial",,-14,,.T.,,,,.T.,.F.)
Private oFArial16 := TFont():New("Arial",,-16,,.F.,,,,.F.,.F.)
Private oFArial16n:= TFont():New("Arial",,-16,,.T.,,,,.T.,.F.)
Private oFArial20 := TFont():New("Arial",,-20,,.F.,,,,.F.,.F.)
Private oFArial20n:= TFont():New("Arial",,-20,,.T.,,,,.T.,.F.)
Private cNumero  := ""
Private cData    := ""
Private cHora    := ""
Private cCompet  := Ctod("")
Private cCodNFE	 := ""
Private cDataVen := Ctod("")
Private cEmpNom	 := AllTrim(SM0->M0_NOMECOM)
Private cEmCNPJ	 := AllTrim(SM0->M0_CGC)
Private cInscMu	 := AllTrim(SM0->M0_INSCM)
Private cEmpEnd	 := AllTrim(SM0->M0_ENDENT)
Private cEmpBai	 := AllTrim(SM0->M0_BAIRENT)
Private cEmpCep  := AllTrim(SM0->M0_CEPENT)
Private cEmpCid	 := AllTrim(SM0->M0_CIDENT)
Private cEmpEst  := AllTrim(SM0->M0_ESTENT)
Private cEmpTel  := AllTrim(SM0->M0_TEL)
Private cTomCNPJ := ""
Private cTomINSC := ""
Private cTomNome := ""
Private cTomEnde := ""
Private cTomBair := ""
Private cTomCIDA := ""
Private cTomESTA := ""
Private cTomFone := ""
Private cTomEmai := ""
Private cServ    := ""
Private cCNAEBH	 := ""
Private cTRIBMUN := ""
Private cCODISS  := ""   
Private cPedCli  := ""
Private cMunServ := ""
Private cTrbServ := ""
Private cDescNFE := ""
Private cPerg    := "MCFATRPS01"
Private nValServ := 0
Private nDedu    := 0
Private nIrRet   := 0
Private nCsllRet := 0
Private nPisRet  := 0
Private nCofRet  := 0
Private nInssRet := 0
Private nIssRet  := 0
Private nIssAli  := 0
Private nValLiq  :=	0
Private nIncond  := 0
Private nValAli  := 0
Private nValNota := 0
Private nPercMO  := 0

If ! FReadParam()
   Return .T.
Endif   

FBuscaInf()
	
Return





//---------------------------------------------------------------------------
/*/{Protheus.doc} FBuscaInf

@protected
@author    Rodrigo Carvalho
@since     07/11/2019
@Obs       Relat�rio NFS-e, Nota Fiscal de Servi�os Eletronica

Alteracoes Realizadas desde a Estruturacao Inicial
Data       Programador     Motivo
/*/ 
//---------------------------------------------------------------------------
Static Function FBuscaInf() 

Local aDadosTSS := {}
Local aUF       := {}

aadd(aUF,{"RO","11"})
aadd(aUF,{"AC","12"})
aadd(aUF,{"AM","13"})
aadd(aUF,{"RR","14"})
aadd(aUF,{"PA","15"})
aadd(aUF,{"AP","16"})
aadd(aUF,{"TO","17"})
aadd(aUF,{"MA","21"})
aadd(aUF,{"PI","22"})
aadd(aUF,{"CE","23"})
aadd(aUF,{"RN","24"})
aadd(aUF,{"PB","25"})
aadd(aUF,{"PE","26"})
aadd(aUF,{"AL","27"})
aadd(aUF,{"MG","31"})
aadd(aUF,{"ES","32"})
aadd(aUF,{"RJ","33"})
aadd(aUF,{"SP","35"})
aadd(aUF,{"PR","41"})
aadd(aUF,{"SC","42"})
aadd(aUF,{"RS","43"})
aadd(aUF,{"MS","50"})
aadd(aUF,{"MT","51"})
aadd(aUF,{"GO","52"})
aadd(aUF,{"DF","53"})
aadd(aUF,{"SE","28"})
aadd(aUF,{"BA","29"})
aadd(aUF,{"EX","99"})

dbSelectArea("SF2")
dbSetOrder(1)

If MsSeek(xFilial("SF2")+MV_PAR01+MV_PAR03) 
   
   nQtd := 1
   
   If !oPrint:Setup() .or. !oPrint:IsPrinterActive()
		Alert("Selecione a impressora padrao.")
		return
   Endif 	
   
   oPrint:SetPortrait() //SetPortrait() ou SetLandscape()
   oPrint:setPaperSize(9)//Formato A4
	
   	Do While ! SF2->(Eof()) .And. SF2->F2_FILIAL == xFilial("SF2") .And.;
   	                              SF2->F2_SERIE  == MV_PAR03 .And.;
                                 (SF2->F2_DOC    >= MV_PAR01 .And.;
                                  SF2->F2_DOC    <= MV_PAR02)
                
		If ( nQtd > 1 )
   
			oPrint:EndPage()
			oPrint:StartPage()
			nLin 	:= 100
			nDedu	:= 0
			nValServ:= 0
			nDedu   := 0
			nIrRet  := 0
			nCsllRet:= 0
			nPisRet := 0
			nCofRet := 0
			nInssRet:= 0                                             
			nIssRet := 0
			nValLiq := 0      
			nIncond := 0
			nValAli := 0        
			nValNota:= 0
			nPercMO := 0
			cCNAEBH := "" 
            cTRIBMUN:= ""
            cCODISS := ""
            cDescNFE:= ""
            cPedCli := ""
		EndIf

		dbSelectArea("SA1")
		dbSetOrder(1)
		MsSeek(xFilial("SA1")+SF2->F2_CLIENTE + SF2->F2_LOJA)

		dbSelectArea("SD2")
		dbSetOrder(3)
		MsSeek(xFilial("SD2") + SF2->(F2_DOC+F2_SERIE) )  	

		dbSelectArea("SC5")
		dbSetOrder(1)
		MsSeek(xFilial("SC5") + SD2->D2_PEDIDO )		

		If SC5->C5_CLIENTE <> SF2->F2_CLIENTE
           APMsgAlert("Cliente da NFS-e diferente do pedido!")			
           Return .F.
		Endif					

		cServ    := ""
		cDescNFE := AllTrim(SF2->F2_MENNOTA)      

		If ! Empty(SC5->C5_MENPAD)
           cDescNFE += AllTrim(FORMULA(SC5->C5_MENPAD))	
		Endif

		DbSelectArea("SD2")
        
        Do While ! SD2->(Eof()) .And. SD2->(D2_FILIAL + D2_DOC + D2_CLIENTE) == SF2->(F2_FILIAL + F2_DOC + F2_CLIENTE)

            dbSelectArea("SC6")
            dbSetOrder(1)				
		    MsSeek( xFilial("SC6") + SD2->(D2_PEDIDO + D2_ITEMPV + D2_COD), .t.) 
            
            If SC6->C6_NOTA == SD2->D2_DOC
            
               dbSelectArea("SB1")
               dbSetOrder(1)
               MsSeek(xFilial("SB1")+SC6->C6_PRODUTO)

               cServ += IIF(Empty(SC6->C6_DESCRI),SB1->B1_DESC,SC6->C6_DESCRI)
              
               If ! Empty(cTRIBMUN) .And. ! AllTrim(SB1->B1_TRIBMUN) $ cTRIBMUN
                  cTRIBMUN += "/" + AllTrim(SB1->B1_TRIBMUN)
               Else
                  cTRIBMUN := AllTrim(SB1->B1_TRIBMUN)                  
               Endif

               If ! Empty(cCNAEBH) .And. ! AllTrim(SB1->B1_CNAE) $ cCNAEBH
                  cCNAEBH += "/" + AllTrim(SB1->B1_CNAE)
               Else
                  cCNAEBH := AllTrim(SB1->B1_CNAE)                
               Endif

               If ! Empty(cCODISS) .And. ! AllTrim(SB1->B1_CODISS) $ cCODISS
                  cCODISS += "/" + AllTrim(SB1->B1_CODISS)
               Else
                  cCODISS := AllTrim(SB1->B1_CODISS)                
               Endif     
               
               If ! Empty(SC6->C6_PEDCLI) .And. ! Rtrim(SC6->C6_PEDCLI) $ cPedCli
                  cPedCli += IIf(Empty(cPedCli),"","/") + SC6->C6_PEDCLI 
               Endif
                  
			   nPercMO := IIf(nPercMO > 0,nPercMO,SB1->B1_REDINSS)

			   If SA1->A1_RECISS == "1"     //alterado aqui  
                  nIssAli := IIf(nIssAli==0,SD2->D2_ALIQISS,nIssAli)  
                  nIssRet := IIf(nIssRet==0,SF2->F2_VALISS,nIssRet)
               Endif
   
			Endif
			
            DbSelectArea("SD2")
            SD2->(DbSkip())

        Enddo

		If ! Empty(SC5->C5_MUNPRES)
			cTRIBMUN := SC5->C5_MUNPRES               
		EndIf		

            
            aDadosTSS := {} //FDADOSTSS()

            /*  
            aDadosTSS[1][1] // RPS
            aDadosTSS[1][2] // DATA EMISSAO
            aDadosTSS[1][3] // HORA EMISSAO
            aDadosTSS[1][4] // RECIBO
            aDadosTSS[1][5] // LOTE
            aDadosTSS[1][6] // COD VERIFICACAO
            */   

            If Empty(SF2->F2_NFELETR)
               cNumero := Left(SF2->F2_DOC,4) +"/"+ Alltrim(Str(Val(SubStr(SF2->F2_DOC,5,5))))
	        Else
               cNumero := Left(SF2->F2_NFELETR,4) +"/"+ Alltrim(Str(Val(SubStr(SF2->F2_NFELETR,5,12)))) 
	        Endif

            cCompet := SF2->F2_EMISSAO
            cData   := DtoC(SF2->F2_EMINFE)
            cHora   := SF2->F2_HORNFE
            cCodNFE := SF2->F2_CODNFE

			dbSelectArea("SF3")
			dbSetOrder(4)
			MsSeek(xFilial("SF3")+SF2->F2_CLIENTE+SF2->F2_LOJA+SF2->F2_DOC+SF2->F2_SERIE) 
			
			nValServ := SF3->F3_VALCONT		
	
			nIncond  := SF3->F3_VALOBSE		
			
			nValAli  := SF3->F3_ALIQICM		
	
			If SF3->(FieldPos("F3_ISSSUB"))>0
				nDedu+= SF3->F3_ISSSUB
			EndIf
	
			If SF3->(FieldPos("F3_ISSMAT"))>0
				nDedu+= SF3->F3_ISSMAT
			EndIf
	
			if (SF3->F3_ISSST == "1")
				cTrbServ := "Tributa��o Dentro do Municipio"
			elseif (SF3->F3_ISSST == "2")
				cTrbServ := "Tributa��o Fora do Municipio"
			elseif (SF3->F3_ISSST == "3")
				cTrbServ := "Tributa��o Isenta"                                                        
			elseif (SF3->F3_ISSST == "4")
				cTrbServ := "Imune"			
			elseif (SF3->F3_ISSST == "5")
				cTrbServ := "Exigibilidade Susp. Judicial"
			elseif (SF3->F3_ISSST == "6")			
				cTrbServ := "Exigibilidade Susp. Proc. Adm."
			endIf

			if ( SC5->C5_FORNISS == "06200 " .Or. Empty(SC5->C5_FORNISS)) .AND. ( SC5->C5_ESTPRES == "MG" .Or. Empty(SC5->C5_ESTPRES) )
				cTrbServ := "Tributa��o Dentro do Municipio"
			endif
	
			dbSelectArea("SE1")
			dbSetOrder(2)                   
			If MsSeek(xFilial("SE1")+SF3->F3_CLIEFOR+SF3->F3_LOJA+SF3->F3_SERIE+SF3->F3_NFISCAL)
               cDataVen := SE1->E1_VENCREA
			   SumAbatRec(SE1->E1_PREFIXO,SE1->E1_NUM,SE1->E1_PARCELA,SE1->E1_MOEDA,"V",SE1->E1_BAIXA,,@nIrRet,@nCsllRet,@nPisRet,@nCofRet,@nInssRet)
			EndIf    

			cTomCNPJ := AllTrim(SA1->A1_CGC)
			cTomINSC := AllTrim(SA1->A1_INSCRM)			
			cTomNome := AllTrim(SA1->A1_NOME)
			cTomEnde := AllTrim(RTRIM(SA1->A1_END)+", "+RTRIM(SA1->A1_BAIRRO)+" - Cep:"+RTRIM(SA1->A1_CEP))
			cTomBair := AllTrim(SA1->A1_BAIRRO)
			cTomCIDA := AllTrim(SA1->A1_MUN)
			cTomESTA := AllTrim(SA1->A1_EST)
			cTomFone := AllTrim(SA1->A1_TEL)
			cTomEmai := AllTrim(SA1->A1_EMAIL)
	
			dbSelectArea("CC2")
			dbSetOrder(1) //CC2_FILIAL+CC2_EST+CC2_CODMUN
			If ! Empty(SC5->C5_ESTPRES) .And. ! Empty(SC5->C5_FORNISS) .And. MsSeek(xFilial("CC2")+SC5->C5_ESTPRES+ALLTRIM(SC5->C5_FORNISS))
				cMunServ:= aUF[aScan(aUF,{|x| x[1] == CC2->CC2_EST})][02]+ALLTRIM(SC5->C5_FORNISS)
				cMunServ:=cMunServ+" / "+ ALLTRIM(CC2->CC2_MUN)		
			Else
				dbSelectArea("CC2")
				dbSetOrder(1)
				If MsSeek(xFilial("CC2")+IIF(Empty(SC5->C5_ESTPRES),SM0->M0_ESTENT,SC5->C5_ESTPRES)+ALLTRIM(IIf(Empty(SC5->C5_FORNISS),"06200 ",SC5->C5_FORNISS)))
				   cMunServ := aUF[aScan(aUF,{|x| x[1] == CC2->CC2_EST})][02]+ALLTRIM(IIf(Empty(SC5->C5_FORNISS),"06200 ",SC5->C5_FORNISS))
				   cMunServ := cMunServ+" / "+ ALLTRIM(CC2->CC2_MUN)		
				Endif	
			EndIf

			nValNota:=SF2->F2_ValMerc+SF2->F2_ValIPI+SF2->F2_Seguro+SF2->F2_Frete
	
		
			PRINTERPS()
			
			dbSelectArea("SF2")
			dbSkip()
			nQtd++

    	EndDo

		oPrint:Preview()		  
	Else

		ApMsgAlert(OemToAnsi("N�o existe nota fiscal com o n�mero informado!"),"Alerta!!!")
		Return()

	EndIf    
    		
return





//-------------------------------------------------------------------
/* {Protheus.doc} FDADOSTSS

aDadosTSS[1] // RPS
aDadosTSS[2] // DATA EMISSAO
aDadosTSS[3] // HORA EMISSAO
aDadosTSS[4] // RECIBO
aDadosTSS[5] // LOTE
aDadosTSS[6] // COD VERIFICACAO

@protected
@author    Rodrigo Carvalho
@since     03/02/2016
@obs        
Alteracoes Realizadas desde a Estruturacao Inicial
Data       Programador     Motivo
/*/
//-------------------------------------------------------------------
Static Function FDADOSTSS() 

Local aINFTSS   := {}
Local cQuerytss := ""
Local cTxtCod   := "CodigoVerificacao"    
Local cTxtChv   := "ChaveEletronica"     
Local cCodVer   := ""
Local cChvNfe   := ""

cQuerytss := "SELECT TOP 20 cast(cast(XML_RET as varbinary(max)) as varchar(max)) AS XML_RET," + CRLF
cQuerytss += "       RECIBO," + CRLF
cQuerytss += "       LOTE," + CRLF
cQuerytss += "       XMOT_SEF," + CRLF
cQuerytss += "       TIME_EMIS," + CRLF
cQuerytss += "       DATE_EMIS," + CRLF
cQuerytss += "       RPS_TSS,"   + CRLF
cQuerytss += "   S53.STATUS,"    + CRLF
cQuerytss += "   S51.NFSE_PROT"  + CRLF
cQuerytss += "  FROM SPED053 S53" + CRLF
cQuerytss += " INNER JOIN SPED051 S51 ON S51.D_E_L_E_T_ = ''" + CRLF
cQuerytss += "                       AND NFSE_LOTE  = LOTE" + CRLF
cQuerytss += "                       AND NFSE_ID    = '"+SF2->F2_SERIE + SF2->F2_DOC+"' " + CRLF
cQuerytss += "					     AND S53.ID_ENT = S51.ID_ENT" + CRLF
cQuerytss += "					     AND S53.CODMUN = S51.CODMUN" + CRLF
cQuerytss += " WHERE S53.D_E_L_E_T_ = '' ORDER BY S53.R_E_C_N_O_ DESC" + CRLF

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuerytss),"NFETSS",.T.,.T.)  

dbSelectArea("NFETSS")
dbGoTop()
Do While ! Eof()
   
   If NFETSS->STATUS == 3
      APMsgAlert("Aten��o, O RPS pode n�o ter sido autorizado!")			   
   Endif
   
   cXml    := OemToAnsi(Upper(NFETSS->XML_RET))
   cCodVer := ""
   cChvNfe := ""
   nPosI   := At(cXml,"<"+Upper(cTxtCod)+">")
   nPosF   := At(cXml,"</"+Upper(cTxtCod)+">")   
   
   If nPosI > 0 .And. nPosF > 0 .And. nPosF > nPosI
      cCodVer := SubStr(cXml,nPosI,nPosF)
      cCodVer := StrTran(cCodVer,cTxtCod,"")
      cCodVer := StrTran(cCodVer,"<","")
      cCodVer := StrTran(cCodVer,">","")
      cCodVer := StrTran(cCodVer,"/","")
      cCodVer := Alltrim(cCodVer)
   Endif

   nPosI   := At(cXml,"<"+Upper(cTxtChv)+">")
   nPosF   := At(cXml,"</"+Upper(cTxtChv)+">")   
   
   If nPosI > 0 .And. nPosF > 0 .And. nPosF > nPosI
      cChvNfe := SubStr(cXml,nPosI,nPosF)
      cChvNfe := StrTran(cChvNfe,cTxtChv,"")
      cChvNfe := StrTran(cChvNfe,"<","")
      cChvNfe := StrTran(cChvNfe,">","")
      cChvNfe := StrTran(cChvNfe,"/","")
      cChvNfe := Alltrim(cChvNfe)
   Endif

   aAdd(aINFTSS,{NFETSS->RPS_TSS,;
                 Stod(NFETSS->DATE_EMIS),;
                 NFETSS->TIME_EMIS,;
                 NFETSS->RECIBO,;
                 NFETSS->LOTE,;
                 cCodVer,;
                 cChvNfe,;
                 NFETSS->NFSE_PROT})

   NFETSS->(DbSkip())  
   
Enddo
dbSelectArea("NFETSS")
DbCloseArea()  

If Len(aINFTSS) > 0

      RecLock("SF2",.F.)               
      Replace SF2->F2_NFELETR With IIf(Empty(SF2->F2_NFELETR),aINFTSS[1][1],SF2->F2_NFELETR)
      Replace SF2->F2_EMINFE  With IIf(Empty(SF2->F2_EMINFE) ,aINFTSS[1][2],SF2->F2_EMINFE)
      Replace SF2->F2_HORNFE  With IIf(Empty(SF2->F2_HORNFE) ,aINFTSS[1][3],SF2->F2_HORNFE)
      Replace SF2->F2_CODNFE  With IIf(Empty(SF2->F2_CODNFE) ,aINFTSS[1][6],SF2->F2_CODNFE)
      Replace SF2->F2_CHVNFE  With IIf(Empty(SF2->F2_CHVNFE) ,aINFTSS[1][7],SF2->F2_CHVNFE)
      SF2->(MsUnLock())

   DbSelectArea("SF3")
   DbSetOrder(4) // F3_FILIAL+F3_CLIEFOR+F3_LOJA+F3_NFISCAL+F3_SERIE
   DbSeek( xFilial("SF3") + SF2->(F2_CLIENTE + F2_LOJA + F2_DOC + F2_SERIE ))
   
   Do While ! SF3->(Eof()) .And. SF2->(F2_FILIAL+F2_CLIENTE + F2_LOJA + F2_DOC + F2_SERIE) == SF3->(F3_FILIAL+F3_CLIEFOR+F3_LOJA+F3_NFISCAL+F3_SERIE)
      
      RecLock("SF3",.F.) 
      Replace SF3->F3_NFELETR With IIf(Empty(SF3->F3_NFELETR),aINFTSS[1][1],SF3->F3_NFELETR)
      Replace SF3->F3_EMINFE  With IIf(Empty(SF3->F3_EMINFE) ,aINFTSS[1][2],SF3->F3_EMINFE)
      Replace SF3->F3_CODNFE  With IIf(Empty(SF3->F3_CODNFE) ,aINFTSS[1][6],SF3->F3_CODNFE)
      Replace SF3->F3_CHVNFE  With IIf(Empty(SF3->F3_CHVNFE) ,aINFTSS[1][7],SF3->F3_CHVNFE)      
      SF3->(MsUnLock())
      
      DbSelectArea("SF3")
      SF3->(DbSkip())
   
   Enddo


   DbSelectArea("SFT")
   DbSetOrder(1) //  FT_FILIAL+FT_TIPOMOV+FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA+FT_ITEM+FT_PRODUTO
   DbSeek( xFilial("SFT") + "S" + SF2->(F2_SERIE + F2_DOC + F2_CLIENTE + F2_LOJA ) , .T. )

   Do While ! SFT->(Eof()) .And. ;
      SF2->(F2_FILIAL+"S"+F2_SERIE+F2_DOC+F2_CLIENTE+F2_LOJA ) == SFT->(FT_FILIAL+FT_TIPOMOV+FT_SERIE+FT_NFISCAL+FT_CLIEFOR+FT_LOJA)
      
      RecLock("SFT",.F.)               
      Replace SFT->FT_NFELETR With IIf(Empty(SFT->FT_NFELETR),aINFTSS[1][1],SFT->FT_NFELETR)
      Replace SFT->FT_EMINFE  With IIf(Empty(SFT->FT_EMINFE) ,aINFTSS[1][2],SFT->FT_EMINFE)
      Replace SFT->FT_CODNFE  With IIf(Empty(SFT->FT_CODNFE) ,aINFTSS[1][6],SFT->FT_CODNFE)
      Replace SFT->FT_CHVNFE  With IIf(Empty(SFT->FT_CHVNFE) ,aINFTSS[1][7],SFT->FT_CHVNFE)      
      SFT->(MsUnLock())
      
      DbSelectArea("SFT")
      SFT->(DbSkip())
   Enddo

Endif      

Return(aINFTSS)





//---------------------------------------------------------------------------
/*/{Protheus.doc} PRINTERPS

@protected
@author    Rodrigo Carvalho
@since     07/11/2019
@Obs       Relat�rio NFS-e, Nota Fiscal de Servi�os Eletronica

Alteracoes Realizadas desde a Estruturacao Inicial
Data       Programador     Motivo
/*/ 
//---------------------------------------------------------------------------
Static Function PRINTERPS()
	
oPrint:StartPage()

FHeadeRPS()

FDetalRPS()

Return




//---------------------------------------------------------------------------
/*/{Protheus.doc} FHeadeRPS

@protected
@author    Rodrigo Carvalho
@since     07/11/2019
@Obs       Relat�rio NFS-e, Nota Fiscal de Servi�os Eletronica
Diagrama margem da Impressao
X = dist�ncia da face da folha at� a margem de impress�o
Nome da figura a ser usada, diretorio \SYSTEM\
oPrn:Line(nTop,nLeft,nBottom,nRight)
Define as margens do documento

Alteracoes Realizadas desde a Estruturacao Inicial
Data       Programador     Motivo
/*/ 
//---------------------------------------------------------------------------
Static Function FHeadeRPS()

Private xRemoLogo := ""

xRemoLogo := IIf(Rtrim(SM0->M0_CODFIL) == "010101","lgrl01010101.bmp" ,xRemoLogo)
xRemoLogo := IIf(Rtrim(SM0->M0_CODFIL) == "020201","DANFE01020201.BMP",xRemoLogo)
		
oPrint:Box(nLin,nCol,nBottom,nWidth)

IncLinha(20)
oPrint:Say(nLin,nCol+0550,cRelNome,oFArial16n)
IncLinha(100)

oPrint:Say(nLin-10,nCol+0010,"N�: "+cNumero,oFArial20,CLR_BLACK,CLR_HRED)

oPrint:Line(nLin-15,nCol+0455,nLin+70,nCol+0455)//Separador vertical
oPrint:Line(nLin-15,nCol+0457,nLin+70,nCol+0457)//Separador vertical

oPrint:Say(nLin-15,nCol+0465,"Emitida em:",oFArial10,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin+15,nCol+0465,Alltrim(cData),oFArial16n,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin+30,nCol+0720,"     �s  "+cHora,oFArial10,CLR_BLACK,CLR_BLACK)

oPrint:Line(nLin-15,nCol+0995,nLin+70,nCol+0995)//Separador vertical
oPrint:Line(nLin-15,nCol+0997,nLin+70,nCol+0997)//Separador vertical

oPrint:Say(nLin-15,nCol+1005,"Compet�ncia:",oFArial10,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin+15,nCol+1005,DtoC(cCompet),oFArial16n,CLR_BLACK,CLR_BLACK)

oPrint:Line(nLin-15,nCol+1495,nLin+70,nCol+1495)//Separador vertical
oPrint:Line(nLin-15,nCol+1497,nLin+70,nCol+1497)//Separador vertical

oPrint:Say(nLin-15,nCol+1505,"C�digo de Verifica��o:",oFArial10,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin+10,nCol+1505,cCodNFE,oFArial16n,CLR_BLACK,CLR_BLACK)

oPrint:Line(nLin-15,nCol+1895,nLin+70,nCol+1895)//Separador vertical
oPrint:Line(nLin-15,nCol+1897,nLin+70,nCol+1897)//Separador vertical

oPrint:Say(nLin-15,nCol+1905,"Vencimento:",oFArial10,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin+10,nCol+1905,DtoC(cDataVen),oFArial16n,CLR_BLACK,CLR_BLACK)

//Linha divis�ria longa dupla
IncLinha(75)
oPrint:Line(nLin,nCol,nLin,nWidth)
oPrint:Line(nLin-3,nCol,nLin-3,nWidth)
//Imagem da Empresa
oPrint:SayBitmap(nLin+050,nCol+010,xRemoLogo,0430,0150)
IncLinha(20)
//Dados da Empresa
oPrint:Say(nLin,nCol+0460,cEmpNom,oFArial12n,CLR_BLACK,CLR_BLACK)
IncLinha(50)
oPrint:Say(nLin,nCol+0460,"CPF/CNPJ: "+cEmCNPJ,oFArial12n,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin,nCol+1350,"Inscri��o Municipal: "+cInscMu,oFArial12n,CLR_BLACK,CLR_BLACK)
IncLinha(50)
oPrint:Say(nLin,nCol+0460,cEmpEnd+", "+cEmpBai+" - Cep: "+cEmpCep,oFArial10,CLR_BLACK,CLR_BLACK)
IncLinha(50)
oPrint:Say(nLin,nCol+0460,cEmpCid,oFArial10,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin,nCol+1350,cEmpEst,oFArial10,CLR_BLACK,CLR_BLACK)
IncLinha(50)
oPrint:Say(nLin,nCol+0460,"Telefone:"+cEmpTel,oFArial10,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin,nCol+1350,"Email: fiscalnfe@dmbbombas.com.br"  ,oFArial10,CLR_BLACK,CLR_BLACK)
//Linha divis�ria longa dupla
IncLinha(70)
oPrint:Line(nLin,nCol,nLin,nWidth)
oPrint:Line(nLin-3,nCol,nLin-3,nWidth)
IncLinha(20)

Return




//---------------------------------------------------------------------------
/*/{Protheus.doc} FDetalRPS

@protected
@author    Rodrigo Carvalho
@since     07/11/2019
@Obs       Relat�rio NFS-e, Nota Fiscal de Servi�os Eletronica

Alteracoes Realizadas desde a Estruturacao Inicial
Data       Programador     Motivo
/*/ 
//---------------------------------------------------------------------------
Static Function FDetalRPS()

Local nXy

Local nSobe := 0
Local nNumLin := 0
Private nRetenc := 0
    	
oPrint:Say(nLin,nCol+0050,"Tomador do(s) Servi�o(s)",oFArial14n,CLR_BLACK,CLR_BLACK)
IncLinha(70)
//Linha divis�ria curta dupla
oPrint:Line(nLin,nCol+50,nLin,nWidth-50)
oPrint:Line(nLin-3,nCol+50,nLin-3,nWidth-50)
//
IncLinha(20)
oPrint:Say(nLin,nCol+0050,"CPF/CNPJ: "+cTomCNPJ,oFArial12n,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin,nCol+1020,"Inscri��o Municipal: "+cTomINSC,oFArial12n,CLR_BLACK,CLR_BLACK)
IncLinha(50)
oPrint:Say(nLin,nCol+0050,cTomNome,oFArial12n,CLR_BLACK,CLR_BLACK)
IncLinha(50)
oPrint:Say(nLin,nCol+0050,cTomEnde,oFArial10,CLR_BLACK,CLR_BLACK)
IncLinha(50)
oPrint:Say(nLin,nCol+0050,cTomCIDA,oFArial10,CLR_BLACK,CLR_BLACK)	
oPrint:Say(nLin,nCol+1020,cTomESTA,oFArial10,CLR_BLACK,CLR_BLACK)
IncLinha(50)
oPrint:Say(nLin,nCol+0050,"Telefone: "+cTomFone,oFArial10,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin,nCol+1020,"Email: "+cTomEmai,oFArial10,CLR_BLACK,CLR_BLACK)
IncLinha(50)
oPrint:Line(nLin,nCol,nLin,nWidth)
oPrint:Line(nLin-3,nCol,nLin-3,nWidth)	
IncLinha(40)
oPrint:Say(nLin,nCol+0050,"Discrimina��o do(s) Servi�o(s)",oFArial14n,CLR_BLACK,CLR_BLACK)
IncLinha(70)
//Linha Divis�ria curta dupla
oPrint:Line(nLin,nCol+50,nLin,nWidth-50)
oPrint:Line(nLin-3,nCol+50,nLin-3,nWidth-50)
IncLinha(30)
//
nNumLin := MLCOUNT(cServ,80)
For nXy := 1 To nNumLin
	If ! Empty(MEMOLINE(cServ,80,nXy))
		oPrint:Say(nLin,nCol+0050,MEMOLINE(cServ,80,nXy),oFArial10,CLR_BLACK,CLR_BLACK)
		IncLinha(40)
	EndIf
Next nXy
IncLinha(40)
oPrint:Say(nLin,nCol+0050,"N/Pedido: " + SC5->C5_NUM+" Pedido(s) Cliente: " +cPedCli,oFArial10,CLR_BLACK,CLR_BLACK)
IncLinha(40)
//Linha divis�ria longa dupla
oPrint:Line(nLin,nCol,nLin,nWidth)
oPrint:Line(nLin-3,nCol,nLin-3,nWidth)
	//
IncLinha(30)
oPrint:Say(nLin,nCol+0050,"CNAE/BH:",oFArial11n,CLR_BLACK,CLR_BLACK)
IncLinha(50)
oPrint:Say(nLin,nCol+0050,"Codigo de Atividade do Produto: "+cCNAEBH,oFArial10,CLR_BLACK,CLR_BLACK)
IncLinha(50)
//Linha Divis�ria curta simples
oPrint:Line(nLin,nCol+50,nLin,nWidth-50)
IncLinha(30)
// 
oPrint:Say(nLin-15,nCol+0050,"Subitem Lista de Servi�os LC 116/03: "+cCODISS,oFArial11n,CLR_BLACK,CLR_BLACK)
IncLinha(50)
//Implementar um FOR para imprimir este campo, incrementando o INCLINHA a cada LOOP.
oPrint:Say(nLin,nCol+0050,"Codigo de Tributa��o Municipal: "+IIf(Len(Alltrim(cTRIBMUN)) < 12,Transform(cTRIBMUN,"@R !!!!-!/!!-!!!!!!"),Alltrim(cTRIBMUN)),oFArial10,CLR_BLACK,CLR_BLACK)
IncLinha(50)
//Linha Divis�ria curta simples
oPrint:Line(nLin,nCol+50,nLin,nWidth-50)
IncLinha(30)	
//
oPrint:Say(nLin,nCol+0050,"Cod/Munic�pio da presta��o do(s) servi�o(s):",oFArial11n,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin,nCol+1020,"Natureza da Opera��o:",oFArial11n,CLR_BLACK,CLR_BLACK)
IncLinha(50)
oPrint:Say(nLin,nCol+0050,cMunServ,oFArial10,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin,nCol+1020,cTrbServ,oFArial10,CLR_BLACK,CLR_BLACK)
IncLinha(50)
//Linha Divis�ria curta simples
oPrint:Line(nLin,nCol+50,nLin,nWidth-50)
IncLinha(30)

oPrint:Say(nLin,nCol+0050,"Valor do(s) Servi�o(s)",oFArial12n,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin,nCol+0680,"R$ "+Transform(nValServ,"@E 999,999,999.99"),oFArial12n,CLR_BLACK,CLR_BLACK)
IncLinha(50)//-50.
nSobe += 50
//Linha Divis�ria curta tripla - Coluna01
oPrint:Line(nLin,nCol+50,nLin,nWidth/2-50)
oPrint:Line(nLin-3,nCol+50,nLin-3,nWidth/2-50)
oPrint:Line(nLin-6,nCol+50,nLin-6,nWidth/2-50)
IncLinha(20)//-20.
nSobe += 20

oPrint:Say(nLin,nCol+50,"(-) Descontos:",oFArial12,CLR_BLACK,CLR_BLACK)				
oPrint:Say(nLin,nCol+0695,"R$ "+Transform(nDedu,"@E 999,999,999.99"),oFArial12,CLR_BLACK,CLR_BLACK)
IncLinha(50)//-50.
nSobe += 50

oPrint:Line(nLin,nCol+50,nLin,nWidth/2-50)
oPrint:Line(nLin-3,nCol+50,nLin-3,nWidth/2-50)
IncLinha(30)//-30.
nSobe += 30

nRetenc := (nCsllRet+nPisRet+nCofRet+nInssRet)

oPrint:Say(nLin,nCol+50,"(-) Reten��es Federais:",oFArial12,CLR_BLACK,CLR_BLACK)				
oPrint:Say(nLin,nCol+0695,"R$ "+Transform(nRetenc,"@E 999,999,999.99"),oFArial12,CLR_BLACK,CLR_BLACK)
IncLinha(50)//-50.
nSobe += 50
//Linha Divis�ria curta dupla - Coluna01
oPrint:Line(nLin,nCol+50,nLin,nWidth/2-50)
oPrint:Line(nLin-3,nCol+50,nLin-3,nWidth/2-50)
IncLinha(30)//-30.
nSobe += 30

oPrint:Say(nLin,nCol+50,"(-) ISS Retido na Fonte:",oFArial12,CLR_BLACK,CLR_BLACK)				
oPrint:Say(nLin,nCol+0695,"R$ "+Transform(nIssRet,"@E 999,999,999.99"),oFArial12,CLR_BLACK,CLR_BLACK)
IncLinha(50)//-50.
nSobe += 50
//Linha Divis�ria curta dupla - Coluna01
oPrint:Line(nLin,nCol+50,nLin,nWidth/2-50)
oPrint:Line(nLin-3,nCol+50,nLin-3,nWidth/2-50)
IncLinha(20)//-20.
nSobe += 20
/////////////////////////////////
nValLiq := nValServ - (nIssRet+(nCsllRet+nPisRet+nCofRet+nInssRet)+nDedu)
////////////////////////////////
oPrint:Say(nLin,nCol+50,"Valor Liquido:",oFArial12n,CLR_BLACK,CLR_HRED)				
oPrint:Say(nLin,nCol+0685,"R$ "+Transform(nValLiq,"@E 999,999,999.99"),oFArial12n,CLR_BLACK,CLR_HRED)
IncLinha(50)//-50.
nSobe += 50		

oPrint:Say(nLin-nSobe,nCol+(nWidth/2+50),"Valor do(s) Servi�o(s)",oFArial12n,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin-nSobe,nCol+0630+(nWidth/2+50),"R$ "+Transform(nValServ,"@E 999,999,999.99"),oFArial12n,CLR_BLACK,CLR_BLACK)
//Linha Divis�ria curta tripla - Coluna02
nSobe-=50
oPrint:Line(nLin-(nSobe),nCol+(nWidth/2+50),nLin-(nSobe),nWidth-50)
oPrint:Line(nLin-(3+nSobe),nCol+(nWidth/2+50),nLin-(3+nSobe),nWidth-50)
oPrint:Line(nLin-(6+nSobe),nCol+(nWidth/2+50),nLin-(6+nSobe),nWidth-50)
//
nSobe-=20
oPrint:Say(nLin-(nSobe),nCol+(nWidth/2+50),"(-) Dedu��es:",oFArial11,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin-(nSobe),nCol+0665+(nWidth/2+50),"R$ "+Transform(nDedu,"@E 999,999,999.99"),oFArial11,CLR_BLACK,CLR_BLACK)
//Linha Divis�ria curta dupla - Coluna02
nSobe-=50
oPrint:Line(nLin-(nSobe),nCol+(nWidth/2+50),nLin-(nSobe),nWidth-50)
oPrint:Line(nLin-(3+nSobe),nCol+(nWidth/2+50),nLin-(3+nSobe),nWidth-50)
//
nSobe-=30
oPrint:Say(nLin-(nSobe),nCol+(nWidth/2+50),"(-) Desconto Incondicionado:",oFArial11,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin-(nSobe),nCol+0665+(nWidth/2+50),"R$ "+Transform(nIncond,"@E 999,999,999.99"),oFArial11,CLR_BLACK,CLR_BLACK)	
//Linha Divis�ria curta dupla - Coluna02
nSobe-=50
oPrint:Line(nLin-(nSobe),nCol+(nWidth/2+50),nLin-(nSobe),nWidth-50)
oPrint:Line(nLin-(3+nSobe),nCol+(nWidth/2+50),nLin-(3+nSobe),nWidth-50)
//
nSobe-=30
oPrint:Say(nLin-(nSobe),nCol+(nWidth/2+50),"(=) Base de C�lculo:",oFArial12n,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin-(nSobe),nCol+0630+(nWidth/2+50),"R$ "+Transform(nValServ,"@E 999,999,999.99"),oFArial12n,CLR_BLACK,CLR_BLACK)	
//Linha Divis�ria curta dupla - Coluna02

nSobe-=50
oPrint:Line(nLin-(nSobe),nCol+(nWidth/2+50),nLin-(nSobe),nWidth-50)
oPrint:Line(nLin-(3+nSobe),nCol+(nWidth/2+50),nLin-(3+nSobe),nWidth-50)

nSobe-=20
oPrint:Say(nLin-(nSobe),nCol+(nWidth/2+50),"(x) Al�quota:",oFArial11,CLR_BLACK,CLR_BLACK)
oPrint:Say(nLin-(nSobe),nCol+0745+(nWidth/2+50),Transform(nIssAli,"@E 999.99")+"%",oFArial11,CLR_BLACK,CLR_BLACK)	//nValAli 20012020
//Linha Divis�ria curta dupla - Coluna02

nSobe-=50
oPrint:Line(nLin-(nSobe),nCol+(nWidth/2+50),nLin-(nSobe),nWidth-50)
oPrint:Line(nLin-(3+nSobe),nCol+(nWidth/2+50),nLin-(3+nSobe),nWidth-50)
	//
IncLinha(30)
oPrint:Say(nLin,nCol+(nWidth/2+50),"(=)Valor do ISS:",oFArial12n,CLR_BLACK,CLR_HRED)				
oPrint:Say(nLin,nCol+0650+(nWidth/2+50),"R$ "+Transform(nIssRet,"@E 999,999,999.99"),oFArial12n,CLR_BLACK,CLR_HRED)
IncLinha(80)
//Linha divis�ria longa dupla
oPrint:Line(nLin,nCol,nLin,nWidth)
oPrint:Line(nLin-3,nCol,nLin-3,nWidth)

If nRetenc>0
		//
	IncLinha(25)
	oPrint:Say(nLin-20,nCol+0050,"Reten��es Federais:",oFArial12n,CLR_BLACK,CLR_BLACK)
	IncLinha(40)

	oPrint:Say(nLin,nCol+0050,"PIS:",oFArial11n,CLR_BLACK,CLR_BLACK)//050
	oPrint:Say(nLin,nCol+0160,"R$: "+Transform(nPisRet,"@E 999,999,999.99"),oFArial11,CLR_BLACK,CLR_BLACK)//125
	oPrint:Say(nLin,nCol+0500,"COFINS:",oFArial11n,CLR_BLACK,CLR_BLACK)//225
	oPrint:Say(nLin,nCol+0680,"R$: "+Transform(nCofRet,"@E 999,999,999.99"),oFArial11,CLR_BLACK,CLR_BLACK)
	oPrint:Say(nLin,nCol+0975,"CSLL:",oFArial11n,CLR_BLACK,CLR_BLACK)
	oPrint:Say(nLin,nCol+1125,"R$: "+Transform(nCsllRet,"@E 999,999,999.99"),oFArial11,CLR_BLACK,CLR_BLACK)
	oPrint:Say(nLin,nCol+1420,"INSS:",oFArial11n,CLR_BLACK,CLR_BLACK)
	oPrint:Say(nLin,nCol+1540,"R$: "+Transform(nInssRet,"@E 999,999,999.99"),oFArial11,CLR_BLACK,CLR_BLACK)
	IncLinha(50)
	//Linha divis�ria longa dupla
	oPrint:Line(nLin,nCol,nLin,nWidth)
	oPrint:Line(nLin-3,nCol,nLin-3,nWidth)
	//      
EndIf

IncLinha(40)

nNumLin := MLCOUNT(cDescNFE,90) // Informacoes complementares inseridas no SC5
	
if nNumLin > 0
  oPrint:Say(nLin,nCol+0050,"Outras Informa��es:",oFArial14n,CLR_BLACK,CLR_BLACK)
  IncLinha(70)
endif

For nXy := 1 To nNumLin
	If !Empty(MEMOLINE(cDescNFE,90,nXy))
		oPrint:Say(nLin,nCol+0050,MEMOLINE(cDescNFE,90,nXy),oFArial10,CLR_BLACK,CLR_BLACK)
		IncLinha(40)
	EndIf
Next nXy

If Rtrim(SM0->M0_CODFIL) == "020201"  .And. ! cMsgSimpl $ Upper(cDescNFE)
   oPrint:Say(nLin,nCol+0050,cMsgSimpl,oFArial10,CLR_BLACK,CLR_BLACK)
Endif
IncLinha(40)
		
if nNumLin > 0
  //Linha divis�ria longa dupla
  oPrint:Line(nLin,nCol,nLin,nWidth)
  oPrint:Line(nLin-3,nCol,nLin-3,nWidth)
endif

FTRAILLERPS()
		
Return






//---------------------------------------------------------------------------
/*/{Protheus.doc} FTRAILLERPS

@protected
@author    Rodrigo Carvalho
@since     07/11/2019
@Obs       Relat�rio NFS-e, Nota Fiscal de Servi�os Eletronica

Alteracoes Realizadas desde a Estruturacao Inicial
Data       Programador     Motivo
/*/ 
//---------------------------------------------------------------------------
Static Function FTRAILLERPS()

Private cPfBhNom := "Prefeitura de Belo Horizonte - Secretaria Municipal de Fazenda"
Private cPfBhEnd := "Rua Esp�rito Santo, 605 - 3� andar - Centro - CEP: 30160-919 - Belo Horizonte MG."
Private cPfBhTel := "Tel.: 31.3277-4000 Fax: 31.3224-3099"
Private	cPfBhEma := "E-mail: nfse@pbh.gov.br"

Private xPfBHLogo := "brasaoPfBHMG.bmp"
	  
//Linha divis�ria longa dupla
oPrint:Line(nBottom-200,nCol,nBottom-200,nWidth)
oPrint:Line(nBottom-203,nCol,nBottom-203,nWidth)
	//
//Imagem da Empresa
oPrint:SayBitmap(nBottom-180,nCol+010,xPfBHLogo,0180,0160)
	//
oPrint:Say(nBottom-180,nCol+200,cPfBhNom,oFArial11n,CLR_BLACK,CLR_BLACK)
oPrint:Say(nBottom-130,nCol+200,cPfBhEnd,oFArial10,CLR_BLACK,CLR_BLACK)
oPrint:Say(nBottom-090,nCol+200,cPfBhTel,oFArial10,CLR_BLACK,CLR_BLACK)
oPrint:Say(nBottom-050,nCol+200,cPfBhEma,oFArial10,CLR_BLACK,CLR_BLACK)	

Return





//---------------------------------------------------------------------------
/*/{Protheus.doc} MCFATRPS

@protected
@author    Rodrigo Carvalho
@since     07/11/2019
@Obs       Relat�rio NFS-e, Nota Fiscal de Servi�os Eletronica
@Obs       A funcao est�tica IncLinha faz verifica��o do posicionamento da linha
@Obs       em pixel, faz salto de linha e de pagina.

Alteracoes Realizadas desde a Estruturacao Inicial
Data       Programador     Motivo
/*/ 
//---------------------------------------------------------------------------
Static Function IncLinha(nPixelLinN)
If ((nLin + nPixelLinN) > nNumLin)
	nPagina++
	FTRAILLERPS()
	oPrint:EndPage()
	oPrint:StartPage()
	nLin := 100
	FHeadeRPS()
Else
	nLin+= nPixelLinN
EndIf
Return




//---------------------------------------------------------------------------
/*/{Protheus.doc} MCFATRPS

@protected
@author    Rodrigo Carvalho
@since     07/11/2019
@Obs       Relat�rio NFS-e, Nota Fiscal de Servi�os Eletronica

Alteracoes Realizadas desde a Estruturacao Inicial
Data       Programador     Motivo
/*/ 
//---------------------------------------------------------------------------
Static Function	FReadParam()

Private cPerg     := "MCCOMRPC01"
Private aRegs      := {}

AADD(aRegs,{"Nota Servi�o de: ","","",'MV_CH1','C',09,0,,'G','','MV_PAR01','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',{},{},{}})
AADD(aRegs,{"Nota Servi�o at�:","","",'MV_CH2','C',09,0,,'G','','MV_PAR02','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',{},{},{}})
AADD(aRegs,{"Nota Serie:      ","","",'MV_CH3','C',03,0,,'G','','MV_PAR03','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',{},{},{}})

FMX_AJSX1(cPerg,aRegs)

If ! Pergunte(cPerg,.T.)
   Return .F.
Endif   
	
Return .T.