#ifdef SPANISH
	#define STR0001 "Indice de FCS"
	#define STR0002 "Indices de FCS"
	#define STR0003 "Nombre"
	#define STR0004 "Anual"
	#define STR0005 "Semestral"
	#define STR0006 "Cuatrimestral"
	#define STR0007 "Trimestral"
	#define STR0008 "Bimestral"
	#define STR0009 "Mensual"
	#define STR0010 "Quincenal"
	#define STR0011 "Semanal"
	#define STR0012 "Diaria"
	#define STR0013 "Suma"
	#define STR0014 "Promedio"
	#define STR0015 "Editable"
#else
	#ifdef ENGLISH
		#define STR0001 "FCS indicator "
		#define STR0002 "FCS indicators "
		#define STR0003 "Name"
		#define STR0004 "Annual"
		#define STR0005 "Semesterly"
		#define STR0006 "Four-month periods"
		#define STR0007 "Quaterly "
		#define STR0008 "Bi-monthly"
		#define STR0009 "Monthly"
		#define STR0010 "Fortnightly"
		#define STR0011 "Weekly "
		#define STR0012 "Daily "
		#define STR0013 "Sum"
		#define STR0014 "Average"
		#define STR0015 "Editable"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Indicador De Fcs", "Indicador de FCS" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Indicadores De Fcs", "Indicadores de FCS" )
		#define STR0003 "Nome"
		#define STR0004 "Anual"
		#define STR0005 "Semestral"
		#define STR0006 "Quadrimestral"
		#define STR0007 "Trimestral"
		#define STR0008 "Bimestral"
		#define STR0009 "Mensal"
		#define STR0010 "Quinzenal"
		#define STR0011 "Semanal"
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Di�ria", "Diaria" )
		#define STR0013 "Somat�rio"
		#define STR0014 "M�dia"
		#define STR0015 "Edit�vel"
	#endif
#endif
