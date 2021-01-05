function Start()
cdirectory := "C:\prog\Adventofcode2020\day24"
ninput := 11
npart := 1
cprot := ""
macrofunc("Read", {})
irow := 1
atiles := {}
nday := 0
macrofunc("parseall", {})
return

function nextdays()
do while nday < 100 
macrofunc("nextday")
enddo
return 

function nextday()
nday += 1
macrofunc("checkaddneighborsall")

atilesnew := aclonemacro(atiles)
for i := 1 upto alen(atiles)
	nblack := 0
	ice := atiles[i,3]
	ics := atiles[i,4]
	nblack += macrofunc("checkblackneighbor", {ice+2,ics})
	nblack += macrofunc("checkblackneighbor", {ice+1,ics+2})
	nblack += macrofunc("checkblackneighbor", {ice-1,ics+2})
	nblack += macrofunc("checkblackneighbor", {ice-1,ics-2})
	nblack += macrofunc("checkblackneighbor", {ice+1,ics-2})
	nblack += macrofunc("checkblackneighbor", {ice-2,ics})

	n := atiles[i,2] 

	//Any black tile with zero or more than 2 black tiles immediately adjacent to it is flipped to white.
	if n == 1 .and. (nblack == 0 .or. nblack > 2)
		n := 0
	endif	
    //Any white tile with exactly 2 black tiles immediately adjacent to it is flipped to black.	
	if n == 0 .and. (nblack == 2)
		n := 1
	endif	
	aputtwo (atilesnew, i, 2, n)
next
atiles := atilesnew
macrofunc("Sum")
dlgprogressupdatetext(getshell(), ntrim(nday) + " " + ntrim(nsum))
return 

function checkblackneighbor(ice, ics)
nd := ice*1000+ics
nblack := 0
npos := ascanusual(atilesnew, nd, 1)
if npos > 0
	n := atiles[npos,2] 
	nblack += n

else 
//msgerror ("neighbor not found " + typevalue2string(ice, ics))
endif
return nblack


function checkaddneighborsall()
atilesnew := aclonemacro(atiles)
for i := 1 upto alen(atiles)
	ice := atiles[i,3]
	ics := atiles[i,4]
	if atiles[i,2] == 1
		macrofunc("checkaddneighbors", {ice,ics})
	endif
next
atiles := atilesnew 
return 

function checkaddneighbors(ice, ics)
macrofunc("checkaddneighbor", {ice+2,ics})
macrofunc("checkaddneighbor", {ice+1,ics+2})
macrofunc("checkaddneighbor", {ice-1,ics+2})
macrofunc("checkaddneighbor", {ice-1,ics-2})
macrofunc("checkaddneighbor", {ice+1,ics-2})
macrofunc("checkaddneighbor", {ice-2,ics})
return 

function checkaddneighbor(ice, ics)
nd := ice*1000+ics
npos := ascanusual(atilesnew, nd, 1)
if npos == 0
	Aadd (atilesnew, {nd, 0, ice, ics})
endif
return 

function read()
cfile := faddbackslash(cdirectory)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
// a := string2arraykeepposition(c, crlf)
a := string2array(c, crlf)
adata := {}
for i := 1 upto alen(a)
	c := alltrim(a[i])
	if !Empty(c)
		AAdd (adata, c)
	endif
next
return 

function sum()
nsum := 0
for i := 1 upto alen(atiles)
	n := atiles[i,2] 
	nsum += n
next 
return 

function parseall()
for irow := 1 upto alen(adata)
macrofunc("parseline", {})
next 
return

function parseline()
cline := adata[irow]
//e, se, sw, w, nw, and ne
adir := {0, 0}  //e s 

i := 1 
do while i <= len(cline)
	c := substr(cline, i, 1)
	if c == "e"
		n := adir[1]
		n += 2
		aputone (adir, 1, n)
	elseif c == "s"
		n := adir[2]
		n += 2
		aputone (adir, 2, n)

		i += 1
		c := substr(cline, i, 1)
		if c == "e"
			n := adir[1]
			n += 1
			aputone (adir, 1, n)
		elseif c == "w"
			n := adir[1]
			n += -1
			aputone (adir, 1, n)
		else 
			msgerror ("invalid character s " + typevalue2string(c, i))
		endif
	elseif c == "w"
		n := adir[1]
		n += -2
		aputone (adir, 1, n)
	elseif c == "n"
		n := adir[2]
		n += -2
		aputone (adir, 2, n)

		i += 1
		c := substr(cline, i, 1)
		if c == "e"
			n := adir[1]
			n += 1
			aputone (adir, 1, n)
		elseif c == "w"
			n := adir[1]
			n += -1
			aputone (adir, 1, n)
		else 
			msgerror ("invalid character w " + typevalue2string(c, i))
		endif
	else 
		msgerror ("invalid character " + typevalue2string(c, i))
	endif


	i += 1
enddo

nd := adir[1]*1000+adir[2]
npos := ascanusual(atiles, nd, 1)
if npos == 0
	Aadd (atiles, {nd, 0, adir[1], adir[2]})
	npos := alen(atiles)
endif 
	n := atiles[npos,2]
	if n == 1
		n := 0
	else 
		n := 1
	endif
	aputtwo (atiles, npos, 2, n)
return 

export cdirectory
export ninput
export npart
export cprot 
export adata
export irow
export atiles
export atilesnew
export nday
export nsum