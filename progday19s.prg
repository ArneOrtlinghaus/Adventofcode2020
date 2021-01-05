function Start()
cdirectory := "C:\prog\Adventofcode2020\day19"
ninput := 11
npart := 1
ncalls := 0
nsum := 0
irow := 1
nmaxrecursive := 30
macrofunc("Readrules")
macrofunc("Readdata")

cprot := ""
return


function parsesingle()
cprot := ""
nretsub := macrofunc("parsetree", {0, 1})
msginfo (typevalue2string(nretsub))
return 

function parseall()
nsum := 0
cprot2 := ""
for irow := 1 upto alen(adata)
cline := adata[irow]
dlgprogressupdatetext(getshell(), ntrim(irow) + " " + ntrim(nsum) )
nret := macrofunc("parsetree", {0, 1})
if nret > 0 
	nsum += 1
endif	
cprot2 += ntrim(nret) + " " + cline+crlf
next 
msginfo (typevalue2string(nsum, cprot2))
return 

function parsetree(irule, nindex)
ncalls += 1
if mod (ncalls, 100) == 0
	dlgprogressupdatetext(getshell(), ntrim(irow) + " " + ntrim(nsum) + " " + ntrim(ncalls) )
endif
nret := 0
if irule == 0
	astack := {}
	cprot := ""
endif	
cprota := padr(" ", 3*(alen(astack)+1)) + "rule " + ntrim(irule) + " index" + ntrim(nindex) +": "
nrecursive := 0
for istack := 1 upto alen(astack)
	if astack[istack] == irule 
		nrecursive += 1
	endif
next
if nrecursive > nmaxrecursive // ascanmacro (astack, irule, 0) > 0
	cprot += cprota +" recursive"+crlf
	return nret 
endif
aadd (astack, irule)
if len(cline) < nindex 
	cprot += cprota +" parse string too short" + typevalue2string(nret)+crlf
	return nret 
endif 
arule := arules[irule+1]
ntype := arule[2]
cprot += cprota+" parse start "  
cprot += " " 
if nindex > 1
cprot += substr(cline, 1, nindex-1) 
endif
cprot += upper(substr(cline, nindex, 1))
cprot += substr(cline, nindex+1)
cprot += " " + strtran(typevalue2string(ntype, arule[3]), crlf, " ")
cprot += " "
cprot += strtran(typevalue2string(astack), crlf, " ")
cprot +=crlf
if ntype == 2
	if substr(cline, nindex, 1) == arule[3]
		nret := 1 // einen weiter
	endif
else 
	asubs := arule[3]
	for isubs := 1 upto alen(asubs) // pipe
		nretsubs := 0
		asub := asubs[isubs]
		cprot += cprota+ " pipe: index new " + ntrim(nindex+nretsubs) + " " + strtran(typevalue2string(isubs, asub), crlf, " ")+crlf
		for isub := 1 upto alen(asub)
			nrule := asub[isub]
			nretsub := macrofunc("parsetree", {nrule, nindex+nretsubs})
			if nretsub > 0 
				nretsubs += nretsub
			else 
				nretsubs := 0
				cprot += cprota+ " subrule not ok " + crlf
				exit 
			endif
		next
		if nretsubs > 0 
			
			nret := nretsubs
			cprot += cprota+ " subrule ok " +typevalue2string(nret)+ crlf
			if irule == 8 
				//msginfo (" rule 8 ok " + typevalue2string(isubs, asubs[isubs]))
				n42 := alen(asubs[isubs])
				asubs :={}
				n42 -=1
				do while n42 > 0
					asubsubs :={}
					for i := 1 upto n42
						AAdd(asubsubs, 31)
					next
					aadd(asubs, asubsubs)
					n42 -= 1
				enddo
				aputtwo(arules, 11 +1, 3, asubs)
			endif
			exit 
		endif
	next
endif
if irule == 0 
	if nindex + nret <= len(cline)
		cprot += cprota +" parse string too long " + typevalue2string(nret, nindex + nret, len(cline))+crlf
		nret := 0
	endif
endif
cprot += cprota+" parse ende " 
if nret > 0
	cprot += "Ok"
else 
	cprot += "Not ok"
endif
cprot += " " + typevalue2string(irule, nret)+crlf
Aaus (astack, alen(astack))
return nret





function readrules()
cfile := faddbackslash(cdirectory)+"input"
cfile +=ntrim(ninput)
cfile += "a"
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
//a := string2arraykeepposition(c, crlf)
a := string2array(c, crlf)

arules := {}
nmaxrule := 0
for i := 1 upto alen(a)
c := a[i] 
	if !empty(c)
		//"1: 2 3 | 3 2"
		a2 := string2array(c, ": ")
		//msginfo (typevalue2string(i, a2))
		
		arow := {}
		nrule := val(a2[1])
		nmaxrule := max(nmaxrule, nrule)
		aadd (arow, nrule)
		c := a2[2]
		ntype := 1
		if at ('"', c) > 0
			ntype := 2
			c := strtran(c, '"', "")
			asub := c
		else
			a2 := string2array(c, "|")
			asub := {}
			for i2 := 1 upto alen(a2)
				asubs := {}
				a3 := string2array(a2[i2], " ")
				for i3 := 1 upto alen(a3)
					n := val(a3[i3])
					aadd (asubs, n)
				next
				aadd (asub, asubs)
			next
		endif
		aadd (arow, ntype)
		aadd (arow, asub)
		aadd (arules, arow)
	endif
next
for i := 1 upto nmaxrule
	if ascanmacro(arules, i,1) == 0
		aadd (arules, {i, 1, {{}}})
	endif
next 
ASortTwoDim(arules, 1, true)
for i := 1 upto alen(arules)
	if i <> arules[i,1]+1 
		msgerror ("Missing rule element " + typevalue2string(i, arules[i,1]))
		exit
	endif
next
return 

function readdata()
cfile := faddbackslash(cdirectory)+"input"
cfile +=ntrim(ninput)
cfile += "b"
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
//a := string2arraykeepposition(c, crlf)
a := string2array(c, crlf)

adata := {}
for i := 1 upto alen(a)
c := a[i] 
aadd (adata, c)
next
cline := adata[1]
return 


export cdirectory
export ninput
export npart
export cprot 
export arules
export adata
export cline 
export astack
export nmaxrecursive
export nsum
export irow
export ncalls