function Start()
cdir := "C:\prog\Adventofcode2020\day6"
ninput := 1
macrofunc("Read")
return

function evalsingle ()
c := adata[4]
nsum := macrofunc("calc2", {c})
return

function calc2(c)
agroup := string2array(c, crlf)
c := agroup[1]
a := ACreateone(26, false)
for i := 1 upto len(c)
	cch := substr(c, i, 1)
	if between (cch, "a", "z")
		nch := asc(cch)-asc("a")
		nch+=1 
		if between (nch, 1, 26)
			APutone(a, nch, true)
		endif
	endif
next
for i := 1 upto len(a)
	if a[i] 
		cch := chr(asc("a")-1+i)
		for ig := 2 upto len(agroup)
			c := agroup[ig]
			if at(cch, c) == 0
				APutone(a, i, false)
			endif
		next
	endif
next
nsum := 0
for i := 1 upto len(a)
	if a[i] 
		nsum += 1
	endif
next
return nsum


function calc1(c)
a := ACreateone(26, false)
for i := 1 upto len(c)
	cch := substr(c, i, 1)
	if between (cch, "a", "z")
		nch := asc(cch)-asc("a")
		nch+=1 
		if between (nch, 1, 26)
			APutone(a, nch, true)
		endif
	endif
next
nsum := 0
for i := 1 upto len(a)
	if a[i] 
		nsum += 1
	endif
next
return nsum

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
a := string2arraykeepposition(c, crlf)
adata := {}
cp := ""
for i := 1 upto alen(a)
	c := alltrim(a[i])
	if !empty(c)
		cp := addstring(cp, c, crlf)
	else 
	   if !Empty(cp)
		   aadd (adata, cp)
		   cp := ""
		endif
	endif
next
   if !Empty(cp)
	   aadd (adata, cp)
	   cp := ""
	endif
return 

function evalall ()
nsumsum := 0
cprot := ""
for i := 1 upto alen(adata)
	c := adata[i]
	nsum := macrofunc("calc2", {c})
	cprot += typevalue2string(i, c, nsum)+crlf
	nsumsum += nsum
next
msginfo (typevalue2string(nsumsum)+crlf+cprot)
return 




export cdir
export ninput 
export adata
