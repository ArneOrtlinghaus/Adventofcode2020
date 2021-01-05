function Start()
cdirectory := "C:\prog\Adventofcode2020\day15"
ninput := 0
npart := 1
nturn := 0
adata := clsdictionaryStringstring{}
nmaxturns := 30000000 // 2020 // 
macrofunc("Read2b")
cprot := ""
c := adata:outputasstring("KEYVALUE", ",", crlf, "")

return

function read2a()
macrofunc("addturn", {0})
macrofunc("addturn", {3})
macrofunc("addturn", {6})
return

// Your puzzle input is 1,0,15,2,10,13.
function read2b()
macrofunc("addturn", {1})
macrofunc("addturn", {0})
macrofunc("addturn", {15})
macrofunc("addturn", {2})
macrofunc("addturn", {10})
macrofunc("addturn", {13})
return

function nextturn()
macrofunc("repeatturns", {true})
c := adata:outputasstring("KEYVALUE", ",", crlf, "")
return

function repeatturnsall()
macrofunc("repeatturns", {false})
return

function repeatturns(lonce)
lgoon := true
do while lgoon 

	nturn += 1


	if modmacro(nturn, 10000) == 0
		dlgprogressupdatetext(getshell(), ntrim(nturn))
	endif

	c := adata:getvalue(ntrim(nlastnumber))
	if !empty(c)
		a := string2array (c, ";")
		nprevturn := val(a[1])
		nlastturn := val(a[2])
		nnewnumber := nlastturn - nprevturn
	else 
		nnewnumber := 0
	endif
		c := adata:getvalue(ntrim(nnewnumber))
		if !empty(c)
			a := string2array (c, ";")
			nlastturn := val(a[2])
			c := ntrim(nlastturn)+";"+ntrim(nturn)
		else 
			c := ntrim(nturn)+";"+ntrim(nturn)
		endif
		adata:addorupdate(ntrim(nnewnumber), c)


	nlastnumber := nnewnumber

	if lonce 
		lgoon := false 
	else 
		lgoon := nturn < nmaxturns 
	endif

enddo 

msginfo (typevalue2string(nlastnumber))
return 


function addturn(nnewnumber)
nturn += 1
adata:addorupdate(ntrim(nnewnumber), ntrim(nturn)+";"+ntrim(nturn))
nlastnumber := nnewnumber
return




export cdirectory
export ninput
export npart
export adata 
export nturn
export nlastnumber
export nmaxturns
