#ifdef SPANISH
	#define STR0001 "Extracto SLA"
	#define STR0002 "Este informe debe mostrar el extracto SLA de las llamadas regist. en el sistema."
	#define STR0003 "Equipos"
	#define STR0004 "Prod."
	#define STR0005 "Llamadas"
	#define STR0006 "Total Sintetico"
	#define STR0007 "Cliente"
	#define STR0008 "Descrip."
	#define STR0009 "Atrasado"
	#define STR0010 "Atraso(Dias)"
	#define STR0011 "Analista"
	#define STR0012 "Resp. SLA"
	#define STR0013 "Nomb Resp. SLA"
	#define STR0014 "Total de Llamadas "
	#define STR0015 "Equipo"
	#define STR0016 "Nomb"
	#define STR0017 "Cant. llamadas atrasadas"
	#define STR0018 "Cant. llamadas al dia"
	#define STR0019 "Cant. total llamadas"
	#define STR0020 "Resultados por equipo"
	#define STR0021 "No"
	#define STR0022 "Si"
	#define STR0023 ""
	#define STR0024 "Fch. Cierre"
	#define STR0025 "Hr. Cierre"
	#define STR0026 "Fecha Inicial"
	#define STR0027 "Hora Inicial"
	#define STR0028 "Fecha Final"
	#define STR0029 "Hora Final"
	#define STR0030 "Duracion"
	#define STR0031 "Registros de SLA"
	#define STR0032 "Atraso"
	#define STR0033 "Fch.Ul Pausa SLA"
	#define STR0034 "Hr.Ul Pausa SLA"
	#define STR0035 "Fch.Enc SLA"
	#define STR0036 "Hr.Enc SLA"
	#define STR0037 "Fch.Enc CH"
	#define STR0038 "Hr.Enc CH"
	#define STR0039 "% SLA"
	#define STR0040 "Entidad Resp."
	#define STR0041 "Contacto Resp."
#else
	#ifdef ENGLISH
		#define STR0001 "SLA Statement"
		#define STR0002 "This report must show SLA statement of calls registered in the system."
		#define STR0003 "Teams"
		#define STR0004 "Product"
		#define STR0005 "Calls"
		#define STR0006 "Total Synthetic Analysis"
		#define STR0007 "Customer"
		#define STR0008 "Description"
		#define STR0009 "Overdue"
		#define STR0010 "Overdue (Days)"
		#define STR0011 "Analyst"
		#define STR0012 "Resp. SLA"
		#define STR0013 "Resp.Name SLA"
		#define STR0014 "Total of calls "
		#define STR0015 "Team"
		#define STR0016 "Name"
		#define STR0017 "Amt.of overdue calls"
		#define STR0018 "Amt.of up-to-date calls"
		#define STR0019 "Total of calls"
		#define STR0020 "Results by teams"
		#define STR0021 "No"
		#define STR0022 "Yes"
		#define STR0023 ""
		#define STR0024 "Concusion Dt:"
		#define STR0025 "Conclusion. Hr:"
		#define STR0026 "Start Date"
		#define STR0027 "Start Time"
		#define STR0028 "End Date"
		#define STR0029 "End Time"
		#define STR0030 "Duration:"
		#define STR0031 "SLA records"
		#define STR0032 "Delay"
		#define STR0033 "Dt. Lt SLA Pause"
		#define STR0034 "Tm. Lt SLA Pause"
		#define STR0035 "Dt. SLA Clos"
		#define STR0036 "Tm. SLA Clos"
		#define STR0037 "Dt. Cl Clos"
		#define STR0038 "Tm. Cl Clos"
		#define STR0039 "% SLA"
		#define STR0040 "Resp. Entity"
		#define STR0041 "Resp. Contact"
	#else
		#define STR0001 "Extrato de SLA"
		#define STR0002 "Este relat�rio dever� exibir o extrato de SLA dos chamados registrados no sistema."
		#define STR0003 "Equipes"
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Artigo", "Produto" )
		#define STR0005 "Chamados"
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "A totalizar sint�tico.", "Totalizado Sint�tico" )
		#define STR0007 "Cliente"
		#define STR0008 "Descri��o"
		#define STR0009 "Atrasado"
		#define STR0010 "Atraso(Dias)"
		#define STR0011 "Analista"
		#define STR0012 "Resp. SLA"
		#define STR0013 "Nome Resp. SLA"
		#define STR0014 "Total de Chamados "
		#define STR0015 "Equipe"
		#define STR0016 "Nome"
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Qtde. de chamados em atraso.", "Qtde de chamados em atraso" )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Qtde. de chamados em dia.", "Qtde de chamados em dia" )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Qtde. total de chamados.", "Qtde total de chamados" )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Resultados por Equipes", "Resultados por equipes" )
		#define STR0021 "N�o"
		#define STR0022 "Sim"
		#define STR0023 ""
		#define STR0024 "Dt. Encerramento"
		#define STR0025 "Hr. Encerramento"
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "Data In�cio", "Data Inicio" )
		#define STR0027 If( cPaisLoc $ "ANG|PTG", "Hora In�cio", "Hora Inicio" )
		#define STR0028 "Data Fim"
		#define STR0029 "Hora Fim"
		#define STR0030 "Dura��o"
		#define STR0031 If( cPaisLoc $ "ANG|PTG", "Registos de SLA", "Registros de SLA" )
		#define STR0032 "Atraso"
		#define STR0033 "Dt.Ul Pausa SLA"
		#define STR0034 "Hr.Ul Pausa SLA"
		#define STR0035 If( cPaisLoc $ "ANG|PTG", "Dt.Enc.SLA", "Dt.Enc SLA" )
		#define STR0036 If( cPaisLoc $ "ANG|PTG", "Hr.Enc.SLA", "Hr.Enc SLA" )
		#define STR0037 If( cPaisLoc $ "ANG|PTG", "Dt.Enc.CH", "Dt.Enc CH" )
		#define STR0038 If( cPaisLoc $ "ANG|PTG", "Hr.Enc.CH", "Hr.Enc CH" )
		#define STR0039 "% SLA"
		#define STR0040 "Entidade Resp."
		#define STR0041 If( cPaisLoc $ "ANG|PTG", "Contacto Resp.", "Contato Resp." )
	#endif
#endif
