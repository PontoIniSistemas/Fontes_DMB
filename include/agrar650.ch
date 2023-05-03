#ifdef SPANISH
	#define STR0001 "Fardos por bloques"
	#define STR0002 "Datos gerales"
	#define STR0003 "Fardo"
	#define STR0004 "Tipo"
	#define STR0005 "Peso"
	#define STR0006 "Prensa"
	#define STR0007 "Peso total"
	#define STR0008 "Total de fardos"
#else
	#ifdef ENGLISH
		#define STR0001 "Bales per Blocks"
		#define STR0002 "General Data"
		#define STR0003 "Bale"
		#define STR0004 "Type"
		#define STR0005 "Weight"
		#define STR0006 "Press"
		#define STR0007 "Total Weight"
		#define STR0008 "Total of Bales"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Fardos por blocos", "Fardos por Blocos" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Dados gerais", "Dados Gerais" )
		#define STR0003 "Fardo"
		#define STR0004 "Tipo"
		#define STR0005 "Peso"
		#define STR0006 "Prensa"
		#define STR0007 "Peso Total"
		#define STR0008 "Total de Fardos"
	#endif
#endif
