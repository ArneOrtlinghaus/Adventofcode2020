function Start()
cdir := "C:\prog\Adventofcode2020\day7"
ninput := 1
macrofunc("Read")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
c := Strtran(c, "bags", "")
c := Strtran(c, "bag", "")
c := Strtran(c, ".", "")
a := string2array(c, crlf)
adata := {}
for i := 1 upto alen(a)
	c := alltrim(a[i])
	a2 := string2array(c, " contain ")
	if alen(a2) >= 2
		arow := {}
		c := alltrim(a2[1])
		AAdd (arow, c)
		l := c=="shiny gold"
		if l 
			istart := i 
		endif
		AAdd (arow, l)
		c := alltrim(a2[2])
		if c == "no other"
			a2 := {}
		else
			a2 := string2array(c, ",")
		endif
		for i2 := 1 upto alen(a2)
			a3 := string2array(a2[i2], " ")
			if alen(a3) >= 2
				n := val(a3[1])
				aaus (a3, 1)
				c := Array2string(a3, " ")
				APutone(a2, i2, {c, n})

			endif
		next
		aadd (arow, a2)
		aadd (adata, arow)
   endif
next
return 

function eval2 ()
cbag := "shiny gold"
nsum := macrofunc("calc2", {cbag, 1})
return


function calc2(cbag, nlevel)
nsum := 0
abags := ArrayGetValueTwodim(adata, cbag, 1, 3, {})

dlgprogressupdatetext(getshell(), cbag + " " + ntrim(nlevel))
for i := 1 upto alen(abags)
	cbagi := abags[i][1]
	nbag := abags[i][2]
	n := macrofunc("calc2", {cbagi, nlevel+1})
	nsum += nbag + n * nbag
next

return nsum


function evalall ()
nsum := 0
cprot := ""
nmodified := 99
nloop := 1
do while nmodified > 0
    nloop += 1
	nmodified := 0
	for i := 1 upto alen(adata)
		dlgprogressupdatetext(getshell(), "loop " + ntrim(i) + " " + ntrim(nloop)+ " " + ntrim(nsum))
		arow := adata[i]
		nmodified := nmodified + macrofunc("calc1", {arow})
	next
	nsum := macrofunc ("result", {})
enddo
//msginfo (typevalue2string(nsumsum)+crlf+cprot)
return 

function result ()
nsum := -1 // shiny gold
for i := 1 upto alen(adata)
	arow := adata[i]
	l := arow[2]
	if l 
		nsum += 1
	endif
next
return nsum

function shiny(cbagi)
for i := 1 upto alen(adata)
	arow := adata[i]
	cbag := arow[1]
	if cbag == cbagi 
		return arow[2]
	endif
next
msginfo ("bag not found " + typevalue2string(cbagid))
return false

function calc1(arow)
nmodified := 0
cbag := arow[1]
l := arow[2]
if !l
	abags := arow[3]
	for i := 1 upto alen(abags)
		cbagi := abags[i,1]
		lshiny := ArrayGetValueTwodim(adata, cbagi, 1, 2, false)

		//macrofunc("shiny", {cbagi})
		if lshiny 
			APutone (arow, 2, true)
			nmodified := 1
		endif
	next
endif
return nmodified

function evalsingle ()
i := 3
arow := adata[i]
//nmodified := macrofunc("calc1", {arow})
return


export cdir
export ninput 
export adata
export istart