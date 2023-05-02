// Programa:		ATUMOEDAS
// Autor:		Antonio Carlos Poloni
// Data:		01/10/2006
// Objeto:		Atualiza e Projeta Moedas/Cambio
// Uso:			Modulos Contabilidade Gerencial e Financeiro
// Especificações: 	Colocar as linhas abaixo no AP8SRV.INI
// [ONSTART]
// jobs=Moedas
// RefreshRate=86400
//
// [Moedas]
// main=u_AtuMoedas
// Environment=Environment


#include 'protheus.ch'

User Function AtuMoedas()

Private lAuto		:= .F.
Private dData
Private nValDolar, nValYen, nValEuro
Private nValReal	:= 1.000000
Private nValUfir	:= 1.064100
Private nN		:= 0
Private nS1, nS2, nS3
Private nI1, nI2, nI3

If	Select('SX2') == 0					//Testa se esta sendo rodado do menu
	RPCSetType( 3 )						//Não consome licensa de uso
	RpcSetEnv('01','01',,,,GetEnvServer(),{ "SZ7" })	//Ajustado para a empresa 01 e filial 01 
	sleep( 5000 )						//Aguarda 5 segundos para que as jobs subam.
	ConOut('Moedas - Atualizacao de Moedas... '+Dtoc(DATE())+' - '+Time())
	lAuto := .T.
EndIf

If	( ! lAuto )
	LjMsgRun(OemToAnsi('Atualizando Moedas On-line pelo Banco Central'),,{|| xExecMoeda()} )
Else
	xExecMoeda()
EndIf

If	( lAuto )
	RpcClearEnv()						//Libera o Environment
	ConOut('Moedas Atualizadas. '+Dtoc(DATE())+' - '+Time() )
EndIf
Return


Static Function xExecMoeda()

Local nPass, cFile, cTexto, nLinhas, j, cLinha, cdata, cCompra, cVenda, W

For nPass := 5 to 0 step -1					//Refaz os ultimos 6 dias, caso algum dia falhou a conexao
	dDataRef := dDataBase - nPass

	If	( Dow(dDataRef) == 1 )				//Se for domingo
		cFile := Dtos(dDataRef - 2)+'.csv'
	ElseIf	Dow(dDataRef) == 7  				//Se for sabado
		cFile := Dtos(dDataRef - 1)+'.csv'
	Else							//Se for dia normal
		cFile := Dtos(dDataRef)+'.csv'	
	EndIf
	
	cTexto  := HttpGet('http://www5.bcb.gov.br/Download/'+cFile)
	If	( lAuto )
		ConOut('DownLoading from www5.bcb.gov.br/Download/'+cFile+' In '+Dtoc(DATE())+' On '+Time())
	EndIf

	If ! Empty(cTexto)
		nLinhas := MLCount(cTexto, 81)
		For j	:= 1 to nLinhas
			cLinha	:= Memoline(cTexto,81,j)
			cData  	:= Substr(cLinha,1,10)
			cVenda  := StrTran(Substr(cLinha,37,14),',','.')

			If	( Substr(cLinha,12,3)=='220' )	//Dolar
				dData		:= Ctod(cData)
 				nValDolar	:= Val(cVenda)
			EndIf

			If	( Substr(cLinha,12,3)=='470' )	//Yen
 				nValYen		:= Val(cVenda)
			EndIf
			
			If	( Substr(cLinha,12,3)=='978' )	//Euro
 				nValEuro	:= Val(cVenda)
			EndIf
		Next
	Endif
	GravaDados()
Next
          
If	( Dow(dData) == 6 )					//Se for sexta
	For W := 1 to 2
		dData ++
		GravaDados()	
	Next
EndIf	

Regressao()							//Executa a rotina que determina os Eixos X e Y
For K := 1 to 10						//Projeta para 10 dias seguintes
	nN++
	dData ++    
	nValDolar := (nN * nS1) + nI1				//Valor projetado do Dolar
	nValEuro  := (nN * nS2) + nI2				//Valor projetado do Euro
	nValYen	  := (nN * nS3) + nI3				//Valor Projetado do Yen 
	Gravadados()
Next
Return


Static Function GravaDados()

DbSelectArea("SM2")						//Grava Moedas
SM2->(DbSetorder(1))
  	
	If SM2->(DbSeek(Dtos(dData)))
		Reclock('SM2',.F.)
	Else
		Reclock('SM2',.T.)
			SM2->M2_DATA	:= dData
	EndIf
	SM2->M2_MOEDA1	:= nValReal				//Real
	SM2->M2_MOEDA2	:= nValDolar				//Dolar
	SM2->M2_MOEDA3	:= nValUfir				//Ufir
	SM2->M2_MOEDA4	:= nValEuro				//Euro
	SM2->M2_MOEDA5	:= nValYen				//Yen
	SM2->M2_INFORM	:= "S"
	MsUnlock('SM2')

DbSelectArea('CTP')						//Grava Cambio	
CTP->(DbSetorder(1))
	
	If CTP->(DbSeek(xfilial('CTP')+Dtos(dData)+'01'))	//Real
		RecLock('CTP',.F.)		
	Else
		RecLock('CTP',.T.)
			CTP->CTP_DATA	:= dData
	EndIf
	CTP->CTP_MOEDA	:= '01'
	CTP->CTP_TAXA	:= nValReal
	CTP->CTP_BLOQ	:= '2'
	MsUnlock('CTP')
	
	If CTP->(DbSeek(xfilial('CTP')+Dtos(dData)+'02'))	//Dolar
		RecLock('CTP',.F.)
	Else
		RecLock('CTP',.T.)
			CTP->CTP_DATA	:= dData
	EndIf
	CTP->CTP_MOEDA	:= '02'
	CTP->CTP_TAXA	:= nValDolar
	CTP->CTP_BLOQ	:= '2'
	MsUnlock('CTP')
	
	If CTP->(DbSeek(xfilial('CTP')+Dtos(dData)+'03'))	//Ufir
		RecLock('CTP',.F.)
	Else
		RecLock('CTP',.T.)
			CTP->CTP_DATA	:= dData
	EndIf
	CTP->CTP_MOEDA	:= '03'
	CTP->CTP_TAXA	:= nValUfir
	CTP->CTP_BLOQ	:= '2'
	MsUnlock('CTP')
	
	If CTP->(DbSeek(xfilial('CTP')+Dtos(dData)+'04'))	//Euro
		RecLock('CTP',.F.)
	Else
		RecLock('CTP',.T.)
			CTP->CTP_DATA	:= dData
	EndIf
	CTP->CTP_MOEDA	:= '04'
	CTP->CTP_TAXA	:= nValEuro
	CTP->CTP_BLOQ	:= '2'
	MsUnlock('CTP')
	
	If CTP->(DbSeek(xfilial('CTP')+Dtos(dData)+'05'))	//Yen
		RecLock('CTP',.F.)
	Else
		RecLock('CTP',.T.)
			CTP->CTP_DATA	:= dData
	EndIf
	CTP->CTP_MOEDA	:= '05'
	CTP->CTP_TAXA	:= nValYen
	CTP->CTP_BLOQ	:= '2'
	MsUnlock('CTP')

Return


Static Function Regressao()

Local nSX          := 0
Local nSY1         := 0
Local nSY2         := 0
Local nSY3         := 0
local nSXY1	   := 0
Local nSXY2        := 0
Local nSXY3        := 0
Local nSXX         := 0
Local mPass, nMedx, nMedY1, nMedY2, nMedY3

For mPass := 14 to 0 step -1					//Seleciona os Ultimos 15 Dias das Moedas
	dDataRef	:= dData - mPass
	DbSelectArea("SM2")
	SM2->(DbSetorder(1))

	If SM2->(DbSeek(Dtos(dDataRef)))         		//Pesquisa
		nN	:= nN	 + 1				//Quantidade de Variãveis
		nSX	:= nSX   + nN				//Somatoria de X
		nSY1	:= nSY1  + SM2->M2_MOEDA2		//Somatoria de Y Dolar
		nSY2	:= nSY2  + SM2->M2_MOEDA4		//Somatoria de Y Euro
		nSY3	:= nSY3  + SM2->M2_MOEDA5		//Somatoria de Y Yen
		nSXY1	:= nSXY1 + (nN*SM2->M2_MOEDA2)		//Somatoria de X * Y Dolar
		nSXY2	:= nSXY2 + (nN*SM2->M2_MOEDA4)		//Somatoria de X * Y Euro
		nSXY3	:= nSXY3 + (nN*SM2->M2_MOEDA5)		//Somatoria de X * Y Yen
		nSXX	:= nSXX  + (nN*nN)			//Somatoria de X Quadrado
	EndIf

Next
	
nMedX	:= nSX 	/ nN						//Media de X
nMedY1	:= nSY1 / nN						//Media de Y Dolar
nMedY2	:= nSY2 / nN						//Media de Y Euro
nMedY3	:= nSY3 / nN						//Media de Y yen

// DOLAR
nS1	:= (nN*nSXY1 - (nSX*nSY1)) / (nN*nSXX-(nSX*nSX))	//Coeficiente de X Na Equação
nI1	:= nMedY1 - (nS1*nMedX)					//Ponto que a reta toca Eixo X

// EURO
nS2	:= (nN*nSXY2 - (nSX*nSY2)) / (nN*nSXX-(nSX*nSX))	//Coeficiente de X Na Equação
nI2	:= nMedY2 - (nS2*nMedX)					//Ponto que a reta toca Eixo X

// YEN
nS3	:= (nN*nSXY3 - (nSX*nSY3)) / (nN*nSXX-(nSX*nSX))	//Coeficiente de X Na Equação
nI3	:= nMedY3 - (nS3*nMedX)					//Ponto que a reta toca Eixo X

Return