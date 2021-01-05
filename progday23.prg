function Start()
cdirectory := "C:\prog\Adventofcode2020\day23"
ninput := 1
npart := 1
cprot := ""
//macrofunc("Read", {"389125467"})
macrofunc("Read", {"362981754"})
nmaxnum := 1000000 // 9
nmove := 0
return

function resultpart2()
ccupnext := adata:getvalue("1")
ccupnextnext := adata:getvalue(ccupnext)
n := 1.0*val(ccupnext) * val(ccupnextnext)
msginfo (typevalue2string(n, ccupnext, ccupnextnext))
return 


function read(cp)
adata := {}
adata := clsdictionaryStringstring{}
i := 1
c1 := substr(cp, i, 1)
ccupcurr := c1

cprev := c1

for i := 2 upto len(cp)
	cc := substr(cp, i, 1)
	adata:addorupdate(cprev, cc)
	cprev := cc
next	
for i := 10 upto nmaxnum
	cc := ntrim(i)
	adata:addorupdate(cprev, cc)
	cprev := cc
next	


adata:addorupdate(cprev, c1)

return 

function order()
c := ""
ccupnext := "1"
for i := 1 upto 8
	ccupnext := adata:getvalue(ccupnext)
	c += ccupnext
next 
return c

function moveall()
do while nmove < 10000000
	macrofunc("nextmove", {""})
enddo
return 

function nextmove()

nmove += 1
if modmacro(nmove, 1000) == 0
	dlgprogressupdatetext(getshell(), ntrim(nmove))
endif
aout := {}

ccupnext := ccupcurr
for i := 1 upto 3
	ccupnext := adata:getvalue(ccupnext)
	AAdd (aout, ccupnext)
next
ccupnext := adata:getvalue(ccupnext)

ncupdest := val(ccupcurr)-1
if ncupdest == 0
	ncupdest := nmaxnum 
endif	
ccupdest := ntrim(ncupdest)

do while ascanusual(aout, ccupdest, 0) > 0
	ncupdest := ncupdest-1
	if ncupdest == 0
		ncupdest := nmaxnum 
	endif
	ccupdest := ntrim(ncupdest)
enddo	
ccupdestnext := adata:getvalue(ccupdest)
//cprot += "nmove " + ntrim(nmove) + " ccupcurr " + ccupcurr + " ccupnext " + ccupnext + " ccupdest " + ccupdest + " ccupdestnext " + ccupdestnext+ crlf 

adata:addorupdate(ccupdest, aout[1])
adata:addorupdate(aout[1], aout[2])
adata:addorupdate(aout[2], aout[3])
adata:addorupdate(aout[3], ccupdestnext)
adata:addorupdate(ccupcurr, ccupnext)

//c := adata:outputasstring("KEYVALUE", ";", crlf, "")
//cprot += c + crlf 

ccupcurr := ccupnext
return 


export cdirectory
export ninput
export npart
export cprot 
export adata
export ccupcurr
export ccupdest
export ccupnext
export nmove 
export nmaxnum