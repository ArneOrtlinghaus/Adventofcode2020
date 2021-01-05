function Start()
cdir := "C:\prog\Adventofcode2020\day10"
ninput := 1
npart := 2
macrofunc("Read")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
a := string2array(c, crlf)
adata := {}
if npart == 2
	aadd (adata, 0)
endif
for i := 1 upto alen(a)
	c := alltrim(a[i])
	n := val(c)
	aadd (adata, n)
next
ndata := alen(adata)
ASortTwoDim(adata, 0, true)

return 

function getcluster()
acl := {}
nstart := -3
a := {}
lincl := false
for i := 1 upto ndata
	n := adata[i]
	ndiff := n - nstart 
	if lincl
		if ndiff == 1
			aadd (a, n)
		else
			lincl := false
			AAdd (acl, a)
			a := {}
		endif
	else
		if ndiff == 1
			lincl := true
			aadd (a, n)
		else
		endif
	endif
	nstart := n
next
if !Empty(a)
	AAdd (acl, a)
endif

for i := alen(acl) downto 1
   a := acl [i]
   if alen(a) >= 2
	   AAus (a, alen(a))
   else 
	   aaus (acl, i)
   endif 
next

return 

function countcluster()
np := 1.0
for i := 1 upto alen(acl) 
   a := acl [i]
   n := alen(a) 
   if n == 1
	  np := np * 2
   elseif n == 2
	  np := np * 4
   elseif n == 3
	  np := np * 7
   else 
      msgerror ("countcluster " + typevalue2string(np))
   endif
next
msginfo (typevalue2string(np))

function calc1()
nstart := 0
adiff := ACreateone(3, 0)
for i := 1 upto ndata
	n := adata[i]
	ndiff := n - nstart 
	np := adiff[ndiff] + 1
	APutone(adiff, ndiff, np)
	nstart := n
next
	np := adiff[3] + 1
	APutone(adiff, 3, np)
msginfo (typevalue2string(adiff, adiff[3]*adiff[1]))
return 



export acl


export cdir
export ninput 
export adata
export ndata
export npart
