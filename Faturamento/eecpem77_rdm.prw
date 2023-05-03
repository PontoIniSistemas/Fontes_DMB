#Include "EECPEM77.ch"
#Include "EECRDM.ch"

#Define ANTERIOR "A"
#Define PROXIMO  "P"

#XTranslate xLin1(<nVar>) => (<nVar> := <nVar> + 18)
#XTranslate xLin2(<nVar>) => (<nVar> := <nVar> - 3 )

/*
Programa        : EECPEM77.PRW
Objetivo        : Gerar o Memorando de Exportac�o modelo 2, conforme artigo 457 do RICMS,
                  conv�nios 113/96 e 107/01.
Autor           : Wilsimar Fabr�cio da Silva
Data            : 02/09/2009
Obs.            : 

*/

User Function EECPEM77()

Local lRet:= .F.
Local aOrd:= SaveOrd({"SA2", "EE9", "SYR", "EEM", "EXL"})
Local oDlg
Local bOk:= {||lRet:= .T., If(ValidAll(oDlg), oDlg:End(), lRet:= .F.)}
Local bCancel:= {||oDlg:End()}
Local nCont:= 1
Private cRpt:= "MEMEXP2.RPT",;
        cNumMemo:= Space(20),;
        aArq:= {}
//Exportador
Private cNomeExp:= "",;
        cEndExp := "",;
        cCnpjExp:= "",;
        cInscExp:= ""
//Dados da exporta��o
Private cNrDDE:= "",;
        dDataDDE,;
        cNrConh := "",;
        dDtConh,;
        cPaisDest:= ""
Private aNotasExp:= {},;
        aRe:= {}
//Discrimina��o dos produtos exportados
Private aProdutos:= {}
//Remetente com fim espec�fico de exporta��o
Private aFabricante:= {}
//Dados dos documentos fiscais de remessa
Private aNfRemessa:= {}
//Dados dos conhecimentos de transporte
Private aConhTransp:= {}
//Dados do Transportador
Private cNomeTransp:= Space(60),;
        cEndTransp:= Space(100),;
        cInsEstTransp:= Space(20),;
        cCNPJTrans:= Space(20)
//Representante legal do exportador/ respons�vel
Private dDtMemExp,;
        cAssExp  := "",;
        cCargoAss:= ""

//Vari�veis requeridas pela MsGetDb
Private aRotina, aCols:= {}, aHeader:= {}, lRefresh

Private oTmpTable1, oTmpTable2, oTmpTable3, oTmpTable4, oTmpTable5

aRotina:={{"Pesquisar" , "AxPesqui", 0, 1},;
          {"Visualizar", "AxVisual", 0, 2},;
          {"Incluir"   , "AxInclui", 0, 3},;
          {"Alterar"   , "AxAltera", 0, 4},;
          {"Excluir"   , "AxDeleta", 0, 5}}

SA2->(DBSetOrder(1))
EE9->(DBSetOrder(1))
SYR->(DBSetOrder(1))
EEM->(DBSetOrder(1))

Begin Sequence

   If Upper(FunName()) <> "EECAE100" .And. Upper(FunName()) <> "AA100DOC" 

      M->EEC_PREEMB:= Space(AvSx3("EEC_PREEMB", AV_TAMANHO))

      Define MsDialog oDlg Title STR0001 From 7,10 To 12,60 Of oMainWnd //"Memorando de Exporta��o"

         @ 20, 05 Say AvSx3("EEC_PREEMB", AV_TITULO) Pixel
         @ 20, 45 MsGet M->EEC_PREEMB F3 "EEC" Size 50, 08 Picture AvSx3("EEC_PREEMB", AV_PICTURE);
                  Valid ExistEmbarq() Pixel

      Activate MsDialog oDlg Centered On Init (EnchoiceBar(oDlg, bOk, bCancel))
   Else
      lRet:= .T.
   EndIf

   If !lRet
      Break
   EndIf
   
   If Select("Header_p") == 0
      AbreEEC()
   EndIf

   /*Carregar os dados da capa do processo.
     Estes dados ser�o usados em todos os memorandos de exporta��o, independente de qual
     seja o estado produtor/ fabricante da mercadoria.*/  

   LoadCapa()
   
   /* Carregar os dados referente aos itens do processo.
      Carrega os produtos do processo de exporta��o, agrupando por produtor/ fabricante.
      Levantamento das notas fiscais de venda e remessa (compra) */
      
   If !LoadDetalhe()
      Break
   EndIf

   //Cria��o das Works usadas nas MsGetDB
   CriaWorks(1)

   //Cria��o do aHeader, udado no MsGetDB
   LoadHeader()

   //Exibe a tela para que o usu�rio possa editar as informa��es antes de gerar a impress�o.
   TelaGets()

   //Fecha as works e apaga os arquivos criados.
   EncerraWorks()

      
End Sequence

RestOrd(aOrd)

oTmpTable1:Delete()
oTmpTable2:Delete()
oTmpTable3:Delete()
oTmpTable4:Delete()
oTmpTable5:Delete()

Return .F.


/*
Fun��o      : LoadCapa
Par�metros  : 
Retorno     : 
Objetivos   : Carregar os dados da capa do processo.
              Estes dados ser�o usados em todos os memorandos de exporta��o, independente de qual
              seja o estado produtor/ fabricante da mercadoria.
Autor       : Wilsimar Fabr�cio da Silva
Data/Hora   : 02/09/09
Revis�o     : 
Obs.        :
*/
Static Function LoadCapa()
Local aOrd:= SaveOrd({"EE9"})

Begin Sequence

   EE9->(DBSetOrder(3))

   EE9->(DBSeek(xFilial() + EEC->EEC_PREEMB))


   //Exportador
   If !Empty(EEC->EEC_EXPORT)
      SA2->(DBSeek(xFilial() + EEC->EEC_EXPORT + EEC->EEC_EXLOJA))
   Else
      SA2->(DBSeek(xFilial() + EEC->EEC_FORN + EEC->EEC_FOLOJA))
   EndIf

   cNomeExp:= Padr(SA2->A2_NOME, 60)
   cEndExp := Padr(AllTrim(SA2->A2_END) + ", " + AllTrim(SA2->A2_NR_END) +;
                   If (!Empty(SA2->A2_BAIRRO), " - " + AllTrim(SA2->A2_BAIRRO),"") +;
                   If (!Empty(SA2->A2_MUN)   , ", "  + AllTrim(SA2->A2_MUN), "") +;
                   If (!Empty(SA2->A2_EST)   , " - " + AllTrim(SA2->A2_EST), ""), 100)
   cCnpjExp:= Padr(SA2->A2_CGC, 20)
   cInscExp:= Padr(SA2->A2_INSCR, 20)


   //Dados da Exporta��o
   cNrDDE  := Padr(Transf(EE9->EE9_NRSD, X3Picture("EE9_NRSD")), 20)
   dDataDDE:= EE9->EE9_DTAVRB
   cNrConh := Padr(Transf(EEC->EEC_NRCONH, X3Picture("EEC_NRCONH")), 20)
   dDtConh := EEC->EEC_DTCONH

   SYR->(DBSeek(xFilial() + EEC->EEC_VIA + EEC->EEC_ORIGEM + EEC->EEC_DEST + EEC->EEC_TIPTRA))
   cPaisDest:= Padr(Posicione("SYA", 1, xFilial("SYA") + SYR->YR_PAIS_DE, "YA_DESCR"), 30)


   //Dados do transportador
   //N�o h� tratamento no padr�o para armazenar estes dados. Ser� digitado pelo usu�rio


   //Representante legal do exportador/ respons�vel
   dDtMemExp:= dDataBase
   cAssExp  := Padr(EECContato(CD_SA2, SA2->A2_COD, SA2->A2_LOJA, "1", 1), 30)
   cCargoAss:= Padr(EECContato(CD_SA2, SA2->A2_COD, SA2->A2_LOJA, "1", 2), 30)

End Sequence

RestOrd(aOrd)
Return

/*
Fun��o      : LoadDetalhe
Par�metros  : 
Retorno     : lRet: .T. quando o processo caracteriza uma exporta��o indireta (o fabricante e o exportador
              n�o s�o os mesmos). .F. quando descaracteriza uma exporta��o indireta, n�o havendo a
              necessidade de gera��o do memorando de exporta��o.
Objetivos   : Carregar os dados referente aos itens do processo.
              As informa��es s�o agrupadas por produtor/ fabricante.
Autor       : Wilsimar Fabr�cio da Silva
Data/Hora   : 02/09/09
Revis�o     : 
Obs.        : Os tratamentos customizados devem ser feitos considerando o dimensionamento dos arrays
              usados nesta fun��o.
*/
Static Function LoadDetalhe()
Local aOrd:= SaveOrd({"EE9", "SD1", "SD2", "SC6"})
Local cExportador:= "",;
      cFabricante:= "",;
      cNfRem     := Space(9),;
      cModNfRem  := Space(3),;
      cSerieNfRem:= Space(3),;
      cUnidade   := Space(2),;
      cNcm       := Space(10),;
      cDescricao := Space(AvSx3("B1_DESC", AV_TAMANHO))
Local dDataNfRem:= CtoD("")
Local nPos,;
      nPrecoUnit := 0,;
      nPrecoTot  := 0,;
      nQuantidade:= 0
Local lRet:= .F.
Local cPar1 := GetMv("MV_AVG0174",, .F.)
                  
EE9->(DBSetOrder(3)) //EE9_FILIAL + EE9_PREEMB + EE9_SEQEMB
SD1->(DBSetOrder(2)) //D1_FILIAL + D1_COD + D1_DOC + D1_SERIE + D1_FORNECE + D1_LOJA

//Verifica se existe a tabela usada pela rotina de notas fiscais de remessa.
If ChkFile("EYY") .And. Select("EYY") > 0
   aOrd:= SaveOrd({"EE9", "SD1", "EYY"})
   EYY->(DBSetOrder(1)) //EYY_FILIAL + EYY_PREEMB
EndIf

Begin Sequence   

   /*--------------
     Dados da Exporta��o
     ---------------------*/   
   //Notas fiscais
   EEM->(DBSeek(xFilial() + EEC->EEC_PREEMB + EEM_NF))
   While EEM->(!Eof()) .And.;
         EEM->EEM_FILIAL == EEM->(xFilial()) .And.;
         EEM->EEM_PREEMB == EEC->EEC_PREEMB .And.;
         EEM->EEM_TIPOCA == EEM_NF
         
      If EEM->EEM_TIPONF == EEM_SD  //Se nota fiscal de sa�da
                         //nota fiscal , modelo        , s�rie         , data
         AAdd(aNotasExp, {EEM->EEM_NRNF, EEM->EEM_MODNF, EEM->EEM_SERIE, EEM->EEM_DTNF})
      EndIf
      EEM->(DBSkip())
   EndDo

   
   /*Produtos, RE's e produtores/ fabricantes.
     O memorando de exporta��o � gerado por produtor/ fabricante, quando este n�o for o pr�prio exportador.
     Este ser� o crit�rio usado para o agrupamento.
     Os Arrays montados respeitam o mesmo padr�o de tamanho e organiza��o, para utiliza��o na grava��o
     da work detail.*/
     
   If Empty(EEC->EEC_EXPORT + EEC->EEC_EXLOJA)
      cExportador:= EEC->EEC_FORN + EEC->EEC_FOLOJA
   Else
      cExportador:= EEC->EEC_EXPORT + EEC->EEC_EXLOJA
   EndIf
   
   EE9->(DBSeek(xFilial() + EEC->EEC_PREEMB))

   While EE9->(!Eof()) .And.;
         EE9->EE9_FILIAL == EE9->(xFilial()) .And.;
         EE9->EE9_PREEMB == EEC->EEC_PREEMB

      If EE9->(EE9_FABR + EE9_FALOJA) == cExportador .Or. Empty(EE9->EE9_FABR + EE9->EE9_FALOJA)
         EE9->(DBSkip())
         Loop
      Else
         cFabricante:= EE9->EE9_FABR + EE9->EE9_FALOJA
      EndIf


      /*--------------
        Dados da Exporta��o
        ---------------------*/
      /*
        Registro de exporta��o
        os registros de exporta��o ser�o armazenados por produtor/ fabricante e apenas os n�meros que n�o
        se repetem. O tratamento usado garante que o array seja criado com a estrutura separada por fabricante
        mesmo que n�o haja RE no processo.
        AAdd(aRe[cFabricante], {N�m. RE, Data RE.}) */

      If (nPos:= AScan(aRe, {|x| x[1] == cFabricante})) == 0
         AAdd(aRe, {cFabricante})
         nPos:= Len(aRe)
      EndIf

      If !Empty(EE9->EE9_RE)
         //Verifica se n�o existe registros para este produtor/ fabricante e adiciona
         If Len(aRe[nPos]) == 1

            AAdd(aRe[nPos], {EE9->EE9_RE,;
                             EE9->EE9_DTRE})
         ElseIf (AScan(aRe[nPos][2], {|y| AllTrim(y) == AllTrim(EE9->EE9_RE)})) == 0

            AAdd(aRe[nPos], {EE9->EE9_RE,;
                             EE9->EE9_DTRE})
         EndIf
      EndIf


      /*Busca os dados da nota fiscal de remessa e valores de compra dos produtos.
        Caso o cliente n�o use a integra��o com o faturamento e a rotina de notas fiscais de remessa,
        estas informa��es poder�o ser digitadas antes da impress�o do relat�rio. */

      If IsIntFat() .And. cPar1

         //Redefine os valores iniciais
         nQuantidade:= 0
         nPrecoUnit := 0
         cNfRem     := Space(9)
         cSerieNfRem:= Space(3)
         dDataNfRem := CtoD("")
         cUnidade   := Space(2)
         cNcm       := Space(10)
         cDescricao := Space(AvSx3("B1_DESC", AV_TAMANHO))

         If EYY->(DBSeek(xFilial() + EE9->EE9_PREEMB))
            While EYY->(!Eof()) .And.;
                  EYY->(xFilial()) == EYY->EYY_FILIAL .And.;
                  EYY->EYY_PREEMB == EE9->EE9_PREEMB

               If AllTrim(EYY->EYY_RE) == AllTrim(EE9->EE9_RE)

                  //D1_FILIAL + D1_COD + D1_DOC + D1_SERIE + D1_FORNECE + D1_LOJA
                  If SD1->(DBSeek(xFilial() + AvKey(EE9->EE9_COD_I, "D1_COD") +;
                                  AvKey(EYY->EYY_NFENT, "D1_DOC") +;
                                  AvKey(EYY->EYY_SERENT, "D1_SERIE") +;
                                  cFabricante))

                     cNfRem     := SD1->D1_DOC
                     cSerieNfRem:= SD1->D1_SERIE
                     //nPrecoUnit := SD1->D1_VUNIT nopado por WFS em 20/01/2010
                     dDataNfRem := SD1->D1_EMISSAO
                     nQuantidade:= SD1->D1_QUANT
                     cUnidade   := SD1->D1_UM
                     cNcm       := Posicione("SB1", 1, xFilial("SB1") + SD1->D1_COD, "B1_POSIPI")
                     cDescricao := Posicione("SB1", 1, xFilial("SB1") + SD1->D1_COD, "B1_DESC")
                     Exit
                  EndIf
               EndIf

               EYY->(DBSkip())
            End      
         EndIf
      EndIf
      

      /*------------------
        Discrimina��o dos produtos exportados
        ---------------------------------------*/
      //Se n�o encontrar o fabricante, o inclui e retorna a nova posi��o (�ltima).
      If (nPos:= AScan(aProdutos, {|x| x[1] == cFabricante})) == 0
         AAdd(aProdutos, {cFabricante})
         nPos:= Len(aProdutos)
      EndIf

      /* WFS 20/01/2010
         Altera��es conforme o conv�nio 84 do ICMS.
         Os dados da se��o "Discrimina��o dos produtos exportados" ser�o conforme
         a nota fiscal de sa�da (pedido de venda).
      
      
      //AAdd(aProdutos[cFabricante], {Quant., Unid., NCM, Descri��o, Vl. Unit., Vl. Total, C�digo do produto, RE, Data RE})
      AAdd(aProdutos[nPos], {EE9->EE9_SLDINI,;
                             EE9->EE9_UNIDAD,;
                             EE9->EE9_POSIPI,;
                             AllTrim(MSMM(EE9->EE9_DESC, AvSx3("EE9_VM_DES", AV_TAMANHO))),;
                             nPrecoUnit,;
                             nPrecoTot:= EE9->EE9_SLDINI * nPrecoUnit,;
                             EE9->EE9_COD_I,;
                             EE9->EE9_RE,;
                             EE9->EE9_DTRE;
                             }) */


      If IsIntFat() .And. !Empty(EE9->EE9_NF)
      
         //Posicionamento das tabelas de itens, nota fiscal e pedido de venda
         SD2->(DBSetOrder(3)) //D2_FILIAL + D2_DOC + D2_SERIE + D2_CLIENTE + D2_LOJA + D2_COD + D2_ITEM
         SD2->(DBSeek(xFilial() + AvKey(EE9->EE9_NF, "D2_DOC") + AvKey(EE9->EE9_SERIE, "D2_SERIE") +;
                                  AvKey(EEC->EEC_IMPORT, "D2_CLIENTE") + AvKey(EEC->EEC_IMLOJA, "D2_LOJA") +;
                                  AvKey(EE9->EE9_COD_I, "D2_COD")))
      
         SC6->(DBSetOrder(1)) //C6_FILIAL + C6_NUM + C6_ITEM + C6_PRODUTO
         SC6->(DBSeek(xFilial() + SD2->D2_PEDIDO + SD2->D2_ITEMPV + AvKey(EE9->EE9_COD_I, "C6_PRODUTO")))

         //AAdd(aProdutos[cFabricante], {Quant., Unid., NCM, Descri��o, Vl. Unit., Vl. Total, C�digo do produto, RE, Data RE})
         AAdd(aProdutos[nPos], {SD2->D2_QUANT,;
                                SD2->D2_UM,;
                                EE9->EE9_POSIPI,;
                                AllTrim(SC6->C6_DESCRI),;
                                SD2->D2_PRCVEN,;
                                SD2->D2_TOTAL,;
                                EE9->EE9_COD_I,;
                                EE9->EE9_RE,;
                                EE9->EE9_DTRE;
                                })      
      Else
         //AAdd(aProdutos[cFabricante], {Quant., Unid., NCM, Descri��o, Vl. Unit., Vl. Total, C�digo do produto, RE, Data RE})
         AAdd(aProdutos[nPos], {EE9->EE9_SLDINI,;
                                EE9->EE9_UNIDAD,;
                                EE9->EE9_POSIPI,;
                                AllTrim(MSMM(EE9->EE9_DESC, AvSx3("EE9_VM_DES", AV_TAMANHO))),;
                                EE9->EE9_PRECO * BuscaTaxa(EEC->EEC_MOEDA, EEC->EEC_DTEMBA),;
                                EE9->EE9_SLDINI * EE9->EE9_PRECO * BuscaTaxa(EEC->EEC_MOEDA, EEC->EEC_DTEMBA),;
                                EE9->EE9_COD_I,;
                                EE9->EE9_RE,;
                                EE9->EE9_DTRE;
                                })
      EndIf

      /*-----------------
        Remetente com fim espec�fico de exporta��o
        ----------------------------------------------*/
      SA2->(DBSeek(xFilial() + cFabricante))
      If AScan(aFabricante, {|x| x[1] == cFabricante}) == 0

         AAdd(aFabricante, {cFabricante,; //1. fabricante
                            Padr(SA2->A2_NOME, 60),; //2. raz�o social
                            Padr(AllTrim(SA2->A2_END) + ", " + AllTrim(SA2->A2_NR_END) +;
                                 If (!Empty(SA2->A2_BAIRRO), " - " + AllTrim(SA2->A2_BAIRRO), "") +;
                                 If (!Empty(SA2->A2_MUN)   , ", "  + AllTrim(SA2->A2_MUN), "") +;
                                 If (!Empty(SA2->A2_EST)   , " - " + AllTrim(SA2->A2_EST), ""), 100),; //3. endere�o
                            SA2->A2_EST,; //4. estado produtor
                            SA2->A2_INSCR,; //5. inscri��o estatual
                            SA2->A2_CGC}) //6. CNPJ

      EndIf
      
      
      /*---------------------
        Dados dos documentos fiscais de remessa
        -------------------------------------------*/
      //Se n�o encontrar o fabricante, o inclui e retorna a nova posi��o (�ltima).
      If (nPos:= AScan(aNfRemessa, {|x| x[1] == cFabricante})) == 0
         AAdd(aNfRemessa, {cFabricante})
         nPos:= Len(aNfRemessa)
      EndIf
      
      If !Empty(cNfRem)
         //aNfRemessa[cFabricante], {Nota fiscal de remessa, Modelo, S�rie, Emiss�o, Quantidade, Unidade, NCM, Descri��o}
         //N�o ser�o armazenadas notas fiscais repetidas
         If Len(aNfRemessa[nPos]) == 1

            AAdd(aNfRemessa[nPos], {cNfRem,;
                                    cModNfRem,;
                                    cSerieNfRem,;
                                    dDataNfRem,;
                                    nQuantidade,;
                                    cUnidade,;
                                    cNcm,;
                                    cDescricao;
                                    })
         ElseIf (AScan(aNfRemessa[nPos][2], {|y| AllTrim(y) == AllTrim(cNfRem)})) == 0

            AAdd(aNfRemessa[nPos], {cNfRem,;
                                    cModNfRem,;
                                    cSerieNfRem,;
                                    dDataNfRem,;
                                    nQuantidade,;
                                    cUnidade,;
                                    cNcm,;
                                    cDescricao;
                                    })
         EndIf

      EndIf



      /*-----------------------
        Dados dos conhecimentos de transporte
        ----------------------------------------*/
      /*
        N�o h� tratamento no padr�o para armazenar estes dados. Ser�o digitados pelo usu�rio.
        AAdd(aConhTransp[cFabricante], {N�m. Conhec., Mod., S�rie, Data de emiss�o}) */

      If (nPos:= AScan(aConhTransp, {|x| x[1] == cFabricante})) == 0
         AAdd(aConhTransp, {cFabricante})
      EndIf


      EE9->(DBSkip())
   EndDo

   //Verifica se existem produtores/ fabricantes para o processo.
   If Len(aFabricante) > 0
      lRet:= .T.
   Else
      MsgInfo(STR0052 + ENTER + STR0053, STR0045) //Este processo n�o caracteriza uma exporta��o indireta./ N�o existem memorandos de exporta��o para serem impressos./ Aviso
   EndIf
   
   
End Sequence
RestOrd(aOrd)
Return lRet

/*
Fun��o      : TelaGets
Par�metros  : 
Retorno     : 
Objetivos   : Gera a tela com as informa��es do memorando de exporta��o, agrupadas por produtor/ fabricante.
              Permite que o usu�rio saiba quais informa��es ser�o impressas, editar as informa��es carregadas
              e incluir demais informa��es n�o tratadas pelo Easy.
Autor       : Wilsimar Fabr�cio da Silva
Data/Hora   : 04/09/2009
Revis�o     : 
Obs.        :
*/
Static Function TelaGets()

Local bOk     := {||AtualizaDados(nFabr), If(GeraTodos(), oDlg:End(),)},;
      bCancel := {||oDlg:End()},;
      bTitulo := {||oDlg:cTitle:= STR0001 + " " + AllTrim(Str(nFabr)) + " de " + AllTrim(Str(Len(aFabricante))) + " - " + AllTrim(aFabricante[nFabr][2])},;
      bRefresh:= {||oGetDb_b:oBrowse:Refresh(), oGetDb_b2:oBrowse:Refresh(), oGetDb_c:oBrowse:Refresh(), oGetDb_e:oBrowse:Refresh(), oGetDb_f:oBrowse:Refresh(), oFld:Refresh(), oDlg:Refresh()}
Local oFld,;
      oGetDb_b,;
      oGetDb_b2,;
      oGetDb_c,;
      oGetDb_e,;
      oGetDb_f,;
      oFld_b,;
      oFld_c,;
      oFld_e
Local aFld,;
      aPos,;
      aAltFld_b ,;
      aAltFld_b2,;
      aAltFld_c ,;
      aAltFld_e ,;
      aAltFld_f ,;
      aButtons:= {{"PREV",  {||AtualizaDados(nFabr), Navegacao(@nFabr, ANTERIOR), Eval(bTitulo), Eval(bRefresh)}, STR0037, STR0041},; //Fabricante Anterior / Anterior
                  {"NEXT",  {||AtualizaDados(nFabr), Navegacao(@nFabr, PROXIMO),  Eval(bTitulo), Eval(bRefresh)}, STR0038, STR0042},; //Pr�ximo Fabricante  / Pr�ximo
                  {"PEDIDO",{||AtualizaDados(nFabr), GeraRelatorio(nFabr), Eval(bRefresh) }, STR0043, STR0044}} //Gera o memorando para o fabricante / Gerar
Local cNota:= "",;
      cMod:= "",;
      cSerie:= "",;
      cDataNf:= "",;
      cProdRe:= "",;
      cRe:= "",;
      cDataRe:= "",;
      cTitulo:= ""
Local nLin,;
      nCol,;
      nCont,;
      nFld_a,;
      nFld_b,;
      nFld_d,;
      nFld_e,;
      nFld_f,;
      nFld_g,;
      nFld_h,;
      nFabr:= 1 //primeiro produtor/ fabricante

Begin Sequence


   cTitulo:= " " + AllTrim(Str(nFabr)) + " de " + AllTrim(Str(Len(aFabricante))) + " - " + AllTrim(aFabricante[nFabr][2])
   
   Define MsDialog oDlg Title STR0001 + cTitulo From 7, 0 To 35, 100 Of oMainWnd //Memorando de Exporta��o x de n - Raz�o Social do Produtor/ Fabricante
   
      oFld:= TFolder():New(15, 3, {STR0002,; //Exportador
                                   STR0003,; //Dados da exporta��o
                                   STR0004,; //Discrimina��o dos produtos exportados
                                   STR0005,; //Remetente com fim espec�fico de exporta��o
                                   STR0006,; //Dados dos documentos fiscais de remessa
                                   STR0007,; //Dados dos conhecimentos de transporte
                                   STR0008,; //Dados do transportador
                                   STR0009},;//Representante legal do exportador
                           {"F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8"}, oDlg,,,, .T., .F., 390, 193)

      aFld:= oFld:aDialogs
      aPos:= PosDlg(oFld)


      /*--------
        Exportador
        -------------*/
      
      nFld_a:= 1
      nLin:= 10
      nCol:= 5
      
      TSay():New(nLin       , nCol     , {|| STR0025}, aFld[nFld_a],,,,,, .T.) //Memorando de exporta��o n�
      TGet():New(xLin2(nLin), nCol + 80, BSetGet(cNumMemo), aFld[nFld_a], 50, 08, "@!",,,,,,, .T.)

      xLin1(nLin)
      TSay():New(xLin1(nLin), nCol     , {|| STR0010}, aFld[nFld_a],,,,,, .T.) //Raz�o Social
      TGet():New(xLin2(nLin), nCol + 35, BSetGet(cNomeExp), aFld[nFld_a], 210, 08, "@!",,,,,,, .T.)
            
      TSay():New(xLin1(nLin), nCol     , {|| STR0011}, aFld[nFld_a],,,,,, .T.) //Endere�o
      TGet():New(xLin2(nLin), nCol + 35, BSetGet(cEndExp), aFld[nFld_a], 230, 08, "@!",,,,,,, .T.)      
              
      TSay():New(xLin1(nLin), nCol     , {|| STR0012}, aFld[nFld_a],,,,,, .T.) //Insc. Estadual
      TGet():New(xLin2(nLin), nCol + 35, BSetGet(cInscExp), aFld[nFld_a], 150, 08, X3Picture("A2_INSCR"),,,,,,, .T.)
      
      TSay():New(xLin1(nLin), nCol     , {|| STR0013}, aFld[nFld_a],,,,,, .T.) //CNPJ
      TGet():New(xLin2(nLin), nCol + 35, BSetGet(cCnpjExp), aFld[nFld_a], 150, 08, X3Picture("A2_CGC"),,,,,,, .T.)



      /*--------------------
        Dados da exporta��o
        ----------------------------*/

      nFld_b:= 2
      nLin:= 10
            
      TSay():New(nLin       , nCol     , {|| STR0014}, aFld[nFld_b],,,,,, .T.) //Declara��o de exporta��o n�
      TGet():New(xLin2(nLin), nCol + 75, BSetGet(cNrDDE), aFld[nFld_b], 80, 08, X3Picture("EE9_NRSD"),,,,,,, .T.)
      
      nLin += 3
      nCol += 165
      
      TSay():New(nLin       , nCol     , {|| STR0015}, aFld[nFld_b],,,,,, .T.) //Data
      TGet():New(xLin2(nLin), nCol + 20, BSetGet(dDataDDE), aFld[nFld_b], 25, 08, X3Picture("EE9_DTAVRB"),,,,,,, .T.)

      nCol:= 5
      
      TSay():New(xLin1(nLin), nCol     , {|| STR0016}, aFld[nFld_b],,,,,, .T.) //Conhecimento de embarque n�
      TGet():New(xLin2(nLin), nCol + 75, BSetGet(cNrConh), aFld[nFld_b], 80, 08, X3Picture("EEC_NRCONH"),,,,,,, .T.)

      nLin += 3
      nCol += 165
            
      TSay():New(nLin       , nCol     , {|| STR0015}, aFld[nFld_b],,,,,, .T.) //Data
      TGet():New(xLin2(nLin), nCol + 20, BSetGet(dDtConh), aFld[nFld_b], 25, 08, X3Picture("EEC_DTCONH"),,,,,,, .T.)
      
      nCol:= 5
      
      TSay():New(xLin1(nLin), nCol     , {|| STR0017}, aFld[nFld_b],,,,,, .T.) //Estado produtor/ fabricante
      TGet():New(xLin2(nLin), nCol + 75, BSetGet(aFabricante[nFabr][4]), aFld[nFld_b], 10, 08,"!@",,,,,,, .T.)

      nLin += 3
      nCol += 105
      
      TSay():New(nLin       , nCol     , {|| STR0018}, aFld[nFld_b],,,,,, .T.) //Pa�s de destino da mercadoria
      TGet():New(xLin2(nLin), nCol + 80, BSetGet(cPaisDest), aFld[nFld_b], 80, 08,"@!",,,,,,, .T.)


      oFld_b:= aFld[2]

      //Campos que podem ser alterados
      //Registro de exporta��o
      aAltFld_b:= {"WK_RE", "WK_DTRE"}
      
      xLin1(nLin)
      oGetDb_b:= MsGetDb():New(nlin, aPos[2] , aPos[3]-75, aPos[4],;  // Posi��es da Tela
                                                                 4,;  // Tipo de acordo com o aRotina(Inclus�o, Altera��o, etc.)
                                                                  ,;  // cLinhaOk
                                                                  ,;  // cTudoOk
                                                                  ,;  // cIncrementa
                                                               .F.,;  // Habilita a op��o de deletar linhas do aCols. Valor padr�o falso
                                                         aAltFld_b,;  // Campos que podem ser alterados
                                                                  ,;  // Indica qual coluna n�o ficara congelada na exibi��o
                                                                  ,;  // lVazio: Habilita valida��o da primeira coluna do aCols para esta n�o poder estar vazia. Valor padr�o falso.
                                                                  ,;  // Reservado
                                                           "Work1",;  // Work que ser� mostrada no Browse
                                                                  ,;  // Fun��o executada na valida��o do campo
                                                                  ,;  // Reservado
                                                               .F.,;  // Define se as linhas poder�o ser inclu�das
                                                            oFld_b,;  // Objeto no qual est� inserida a MsGetDb
                                                               .F.,;  // Define se vai utilizar caracter�sticas do dicion�rio (gatilhos, consultas...)
                                                                  ,;  // Reservado
                                                                  ,;  // Fun��o que valida exclus�o
                                                                  ,)  // Fun��o executada quando pressionada as teclas <Ctrl>+<Delete>

      oGetDb_b:oBrowse:Badd:= {|| .F.}
      oGetDb_b:oBrowse:Refresh()
      
      //Campos que podem ser alterados.
      //Nenhum. As notas fiscais ser�o apenas visualizadas.
      aAltFld_b2:= {}
      oGetDb_b2:= MsGetDb():New(aPos[3]-75, aPos[2], aPos[3]-11, aPos[4],; // Posi��es da Tela
                                                                       4,; // Tipo de acordo com o aRotina(Inclus�o, Altera��o, etc.)
                                                                        ,; // cLinhaOk
                                                                        ,; // cTudoOk
                                                                        ,; // cIncrementa
                                                                     .F.,; // Habilita a op��o de deletar linhas do aCols. Valor padr�o falso
                                                              aAltFld_b2,; // Campos que podem ser alterados
                                                                        ,; // Indica qual coluna n�o ficara congelada na exibi��o
                                                                        ,; // lVazio: Habilita valida��o da primeira coluna do aCols para esta n�o poder estar vazia. Valor padr�o falso.
                                                                        ,; // Reservado
                                                                 "Work4",; // Work que ser� mostrada no Browse
                                                                        ,; // Fun��o executada na valida��o do campo
                                                                        ,; // Reservado
                                                                     .F.,; // Define se as linhas poder�o ser inclu�das
                                                                  oFld_b,; // Objeto no qual est� inserida a MsGetDb
                                                                     .F.,; // Define se vai utilizar caracter�sticas do dicion�rio (gatilhos, consultas...)
                                                                        ,; // Reservado
                                                                        ,; // Fun��o que valida exclus�o
                                                                        ,) // Fun��o executada quando pressionada as teclas <Ctrl>+<Delete>

      oGetDb_b2:oBrowse:Badd:= {|| .F.}      
      oGetDb_b2:oBrowse:Refresh()

      /*--------------------  
        Discrimina��o dos produtos exportados
        ----------------------------------------*/

      oFld_c:= aFld[3]        

      //Campos que podem ser alterados
      aAltFld_c:= {"WK_DESC", "WK_QTD", "WK_UNID", "WK_VLUNIT"}
      
      oGetDb_c:= MsGetDb():New(aPos[1], aPos[2] ,aPos[3]-11, aPos[4],; // Posi��es da Tela
                                                                   4,; // Tipo de acordo com o aRotina(Inclus�o, Altera��o, etc.)
                                                                    ,; // cLinhaOk
                                                                    ,; // cTudoOk
                                                                    ,; // cIncrementa
                                                                 .F.,; // Habilita a op��o de deletar linhas do aCols. Valor padr�o falso
                                                           aAltFld_c,; // Campos que podem ser alterados
                                                                    ,; // Indica qual coluna n�o ficara congelada na exibi��o
                                                                    ,; // lVazio: Habilita valida��o da primeira coluna do aCols para esta n�o poder estar vazia. Valor padr�o falso.
                                                                    ,; // Reservado
                                                             "Work2",; // Work que ser� mostrada no Browse
                                             "U_PEM77CAMPO('Work2')",; // Fun��o executada na valida��o do campo
                                                                    ,; // Reservado
                                                                 .F.,; // Define se as linhas poder�o ser inclu�das
                                                              oFld_c,; // Objeto no qual est� inserida a MsGetDb
                                                                 .F.,; // Define se vai utilizar caracter�sticas do dicion�rio (gatilhos, consultas...)
                                                                    ,; // Reservado
                                                                    ,; // Fun��o que valida exclus�o
                                                                    ,) // Fun��o executada quando pressionada as teclas <Ctrl>+<Delete>


      oGetDb_c:oBrowse:Badd:= {|| .F.}
      oGetDb_c:oBrowse:Refresh()

      /*--------------------  
        Remetente com fim espec�fico de exporta��o
        ----------------------------------------------*/
      /* Array aFabricante
         1. fabricante
         2. raz�o social
         3. endere�o
         4. estado produtor
         5. inscri��o estatual
         6. CNPJ
      */
      nFld_d:= 4
      nLin:= 10
      nCol:= 5
      
      TSay():New(nLin       , nCol     , {|| STR0010}, aFld[nFld_d],,,,,, .T.) //Raz�o Social
      TGet():New(xLin2(nLin), nCol + 35, BSetGet(aFabricante[nFabr][2]), aFld[nFld_d], 210, 08, "@!",,,,,,, .T.)
      
      TSay():New(xLin1(nLin), nCol     , {|| STR0011}, aFld[nFld_d],,,,,, .T.) //Endere�o
      TGet():New(xLin2(nLin), nCol + 35, BSetGet(aFabricante[nFabr][3]), aFld[nFld_d], 230, 08, "@!",,,,,,, .T.)      

      TSay():New(xLin1(nLin), nCol     , {|| STR0012}, aFld[nFld_d],,,,,, .T.) //Insc. Estadual
      TGet():New(xLin2(nLin), nCol + 35, BSetGet(aFabricante[nFabr][5]), aFld[nFld_d], 150, 08, X3Picture("A2_INSCR"),,,,,,, .T.)

      TSay():New(xLin1(nLin), nCol     , {|| STR0013}, aFld[nFld_d],,,,,, .T.) //CNPJ
      TGet():New(xLin2(nLin), nCol + 35, BSetGet(aFabricante[nFabr][6]), aFld[nFld_d], 150, 08, X3Picture("A2_CGC"),,,,,,, .T.)
      
      

      /*--------------------  
        Dados dos documentos fiscais de remessa
        ------------------------------------------*/
      
      oFld_e:= aFld[5]

      //Campos que podem ser alterados
      aAltFld_e:= {"WK_NFREM", "WK_MODNFRE", "WK_SERNFRE", "WK_DTNFREM", "WK_QTDNFRE", "WK_UNINFRE", "WK_DESCNFR", "WK_NCMNFRE"}

      oGetDb_e:= MsGetDb():New(aPos[1], aPos[2] ,aPos[3]-11, aPos[4],; // Posi��es da Tela
                                                                   4,; // Tipo de acordo com o aRotina(Inclus�o, Altera��o, etc.)
                                                     "AllwaysTrue()",; // cLinhaOk
                                                                    ,; // cTudoOk
                                                                    ,; // cIncrementa
                                                                 .T.,; // Habilita a op��o de deletar linhas do aCols. Valor padr�o falso
                                                           aAltFld_e,; // Campos que podem ser alterados
                                                                    ,; // Indica qual coluna n�o ficara congelada na exibi��o
                                                                    ,; // lVazio: Habilita valida��o da primeira coluna do aCols para esta n�o poder estar vazia. Valor padr�o falso.
                                                                    ,; // Reservado
                                                             "Work3",; // Work que ser� mostrada no Browse
                                                                    ,; // Fun��o executada na valida��o do campo
                                                                    ,; // Reservado
                                                                 .T.,; // Define se as linhas poder�o ser inclu�das
                                                              oFld_e,; // Objeto no qual est� inserida a MsGetDb
                                                                 .F.,; // Define se vai utilizar caracter�sticas do dicion�rio (gatilhos, consultas...)
                                                                    ,; // Reservado
                                                     "AllwaysTrue()",; // Fun��o que valida exclus�o
                                                                    ,) // Fun��o executada quando pressionada as teclas <Ctrl>+<Delete>
      oGetDb_e:oBrowse:Refresh()


      /*--------------------  
        Dados dos conhecimentos de transporte
        ------------------------------------------*/
      nFld_f:= 6
      
      oFld_f:= aFld[nFld_f]

      //Campos que podem ser alterados
      aAltFld_f:= {"WK_NUMCONH", "WK_MODCONH", "WK_SERCONH", "WK_DTCONH"}
      oGetDb_f:= MsGetDb():New(aPos[1], aPos[2] ,aPos[3]-11, aPos[4],; // Posi��es da Tela
                                                                   4,; // Tipo de acordo com o aRotina(Inclus�o, Altera��o, etc.)
                                                     "AllwaysTrue()",; // cLinhaOk
                                                                    ,; // cTudoOk
                                                                    ,; // cIncrementa
                                                                 .T.,; // Habilita a op��o de deletar linhas do aCols. Valor padr�o falso
                                                           aAltFld_f,; // Campos que podem ser alterados
                                                                    ,; // Indica qual coluna n�o ficara congelada na exibi��o
                                                                    ,; // lVazio: Habilita valida��o da primeira coluna do aCols para esta n�o poder estar vazia. Valor padr�o falso.
                                                                    ,; // Reservado
                                                             "Work5",; // Work que ser� mostrada no Browse
                                                                    ,; // Fun��o executada na valida��o do campo
                                                                    ,; // Reservado
                                                                 .T.,; // Define se as linhas poder�o ser inclu�das
                                                              oFld_f,; // Objeto no qual est� inserida a MsGetDb
                                                                 .F.,; // Define se vai utilizar caracter�sticas do dicion�rio (gatilhos, consultas...)
                                                                    ,; // Reservado
                                                     "AllwaysTrue()",; // Fun��o que valida exclus�o
                                                                    ,) // Fun��o executada quando pressionada as teclas <Ctrl>+<Delete>

      oGetDb_f:oBrowse:Refresh()
      
      
      /*-------------
        Dados do transportador
        -------------------------*/

      nFld_g:= 7
      nLin:= 10
      nCol:= 5
      
      TSay():New(nLin       , nCol     , {|| STR0010}, aFld[nFld_g],,,,,, .T.) //Raz�o Social
      TGet():New(xLin2(nLin), nCol + 35, BSetGet(cNomeTransp), aFld[nFld_g], 210, 08, "@!",,,,,,, .T.)
      
      TSay():New(xLin1(nLin), nCol     , {|| STR0011}, aFld[nFld_g],,,,,, .T.) //Endere�o
      TGet():New(xLin2(nLin), nCol + 35, BSetGet(cEndTransp), aFld[nFld_g], 230, 08, "@!",,,,,,, .T.)      
              
      TSay():New(xLin1(nLin), nCol     , {|| STR0012}, aFld[nFld_g],,,,,, .T.) //Insc. Estadual
      TGet():New(xLin2(nLin), nCol + 35, BSetGet(cInsEstTransp), aFld[nFld_g], 150, 08, X3Picture("A2_INSCR"),,,,,,, .T.)
      
      TSay():New(xLin1(nLin), nCol     , {|| STR0013}, aFld[nFld_g],,,,,, .T.) //CNPJ
      TGet():New(xLin2(nLin), nCol + 35, BSetGet(cCNPJTrans), aFld[nFld_g], 150, 08, X3Picture("A2_CGC"),,,,,,, .T.)


      /*-------------
        Representante legal do exportador/ respons�vel
        -------------------------------------------------*/
      
      nFld_h:= 8
      nLin:= 10
      nCol:= 5
      
      TSay():New(nLin       , nCol     , {|| STR0022}, aFld[nFld_h],,,,,, .T.) //Nome
      TGet():New(xLin2(nLin), nCol + 25, BSetGet(cAssExp), aFld[nFld_h], 100, 08, "@!", {||AllwaysTrue(cCargoAss:= EE3->EE3_CARGO)},,,,,, .T.,,,,,,,,, "E33")
      
      TSay():New(xLin1(nLin), nCol     , {|| STR0023}, aFld[nFld_h],,,,,, .T.) //Cargo
      TGet():New(xLin2(nLin), nCol + 25, BSetGet(cCargoAss), aFld[nFld_h], 100, 08, "@!",,,,,,, .T.)

      TSay():New(xLin1(nLin), nCol     , {|| STR0024}, aFld[nFld_h],,,,,, .T.) //Data da emiss�o
      TGet():New(xLin2(nLin), nCol + 42, BSetGet(dDtMemExp), aFld[nFld_h], 20, 08, "@!",,,,,,, .T.)

      Eval(bRefresh)
   Activate MsDialog oDlg Centered On Init EnchoiceBar(oDlg, bOk, bCancel,, aButtons)

End Sequence

Return

/*
Fun��o      : GeraRelatorio
Par�metros  : nFabr - posi��o do array correspondente ao produtor/ fabricante.
Retorno     : 
Objetivos   : Gera o memorando de exporta��o para o produtor/ fabricante.
Autor       : Wilsimar Fabr�cio da Silva
Data/Hora   : 02/09/09
Revis�o     : 
Obs.        :
*/
Static Function GeraRelatorio(nFabr)
Local cSeqRel,;
      cEstProd:= ""
Local nCont, nCont2
Local lRet:= .F.

Begin Sequence

      //Ser� impresso um memorando por estado produtor/ fabricante

      cEstProd:= aFabricante[nFabr][4] //Estado produtor

      cSeqRel:= GetSxeNum("SY0", "Y0_SEQREL")

      For nCont:= 1 To 2 //3 //n�mero de vias - altera��o conforme conv�nio 84/09

         ConfirmSx8()

         //Captura do SeqRel para a grava��o do hist�rio (vias do Header)
         
         /*------------------
           Grava��o do Header
           -------------------*/
      
         HEADER_P->(DBAppend())

         HEADER_P->AVG_C01_10:= AllTrim(Str(nCont))
         HEADER_P->AVG_CHAVE := EEC->EEC_PREEMB
         HEADER_P->AVG_SEQREL:= cSeqRel
         
         HEADER_P->AVG_C16_20:= cNumMemo


         //Exportador
         HEADER_P->AVG_C01_60:= cNomeExp
         HEADER_P->AVG_C01100:= AllTrim(cEndExp)
         HEADER_P->AVG_C01_20:= Transf(cInscExp, X3Picture("A2_INSCR"))
         HEADER_P->AVG_C02_20:= Transf(cCnpjExp, X3Picture("A2_CGC"))


         //Dados da Exporta��o
         HEADER_P->AVG_C03_20:= cNrDDE
         HEADER_P->AVG_C02_10:= DtoC(dDataDDE)
         HEADER_P->AVG_C04_20:= cNrConh
         HEADER_P->AVG_C03_10:= DtoC(dDtConh)
         HEADER_P->AVG_C05_10:= cEstProd
         HEADER_P->AVG_C01_30:= cPaisDest
      
      
         //Remetente com fim espec�fico de exporta��o
         /* Array aFabricante
            1. fabricante
            2. raz�o social
            3. endere�o
            4. estado produtor
            5. inscri��o estatual
            6. CNPJ
         */
         HEADER_P->AVG_C04_60:= aFabricante[nFabr][2]
         HEADER_P->AVG_C02100:= AllTrim(aFabricante[nFabr][3])
         HEADER_P->AVG_C07_20:= Transf(aFabricante[nFabr][5], X3Picture("A2_INSCR"))
         HEADER_P->AVG_C08_20:= Transf(aFabricante[nFabr][6], X3Picture("A2_CGC"))
         

         //Dados do transportador
         HEADER_P->AVG_C02_60:= cNomeTransp
         HEADER_P->AVG_C03100:= cEndTransp
         HEADER_P->AVG_C14_20:= Transf(cInsEstTransp, X3Picture("A2_INSCR"))
         HEADER_P->AVG_C15_20:= Transf(cCNPJTrans, X3Picture("A2_CGC"))
         

         //Representante legal do exportador/ respons�vel
         HEADER_P->AVG_C02_30:= cAssExp
         HEADER_P->AVG_C03_30:= cCargoAss
         HEADER_P->AVG_C04_10:= DtoC(dDtMemExp)
      
         HEADER_P->(MsUnlock())
      
                
         //Grava��o do hist�rico de documentos
         HEADER_H->(DBAppend())
         AvReplace("HEADER_P","HEADER_H")
         HEADER_H->(RecLock("HEADER_H", .F.))
         HEADER_H->AVG_SEQREL:= cSeqRel
         HEADER_H->(MsUnlock())

                
         /*------------------
           Grava��o do Detail
           -------------------*/
                  
         //A grava��o do Detail � realizada apenas uma vez
         If nCont == 1

            //Dados da Exporta��o
            //Notas fiscais de venda
            For nCont2:= 1 To Len(aNotasExp)
   
               /*Array aNotasExp
                 1. Nota fiscal
                 2. Modelo
                 3. S�rie
                 4. Data
               */
               DETAIL_P->(RecLock("DETAIL_P", .T.))
               DETAIL_P->AVG_CHAVE := EEC->EEC_PREEMB
               DETAIL_P->AVG_SEQREL:= cSeqRel

               DETAIL_P->AVG_C01_10:= "A"
               DETAIL_P->AVG_C05_20:= AllTrim(aNotasExp[nCont2][1])
               DETAIL_P->AVG_C04_10:= AllTrim(aNotasExp[nCont2][2])
               DETAIL_P->AVG_C05_10:= AllTrim(aNotasExp[nCont2][3])
               DETAIL_P->AVG_C06_20:= DtoC(aNotasExp[nCont2][4])

               DETAIL_P->(MsUnlock())

               //Hist�rico
               DETAIL_H->(DBAppend())
               AvReplace("DETAIL_P", "DETAIL_H")
            Next

            //Registro de exporta��o
            For nCont2:= 2 To Len(aRe[nFabr])

               DETAIL_P->(RecLock("DETAIL_P", .T.))
               DETAIL_P->AVG_CHAVE := EEC->EEC_PREEMB
               DETAIL_P->AVG_SEQREL:= cSeqRel
               DETAIL_P->AVG_C01_10:= "B"

               DETAIL_P->AVG_C04_20:= AllTrim(Transf(aRe[nFabr][nCont2][1], X3Picture("EE9_RE")))
               DETAIL_P->AVG_C02_10:= DtoC(aRe[nFabr][nCont2][2])

               DETAIL_P->(MsUnlock())

               //Hist�rico
               DETAIL_H->(DBAppend())
               AvReplace("DETAIL_P", "DETAIL_H")
            Next
            
            
            //Discrimina��o dos produtos exportados
            For nCont2:= 2 To Len(aProdutos[nFabr])
      
               /* Array aProdutos
                  x.1   - Produtor/ Fabricante
                  x.2.1 - Quant.
                  x.2.2 - Unid.
                  X.2.3 - NCM
                  x.2.4 - Descri��o
                  x.2.5 - Vl. Unit.
                  x.2.6 - Vl. Total
                  x.2.7 - C�digo do produto
                  x.2.8 - RE
                  x.2.9 - Data RE
               */

               DETAIL_P->(RecLock("DETAIL_P", .T.))
               DETAIL_P->AVG_CHAVE := EEC->EEC_PREEMB
               DETAIL_P->AVG_SEQREL:= cSeqRel
               DETAIL_P->AVG_C01_10:= "C"

               DETAIL_P->AVG_C01_20:= AllTrim(Transf(aProdutos[nFabr][nCont2][1], X3Picture("EE9_SLDINI")))
               DETAIL_P->AVG_C03_10:= aProdutos[nFabr][nCont2][2]
               DETAIL_P->AVG_C02_10:= AllTrim(Transf(aProdutos[nFabr][nCont2][3], X3Picture("EE9_POSIPI")))
               DETAIL_P->AVG_C01150:= aProdutos[nFabr][nCont2][4]
               DETAIL_P->AVG_C02_20:= AllTrim(Transf(aProdutos[nFabr][nCont2][5], X3Picture("EE9_PRECO")))
               DETAIL_P->AVG_C03_20:= AllTrim(Transf(aProdutos[nFabr][nCont2][6], X3Picture("EE9_PRCINC")))

               DETAIL_P->(MsUnlock())

               //Hist�rico
               DETAIL_H->(DBAppend())
               AvReplace("DETAIL_P", "DETAIL_H")
            Next


            //Dados dos documentos fiscais de remessa.
            //Tratamento para impedir que a linha n�o seja suprimida quando n�o houver dados.
            If Len(aNfRemessa[nFabr]) < 2
               AAdd(aNfRemessa[nFabr], {"", "", "", CtoD(""), 0, "", "", ""})
            EndIf

            For nCont2:= 2 To Len(aNfRemessa[nFabr])

               /*
                 Array aNfRemessa
                 x.1   - Produtor/ Fabricante
                 x.2.1 - Nota fiscal de remessa
                 x.2.2 - Modelo
                 x.2.3 - S�rie
                 x.2.4 - Emiss�o
                 x.2.5 - Quantidade
                 x.2.6 - Unidade
                 x.2.7 - NCM
                 x.2.8 - Descri��o
               */

               DETAIL_P->(RecLock("DETAIL_P", .T.))
               DETAIL_P->AVG_CHAVE := EEC->EEC_PREEMB
               DETAIL_P->AVG_SEQREL:= cSeqRel

               //Flag usada para suprimir informa��es no crystal
               DETAIL_P->AVG_C01_10:= "D"

               DETAIL_P->AVG_C07_20:= AllTrim(aNfRemessa[nFabr][nCont2][1])
               DETAIL_P->AVG_C08_20:= AllTrim(aNfRemessa[nFabr][nCont2][2])
               DETAIL_P->AVG_C09_20:= AllTrim(aNfRemessa[nFabr][nCont2][3])
               DETAIL_P->AVG_C10_20:= DtoC(aNfRemessa[nFabr][nCont2][4])
               DETAIL_P->AVG_C06_20:= AllTrim(Transf(aNfRemessa[nFabr][nCont2][5], X3Picture("EE9_SLDINI")))
               DETAIL_P->AVG_C02_10:= AllTrim(aNfRemessa[nFabr][nCont2][6])
               DETAIL_P->AVG_C03_10:= AllTrim(Transf(aNfRemessa[nFabr][nCont2][7], X3Picture("B1_POSIPI")))
               DETAIL_P->AVG_C01_60:= AllTrim(aNfRemessa[nFabr][nCont2][8])
               DETAIL_P->(MsUnlock())

               //Hist�rico
               DETAIL_H->(DBAppend())
               AvReplace("DETAIL_P", "DETAIL_H")

            Next

            //Dados dos conhecimentos de transporte
            //Tratamento para impedir que a linha n�o seja suprimida quando n�o houver dados.
            If Len(aConhTransp[nFabr]) < 2
               AAdd(aConhTransp[nFabr], {"", "", "", CtoD("")})
            EndIf

            For nCont2:= 2 To Len(aConhTransp[nFabr])
               /*
                  Array aConhTransp
                  x.1   - Produtor/Fabricante
                  x.2.1 - N�m. Conhec.
                  x.2.2 - Modelo
                  x.2.3 - S�rie
                  x.2.4 - Data de emiss�o
               */

               DETAIL_P->(RecLock("DETAIL_P", .T.))
               DETAIL_P->AVG_CHAVE := EEC->EEC_PREEMB
               DETAIL_P->AVG_SEQREL:= cSeqRel

               //Flag usada para suprimir informa��es no crystal
               DETAIL_P->AVG_C01_10:= "E"
               
               DETAIL_P->AVG_C07_20:= AllTrim(aConhTransp[nFabr][nCont2][1])
               DETAIL_P->AVG_C08_20:= AllTrim(aConhTransp[nFabr][nCont2][2])
               DETAIL_P->AVG_C09_20:= AllTrim(aConhTransp[nFabr][nCont2][3])
               DETAIL_P->AVG_C10_20:= DtoC(aConhTransp[nFabr][nCont2][4])

               DETAIL_P->(MsUnlock())

               //Hist�rico
               DETAIL_H->(DBAppend())
               AvReplace("DETAIL_P", "DETAIL_H")

               Work5->(DBSkip())
            Next
         EndIf


      Next //n�mero de vias
   
      E_HISTDOC( , STR0001, dDataBase,,, cRpt, cSeqRel, "2", EEC->EEC_PREEMB) //Memorando de Exporta��o


      //Gerando a impress�o do relat�rio
      If !(lRet:= AvgCrw32(cRpt, STR0001, cSeqRel)) //Memorando de Exporta��o
         Break
      EndIf
      
      //Grava��o do n�mero do memorando de exporta��o na tabela EXL
      If EXL->(DBSeek(xFilial() + EEC->EEC_PREEMB))
         EXL->(RecLock("EXL", .F.))
         EXL->EXL_NROMEX:= cNumMemo
         EXL->EXL_DTMEX := DtoC(dDtMemExp)
         EXL->(MsUnLock())
      EndIf

End Sequence
Return lRet

/*
Fun��o      : GeraTodos
Par�metros  : 
Retorno     : lRet - .T. se o usu�rio optou por gerar o relat�rio; .F. se a opera��o foi cancelada.
Objetivos   : Gerar o memorando de exporta��o para todos os produtores/ fabricantes do processo.
Autor       : Wilsimar Fabr�cio da Silva
Data/Hora   : 02/09/09
Revis�o     : 
Obs.        :
*/
Static Function GeraTodos()
Local nCont
local lRet:= .F.

Begin Sequence

   If MsgYesNo(STR0046 + AllTrim(EEC->EEC_PREEMB) + "." + ENTER + STR0047, STR0045) //Esta opera��o gerar� o memorando de exporta��o para todos os produtores/ fabricantes do processo ###. Deseja prosseguir? / Aviso
      For nCont:= 1 To Len(aFabricante)
         GeraRelatorio(nCont)
      Next
      
      MsgInfo(STR0048) //Opera��o realizada com sucesso.
      lRet:= .T.
   EndIf
   
End Sequence
Return lRet

/*
Fun��o      : CriaWorks
Par�metros  : 
Retorno     : 
Objetivos   : Cria��o das works que ser�o usadas no objeto MsGetDb, possibilitando que o usu�rio
              digite as informa��es adicionais para os itens do produtor/ fabricante.
              As works s�o montadas com base nas informa��es carregadas na fun��o LoadDetalhe.
Autor       : Wilsimar Fabr�cio da Silva
Data/Hora   : 21/09/2009
Revis�o     : 
Obs.        :
*/
Static Function CriaWorks(nFabr)
Local aEstrutura:= {}
Local cArq, cAlias
Local nCont

Begin Sequence
   
   /* Array aProdutos
      x.1   - Fabricante
      x.2.1 - Quantidade
      x.2.2 - Unidade
      X.2.3 - NCM
      x.2.4 - Descri��o
      x.2.5 - Valor unit�rio
      x.2.6 - Valor total
      x.2.7 - C�digo do produto
      x.2.8 - Registro de exporta��o
      x.2.9 - Data do RE
   */

   /*------------
     Dados da exporta��o
     ----------------------*/
   //Registro de exporta��o
   aEstrutura:= {{"WK_COD"   , "C", AvSx3("EE9_COD_I", AV_TAMANHO), 0},;
                 {"WK_DESC"  , "C", AvSx3("C6_DESCRI", AV_TAMANHO), 0},;
                 {"WK_RE"    , "C", AvSx3("EE9_RE"   , AV_TAMANHO), 0},;
                 {"WK_DTRE"  , "D", AvSx3("EE9_DTRE" , AV_TAMANHO), 0},;
                 {"WK_FLAG"  , "L", 1                             , 0}}

   cAlias:= "Work1"

   oTempTable1 := FWTemporaryTable():New(cAlias)
   oTemptable1:SetFields( aEstrutura )
   oTempTable1:Create()

   //Armazena os arquivos criados para exclus�o
   // AAdd(aArq, {cAlias, cArq})

   //Alimenta a Work
   For nCont:= 2 To Len(aProdutos[nFabr])
      (cAlias)->(DBAppend())
      (cAlias)->WK_COD := aProdutos[nFabr][nCont][7]
      (cAlias)->WK_DESC:= aProdutos[nFabr][nCont][4]
      (cAlias)->WK_RE  := aProdutos[nFabr][nCont][8]
      (cAlias)->WK_DTRE:= aProdutos[nFabr][nCont][9]
   Next
   (cAlias)->(DBGoTop())

   /*Notas fiscais do exportador. Ser�o apenas exibidas.
     Array aNotasExp
     1. Nota fiscal
     2. Modelo
     3. S�rie
     4. Data
   */
   aEstrutura:= {{"WK_NFEXP"  , "C", AvSx3("D1_DOC", AV_TAMANHO)    , 0},;
                 {"WK_MODNFEX", "C", 3                              , 0},;
                 {"WK_SERNFEX", "C", AvSx3("D1_SERIE", AV_TAMANHO)  , 0},;
                 {"WK_DTNFREX", "D", AvSx3("D1_EMISSAO", AV_TAMANHO), 0},;
                 {"WK_FLAG"   , "L", 1                              , 0}}

   cAlias:= "Work4"

   oTempTable2 := FWTemporaryTable():New(cAlias)
   oTemptable2:SetFields( aEstrutura )
   oTempTable2:Create()

   //Armazena os arquivos criados para exclus�o
   // AAdd(aArq, {cAlias, cArq})

   //Alimenta a Work
   For nCont:= 1 To Len(aNotasExp)
      (cAlias)->(DBAppend())
      (cAlias)->WK_NFEXP  := aNotasExp[nCont][1]
      (cAlias)->WK_MODNFEX:= aNotasExp[nCont][2]
      (cAlias)->WK_SERNFEX:= aNotasExp[nCont][3]
      (cAlias)->WK_DTNFREX:= aNotasExp[nCont][4]
   Next
   (cAlias)->(DBGoTop())   



   /*----------------------
     Discrimina��o dos produtos exportados
     ---------------------------------------*/
   aEstrutura:= {{"WK_COD"   , "C", AvSx3("EE9_COD_I" , AV_TAMANHO), 0                              },;
                 {"WK_POSIPI", "C", AvSx3("EE9_POSIPI", AV_TAMANHO), 0                              },;
                 {"WK_DESC"  , "C", AvSx3("C6_DESCRI" , AV_TAMANHO), 0                              },;
                 {"WK_QTD"   , "N", AvSx3("EE9_SLDINI", AV_TAMANHO), AvSx3("EE9_SLDINI", AV_DECIMAL)},;
                 {"WK_UNID"  , "C", AvSx3("EE9_UNIDAD", AV_TAMANHO), 0                              },;
                 {"WK_VLUNIT", "N", AvSx3("EE9_PRECO" , AV_TAMANHO), AvSx3("EE9_PRECO", AV_DECIMAL) },;
                 {"WK_VLTOT" , "N", AvSx3("EE9_PRCTOT", AV_TAMANHO), AvSx3("EE9_PRCTOT", AV_DECIMAL)},;
                 {"WK_FLAG"  , "L", 1                              , 0                              }}


   cAlias:= "Work2"

   oTempTable3 := FWTemporaryTable():New(cAlias)
   oTemptable3:SetFields( aEstrutura )
   oTempTable3:Create()

   //Armazena os arquivos criados para exclus�o
   // AAdd(aArq, {cAlias, cArq})

   //Alimenta a Work
   For nCont:= 2 To Len(aProdutos[nFabr])
      (cAlias)->(DBAppend())
      (cAlias)->WK_COD   := aProdutos[nFabr][nCont][7]
      (cAlias)->WK_POSIPI:= aProdutos[nFabr][nCont][3]
      (cAlias)->WK_DESC  := aProdutos[nFabr][nCont][4]
      (cAlias)->WK_QTD   := aProdutos[nFabr][nCont][1]
      (cAlias)->WK_UNID  := aProdutos[nFabr][nCont][2]
      (cAlias)->WK_VLUNIT:= aProdutos[nFabr][nCont][5]
      (cAlias)->WK_VLTOT := aProdutos[nFabr][nCont][6]
   Next
   (cAlias)->(DBGoTop())    



   /*---------------------
     Dados dos documentos fiscais de remessa
     ------------------------------------------*/
   /*
     Array aNfRemessa
     x.1   - Produtor/ Fabricante
     x.2.1 - Nota fiscal de remessa
     x.2.2 - Modelo
     x.2.3 - S�rie
     x.2.4 - Emiss�o
     x.2.5 - Quantidade
     x.2.6 - Unidade
     x.2.7 - NCM
     x.2.8 - Descri��o
   */
   aEstrutura:= {{"WK_NFREM"  , "C", AvSx3("D1_DOC", AV_TAMANHO)    , 0},;
                 {"WK_MODNFRE", "C", 3                              , 0},;
                 {"WK_SERNFRE", "C", AvSx3("D1_SERIE", AV_TAMANHO)  , 0},;
                 {"WK_DTNFREM", "D", AvSx3("D1_EMISSAO", AV_TAMANHO), 0},;
                 {"WK_QTDNFRE", "N", AvSx3("D1_QUANT", AV_TAMANHO)  , AvSx3("D1_QUANT", AV_DECIMAL)},;
                 {"WK_UNINFRE", "C", AvSx3("D1_UM", AV_TAMANHO)     , 0},;
                 {"WK_NCMNFRE", "C", AvSx3("B1_POSIPI", AV_TAMANHO) , 0},;
                 {"WK_DESCNFR", "C", AvSx3("B1_DESC", AV_TAMANHO)   , 0},;
                 {"WK_FLAG"   , "L", 1                              , 0}}

   cAlias:= "Work3"

   oTempTable4 := FWTemporaryTable():New(cAlias)
   oTemptable4:SetFields( aEstrutura )
   oTempTable4:Create()

   //Armazena os arquivos criados para exclus�o
   // AAdd(aArq, {cAlias, cArq})

   //Alimenta a Work
   For nCont:= 2 To Len(aNfRemessa[nFabr])
      (cAlias)->(DBAppend())
      (cAlias)->WK_NFREM  := aNfRemessa[nFabr][nCont][1]
      (cAlias)->WK_MODNFRE:= aNfRemessa[nFabr][nCont][2]
      (cAlias)->WK_SERNFRE:= aNfRemessa[nFabr][nCont][3]
      (cAlias)->WK_DTNFREM:= aNfRemessa[nFabr][nCont][4]
      (cAlias)->WK_QTDNFRE:= aNfRemessa[nFabr][nCont][5]
      (cAlias)->WK_UNINFRE:= aNfRemessa[nFabr][nCont][6]
      (cAlias)->WK_NCMNFRE:= aNfRemessa[nFabr][nCont][7]
      (cAlias)->WK_DESCNFR:= aNfRemessa[nFabr][nCont][8]
   Next
   (cAlias)->(DBGoTop())

   //Se n�o houver dados, o append permite que o usu�rio inclua no objeto GetDb.
   If (cAlias)->(RecCount()) == 0
      (cAlias)->(DBAppend())
   EndIf


   /*-------------------
     Dados dos conhecimentos de transporte
     ---------------------------------------*/
   /*
     Array aConhTransp
     x.1   - Produtor/ Fabricante
     x.2.1 - Conhecimento de transporte
     x.2.2 - Modelo
     x.2.3 - S�rie
     x.2.4 - Data
   */
   aEstrutura:= {{"WK_NUMCONH", "C", 20                             , 0},;
                 {"WK_MODCONH", "C", 3                              , 0},;
                 {"WK_SERCONH", "C", 3                              , 0},;
                 {"WK_DTCONH" , "D", AVSx3("D1_EMISSAO", AV_TAMANHO), 0},;
                 {"WK_FLAG"   , "L", 1                              , 0}}

   cAlias:= "Work5"

   oTempTable5 := FWTemporaryTable():New(cAlias)
   oTemptable5:SetFields( aEstrutura )
   oTempTable5:Create()

   //Armazena os arquivos criados para exclus�o
   // AAdd(aArq, {cAlias, cArq})

   //Alimenta a Work
   For nCont:= 2 To Len(aConhTransp[nFabr])
      (cAlias)->(DBAppend())
      (cAlias)->WK_NUMCONH:= aConhTransp[nFabr][nCont][1]
      (cAlias)->WK_MODCONH:= aConhTransp[nFabr][nCont][2]
      (cAlias)->WK_SERCONH:= aConhTransp[nFabr][nCont][3]
      (cAlias)->WK_DTCONH := aConhTransp[nFabr][nCont][4]
   Next
   (cAlias)->(DBGoTop())

   //Se n�o houver dados, o append permite que o usu�rio inclua no objeto GetDb.
   If (cAlias)->(RecCount()) == 0
      (cAlias)->(DBAppend())
   EndIf

   DBSelectArea("EEC")
End Sequence
Return


/*
Fun��o      : EncerraWorks
Par�metros  : 
Retorno     : 
Objetivos   : Fechar as works abertas e apagar os arquivos criados.
Autor       : Wilsimar Fabr�cio da Silva
Data/Hora   : 21/09/2009
Revis�o     : 
Obs.        : Usa a vari�vel private aArq
*/
Static Function EncerraWorks()
Local nCont

Begin Sequence

   For nCont:= 1 To Len(aArq)
      If Select(aArq[nCont][1]) > 0
         (aArq[nCont][1])->(DBCloseArea())
      EndIf
      FErase(aArq[nCont][2])
   Next

   aArq:= {}
End Sequence
Return

/*
Fun��o      : LoadHeader
Par�metros  : 
Retorno     : 
Objetivos   : Criar o array aHeader, necess�rio para o uso do objeto MsGetDb
Autor       : Wilsimar Fabr�cio da Silva
Data/Hora   : 22/09/2009
Revis�o     : 
Obs.        :
*/
Static Function LoadHeader()

/*   
AAdd(X3Titulo(),;
     SX3->X3_CAMPO,;
     SX3->X3_PICTURE,;
     SX3->X3_TAMANHO,;
     SX3->X3_DECIMAL,;
     SX3->X3_VALID,;
     ,;
     SX3->X3_TIPO,;
     ,;
      })
*/

Begin Sequence

   AAdd(aHeader, {STR0026,; //C�digo
                  "WK_COD",;
                  X3Picture("EE9_COD_I"),;
                  AvSx3("EE9_COD_I", AV_TAMANHO),;
                  0,;
                  "",;
                  ,;
                  "C"}) 

   AAdd(aHeader, {STR0027,; //Descri��o
                  "WK_DESC",;
                  "@!",;
                  AvSx3("C6_DESCRI" , AV_TAMANHO),;
                  0,;
                  "",;
                  ,;
                  "C"})

   AAdd(aHeader, {STR0031,; //Quantidade
                  "WK_QTD",;
                  X3Picture("EE9_SLDINI"),;
                  AvSx3("EE9_SLDINI", AV_TAMANHO),;
                  AvSx3("EE9_SLDINI", AV_DECIMAL),;
                  "",;
                  ,;
                  "N"})
                  
   AAdd(aHeader, {STR0028,; //Unidade
                  "WK_UNID",;
                  "@!",;
                  AvSx3("EE9_UNIDAD", AV_TAMANHO),;
                  0,;
                  "",;
                  ,;
                  "C"})

   AAdd(aHeader, {STR0054,; //N.C.M.
                  "WK_POSIPI",;
                  X3Picture("EE9_POSIPI"),;
                  AvSx3("EE9_POSIPI", AV_TAMANHO),;
                  0,;
                  "",;
                  ,;
                  "C"})

   AAdd(aHeader, {STR0029,; //Valor unit�rio
                  "WK_VLUNIT",;
                  X3Picture("EE9_PRECO"),;
                  AvSx3("EE9_PRECO" , AV_TAMANHO),;
                  AvSx3("EE9_PRECO" , AV_DECIMAL),;
                  "",;
                  ,;
                  "N"})

   AAdd(aHeader, {STR0030,; //Valor total
                  "WK_VLTOT",;
                  X3Picture("EE9_PRCTOT"),;
                  AvSx3("EE9_PRCTOT", AV_TAMANHO),;
                  AvSx3("EE9_PRCTOT", AV_DECIMAL),;
                  "",;
                  ,;
                  "N"})

   AAdd(aHeader, {STR0032,; //Registro de exporta��o
                  "WK_RE",;
                  X3Picture("EE9_RE"),;
                  AvSx3("EE9_RE", AV_TAMANHO),;
                  0,;
                  "",;
                  ,;
                  "C"})                  

   AAdd(aHeader, {STR0033,; //Data do R.E.
                  "WK_DTRE",;
                  X3Picture("EE9_DTRE"),;
                  AvSx3("EE9_DTRE", AV_TAMANHO),;
                  AvSx3("EE9_DTRE", AV_DECIMAL),;
                  "",;
                  ,;
                  "D"})
                     
   AAdd(aHeader, {STR0034,; //NF de remessa
                  "WK_NFREM",;
                  X3Picture("D1_DOC"),;
                  AvSx3("D1_DOC", AV_TAMANHO),;
                  AvSx3("D1_DOC", AV_DECIMAL),;
                  "",;
                  ,;
                  "C"})

   AAdd(aHeader, {STR0020,; //Modelo
                  "WK_MODNFRE",;
                  "@!",;
                  3,;
                  0,;
                  "",;
                  ,;
                  "C"})
                  
   AAdd(aHeader, {STR0021,; //S�rie
                  "WK_SERNFRE",;
                  X3Picture("D1_SERIE"),;
                  AvSx3("D1_SERIE", AV_TAMANHO),;
                  0,;
                  "",;
                  ,;
                  "C"})
                  
   AAdd(aHeader, {STR0024,; //Data da emiss�o
                  "WK_DTNFREM",;
                  X3Picture("D1_EMISSAO"),;
                  AvSx3("D1_EMISSAO", AV_TAMANHO),;
                  0,;
                  "",;
                  ,;
                  "D"})

   AAdd(aHeader, {SubStr(STR0031, 1, 5) + ".",; //Quantidade
                  "WK_QTDNFRE",;
                  X3Picture("D1_QUANT"),;
                  AvSx3("D1_QUANT", AV_TAMANHO),;
                  AvSx3("D1_QUANT", AV_DECIMAL),;
                  "",;
                  ,;
                  "N"})

   AAdd(aHeader, {SubStr(STR0028, 1, 4) + ".",; //Unidade
                  "WK_UNINFRE",;
                  X3Picture("D1_UM"),;
                  AvSx3("D1_UM", AV_TAMANHO),;
                  0,;
                  "",;
                  ,;
                  "C"})

   AAdd(aHeader, {STR0054,; //N.C.M.
                  "WK_NCMNFRE",;
                  X3Picture("B1_POSIPI"),;
                  AvSx3("B1_POSIPI", AV_TAMANHO),;
                  0,;
                  "",;
                  ,;
                  "C"})

   AAdd(aHeader, {SubStr(STR0027, 1, 4) + ".",; //Descri��o
                  "WK_DESCNFR",;
                  X3Picture("B1_DESC"),;
                  AvSx3("B1_DESC", AV_TAMANHO),;
                  0,;
                  "",;
                  ,;
                  "C"})

   AAdd(aHeader, {STR0035,; //Nota Fiscal
                  "WK_NFEXP",;
                  X3Picture("D1_DOC"),;
                  AvSx3("D1_DOC", AV_TAMANHO),;
                  AvSx3("D1_DOC", AV_DECIMAL),;
                  "",;
                  ,;
                  "C"})

   AAdd(aHeader, {STR0020,; //Modelo
                  "WK_MODNFEX",;
                  "@!",;
                  3,;
                  0,;
                  "",;
                  ,;
                  "C"})
                  
   AAdd(aHeader, {STR0021,; //S�rie
                  "WK_SERNFEX",;
                  X3Picture("D1_SERIE"),;
                  AvSx3("D1_SERIE", AV_TAMANHO),;
                  0,;
                  "",;
                  ,;
                  "C"})
                  
   AAdd(aHeader, {STR0024,; //Data da emiss�o
                  "WK_DTNFREX",;
                  X3Picture("D1_EMISSAO"),;
                  AvSx3("D1_EMISSAO", AV_TAMANHO),;
                  0,;
                  "",;
                  ,;
                  "D"})

   AAdd(aHeader, {STR0039,; //N� do conhecimento
                  "WK_NUMCONH",;
                  "@!",;
                  20,;
                  0,;
                  "",;
                  ,;
                  "C"})

   AAdd(aHeader, {STR0049,; //Mod. Conh.
                  "WK_MODCONH",;
                  "@!",;
                  3,;
                  0,;
                  "",;
                  ,;
                  "C"})
                  
   AAdd(aHeader, {STR0050,; //S�rie Conh.
                  "WK_SERCONH",;
                  "@!",;
                  3,;
                  0,;
                  "",;
                  ,;
                  "C"})
                  
   AAdd(aHeader, {STR0051,; //Data emiss�o
                  "WK_DTCONH",;
                  X3Picture("D1_EMISSAO"),;
                  AvSx3("D1_EMISSAO", AV_TAMANHO),;
                  0,;
                  "",;
                  ,;
                  "D"})


End Sequence
Return

/*
Fun��o      : PEM77Campo()
Par�metros  : 
Retorno     : 
Objetivos   : Gatilho para atualiza��o do campo valor total do produto quando preenchido os campos quantidade e valor unit�rio.
Autor       : Wilsimar Fabr�cio da Silva
Data/Hora   : 23/09/2009
Revis�o     : 
Obs.        :
*/
User Function PEM77Campo(cAlias)
Local lRet:= .T.
Local cVar:= ReadVar()

Begin Sequence

   (cAlias)->(RecLock(cAlias, .F.))
   Do Case
      Case "WK_QTD" $ cVar
         (cAlias)->WK_VLTOT:= M->WK_QTD * (cAlias)->WK_VLUNIT

      Case "WK_VLUNIT" $ cVar
         (cAlias)->WK_VLTOT:= M->WK_VLUNIT * (cAlias)->WK_QTD      

   EndCase
   (cAlias)->(MsUnlock())

End Sequence
Return lRet

/*
Fun��o      : AtualizaDados()
Par�metros  : nFabr - a posi��o do array correspondente ao produtor/ fabricante editado pelo usu�rio.
Retorno     : 
Objetivos   : Atualizar os arrays (detalhes) com os dados editados pelo usu�rio nas MsGetDb.
              As informa��es ser�o passadas das works para os arrays correspondentes.
Autor       : Wilsimar Fabr�cio da Silva
Data/Hora   : Setembro/2009
Revis�o     : 
Obs.        :
*/

Static Function AtualizaDados(nFabr)
Local aReTemp:= {},;
      aNfRemTemp:= {}
Local nCont

Begin Sequence

   //Tratamento para armazenar as informa��es digitadas pelo usu�rio nos arrays correspondentes.
   
   /*--------------
     Dados da Exporta��o
     ---------------------------*/
   /*
      Atualiza o array aRe com as informa��es digitadas pelo usu�rio na tela de pr�via, objeto MsGetDB,
      sem repet�-los. Permite que seja feito o tratamento de ordena��o para a gera��o do memorando.
      Atualiza tamb�m o array aProdutos, onde os RE's est�o separados por produto.
      Array aRe
      x.1   - Produtor/ Fabricante
      x.2.1 - N�mero RE
      x.2.2 - Data RE
   */
   
   Work1->(DBGoTop())
   nCont:= 2
   While Work1->(!Eof())

      If(AScan(aReTemp, {|x| AllTrim(x[1]) == AllTrim(Work1->WK_RE)})) == 0

         AAdd(aReTemp, {Work1->WK_RE, Work1->WK_DTRE})
      EndIf

      aProdutos[nFabr][nCont][8]:= Work1->WK_RE
      aProdutos[nFabr][nCont][9]:= Work1->WK_DTRE
      
      nCont++
      Work1->(DBSkip())
   End
   Work1->(DBGoTop())

   aReTemp:= ASort(aReTemp,,, {|x, y| x[1] < y[1] })

   aRe[nFabr]:={}
   AAdd(aRe[nFabr], aFabricante[nFabr][1])
   AEval(aReTemp, {|aTemp| AAdd(aRe[nFabr], aClone(aTemp))})
   
   /*----------------- 
     Discrimina��o dos produtos exportados
     --------------------------------------*/
   /*
      Atualiza o array aProdutos com as informa��es digitadas para o produto/ fabricante pelo usu�rio.

      x.1   - Fabricante
      x.2.1 - Quantidade
      x.2.2 - Unidade
      X.2.3 - NCM
      x.2.4 - Descri��o
      x.2.5 - Valor unit�rio
      x.2.6 - Valor total
      x.2.7 - C�digo do produto
      x.2.8 - Registro de exporta��o
      x.2.9 - Data do RE
   */

   Work2->(DBGoTop())
   nCont:= 2
   While Work2->(!Eof())

      aProdutos[nFabr][nCont][1]:= Work2->WK_QTD
      aProdutos[nFabr][nCont][2]:= Work2->WK_UNID
      aProdutos[nFabr][nCont][3]:= Work2->WK_POSIPI
      aProdutos[nFabr][nCont][4]:= Work2->WK_DESC
      aProdutos[nFabr][nCont][5]:= Work2->WK_VLUNIT
      aProdutos[nFabr][nCont][6]:= Work2->WK_VLTOT

      nCont++
      Work2->(DBSkip())
   End
   Work2->(DBGoTop())


   /*--------------------------
     Dados dos documentos fiscais de remessa
     ----------------------------------------*/
   /*
      Atualiza o array aNfRemessa com as informa��es digitadas para o produto/ fabricante pelo usu�rio.
      Substitui as informa��es existentes no array pelas novas informadas.

      Array aNfRemessa
      x.1   - Produtor/ Fabricante
      x.2.1 - Nota fiscal de remessa
      x.2.2 - Modelo
      x.2.3 - S�rie
      x.2.4 - Emiss�o
      x.2.5 - Quantidade
      x.2.6 - Unidade
      x.2.7 - NCM
      x.2.8 - Descri��o
   */
   
   //Armazena o produtor/ fabricante
   aNfRemTemp:= {aFabricante[nFabr][1]}
   
   Work3->(DBGoTop())
   
   While Work3->(!Eof())
      //Se a linha n�o foi deletada
      If Work3->WK_FLAG <> .T.
         AAdd(aNfRemTemp, {Work3->WK_NFREM,;
                           Work3->WK_MODNFRE,;
                           Work3->WK_SERNFRE,;
                           Work3->WK_DTNFREM,;
                           Work3->WK_QTDNFRE,;
                           Work3->WK_UNINFRE,;
                           Work3->WK_NCMNFRE,;
                           Work3->WK_DESCNFR})
      EndIf
      
      Work3->(DBSkip())
   End
   Work3->(DBGoTop())
   
   aNfRemessa[nFabr]:= AClone(aNfRemTemp)



   /*------------------------
     Dados dos conhecimentos de transporte
     ----------------------------------------*/
   /*
      Adiciona no array aConhTransp as os dados digitados para o produtor/ fabricante pelo usu�rio.
      Sempre zera o conte�do do array para considerar os �ltimos lan�amentos.

      Array aConhTransp
      x.1   - Produtor/Fabricante
      x.2.1 - N�m. Conhec.
      x.2.2 - Modelo
      x.2.3 - S�rie
      x.2.4 - Data de emiss�o
   */
   Work5->(DBGoTop())
   
   aConhTransp[nFabr]:= {aFabricante[nFabr][1]}

   While Work5->(!Eof())
      //Se a linha n�o foi deletada
      If Work5->WK_FLAG <> .T.
         AAdd(aConhTransp[nFabr], {Work5->WK_NUMCONH,;
                                   Work5->WK_MODCONH,;
                                   Work5->WK_SERCONH,;
                                   Work5->WK_DTCONH})
      EndIf

      Work5->(DBSkip())
   End
   Work5->(DBGoTop())

End Sequence
Return

/*
Fun��o      : Navegacao()
Par�metros  : nFabr - posi��o atual do array
              cNavegacao - a��o que ser� executada (incremento ou decremento)
Retorno     : 
Objetivos   : Incrementar/ decrementar a vari�vel que controla a posi��o do array correspondente � um produtor/ fabricante.
              Atualizar as works com as novas informa��es.
Autor       : Wilsimar Fabr�cio da Silva
Data/Hora   : 
Revis�o     : 
Obs.        : 
*/

Static Function Navegacao(nFabr, cNavegacao)

Begin Sequence

   //Gera os dados para o pr�ximo produtor/ fabricante
   Do Case
      Case cNavegacao == PROXIMO
         nFabr++
      Case cNavegacao == ANTERIOR
         nFabr--
   EndCase

   //Tratamento para impedir o estouro do array
   If nFabr < 1
      nFabr:= 1
      MsgInfo(STR0036) //Primeiro Registro
   ElseIf nFabr > Len(aFabricante)
      nFabr:= Len(aFabricante)
      MsgInfo(STR0040) //�ltimo registro
   Else
      //Encerra e apaga os arquivos
      EncerraWorks()

      //Cria��o das Works usadas nas MsGetDB
      CriaWorks(nFabr)
   EndIf

End Sequence
Return
