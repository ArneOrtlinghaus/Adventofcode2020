function Start()
cdirectory := "C:\prog\Adventofcode2020\day22"
ninput := 11
npart := 1
cprot := ""
ap1 := macrofunc("Read", {"a"})
ap2 := macrofunc("Read", {"b"})
ngameplayed  := 0
nroundplayed := 0
return

function game1()
macrofunc("game", {1, ap1, ap2, {}})

return nil

function game(ngame, ac1, ac2, aprev)
ngameplayed+=1
dlgprogressupdatetext(getshell(), ntrim(nroundplayed)+" " +ntrim(ngameplayed)+" " +ntrim(ngame)+" " + ntrim(alen(ac1))+" " + ntrim(alen(ac2)))
//cprot += "game " + typevalue2string(ngame, ac1, ac2)+crlf
lwin1 := true
nloop := 0
do while alen(ac1) > 0 .and. alen(ac2) > 0
nroundplayed += 1
	c := array2string(ac1,",")+array2string(ac2,",")
	if ascanstring(aprev, c, 0) > 0
		return true 
	endif
	AAdd (aprev,c)
	nloop += 1
	lwin1 := macrofunc("nextround", {ngame, ac1, ac2})
enddo
return lwin1

function nextround(ngame, ac1, ac2)
if alen(ac1) == 0 .or. alen(ac2) == 0
	return  
endif

n1 := ac1[1]
AAus (ac1, 1)
n2 := ac2[1]
AAus (ac2, 1)
if alen(ac1) >= n1 .and. alen(ac2) >= n2
	ac1n := aclonemacro(ac1)
	do while alen(ac1n) > n1 
		aaus (ac1n, alen(ac1n))
	enddo
	ac2n := aclonemacro(ac2)
	do while alen(ac2n) > n2
		aaus (ac2n, alen(ac2n))
	enddo
	lwin1 := macrofunc("game", {ngame+1, ac1n, ac2n, {}})
else
	if n1 > n2 
		lwin1 := true
	else 
		lwin1 := false
	endif
endif 

//cprot += "nextround " + typevalue2string(lwin1, n1, n2)+crlf

if lwin1
	AAdd (ac1, n1)
	AAdd (ac1, n2)
else	
	AAdd (ac2, n2)
	AAdd (ac2, n1)
endif	

return lwin1

function sum()
nsum := 0
if alen(ap1) == 0 
	a := ap2
else 
	a := ap1
endif 

nlen := alen(a)
for i := 1 upto nlen
	n := a[i]
	nsum += 1.*n*(nlen-i+1)
next
msginfo (typevalue2string(nsum))

return 	



function read(cp)
cfile := faddbackslash(cdirectory)+"input"
cfile +=ntrim(ninput)
cfile += cp
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
// a := string2arraykeepposition(c, crlf)
a := string2array(c, crlf)
ap := {}
for i := 1 upto alen(a)
	c := alltrim(a[i])
	if !Empty(c)
		AAdd (ap, val(c))
	endif
next

return ap



export cdirectory
export ninput
export npart
export cprot 
export ap1
export ap2
export ngameplayed 
export nroundplayed