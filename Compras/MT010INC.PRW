/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Funcao    � MT010INC � Autor � Andre Luis Almeida    � Data � 05/09/06 ���
�������������������������������������������������������������������������Ĵ��
���Descricao � Ponto de Entrada executado apos a Inclusao do SB1          ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Generico                                                   ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
USER FUNCTION MT010INC()
//////////////////////////////////////////////////////////////////////////
///  Inclusao automatica do SB5  -  Andre Luis Almeida  -  05/09/2006  ///
//////////////////////////////////////////////////////////////////////////
/*(aAreaSB1 := SB1->(Getarea())
DbSelectArea("SB5")
RecLock("SB5",.t.)
	SB5->B5_FILIAL := xFilial("SB5")
	SB5->B5_COD    := SB1->B1_COD
	SB5->B5_CEME   := SB1->B1_DESC
	SB5->B5_CODCAI := SB1->B1_GRUPO
MsUnlock()                         
SB1->(RestArea(aAreaSB1))*/
//////////////////////////////////////////////////////////////////////////
Return .t.
