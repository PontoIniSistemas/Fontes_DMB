#INCLUDE "PROTHEUS.CH"
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �P1P2TXT   �Autor  �Ronaldo Ricardo     � Data �  28/10/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cria um arquivo TXT com os produtos do cadastro para atender��� 
���          �exigencias legais dos estados AM, ES, MA, MG, SC.           ���
�������������������������������������������������������������������������͹��
���Uso       � AP7                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function P1P2TXT()

//��������������������������������������������������������������Ŀ
//� Define Variaveis                                             �
//����������������������������������������������������������������
Local cCadastro := OemToAnsi("Arquivo Eletronico")
Local nOpca     :=  0
Local aSays     := {}
Local aButtons  := {}
Local aRegs     := {} 
Local cPerg     := "P1P2MG"

//����������������������������������������Ŀ
//� Variaveis utilizadas para parametros   �
//� mv_par01            // Produto de      �
//� mv_par02            // Produto ate     �
//� mv_par03            // Grupo de        �
//� mv_par04            // Grupo ate       �
//������������������������������������������

//������������������������������������Ŀ
//� Verifica as perguntas selecionadas �
//��������������������������������������
AADD(aRegs,{cPerg,"01",OemToAnsi("Produto de ")	,OemToAnsi("Produto de "),OemToAnsi("Produto de "),"MV_CH1" ,"C",15,0,0,"G",""                    ,"mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SB1",""})
AADD(aRegs,{cPerg,"02",OemToAnsi("Produto ate "),OemToAnsi("Produto ate "),OemToAnsi("Produto ate ")	,"MV_CH2" ,"C",15,0,0,"G","(mv_par02>=mv_par01)","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SB1",""})
AADD(aRegs,{cPerg,"03",OemToAnsi("Grupo de "),OemToAnsi("Grupo de "),OemToAnsi("Grupo de "),"MV_CH3" ,"C",04,0,0,"G",""                    ,"mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SBM",""})
AADD(aRegs,{cPerg,"04",OemToAnsi("Grupo ate "),OemToAnsi("Grupo ate "),OemToAnsi("Grupo ate "),"MV_CH4" ,"C",04,0,0,"G","(mv_par04>=mv_par03)","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","SA3",""})
AADD(aRegs,{cPerg,"05",OemToAnsi("Inscricao Municipal"),OemToAnsi("Inscricao Municipal"),OemToAnsi("Inscricao Municipal"),"MV_CH5" ,"C",14,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","",""})
AADD(aRegs,{cPerg,"06",OemToAnsi("Nome do arquivo:"),OemToAnsi("Nome do arquivo:"),OemToAnsi("Nome do arquivo:"),"MV_CH6" ,"C",08,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","",""})

ValidPerg(aRegs,cPerg)

Pergunte(cPerg,.F.)

//������������������������������������Ŀ
//� Verifica as perguntas selecionadas �
//��������������������������������������
Pergunte(cPerg,.F.)

AADD(aSays,OemToAnsi("Este programa tem como objetivo gerar um arquivo eletronico com base no cadastro "))
AADD(aSays,OemToAnsi("de produtos."))
AADD(aSays,OemToAnsi("Insira o disquete no Drive A:"))

AADD(aButtons, { 5,.T.,{|| Pergunte(cPerg,.T. ) } } )
AADD(aButtons, { 1,.T.,{|o| nOpca:= 1, If( Confirma(), o:oWnd:End(), nOpca:=0 ) }} )
AADD(aButtons, { 2,.T.,{|o| o:oWnd:End() }} )
FormBatch( cCadastro, aSays, aButtons )

If nOpca == 1
	Processa({|lEnd| ProcTXT(),OemToAnsi("Processando.....")})		
Endif

Return(.T.)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Confirma  �Autor  �Ronaldo Ricardo     � Data �  28/10/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Confirma execucao da rotina								  ���
�������������������������������������������������������������������������͹��
���Uso       � AP7                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Confirma()

Return(MsgYesNo(OemToAnsi("Confirma geracao do arquivo eletronico ?"),OemToAnsi("Arquivo Eletronico"))) 
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ProcTXT   �Autor  �Ronaldo Ricardo     � Data �  28/10/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Efetua montagem do arquivo TXT.							  ���
�������������������������������������������������������������������������͹��
���Uso       � AP7                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Processa()

Local _nPreco, _nVlUnit
Local cTabPad	:= 	Iif(GetMv("MV_TABPAD")$"1|2|3|4|5|6|7|8|9",GetMv("MV_TABPAD"),"1")
Local cDiret	:= "A:\"
Local xFim 		:= CHR(13)+CHR(10)       // Caracter(es) para final de linha
Local cArq 		:= IIF(Upper(Right(Alltrim(mv_par06),4))==".TXT",Alltrim(mv_par06),Alltrim(mv_par06)+".TXT")
Local cLinha	
Local _cTES
Local _nAliq
Local cInscMun := mv_par05
Local cPar1		:= GetMv("MV_TESSAI")
Local cPar2		:= GetMv("MV_ALIQISS")
Local cPar3		:= GetMv("MV_ICMPAD")

Private nHdl

//���������������������������������������������������������������������Ŀ
//� Cria Arquivo Fisicamente no Caminho Selecionado.                    �
//�����������������������������������������������������������������������
nHdl	:=	fCreate(cDiret+cArq)
If nHdl==-1
	MsgAlert("Nao foi possivel criar o arquivo!","Arquivo Eletronico")
	Return
Endif

//����������������������������������Ŀ
//� Verificando Inscricao Municipal  �
//������������������������������������
cInscMun := Alltrim(StrTran(cInscMun,".",""))
cInscMun := Alltrim(StrTran(cInscMun,"-",""))
cInscMun := Alltrim(StrTran(cInscMun,",",""))

//�����������������������������Ŀ
//� Montando registro tipo P1   �
//�������������������������������
cLinha := "P1" 		//Tipo do registro 
cLinha += StrZero(Val(SM0->M0_CGC),14)		//CNPJ
cLinha += Alltrim(SM0->M0_INSC) 	+ Space(14-Len(Alltrim(SM0->M0_INSC)))		//Inscricao Estadual
cLinha += Alltrim(cInscMun)		 	+ Space(14-Len(Alltrim(cInscMun)))			//Inscricao Municipal
cLinha += Alltrim(SM0->M0_NOMECOM)	+ Space(50-Len(Alltrim(SM0->M0_NOMECOM)))	//Razao Social
cLinha += Space(32) + xFim		//Brancos + Fim de Arquivo

//���������������������������������Ŀ
//� Gravando registro tipo P1       �
//�����������������������������������
If FWrite(nHdl,cLinha,Len(cLinha)) != Len(cLinha)
	MsgAlert("Ocorreu um erro na geracao do registro tipo P1","Arquivo Eletronico")
	Return
EndIf

DbSelectArea("SB1")
DbSetOrder(1)
DbSeek(xFilial("SB1"))
ProcRegua(RecCount())	   
While !SB1->(Eof()) .And. SB1->B1_FILIAL == xFilial("SB1")

    IncProc()
    
	//�����������������������������Ŀ
	//� Filtra os produtos		    �
	//�������������������������������
    If  (SB1->B1_COD   < mv_par01 .Or. SB1->B1_COD   > mv_par02) .Or.;
    	(SB1->B1_GRUPO < mv_par03 .Or. SB1->B1_GRUPO > mv_par04)
		DbSelectArea("SB1")    	
    	DbSkip()
    	Loop
    EndIf

	//�����������������������������Ŀ
	//� Busca preco				    �
	//�������������������������������
	_nPreco := 0    
	DbSelectArea("SB0")	    
	DbSetOrder(1)
	If DbSeek(xFilial("SB0")+SB1->B1_COD)
		_nPreco := &("SB0->B0_PRV" + cTabPad)
		_nVlUnit:= _nPreco 
	EndIf
	_nPreco := StrTran(StrTran(Str(_nPreco,13,2)," ","0"),".","")
	
	//�����������������������������Ŀ
	//� Busca Situacao Tributaria   �
	//�������������������������������
	_cTES     := IIF(Empty(SB1->B1_TS),cPar1,SB1->B1_TS)
	_cSitTrib := SitTrib(_cTES)

	//�����������������������������Ŀ
	//� Busca Aliquota			    �
	//�������������������������������
	DbSelectArea("SA1")		//Deve posicionar no cliente
	DbSetOrder(1)
	If !DbSeek(xFilial("SA1")+GetNewPar("MV_CLIPAD","999999")+GetNewPar("MV_LOJAPAD","01"))
	   MsgAlert("Nao foi encontrado o cliente padrao!","Verifique")
	   Return
	EndIf
	If _cSitTrib == "F"		//Se for substituicao busca aliquota 
		_nAliq := LjIcmsSol(_nVlUnit,1,_nVlUnit)[3]		
	Else
		If _cSitTrib == "S"		//Se for servico busca pelo B1_ALIQISS ou MV_ALIQISS
			_nAliq := IIF(Empty(SB1->B1_ALIQISS),cPar2,SB1->B1_ALIQISS)		
		Else		//caso contrario, busca do B1_PICM ou MV_ICMPAD
			_nAliq := IIF(Empty(SB1->B1_PICM),cPar3,SB1->B1_PICM)				
		EndIf
	EndIf
	_nAliq := StrTran(StrTran(Str(_nAliq,05,2)," ","0"),".","")

	//�����������������������������Ŀ
	//� Montando registro tipo P2   �
	//�������������������������������
    cLinha := "P2"
	cLinha += StrZero(Val(SM0->M0_CGC),14)		//CNPJ
	cLinha += Alltrim(SubStr(SB1->B1_COD,1,14)) + Space(14-Len(Alltrim(SubStr(SB1->B1_COD,1,14))))	//Codigo do Produto
	cLinha += Alltrim(SB1->B1_DESC) + Space(50-Len(Alltrim(SB1->B1_DESC)))	//Descricao do Produto
	cLinha += Alltrim(SB1->B1_UM) + Space(6-Len(Alltrim(SB1->B1_UM)))			//Unidade de Medida
	cLinha += Alltrim(_cSitTrib)	//Situacao Tributaria
	cLinha += _nAliq				//Aliquota
	cLinha += _nPreco				//Valor Unitario	
	cLinha += Space(23) + xFim		//Brancos + Fim de Arquivo

	//���������������������������������Ŀ
	//� Gravando registro tipo P1       �
	//�����������������������������������
	If FWrite(nHdl,cLinha,Len(cLinha)) != Len(cLinha)
		MsgAlert("Ocorreu um erro na geracao do registro tipo P2 do produto : "+SB1->B1_COD,"Arquivo Eletronico")
		Return
	EndIf
	
	DbSelectArea("SB1")
	DbSkip()

End

fClose(nHdl)

MsgInfo("Arquivo gerado com sucesso!","Arquivo Eletronico")

Return
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �SitTrib   �Autor  �Ronaldo Ricardo     � Data �  28/10/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Busca situacao tributaria dos produtos/servicos.			  ���
�������������������������������������������������������������������������͹��
���Uso       � AP7                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function SitTrib(_cTS)

Local _cRet

//����������������������������������������������������������Ŀ
//� Tabela usada na portaria No. 3492 de 23/09/2002 - SEF/MG �
//� I  -  Isento 											 �
//� N  -  Nao tributado  									 �
//� F  -  Substituicao tributaria  							 �
//� T  -  Tributado pelo ICMS  								 �
//� S  -  Tributado pelo ISSQN 								 �
//������������������������������������������������������������

DbSelectArea("SF4")
DbSetOrder(1)
If DbSeek(xFilial("SF4")+_cTS)
	
	If SF4->F4_ISS == "S"		//ISS
		_cRet := 'S' 
		
	ElseIf SB1->B1_PICMRET > 0	//Substituicao tributaria 
		_cRet := "F"
		
	ElseIf SF4->F4_BASEICM > 0 .And. SF4->F4_BASEICM < 100
		_cRet := 'T' 
		
	ElseIf SF4->F4_LFICM == "I"		//Isento
		_cRet:= "I"                 
		
	ElseIf SF4->F4_LFICM == "N"		//Nao tributado
		_cRet := "N"
		
	Else
		_cRet := 'T'
	EndIf
Else
	MsgAlert("Nao foi encontrado o Tipo de Saida : "+_cTS,"Arquivo Eletronico")	
	_cRet := 'T'
EndIf


Return(_cRet)
/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ValidPerg �Autor  �Ronaldo Ricardo     � Data �  28/10/03   ���
�������������������������������������������������������������������������͹��
���Desc.     �Monta perguntas do processamento.							  ���
�������������������������������������������������������������������������͹��
���Uso       � AP7                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ValidPerg(aRegs,cPerg)

Local j
Local i

sAlias := Alias()
DbSelectArea("SX1")
DbSetOrder(1)
cPerg := PADR(cPerg,6)

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
         If j <= Len(aRegs[i])		
				FieldPut(j,aRegs[i,j])
			EndIf	
		Next
		MsUnlock()
		dbCommit()
	Endif
Next
DbSelectArea(sAlias)

Return
