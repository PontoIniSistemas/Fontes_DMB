#ifdef SPANISH
	#define STR0001 "Directorio para la grabacion del txt no existe: "
	#define STR0002 "Aviso"
	#define STR0003 "Incluye Proceso"
	#define STR0004 "Excluye Proceso"
	#define STR0005 "Respuesta de DDE"
	#define STR0006 "No hay proceso(s) seleccionado(s)."
	#define STR0007 "Marcar/ desmarcar items"
	#define STR0008 "Observaciones"
	#define STR0009 "Este proceso ya posee DDE vinculada."
	#define STR0010 "El item "
	#define STR0011 " no posee RE."
	#define STR0012 ", RE "
	#define STR0013 ", no se enmarca en los parametros definidos."
	#define STR0014 "Aun asi, Desea marcarlo (s)?"
	#define STR0015 "La factura "
	#define STR0016 "Ademas de la Factura informada, el proceso posee otros items con Facturas."
	#define STR0017 "Ademas de la Factura informada, el proceso posee otros items con RE."
	#define STR0018 "El proceso posee datos que no se enmarcan en los parametros."
	#define STR0019 "Existe(n) asuntos pendiente(s) en el proceso."
	#define STR0020 "Existen procesos que no se enmarcan totalmente en los parametros."
	#define STR0021 "Esta accion eliminara de la visualizacion todos los procesos"
	#define STR0022 "Desea continuar?"
	#define STR0023 "No hay registros para procesarse."
	#define STR0024 "Error en la generacion de los archivos: "
	#define STR0025 "Respuesta de DDE"
	#define STR0026 "Generando archivos para la integracion"
	#define STR0027 "Conexion con el SISCOMEX"
	#define STR0028 "Conectese al SISCOMEX con el CNPJ "
	#define STR0029 "Despues de haberse posicionado en la pantalla superior, haga clic en el boton Avanzar para iniciar la integracion."
	#define STR0030 "La integracion no puede continuar porque el terminal del Siscomex no se definio."
	#define STR0031 "Los archivos necesarios para la integracion no se encontraron"
	#define STR0032 "Aguarde"
	#define STR0033 "Procesando la integracion"
	#define STR0034 "Verificando archivos de retorno"
	#define STR0035 "Error en la apertura del archivo: "
	#define STR0036 "Recogiendo los CNPJ's de las unidades exportadoras"
	#define STR0037 " y posicione en la pantalla abajo."
	#define STR0038 "Unidad exportadora: "
	#define STR0039 " de "
	#define STR0040 "Pantalla inicial"
	#define STR0041 "Generando archivos en las tablas EEX y EEZ"
	#define STR0042 "Actualizando el Easy Export Control"
	#define STR0043 "Realizando la b�squeda en el Siscomex..."
	#define STR0044 "Leyenda"
	#define STR0045 "Listo para la integracion"
	#define STR0046 "Datos fuera de los parametros"
	#define STR0047 "Posee asuntos pendientes"
	#define STR0048 "Concluido"
	#define STR0049 "No existe factura vinculada a este proceso."
#else
	#ifdef ENGLISH
		#define STR0001 "The directory to save the txt file does not exist: "
		#define STR0002 "Warning"
		#define STR0003 "Add Process"
		#define STR0004 "Exclude Process"
		#define STR0005 "DDE Return"
		#define STR0006 "There are no process(es) selected."
		#define STR0007 "Check / uncheck items"
		#define STR0008 "Notes"
		#define STR0009 "This process already has a DDE linked."
		#define STR0010 "The item "
		#define STR0011 " does not have RE."
		#define STR0012 ", RE "
		#define STR0013 ", does not match with parameters defined."
		#define STR0014 "Do you want to check them anyway?"
		#define STR0015 "The invoice "
		#define STR0016 "Besides the NF informed, the process has other items with NF."
		#define STR0017 "Besides the RE informed, the process has other items with RE."
		#define STR0018 "The process has data which do not match with parameters."
		#define STR0019 "There are pendencies in the process."
		#define STR0020 "There are process which do not quite match with parameters."
		#define STR0021 "This action will take all process off view."
		#define STR0022 "Do you want to continue?"
		#define STR0023 "There are no records to process."
		#define STR0024 "Error in generation of files: "
		#define STR0025 "DDE Return"
		#define STR0026 "Generating files for the integration"
		#define STR0027 "Connection with SISCOMEX"
		#define STR0028 "Connect to SISCOMEX with CNPJ "
		#define STR0029 "In the screen above, click the button Next to start the integration."
		#define STR0030 "The integration cannot proceed because the Siscomex terminal was not defined."
		#define STR0031 "Files required to integration were not found."
		#define STR0032 "Wait"
		#define STR0033 "Processing integration"
		#define STR0034 "Checking return files"
		#define STR0035 "Error opening file: "
		#define STR0036 "Collecting CNPJs of export units"
		#define STR0037 " and position in screen below."
		#define STR0038 "Export unit: "
		#define STR0039 " of "
		#define STR0040 "Initial screen"
		#define STR0041 "Generating records in tables EEX and EEZ"
		#define STR0042 "Updating Easy Export Control"
		#define STR0043 "Searching in Siscomex..."
		#define STR0044 "Caption"
		#define STR0045 "Ready for integration"
		#define STR0046 "Data outside parameters"
		#define STR0047 "There are pendencies"
		#define STR0048 "Concluded"
		#define STR0049 "There is no invoice linked to this process."
	#else
		#define STR0001 "Diret�rio para a grava��o do txt n�o existe: "
		#define STR0002 "Aviso"
		#define STR0003 "Inclui Processo"
		#define STR0004 "Exclui Processo"
		#define STR0005 "Retorno de DDE"
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "N�o existem processo(s) seleccionado(s).", "N�o h� processo(s) selecionado(s)." )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Marcar/ Desmarcar elementos", "Marcar/ desmarcar itens" )
		#define STR0008 "Observa��es"
		#define STR0009 "Este processo j� possui DDE vinculada."
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "O elemento ", "O item " )
		#define STR0011 " n�o possui RE."
		#define STR0012 ", RE "
		#define STR0013 ", n�o se enquadra aos par�metros definidos."
		#define STR0014 "Deseja marc�-lo(s) mesmo assim?"
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "A factura ", "A nota fiscal " )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Al�m da FACT informada, o processo possui outros elementos com FACT.", "Al�m da NF informada, o processo possui outros itens com NF." )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Al�m da RE informada, o processo possui outros elementos com RE.", "Al�m da RE informada, o processo possui outros itens com RE." )
		#define STR0018 "O processo possui dados que n�o se enquadram aos par�metros."
		#define STR0019 "Exite(m) pend�ncia(s) no processo."
		#define STR0020 "Existem processos que n�o se enquadram totalmente aos par�metros."
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Esta ac��o eliminar� da visualiza��o todos os processos" + Chr(13) + Chr(10) + "com pend�ncias ou j� integrados (n�o process�veis).", "Esta a��o eliminar� da visualiza��o todos os processos" + Chr(13) + Chr(10) + "com pend�ncias ou j� integrados (n�o process�veis)." )
		#define STR0022 "Deseja continuar?"
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "N�o existem registos para serem processados.", "N�o existem registros para serem processados." )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "Erro na gera��o dos ficheiros: ", "Erro na gera��o dos arquivos: " )
		#define STR0025 "Retorno de DDE"
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "A gerar ficheiros para a integra��o", "Gerando arquivos para a integra��o" )
		#define STR0027 "Conex�o com o SISCOMEX"
		#define STR0028 "Conecte-se ao SISCOMEX com o CNPJ "
		#define STR0029 "Ap�s ter posicionado na tela acima, clique no bot�o Avan�ar para iniciar a integra��o."
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "A integra��o n�o pode prosseguir, pois o terminal do Siscomex n�o foi definido." + Chr(13) + Chr(10) + "Edite o par�metro MV_AVG0091 e reinicie o processo.", "A integra��o n�o pode prosseguir pois o terminal do Siscomex n�o foi definido." + Chr(13) + Chr(10) + "Edite o par�metro MV_AVG0091 e reinicie o processo." )
		#define STR0031 If( cPaisLoc $ "ANG|PTG", "Os ficheiros necess�rios para a integra��o n�o foram encontrados.", "Os arquivos necess�rios para a integra��o n�o foram encontrados." )
		#define STR0032 "Aguarde"
		#define STR0033 If( cPaisLoc $ "ANG|PTG", "A processar a integra��o", "Processando a integra��o" )
		#define STR0034 If( cPaisLoc $ "ANG|PTG", "A verificar ficheiros de retorno", "Verificando arquivos de retorno" )
		#define STR0035 If( cPaisLoc $ "ANG|PTG", "Erro na abertura do ficheiro: ", "Erro na abertura do arquivo: " )
		#define STR0036 If( cPaisLoc $ "ANG|PTG", "A colectar os CNPJ's das unidades exportadoras", "Coletando os CNPJ's das unidades exportadoras" )
		#define STR0037 " e posicione na tela abaixo."
		#define STR0038 If( cPaisLoc $ "ANG|PTG", "Unidade Exportadora: ", "Unidade exportadora: " )
		#define STR0039 " de "
		#define STR0040 If( cPaisLoc $ "ANG|PTG", "Tela Inicial", "Tela inicial" )
		#define STR0041 If( cPaisLoc $ "ANG|PTG", "A gerar registos nas tabelas EEX e EEZ", "Gerando registros nas tabelas EEX e EEZ" )
		#define STR0042 If( cPaisLoc $ "ANG|PTG", "A actualizar o Easy Export Control", "Atualizando o Easy Export Control" )
		#define STR0043 If( cPaisLoc $ "ANG|PTG", "A realizar a busca no Siscomex...", "Realizando a busca no Siscomex..." )
		#define STR0044 "Legenda"
		#define STR0045 "Pronto para a integra��o"
		#define STR0046 "Dados fora dos par�metros"
		#define STR0047 "Possui pend�ncias"
		#define STR0048 If( cPaisLoc $ "ANG|PTG", "Finalizado", "Conclu�do" )
		#define STR0049 If( cPaisLoc $ "ANG|PTG", "N�o existe factura vinculada a este processo.", "N�o existe nota fiscal vinculada a este processo." )
	#endif
#endif