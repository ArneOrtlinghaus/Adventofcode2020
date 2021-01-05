function Start()
cdir := "C:\prog\Adventofcode2020\day9"
ninput := 1
macrofunc("Read")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
a := string2array(c, crlf)
adata := {}
for i := 1 upto alen(a)
	c := alltrim(a[i])
	n := val(c)
	aadd (adata, n)
next
ndata := alen(adata)
npreamble := 0
return 

function find2()
n := 530627549 // 127 // 
ipos := 612 // 15 // 
for i := 1 upto ipos-2
	ni := adata[i]
	nsum := ni
	nmin := ni
	nmax := ni
	for j := i+1 upto ipos-1
		nj := adata[j]
		nmin := min(nmin, nj)
		nmax := max(nmax, nj)
		nsum += nj
		if nsum == n
			msginfo (typevalue2string(nmin, nmax, nmin+nmax, ni, nj, ni+nj))
			return true 
		endif
	next 
next

return false


function issum(ipos)
if npreamble < 2 
   return false 
endif 
if ipos < npreamble +1 
	return false
endif	
n := adata[ipos]
for i := ipos-npreamble upto ipos-2
for j := ipos-npreamble+1 upto ipos-1
	ni := adata[i]
	nj := adata[j]
	if ni <> nj
	if n == ni+nj
		return true 
	endif
	endif
next 
next

return false

function testsingle()
ipos := 26
npreamble := 25
n := adata[ipos]
lissum := macrofunc("issum", {ipos})
return 

function findpreamble()
lissum := false
npreamble := 0
do while !lissum 
	npreamble += 1
	ipos := npreamble+1
	lissum := macrofunc("issum", {ipos})
enddo 
return 	

function findfirstnotissum()
lissum := true
ipos := npreamble +1
do while lissum 
	n := adata[ipos] 
	lissum := macrofunc("issum", {ipos})
	ipos += 1
enddo 
return 	






export cdir
export ninput 
export adata
export ndata

export npreamble 