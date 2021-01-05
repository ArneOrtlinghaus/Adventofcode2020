function Start()
cdir := "C:\prog\Adventofcode2020\day3"
ninput := 0
npart := 1
macrofunc("Read")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
adata := string2array(c, crlf)
for i := 1 upto alen(adata)
c := alltrim(adata[i])
//n := val(c)
a2 := macrofunc("parse", c)
APutone (adata, i, a2)
next
return 

function parse(c)
a := string2array(c, ": ")
if alen(a) == 2
	c := a[1]
	ctext := a[2]
	a := string2array(c, " ")
	if alen(a) == 2
		c := a[1]
		cchar := a[2]
		a := string2array(c, "-")
		if alen(a) == 2
			cf := val(a[1])
			ct := val(a[2])
			aout := {cf, ct, cchar, ctext}
		endif
	endif
endif

return aout

function checkok (arow)
cf := arow[1] 
ct := arow[2] 
cchar := arow[3] 
ctext := arow[4] 
n := occurs(cchar, ctext)
lok := between(n, cf, ct)
return lok

function checkok2 (arow)
cf := arow[1] 
ct := arow[2] 
cchar := arow[3] 
ctext := arow[4] 
//n := occurs(cchar, ctext)
l1 := substr(ctext, cf,1) == cchar
l2 := substr(ctext, ct,1) == cchar
lok :=  (l1 .and. !l2) .or. (!l1 .and. l2)
return lok


function eval()
nsum := 0
for i := 1 upto alen(adata)
	arow := adata[i]
	lok := macrofunc ("checkok2", {arow})
	if lok 
		nsum += 1
	endif
next 
msginfo ("sum: " + typevalue2string(nsum))
return 
export adata

export cdir
export npart
export ninput 