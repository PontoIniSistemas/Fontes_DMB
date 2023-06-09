/*
Programa : EEC.CH
Objetivo : manter definicoes genericas para uso no SIGAEEC
Autor    : Heder M Oliveira
Data/Hora: 04/11/98 11:11
Obs      : Em todos os prg's deve haver uma chamada para este header
           Nao eh necessario incluir o fivewin.ch nos prg's
           Come�amos com str09 em fun��o de conflito em outros programas.
*/
#include "Average.ch"
#include "eecstr.ch"

//definicao de situacao de processos apresentado em ordem de uso
#define ST_PC  "*"     //processo/embarque cancelado (EE7/EEC)
//fase pedido (EE7->EE7_STATUS)
#define ST_SC  "1"     //aguardando solicitacao de credito
#define ST_LC  "2"     //aguardando liberacao de credito
#define ST_CL  "3"     //credito liberado
#define ST_PE  "7"     //lancado na fase de embarque
//fase embarque (EEC->EEC_STATUS)
#define ST_DC  "4"     //aguardando confeccao documentos
#define ST_AE  "5"     //aguardando embarque
#define ST_EM  "6"     //embarcado
// Novos status 609
#define ST_CC  "8"     //cambio a contratar
#define ST_EP  "9"     //cambio parcial
#define ST_CO  "A"     //cambio contratado
#define ST_LP  "E"     //lanc. parcial na fase de embarque
// Integracao Faturamento
#define ST_AF  "B"     //aguardando faturamento
#define ST_FP  "C"     //faturado parcialmente
#define ST_FA  "D"     //faturado
#define ST_RV  "F"     //pedido especial para rv sem vinculacao    

// definicao de situacao de fixacao de precos para processos com commodities
#define SF_SS  STR0901 //"Sem pre�o e sem diferencial"
#define SF_SD  STR0902 //"Sem pre�o e com diferencial"
#define SF_FX  STR0903 //"Fixado"
#define SF_PI  STR0904 //"Com pre�o inicial"

//definicao de tipos de cadastros
#define CD_SA1  "I"     //importador/distribuidor/cliente //IMP
#define CD_SA2  "X"     //exportador/fornecedor/fabricante
#define CD_SA6  "B"     //Bancos SA6 //BCO
#define CD_SY5  "E"     //EMPRESAS

//definicao de agentes (SY5)
#define CD_AGE "1"   //AGENTE EMBARCADOR
#define CD_AGQ "2"   //AGENTE (REC.DADOS EMBARQUE)
#define CD_AGC "3"   //AGENTE (REC.COMISSAO)
#define CD_ARM "4"   //ARMADOR
#define CD_COC "5"   //CORRETORA CAMBIO
#define CD_DES "6"   //DESPACHANTE
#define CD_DIV "7"   //DIVERSOS
#define CD_INS "8"   //INSPETORA
#define CD_PAL "9"   //PALETIZADORA
#define CD_SEG "A"   //SEGURADORA
#define CD_TRA "B"   //TRANSPORTADORA
#define CD_REP "C"   //REPRESENTANTE
#define CD_COU "D"   //COURIER

//definicao de pgto de comissao
#define CS_RMT "1"   //a remeter
#define CS_CGF "2"   //conta grafica
#define CS_DDF "3"   //deduzir da fatura

//definicao de tipos de cadastros para mensagens (EE2)
#define MC_TMEN   "1"   //mensagem relacionada a TABELA DE MENSAGENS
#define MC_TCPG   "2"   //mensagem para condicoes de pagamento
#define MC_CPRO   "3"   //mensagem relacionadaa CADASTRO DE PRODUTOS
#define MC_TMOE   "4"   //mensagem relacionada tabela de moedas
#define MC_CBAN   "5"   //mensagem relacionada a bancos
#define MC_TEMB   "6"   //mensagem relacionada ao cadastro de embalagens
#define MC_CPAI   "7"   //mensagem relacionada ao cadastro de paises
#define MC_TUNM   "8"   //mensagem relacionada a Tabela de Unidades de Medida

//definicao de tipos de uso de mensagens (EE4)
#define TM_SIT "1"   //mensagem visivel em desc. situacao
#define TM_CAR "2"   //mensagem visivel em cartas
#define TM_FAT "3"   //mensagem visivel em faturas
#define TM_INS "4"   //mensagem visivel em instrumento embarque
#define TM_DOC "5"   //mensagem visivel para criterios de origem de produtos
#define TM_GER "*"   //mensagem visivel generica nao visivel ao usuario para ser usada no EE2

//definicao de peso/valor minimo para nao requisicao de RE
#define RE_VLRMINJ      5000    //US$ 5,000.00 pessoa juridica
#define RE_VLRMINF      1000    //US$ 1,000.00 pessoa fisica
#define RE_PESMIN       100     //100 Kg

//definicao para browser
#define APRVCRED     6  //aprovar credito
#define VINCULAR_RV  9  //vincular R.V

//definicao de quando ocorre um lancamento
#define OC_PE   "P"   //pedido
#define OC_EM   "Q"   //embarque
#define OC_EMBA "E"   //embalagem
#define OC_FI   "F"   //FINANCAS

//definicao de tipo de relacao no EE1 
#define TR_INS  "I"   //instrumento de negociacao
#define TR_ARQ  "A"    //relacao com arquivos de documentos
#define TR_MEN  "M"    //relacao com arquivos de mensagens

//definicao de tipo de uso do EEM
#define EEM_NF  "N"    // Lancamento de Nota Fiscal - Interna
#define EEM_IN  "I"    // Lancamento de Invoice

#define EEM_SD  "1"    //Nota de Saida
#define EEM_CP  "2"    //Nota Complementar
#define EEM_CR  "3"    //Nota de Credito
#define EEM_DP  "4"    //Nota de Despesa

//definicao do Tipo de uso do EEO
#define TIPO_ITEM "I"
#define TIPO_EMB  "E"

#translate RestArea() => DBSELECTAREA(nOLDAREA);;
                         dbSetOrder(nOLDOrdem) ;;
                         dbGoTo(nOLDRec)

//definicoes para siscomex EEC_STASIS / EE9_STATUS
#define SI_AS  "1"   //Aguardando liberacao para siscomex
#define SI_LS  "2"   //Aguardando envio para siscomex
#define SI_RS  "3"   //Aguardando retorno siscomex
#define SI_SF  "4"   //Siscomex Finalizado
#define SI_ER  "5"   //Erro retorno siscomex

#define CRW_NewPage "### "+STR0905+" ##########" //"Pr�xima P�gina"

// Definicoes para a funcao:
//  EE2Manut (Manutencao de descricao em varios idiomas)
#define MO_DS "1" // Descricao Simples
#define MO_MM "2" // Campo Memo
#define MO_SP "3" // Descricao no Sigular e no Plural

#define AC_WK "1" // (Criar/Gravar Work)
#define AC_MS "2" // (Criar MsSelect)
#define AC_IN "3" // (Criar Botoes - on init)
#define AC_GR "4" // (Gravar dados do work no EE2)
#define AC_DE "5" // (Excluir dados do EE2)
#define AC_ER "6" // (Fecha/Apaga o Work)

// definicao de Bancos EEJ
#define BC_DES "6" // Pgto Despachante
#define BC_AVI "D" // Avisador
#define BC_CON "E" // Confirmador
#define BC_EMI "F" // Emissor
#define BC_DBR "G" // Doctos no Brasil
#define BC_DIM "H" // Doctos do Importador
#define BC_COC "I" // Contrato de Cambio
#define BC_FOR "J" // Fornecedor

// definicao dos idiomas
#define PORTUGUES "PORT. -"+STR0906 //"PORTUGUES"
#define INGLES    "INGLES-"+STR0907 //"INGLES"
#define ESPANHOL  "ESP.  -"+STR0908 //"ESPANHOL"

// definicao das fases para impressao de documentos.
#define VD_TOD "1" // Todos
#define VD_PRO "2" // Processo de Exportacao
#define VD_EMB "3" // Embarque de Exportacao
#define VD_FIN "4" // Financeiro
//----------------------------------------------------------------------------\\
// FIM DO ARQUIVO EEC.CH                                                      \\
//----------------------------------------------------------------------------\\
