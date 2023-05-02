/*
	Exemplo de Uso do Workflow em um processo de Liberação de Pedido de Compras com VISIO
*/

#include "rwmake.ch" 
#include "tbiconn.ch"

/* É necessário cadastrar o processo e os status conforme usado na função Track */

User Function WFW120P()
Local oProcess

   ConOut("Iniciando Processo")
   //Iniciou o Processo 
   oProcess := TWFProcess():New( "000001", "Pedido de Compras" )
   oProcess:NewTask( "Aprovação", "\WORKFLOW\WFW120P1.HTM" )
    
   oProcess:Track("10001",,"","PROCESSO")	
      
   If U_AN_PC(oProcess)                
      ConOut("INICIA_PC")
      U_INICIA_PC(oProcess)
   endif
Return

//Processo VISIO
User Function AN_PC(oProcess)
   oProcess:Track("10002",,"","DECISAO")	       
Return .T.
                   
User Function INICIA_PC(oProcess) 
Local aCond:={},nTotal := 0,cMailID,cSubject                                                       
    oProcess:Track("10003",,"","ENVIAR MENSAGEM")	       
	oProcess:cSubject := "Aprovacao de Pedido de Compra"
	oProcess:bReturn := "U_RETORNO_PC"
	oProcess:bTimeOut := {{"U_TIMEOUT_PC(1)",0, 2, 2 },{"U_TIMEOUT_PC(2)",0, 2, 4 }}
	oHTML := oProcess:oHTML
	                                        
	cSubject := "APROVACAO DO PEDIDO No " + SC7->C7_NUM
	
	/*** Preenche os dados do cabecalho ***/
	oHtml:ValByName( "EMISSAO", SC7->C7_EMISSAO )
	oHtml:ValByName( "FORNECEDOR", SC7->C7_FORNECE )    
	dbSelectArea('SA2')
	dbSetOrder(1)
	dbSeek(xFilial('SA2')+SC7->C7_FORNECE)
	oHtml:ValByName( "lb_nome", SA2->A2_NOME )    
	oHtml:ValByName( "lb_cond", SC7->C7_COND )    	

    //Pego as condicoes de Pagamento
    dbSelectArea('SE4')
    dbSeek(xFilial('SE4'))
    While !Eof() .and. xFilial('SE4')==E4_FILIAL 
      aadd(aCond,"'"+E4_DESCRI+"'")
      dbSkip()
    end

	dbSelectArea('SC7')
	oHtml:ValByName( "PEDIDO", SC7->C7_NUM )
    cNum := SC7->C7_NUM
	oProcess:fDesc := "Pedido de Compras No "+ cNum
    dbSetOrder(1)
    dbSeek(xFilial('SC7')+cNum)
    While !Eof() .and. C7_NUM = cNum
       nTotal := nTotal + C7_TOTAL
       AAdd( (oHtml:ValByName( "produto.item" )),C7_ITEM )		
       AAdd( (oHtml:ValByName( "produto.codigo" )),C7_PRODUTO )		       
       dbSelectArea('SB1')
       dbSetOrder(1)
       dbSeek(xFilial('SB1')+SC7->C7_PRODUTO)
       dbSelectArea('SC7')
       AAdd( (oHtml:ValByName( "produto.produto" )),SB1->B1_DESC )		              
       AAdd( (oHtml:ValByName( "produto.quant" )),TRANSFORM( C7_QUANT,'@E 99,999.99' ) )		              
       AAdd( (oHtml:ValByName( "produto.preco" )),TRANSFORM( C7_PRECO,'@E 99,999.99' ) )		                     
       AAdd( (oHtml:ValByName( "produto.total" )),TRANSFORM( C7_TOTAL,'@E 99,999.99' ) )		                     
       AAdd( (oHtml:ValByName( "produto.unid" )),SB1->B1_UM )		              
       AAdd( (oHtml:ValByName( "produto.entrega" )),'0' )		                     
       AAdd( (oHtml:ValByName( "produto.condPag" )),aCond )		                     
       WFSalvaID('SC7','C7_WFID',oProcess:fProcessID)
       dbSkip()
    Enddo

    oHtml:ValByName( "lbValor" ,TRANSFORM( nTotal,'@E 99,999.99' ) )		              	
    oHtml:ValByName( "lbFrete" ,TRANSFORM( 0,'@E 99,999.99' ) )		              	    
    oHtml:ValByName( "lbTotal" ,TRANSFORM( nTotal,'@E 99,999.99' ) )		              	    
	oProcess:ClientName( Subs(cUsuario,7,15) )
	oProcess:cTo := "bi@workflow.com.br"  //Coloque aqui o destinatario do Email.
	oProcess:UserSiga:=WFCodUser( "BI" )
	cMailId := oProcess:Start()            
	
Return .T.

User Function RETORNO_PC(oProcess)
  oProcess:Track("10004",,"","DECISAO2")	       
  if oProcess:oHtml:RetByName('RBAPROVA') <> 'Sim' 
    oProcess:Track("10006",,"","REPROVACAO")	       
    DBSelectarea("SCR")                   // Posiciona a Liberacao
    DBSetorder(2)
    If DBSeek(xFilial("SCR")+"PC"+oProcess:oHtml:RetByName('Pedido'))    
      RecLock("SCR",.f.)
      SCR->CR_DataLib := dDataBase
      SCR->CR_Obs     := ""
      SCR->CR_STATUS  := "04"  //Bloqueado
      SCR->CR_OBS := oProcess:oHtml:RetByName('lbmotivo')
      MsUnLock()
    endif  
    return .t.             
  endif  
  //Acerto o pedido
  oProcess:Track("10005",,"","APROVACAO")	         
  DBSelectar("SCR")                   // Posiciona a Liberacao
  DBSetorder(2)
  If DBSeek(xFilial("SCR")+"PC"+oProcess:oHtml:RetByName('Pedido'))    
    RecLock("SCR",.f.)
    SCR->CR_DataLib := dDataBase
    SCR->CR_Obs     := ""
    SCR->CR_STATUS  := "03"
    MsUnLock()
  endif  
  dbselectarea("SC7")
  DBSETORDER(1)
  DBSeek(xFilial("SC7")+oProcess:oHtml:RetByName('Pedido'))      // Posiciona o Pedido
  while !EOF() .and. SC7->C7_Num == oProcess:oHtml:RetByName('Pedido')
     RecLock("SC7",.f.)
     SC7->C7_ConaPro := "L"
     MsUnLock()
     DBSkip()
  enddo
  ConOut("Aprovando o Pedido")
  
  dbSelectArea('SC7')
  dbSetOrder(1)
  dbSeek(xFilial('SC7')+oProcess:oHtml:RetByName('Pedido'))
  
  oProcess:Track("10007",,"","TERMINADOR")	          
   
Return .T.

User Function TIMEOUT_PC(n,oProcess)
   ConOut("Executando TimeOut:"+Str(n))
Return .T.