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
//a2 := macrofunc("parse", c)
//APutone (adata, i, a2)
next
return 

function walk(nr, nd)
nsum := 0
nx := 1
id := 1+nd
do while id <= alen(adata)
	crowx := adata[id]
	crow := crowx
	nx += nr
	while len(crow) < nx 
	   crow += crowx 
	enddo
	c := substr(crow, nx,1)
	if c == "#"
		nsum += 1
	endif
	id += nd
enddo
//msginfo ("sum: " + typevalue2string(nsum))
return  nsum
export adata

function walkall()
n1 := macrofunc("walk", {1, 1}) // Right 1, down 1.
n2 := macrofunc("walk", {3, 1}) //    Right 3, down 1. (This is the slope you already checked.)
n3 := macrofunc("walk", {5, 1}) //    Right 5, down 1.
n4 := macrofunc("walk", {7, 1}) // //Right 7, down 1.
n5 := macrofunc("walk", {1, 2}) //    Right 1, down 2.
msginfo ("sum: " + typevalue2string(1.0*n1*n2*n3*n4*n5, n1, n2, n3, n4, n5))
return 

export cdir
export npart
export ninput 