function Start()
cdir := "C:\prog\Adventofcode2020\day3"
ninput := 0
npart := 1
macrofunc("Read")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(npart)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
a := string2array(c, crlf)
for i := 1 upto alen(a)
c := alltrim(a[i])
n := val(c)
APutone (a, i, n)
next
return 

function find()
n := alen(a)
lfound := false
for i := 1 upto n-1
for j := i+1 upto n 
n1 := a[i]
n2 := a[j]
nsum := n1+n2 
if nsum == 2020
lfound := true
msginfo ("found: " + typevalue2string(n1, n2, n1*n2))
endif
if lfound 
	exit
endif
next
if lfound 
	exit
endif
next
return

function find2()
n := alen(a)
lfound := false
for i := 1 upto n-2
for j := i+1 upto n-1
for k := j+1 upto n
n1 := a[i]
n2 := a[j]
n3 := a[k]
nsum := n1+n2+n3
if nsum == 2020
lfound := true
msginfo ("found: " + typevalue2string(n1, n2, n3, n1*n2*n3))
endif
if lfound 
	exit
endif
next
if lfound 
	exit
endif
next
if lfound 
	exit
endif
next
return

export a

export cdir
export npart
export ninput 