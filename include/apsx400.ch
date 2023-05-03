#ifdef SPANISH
	#define STR0001 "Archivo de versiones"
	#define STR0002 "Atencion"
	#define STR0003 "Esta version no puede borrarse, pues tiene una estructura vinculada."
	#define STR0004 "Salir"
	#define STR0005 "Atencion"
	#define STR0006 "Esta version no puede borrarse, pues esta en uso en las tablas de movimiento"
	#define STR0007 "Salir"
	#define STR0008 "Estructura de versiones"
	#define STR0009 "Version : "
	#define STR0010 "Adjunta paquete"
	#define STR0011 "Borra paquete"
	#define STR0012 "Visualiza"
	#define STR0013 "Adjunta proyecto"
	#define STR0014 "Borra proyecto"
	#define STR0015 "Busqueda"
	#define STR0016 "Recortar"
	#define STR0017 "Pegar"
	#define STR0018 "Limpia area temporal"
	#define STR0019 "Opciones"
	#define STR0020 "Construyendo estructura..."
	#define STR0021 "Paquete : "
	#define STR0022 "Atencion '"
	#define STR0023 "Este paquete no puede incluirse, pues esta incluido en otra estructura."
	#define STR0024 "Buscar"
	#define STR0025 "Visualizar"
	#define STR0026 "Buscar"
	#define STR0027 "Visualizar"
	#define STR0028 "Proyecto : "
	#define STR0029 "Atencion "
	#define STR0030 "Este proyecto no puede incluirse, pues esta incluido en otra estructura."
	#define STR0031 "Paquete"
	#define STR0032 "Proyecto"
	#define STR0033 "Paquete"
	#define STR0034 "Proyecto"
	#define STR0035 "Buscar Ente"
	#define STR0036 "Ente"
	#define STR0037 "Clave"
	#define STR0038 "Encuesta"
	#define STR0039 "Proyecto: "
	#define STR0040 "Paquete: "
	#define STR0041 "Paquete: "
	#define STR0042 "Atencion"
	#define STR0043 "Si"
	#define STR0044 "Todos los datos del area temporaria se perderan. Confirma"
	#define STR0045 "�La estructura de la version debe poseer un proyecto de mantenimiento!"
	#define STR0046 "�Atencion!"
	#define STR0047 "�La estructura de la version debe poseer mas de un proyecto de mantenimiento!"
	#define STR0048 "�Atencion!"
	#define STR0049 "Abierta"
	#define STR0050 "Situacion"
	#define STR0051 "Incorporada"
	#define STR0052 "Cerrada"
	#define STR0053 "En mantenimiento"
	#define STR0054 "Bloqueada"
	#define STR0055 "Buscar"
	#define STR0056 "Visualizar"
	#define STR0057 "Incluir"
	#define STR0058 "Modificar"
	#define STR0059 "Borrar"
	#define STR0060 "Estructura"
	#define STR0061 "Leyenda"
	#define STR0062 "No"
	#define STR0063 "Solo aprobacion"
	#define STR0064 "Solo .CH"
	#define STR0065 "Abierto sin incl. de tabla"
#else
	#ifdef ENGLISH
		#define STR0001 "Version Register"
		#define STR0002 "Attention"
		#define STR0003 "This version cannot be deleted because it is linked to a structure"
		#define STR0004 "Exit"
		#define STR0005 "Attention"
		#define STR0006 "This version cannot be deleted because it is being used in movement tables"
		#define STR0007 "Exit"
		#define STR0008 "Version Structure"
		#define STR0009 "Version: "
		#define STR0010 "Attach Package"
		#define STR0011 "Delete Package"
		#define STR0012 "View"
		#define STR0013 "Attach Project"
		#define STR0014 "Delete Project"
		#define STR0015 "Search"
		#define STR0016 "Cut"
		#define STR0017 "Paste"
		#define STR0018 "Clear temporary area"
		#define STR0019 "Options"
		#define STR0020 "Building Structure..."
		#define STR0021 "Package: "
		#define STR0022 "Attention '"
		#define STR0023 "This package cannot be added because it is added to another structure!"
		#define STR0024 "Search"
		#define STR0025 "View"
		#define STR0026 "Search"
		#define STR0027 "View"
		#define STR0028 "Project: "
		#define STR0029 "Attention '"
		#define STR0030 "This package cannot be added because it is added to another structure!"
		#define STR0031 "Package"
		#define STR0032 "Project"
		#define STR0033 "Package"
		#define STR0034 "Project"
		#define STR0035 "Search Entity"
		#define STR0036 "Entity"
		#define STR0037 "Key"
		#define STR0038 "Search"
		#define STR0039 "Project: "
		#define STR0040 "Package: "
		#define STR0041 "Package: "
		#define STR0042 "Attention"
		#define STR0043 "Yes"
		#define STR0044 "All the data of the temporary area will be lost. Confirm?"
		#define STR0045 "The structure of the version must have a maintenance project!"
		#define STR0046 "Attention!"
		#define STR0047 "The structure of the version cannot have a maintenance project!"
		#define STR0048 "Attention!"
		#define STR0049 "Open"
		#define STR0050 "Status"
		#define STR0051 "Incorporated"
		#define STR0052 "Closed"
		#define STR0053 "Under Maintenance"
		#define STR0054 "Blocked"
		#define STR0055 "Search"
		#define STR0056 "View"
		#define STR0057 "Add"
		#define STR0058 "Edit"
		#define STR0059 "Delete"
		#define STR0060 "Structure"
		#define STR0061 "Caption"
		#define STR0062 "No"
		#define STR0063 "Only approval"
		#define STR0064 "Only .CH"
		#define STR0065 "Open without table addition"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Registo de Vers�es", "Cadastro de Vers�es" )
		#define STR0002 "Aten��o"
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Esta vers�o n�o pode ser exclu�da, pois possui uma estrutura vinculada", "Esta vers�o n�o pode ser exclu�da pois possui uma estrutura vinculada" )
		#define STR0004 "Sair"
		#define STR0005 "Aten��o"
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Esta vers�o n�o pode ser exclu�da, pois est� em uso nas tabelas de movimento", "Esta vers�o n�o pode ser exclu�da pois est� em uso nas tabelas de movimento" )
		#define STR0007 "Sair"
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Estrutura de Vers�es", "Estrutura de Versoes" )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Vers�o : ", "Versao : " )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Anexa pacote", "Anexa Pacote" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Exclui pacote", "Exclui Pacote" )
		#define STR0012 "Visualiza"
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Anexa projecto", "Anexa Projeto" )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Exclui projecto", "Exclui Projeto" )
		#define STR0015 "Pesquisa"
		#define STR0016 "Recortar"
		#define STR0017 "Colar"
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Limpa �rea tempor�ria", "Limpa area temporaria" )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Op��es", "Opcoes" )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "A construir estrutura...", "Construindo Estrutura..." )
		#define STR0021 "Pacote : "
		#define STR0022 "Aten��o '"
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "Este pacote n�o pode se inserido, pois est� em outra estrutura.", "Este pacote n�o pode se inserido pois est� inserido em outra estrutura !" )
		#define STR0024 "Pesquisar"
		#define STR0025 "Visualizar"
		#define STR0026 "Pesquisar"
		#define STR0027 "Visualizar"
		#define STR0028 If( cPaisLoc $ "ANG|PTG", "Projecto : ", "Projeto : " )
		#define STR0029 "Aten��o '"
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "Este projecto n�o pode se inserido, pois est� em outra estrutura.", "Este projeto n�o pode se inserido pois est� inserido em outra estrutura !" )
		#define STR0031 "Pacote"
		#define STR0032 If( cPaisLoc $ "ANG|PTG", "Projecto", "Projeto" )
		#define STR0033 "Pacote"
		#define STR0034 If( cPaisLoc $ "ANG|PTG", "Projecto", "Projeto" )
		#define STR0035 If( cPaisLoc $ "ANG|PTG", "Pesquisar entidade", "Pesquisar Entidade" )
		#define STR0036 "Entidade"
		#define STR0037 "Chave"
		#define STR0038 "Pesquisa"
		#define STR0039 If( cPaisLoc $ "ANG|PTG", "Projecto : ", "Projeto : " )
		#define STR0040 "Pacote : "
		#define STR0041 "Pacote : "
		#define STR0042 If( cPaisLoc $ "ANG|PTG", "Aten��o", "Atencao" )
		#define STR0043 "Sim"
		#define STR0044 If( cPaisLoc $ "ANG|PTG", "Todos os dados da �rea tempor�ria ser�o perdidos. Confirma ?", "Todos os dados da area temporaria serao perdidos. Confirma ?" )
		#define STR0045 If( cPaisLoc $ "ANG|PTG", "A estrutura da vers�o deve possuir um projecto de manuten��o.", "A estrutura da vers�o deve possuir um projeto de manuten��o !" )
		#define STR0046 If( cPaisLoc $ "ANG|PTG", "Aten��o!", "Aten��o !" )
		#define STR0047 If( cPaisLoc $ "ANG|PTG", "A estrutura da vers�o n�o pode possuir mais de um projecto de manuten��o.", "A estrutura da vers�o n�o pode possuir mais de um projeto de manuten��o !" )
		#define STR0048 If( cPaisLoc $ "ANG|PTG", "Aten��o!", "Aten��o !" )
		#define STR0049 "Aberta"
		#define STR0050 "Situa��o"
		#define STR0051 "Incorporada"
		#define STR0052 "Fechada"
		#define STR0053 "Em manuten��o"
		#define STR0054 "Bloqueada"
		#define STR0055 "Pesquisar"
		#define STR0056 "Visualizar"
		#define STR0057 "Incluir"
		#define STR0058 "Alterar"
		#define STR0059 "Excluir"
		#define STR0060 "Estrutura"
		#define STR0061 "Legenda"
		#define STR0062 If( cPaisLoc $ "ANG|PTG", "N�o", "Nao" )
		#define STR0063 "S� aprova��o"
		#define STR0064 "Apenas .CH"
		#define STR0065 "Aberto sem incl. de tabela"
	#endif
#endif
