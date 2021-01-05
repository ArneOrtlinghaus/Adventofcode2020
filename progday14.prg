function Start()
cdirectory := "C:\prog\Adventofcode2020\day14"
ninput := 1
npart := 2
macrofunc("Read")
aall := {}
irow := 1
cprot := ""
return

function read()
cfile := faddbackslash(cdirectory)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
a := string2arraykeepposition(c, crlf)
adata := {}
arow := {}
for i := 1 upto alen(a)
	c := alltrim(a[i])
	csearch := "mask = "
	if substr(c, 1, 7) == csearch
	   if !Empty(arow) 
			AAdd (adata, arow)
		endif
		c := strtran(c, csearch, "")
		nx := occurs("X", c)
		n2 := 1
		for ix := 1 upto nx 
			n2 := n2 * 2
		next
		amem := {}
		arow := {c, amem, nx, n2}
	else 
		// mem[8] = 11
		a2 := string2array(c, " = ")
		cx := a2[1]
		cx := strtran(cx, "mem[", "")
		cx := strtran(cx, "]", "")
		nidx := val(cx)
		nval := val(a2[2])
	   aadd (amem, {nidx, nval})
	endif
next
if !Empty(arow) 
	AAdd (adata, arow)
endif
return 

function addmem2()
arow := adata[irow]
cmask := arow[1]
amem := arow[2]
nxfloat := arow[4]
nlenfloat := arow[3]
cprot += " " + ntrim(irow) + " " + cmask + crlf
for imem := 1 upto alen(amem)
	nidx := amem[imem][1]
	nval := amem[imem][2]
	cbin := macrofunc("num2binstr",{nidx, 36})
	cbinn := ""
	for ibin := 1 upto alen(cbin)
		c := substr(cbin, ibin,1)
		cm := substr(cmask, ibin,1)
		if cm == "1"
			c := "1"
		elseif cm == "X"
			c := "X"
		endif
		cbinn += c
	next
	
	amask := string2arraykeepposition(cbinn, "X")
	for ixfloat := 1 upto nxfloat
	dlgprogressupdatetext(getshell(), typevalue2string(irow, imem, ixfloat, alen(aall), nsum))

		cbinfloat := macrofunc("num2binstr",{ixfloat-1, nlenfloat})	
		cbinnn := ""
		for ilen := 1 upto nlenfloat
			cbinnn += amask[ilen]
			cbinnn += substr(cbinfloat, ilen, 1)
		next
		ilen := nlenfloat+1
		cbinnn += amask[ilen]
		n := macrofunc("binstr2num",{cbinnn})
		//msginfo (typevalue2string(n, ixfloat, cbinnn, cbinfloat, amask, cmask))

		cprot += ntrim(nidx) + " " + ntrim(nval) + " " + ntrim(n)+ typevalue2string(ixfloat, cbinnn, cbinfloat) + crlf
		npos := ascanmacro (aall, n, 1)
		if npos == 0
			aadd (aall, {n, 0})
			npos := alen(aall)
		endif
		APutTwo(aall, npos, 2, nval)
	//	msginfo (typevalue2string(cbin, cbinn, n))

	next
	
next 

return 





function addallmem()
cprot := ""
aall := {}
for irow := 1 upto alen(adata)
macrofunc("addmem2",{})
next 
return 

function addmem()
arow := adata[irow]
cmask := arow[1]
amem := arow[2]
cprot += " " + ntrim(irow) + " " + cmask + crlf
for imem := 1 upto alen(amem)
	nidx := amem[imem][1]
	nval := amem[imem][2]
	cbin := macrofunc("num2binstr",{nval, 36})
	cbinn := ""
	for ibin := 1 upto alen(cbin)
		c := substr(cbin, ibin,1)
		cm := substr(cmask, ibin,1)
		if cm == "1"
			c := "1"
		elseif cm == "0"
			c := "0"
		endif
		cbinn += c
	next
	n := macrofunc("binstr2num",{cbinn})
	cprot += ntrim(nidx) + " " + ntrim(nval) + " " + ntrim(n)+ crlf
   npos := ascanmacro (aall, nidx, 1)
	if npos == 0
		aadd (aall, {nidx, 0})
		npos := alen(aall)
	endif
	APutTwo(aall, npos, 2, n)
//	msginfo (typevalue2string(cbin, cbinn, n))
next 

nsum := macrofunc("sum",{})
return 

function num2binstr(n, nlength)
cout := ""
do while n > 0
   nr := modmacro(n, 2)
   if nr == 1
      c := "1"
   else
      c := "0"
   endif
   cout := c + cout
   n :=(n - nr) /2
enddo
if len(cout) < nlength
	cout := padl(cout, nlength, "0")
endif	
return cout

function binstr2num(cbin)
n := 0
do while !Empty(cbin)
	c := substr(cbin, 1, 1)
	n := n * 2.0
	if c == "1"
		n += 1
	endif 
	cbin := substr(cbin, 2)
enddo
return n 

function calc()
cprot := ""
for ibus := 1 upto alen(abus)
	nbus := abus[ibus]
   nts := (integer(ntsmin/nbus))*nbus
	cprot += ntrim(nbus) + " " + ntrim(nts) 
   nts += nbus	
	cprot += " " + ntrim(nts) 
	nmin := nts-ntsmin
	cprot += " " + ntrim(nmin) 
	cprot +=" " + ntrim(nmin*nbus) +crlf
next

return 

function sum()
nsum := 0
for i := 1 upto alen(aall)
	nsum += 1.0*aall[i][2]
next
return nsum

export cdirectory
export ninput
export npart

export adata 

export aall
export irow
export cprot
export nsum 


