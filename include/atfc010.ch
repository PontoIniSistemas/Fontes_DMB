#ifdef SPANISH
	#define STR0001 "Consulta grafica de bienes depreciados"
	#define STR0002 "Buscar"
	#define STR0003 "Consultar"
	#define STR0004 "Periodo excede el maximo permitido para la consulta, que es un ano"
	#define STR0005 "Atencion"
	#define STR0006 "Depreciacion "
	#define STR0007 " en el periodo de "
	#define STR0008 " a "
	#define STR0009 "Lineas"
	#define STR0010 "Barras"
	#define STR0011 "Bienes Depreciados"
	#define STR0012 "Rotacion &-"
	#define STR0013 "Rotacion &+"
	#define STR0014 "Graba &BMP"
	#define STR0015 "&Imprime"
	#define STR0016 "Depreciacion"
	#define STR0017 "&Salir"
	#define STR0018 "Meses"
	#define STR0019 "Valores"
	#define STR0020 "No fue posible crear la serie"
	#define STR0021 "Consulta"
	#define STR0022 "&E-mail"
#else
	#ifdef ENGLISH
		#define STR0001 "Consulta gr�fica de bens depreciados"
		#define STR0002 "Pesquisa"
		#define STR0003 "Consultar"
		#define STR0004 "Per�do ultrapassa o m�ximo permitido para a consulta, que � um ano"
		#define STR0005 "Aten��o"
		#define STR0006 "Deprecia��o "
		#define STR0007 " no per�do de "
		#define STR0008 " a "
		#define STR0009 "Linhas"
		#define STR0010 "Barras"
		#define STR0011 "Bens Depreciados"
		#define STR0012 "Rota��o &-"
		#define STR0013 "Rota��o &+"
		#define STR0014 "Salva &BMP"
		#define STR0015 "&Imprime"
		#define STR0016 "Deprecia��o"
		#define STR0017 "&Sair"
		#define STR0018 "Meses"
		#define STR0019 "Valores"
		#define STR0020 "N�o foi poss�vel criar a s�rie"
		#define STR0021 "Consulta"
		#define STR0022 "&E-mail"
	#else
		#define STR0001 "Consulta gr�fica de bens depreciados"
		#define STR0002 "Pesquisa"
		#define STR0003 "Consultar"
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Per�odo ultrapassa o m�ximo permitido de um ano para a consulta", "Per�do ultrapassa o m�ximo permitido para a consulta, que � um ano" )
		#define STR0005 "Aten��o"
		#define STR0006 "Deprecia��o "
		#define STR0007 If( cPaisLoc $ "ANG|PTG", " no per�odo de ", " no per�do de " )
		#define STR0008 " a "
		#define STR0009 "Linhas"
		#define STR0010 "Barras"
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Artigos Depreciados", "Bens Depreciados" )
		#define STR0012 "Rota��o &-"
		#define STR0013 "Rota��o &+"
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Gravar &bmp", "Salva &BMP" )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "&imprimir", "&Imprime" )
		#define STR0016 "Deprecia��o"
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "&sair", "&Sair" )
		#define STR0018 "Meses"
		#define STR0019 "Valores"
		#define STR0020 "N�o foi poss�vel criar a s�rie"
		#define STR0021 "Consulta"
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "&e-mail", "&E-mail" )
	#endif
#endif
