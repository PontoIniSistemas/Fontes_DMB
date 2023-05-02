#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWEBSRV.CH"

/* ===============================================================================
WSDL Location    http://192.168.0.122:8080/CFGTABLE.apw?WSDL
Gerado em        04/12/11 12:31:22
Observa��es      C�digo-Fonte gerado por ADVPL WSDL Client 1.101007
                 Altera��es neste arquivo podem causar funcionamento incorreto
                 e ser�o perdidas caso o c�digo-fonte seja gerado novamente.
=============================================================================== */

User Function _FKOEFIQ ; Return  // "dummy" function - Internal Use 

WSCLIENT WSCFGTABLE2

	WSDATA   _URL                      AS String
	WSDATA   _HEADOUT                  AS Array of String
	WSDATA   cUSERCODE                 AS string
	WSDATA   cALIAS                    AS string
	WSDATA   cQUERYADDWHERE            AS string
	WSDATA   cBRANCH                   AS string
	WSDATA   cLISTFIELDSVIEW           AS string
	WSDATA   oWSGETTABLERESULT         AS CFGTABLE_TABLEVIEW

ENDWSCLIENT

WSMETHOD NEW WSCLIENT WSCFGTABLE
::Init()
If !FindFunction("XMLCHILDEX")
	UserException("O C�digo-Fonte Client atual requer os execut�veis do Protheus Build [7.00.100812P-20101130] ou superior. Atualize o Protheus ou gere o C�digo-Fonte novamente utilizando o Build atual.")
EndIf
Return Self

WSMETHOD INIT WSCLIENT WSCFGTABLE
	::oWSGETTABLERESULT  := CFGTABLE_TABLEVIEW():New()
Return

WSMETHOD RESET WSCLIENT WSCFGTABLE
	::cUSERCODE          := NIL 
	::cALIAS             := NIL 
	::cQUERYADDWHERE     := NIL 
	::cBRANCH            := NIL 
	::cLISTFIELDSVIEW    := NIL 
	::oWSGETTABLERESULT  := NIL 
	::Init()
Return

WSMETHOD CLONE WSCLIENT WSCFGTABLE
Local oClone := WSCFGTABLE():New()
	oClone:_URL          := ::_URL 
	oClone:cUSERCODE     := ::cUSERCODE
	oClone:cALIAS        := ::cALIAS
	oClone:cQUERYADDWHERE := ::cQUERYADDWHERE
	oClone:cBRANCH       := ::cBRANCH
	oClone:cLISTFIELDSVIEW := ::cLISTFIELDSVIEW
	oClone:oWSGETTABLERESULT :=  IIF(::oWSGETTABLERESULT = NIL , NIL ,::oWSGETTABLERESULT:Clone() )
Return oClone

// WSDL Method GETTABLE of Service WSCFGTABLE

WSMETHOD GETTABLE WSSEND cUSERCODE,cALIAS,cQUERYADDWHERE,cBRANCH,cLISTFIELDSVIEW WSRECEIVE oWSGETTABLERESULT WSCLIENT WSCFGTABLE
Local cSoap := "" , oXmlRet

BEGIN WSMETHOD

cSoap += '<GETTABLE xmlns="http://webservices.microsiga.com.br/cfgtable.apw">'
cSoap += WSSoapValue("USERCODE", ::cUSERCODE, cUSERCODE , "string", .T. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("ALIAS", ::cALIAS, cALIAS , "string", .T. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("QUERYADDWHERE", ::cQUERYADDWHERE, cQUERYADDWHERE , "string", .F. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("BRANCH", ::cBRANCH, cBRANCH , "string", .F. , .F., 0 , NIL, .T.) 
cSoap += WSSoapValue("LISTFIELDSVIEW", ::cLISTFIELDSVIEW, cLISTFIELDSVIEW , "string", .F. , .F., 0 , NIL, .T.) 
cSoap += "</GETTABLE>"

oXmlRet := SvcSoapCall(	Self,cSoap,; 
	"http://webservices.microsiga.com.br/cfgtable.apw/GETTABLE",; 
	"DOCUMENT","http://webservices.microsiga.com.br/cfgtable.apw",,"1.031217",; 
	"http://192.168.0.122:8080/CFGTABLE.apw")

::Init()
::oWSGETTABLERESULT:SoapRecv( WSAdvValue( oXmlRet,"_GETTABLERESPONSE:_GETTABLERESULT","TABLEVIEW",NIL,NIL,NIL,NIL,NIL,NIL) )

END WSMETHOD

oXmlRet := NIL
Return .T.


// WSDL Data Structure TABLEVIEW

WSSTRUCT CFGTABLE_TABLEVIEW
	WSDATA   oWSTABLEDATA              AS CFGTABLE_ARRAYOFFIELDVIEW
	WSDATA   oWSTABLESTRUCT            AS CFGTABLE_ARRAYOFFIELDSTRUCT
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CFGTABLE_TABLEVIEW
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CFGTABLE_TABLEVIEW
Return

WSMETHOD CLONE WSCLIENT CFGTABLE_TABLEVIEW
	Local oClone := CFGTABLE_TABLEVIEW():NEW()
	oClone:oWSTABLEDATA         := IIF(::oWSTABLEDATA = NIL , NIL , ::oWSTABLEDATA:Clone() )
	oClone:oWSTABLESTRUCT       := IIF(::oWSTABLESTRUCT = NIL , NIL , ::oWSTABLESTRUCT:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CFGTABLE_TABLEVIEW
	Local oNode1
	Local oNode2
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_TABLEDATA","ARRAYOFFIELDVIEW",NIL,"Property oWSTABLEDATA as s0:ARRAYOFFIELDVIEW on SOAP Response not found.",NIL,"O",NIL,NIL) 
	If oNode1 != NIL
		::oWSTABLEDATA := CFGTABLE_ARRAYOFFIELDVIEW():New()
		::oWSTABLEDATA:SoapRecv(oNode1)
	EndIf
	oNode2 :=  WSAdvValue( oResponse,"_TABLESTRUCT","ARRAYOFFIELDSTRUCT",NIL,"Property oWSTABLESTRUCT as s0:ARRAYOFFIELDSTRUCT on SOAP Response not found.",NIL,"O",NIL,NIL) 
	If oNode2 != NIL
		::oWSTABLESTRUCT := CFGTABLE_ARRAYOFFIELDSTRUCT():New()
		::oWSTABLESTRUCT:SoapRecv(oNode2)
	EndIf
Return

// WSDL Data Structure ARRAYOFFIELDVIEW

WSSTRUCT CFGTABLE_ARRAYOFFIELDVIEW
	WSDATA   oWSFIELDVIEW              AS CFGTABLE_FIELDVIEW OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CFGTABLE_ARRAYOFFIELDVIEW
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CFGTABLE_ARRAYOFFIELDVIEW
	::oWSFIELDVIEW         := {} // Array Of  CFGTABLE_FIELDVIEW():New()
Return

WSMETHOD CLONE WSCLIENT CFGTABLE_ARRAYOFFIELDVIEW
	Local oClone := CFGTABLE_ARRAYOFFIELDVIEW():NEW()
	oClone:oWSFIELDVIEW := NIL
	If ::oWSFIELDVIEW <> NIL 
		oClone:oWSFIELDVIEW := {}
		aEval( ::oWSFIELDVIEW , { |x| aadd( oClone:oWSFIELDVIEW , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CFGTABLE_ARRAYOFFIELDVIEW
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_FIELDVIEW","FIELDVIEW",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSFIELDVIEW , CFGTABLE_FIELDVIEW():New() )
			::oWSFIELDVIEW[len(::oWSFIELDVIEW)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure ARRAYOFFIELDSTRUCT

WSSTRUCT CFGTABLE_ARRAYOFFIELDSTRUCT
	WSDATA   oWSFIELDSTRUCT            AS CFGTABLE_FIELDSTRUCT OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CFGTABLE_ARRAYOFFIELDSTRUCT
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CFGTABLE_ARRAYOFFIELDSTRUCT
	::oWSFIELDSTRUCT       := {} // Array Of  CFGTABLE_FIELDSTRUCT():New()
Return

WSMETHOD CLONE WSCLIENT CFGTABLE_ARRAYOFFIELDSTRUCT
	Local oClone := CFGTABLE_ARRAYOFFIELDSTRUCT():NEW()
	oClone:oWSFIELDSTRUCT := NIL
	If ::oWSFIELDSTRUCT <> NIL 
		oClone:oWSFIELDSTRUCT := {}
		aEval( ::oWSFIELDSTRUCT , { |x| aadd( oClone:oWSFIELDSTRUCT , x:Clone() ) } )
	Endif 
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CFGTABLE_ARRAYOFFIELDSTRUCT
	Local nRElem1, oNodes1, nTElem1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNodes1 :=  WSAdvValue( oResponse,"_FIELDSTRUCT","FIELDSTRUCT",{},NIL,.T.,"O",NIL,NIL) 
	nTElem1 := len(oNodes1)
	For nRElem1 := 1 to nTElem1 
		If !WSIsNilNode( oNodes1[nRElem1] )
			aadd(::oWSFIELDSTRUCT , CFGTABLE_FIELDSTRUCT():New() )
			::oWSFIELDSTRUCT[len(::oWSFIELDSTRUCT)]:SoapRecv(oNodes1[nRElem1])
		Endif
	Next
Return

// WSDL Data Structure FIELDVIEW

WSSTRUCT CFGTABLE_FIELDVIEW
	WSDATA   oWSFLDTAG                 AS CFGTABLE_ARRAYOFSTRING
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CFGTABLE_FIELDVIEW
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CFGTABLE_FIELDVIEW
Return

WSMETHOD CLONE WSCLIENT CFGTABLE_FIELDVIEW
	Local oClone := CFGTABLE_FIELDVIEW():NEW()
	oClone:oWSFLDTAG            := IIF(::oWSFLDTAG = NIL , NIL , ::oWSFLDTAG:Clone() )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CFGTABLE_FIELDVIEW
	Local oNode1
	::Init()
	If oResponse = NIL ; Return ; Endif 
	oNode1 :=  WSAdvValue( oResponse,"_FLDTAG","ARRAYOFSTRING",NIL,"Property oWSFLDTAG as s0:ARRAYOFSTRING on SOAP Response not found.",NIL,"O",NIL,NIL) 
	If oNode1 != NIL
		::oWSFLDTAG := CFGTABLE_ARRAYOFSTRING():New()
		::oWSFLDTAG:SoapRecv(oNode1)
	EndIf
Return

// WSDL Data Structure FIELDSTRUCT

WSSTRUCT CFGTABLE_FIELDSTRUCT
	WSDATA   nFLDDEC                   AS integer
	WSDATA   cFLDNAME                  AS string
	WSDATA   nFLDSIZE                  AS integer
	WSDATA   cFLDTYPE                  AS string
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CFGTABLE_FIELDSTRUCT
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CFGTABLE_FIELDSTRUCT
Return

WSMETHOD CLONE WSCLIENT CFGTABLE_FIELDSTRUCT
	Local oClone := CFGTABLE_FIELDSTRUCT():NEW()
	oClone:nFLDDEC              := ::nFLDDEC
	oClone:cFLDNAME             := ::cFLDNAME
	oClone:nFLDSIZE             := ::nFLDSIZE
	oClone:cFLDTYPE             := ::cFLDTYPE
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CFGTABLE_FIELDSTRUCT
	::Init()
	If oResponse = NIL ; Return ; Endif 
	::nFLDDEC            :=  WSAdvValue( oResponse,"_FLDDEC","integer",NIL,"Property nFLDDEC as s:integer on SOAP Response not found.",NIL,"N",NIL,NIL) 
	::cFLDNAME           :=  WSAdvValue( oResponse,"_FLDNAME","string",NIL,"Property cFLDNAME as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
	::nFLDSIZE           :=  WSAdvValue( oResponse,"_FLDSIZE","integer",NIL,"Property nFLDSIZE as s:integer on SOAP Response not found.",NIL,"N",NIL,NIL) 
	::cFLDTYPE           :=  WSAdvValue( oResponse,"_FLDTYPE","string",NIL,"Property cFLDTYPE as s:string on SOAP Response not found.",NIL,"S",NIL,NIL) 
Return

// WSDL Data Structure ARRAYOFSTRING

WSSTRUCT CFGTABLE_ARRAYOFSTRING
	WSDATA   cSTRING                   AS string OPTIONAL
	WSMETHOD NEW
	WSMETHOD INIT
	WSMETHOD CLONE
	WSMETHOD SOAPRECV
ENDWSSTRUCT

WSMETHOD NEW WSCLIENT CFGTABLE_ARRAYOFSTRING
	::Init()
Return Self

WSMETHOD INIT WSCLIENT CFGTABLE_ARRAYOFSTRING
	::cSTRING              := {} // Array Of  ""
Return

WSMETHOD CLONE WSCLIENT CFGTABLE_ARRAYOFSTRING
	Local oClone := CFGTABLE_ARRAYOFSTRING():NEW()
	oClone:cSTRING              := IIf(::cSTRING <> NIL , aClone(::cSTRING) , NIL )
Return oClone

WSMETHOD SOAPRECV WSSEND oResponse WSCLIENT CFGTABLE_ARRAYOFSTRING
	Local oNodes1 :=  WSAdvValue( oResponse,"_STRING","string",{},NIL,.T.,"S",NIL,"a") 
	::Init()
	If oResponse = NIL ; Return ; Endif 
	aEval(oNodes1 , { |x| aadd(::cSTRING ,  x:TEXT  ) } )
Return


