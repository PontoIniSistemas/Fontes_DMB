#include "RWMAKE.CH"   
#include "protheus.ch"
#Include "Colors.ch"
//-------------------------------------------------------------------
/*/{Protheus.doc} MCCADZNF


@protected
@author    Rodrigo Carvalho
@since     23/05/2018
@obs       

Alteracoes Realizadas desde a Estruturacao Inicial
Data       Programador     Motivo
/*/                                                                                      
//-------------------------------------------------------------------
User Function MCCADZNF()

Private aRotina   := {{"&Pesquisar"   , "AxPesqui"   ,0,1},;
                      {"&Visualizar"  , "AxVisual"   ,0,2},;
                      {"&Incluir"     , "AxInclui"   ,0,3},;
                      {"&Alterar"     , "AxAltera"   ,0,4},;                      
                      {"&Excluir"     , "AxDeleta"   ,0,5}}

Private cString   := "ZNF"
Private cCadastro := "Abax"

dbSelectArea"ZNF"
dbSetOrder(1)
MBrowse(6,1,22,75,"ZNF",,,,,,)    

Return .t.