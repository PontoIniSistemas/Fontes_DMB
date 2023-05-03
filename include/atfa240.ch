#ifdef SPANISH
	#define STR0001 "Buscar"
	#define STR0002 "Visualizar"
	#define STR0003 "Clasificar"
	#define STR0004 "Clasificacion de Activos Inmovilizados"
	#define STR0005 "¿Modificar el Codigo?"
	#define STR0006 "Clasificacion de Activos Inmovilizados"
	#define STR0007 "Modificacion de Codigos de Bienes"
	#define STR0008 "Codigo Base Origen"
	#define STR0009 "Nuevo Codigo Base"
	#define STR0010 "Leyenda"
	#define STR0011 "Bien no Clasificado"
	#define STR0012 "Bien Clasificado"
	#define STR0013 "Bien totalmente dado de baja"
	#define STR0014 "Modulo SIGAATF desactualizado, por favor actualizar el ultimo update"
	#define STR0015 "La fecha de adquisicion del bien es igual o inferior a la fecha de bloqueo de movimiento: "
	#define STR0016 "Bien Planificado"
	#define STR0017 "Contr. de Terceros"
	#define STR0018 "Contr. en Terceros"
	#define STR0019 "Este bien ya se clasifico."
#else
	#ifdef ENGLISH
		#define STR0001 "Search"
		#define STR0002 "View"
		#define STR0003 "Classify"
		#define STR0004 "Classify Fixed Assets"
		#define STR0005 "Do you want to edit the Code?"
		#define STR0006 "Classify of Fixed Assets"
		#define STR0007 "Edit Assets Codes"
		#define STR0008 "Origin Base Code"
		#define STR0009 "New Base Code"
		#define STR0010 "Title"
		#define STR0011 "Asset not Classified"
		#define STR0012 "Asset Classified"
		#define STR0013 "Asset totally posted"
		#define STR0014 "SIGAATF module is outdated. Renew the last update."
		#define STR0015 "The asset acquisition date is equal to or earlier than the transaction stoppage date: "
		#define STR0016 "Planned Asset"
		#define STR0017 "Third Party Control"
		#define STR0018 "Control in Third Party"
		#define STR0019 "This asset is already classified."
	#else
		#define STR0001 "Pesquisar"
		#define STR0002 "Visualizar"
		#define STR0003 "Classificar"
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Classificação De Activos Imobilizados", "Classificação de Ativos Imobilizados" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Deseja Alterar O Código?", "Deseja alterar o Código?" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Classificação De Activos Imobilizados", "Classificacao de Ativos Imobilizados" )
		#define STR0007 "Alteraçäo dos Códigos dos Bens"
		#define STR0008 "Código Base Origem"
		#define STR0009 "Novo Código Base"
		#define STR0010 "Legenda"
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Artigo Não Classificado", "Bem nao Classificado" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Artigo Classificado", "Bem Classificado" )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Artigo totalmente expedido", "Bem totalmente baixado" )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Módulo SIGAATF desactualizado. Por favor, actualizar o último update.", "Modulo SIGAATF desatualizado, por favor atualizar o ultimo update" )
		#define STR0015 "A data de aquisição do bem é igual ou menor que a data de bloqueio de movimentação : "
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Bem Planeado", "Bem Planejado" )
		#define STR0017 "Contr. de Terceiros"
		#define STR0018 "Contr. em Terceiros"
		#define STR0019 "Este bem já foi classificado."
	#endif
#endif
