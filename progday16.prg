function Start()
cdirectory := "C:\prog\Adventofcode2020\day16"
ninput := 11
npart := 1

nrules := 20
macrofunc("Read")
aall := {}
irow := 1
cprot := ""
return

function read()
cfile := faddbackslash(cdirectory)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
a := string2arraykeepposition(c, crlf)
arules := {}
ayourticket := {}
aneartickets := {}

//class: 1-3 or 5-7
//row: 6-11 or 33-44
//seat: 13-40 or 45-50
//
//your ticket:
//7,1,14
//
//nearby tickets:
//7,3,47
//40,4,50
//55,2,20
//38,6,12

apossible := {}
for i := 1 upto nrules 
	AAdd (apossible, i)
next
nmode := 0 

arow := {}
for i := 1 upto alen(a)
	c := alltrim(a[i])
	if !Empty(c)
		ladd := true
		if at("your ticket:", c) > 0
			nmode := 1
			ladd := false
		elseif at("nearby tickets:", c) > 0
			nmode := 2
			ladd := false
		endif
		if ladd 
			if nmode == 0
				a2 := string2array(c, ":")
				cname := a2[1]
				a2 := string2array(a2[2], " or ")
				aranges := {}
				for i2 := 1 upto alen(a2)
					a3 := string2array(a2[i2], "-")
					AAdd (aranges, {val(a3[1]), val(a3[2])})
				next
				aadd (arules, {cname, aranges, aclonemacro (apossible)})
			elseif nmode == 1
				a2 := string2array(c, ",")
				anum := {}
				for i2 := 1 upto alen(a2)
					aadd (anum, val(a2[i2]))
				next
				aadd (ayourticket, anum)
			elseif nmode == 2
				a2 := string2array(c, ",")
				anum := {}
				for i2 := 1 upto alen(a2)
					aadd (anum, val(a2[i2]))
				next
				aadd (aneartickets, anum)
			endif
		endif
	endif
next
return 

function searchnotexist()
nsum := 0
cprot := ""
for i := 1 upto alen(aneartickets)
	dlgprogressupdatetext(getshell(), ntrim(i))
	anum := aneartickets[i]
	for inum := alen(anum) downto 1
		n := anum[inum]
		if n >= 0
			lexist := false
			for irules := 1 upto alen(arules)
				aranges := arules[irules][2] 
				if i == 1 .and. inum == 1
	//				cprot += typevalue2string(aranges, irules)+crlf
				endif
				for ir := 1 upto alen(aranges)
					nfrom := aranges[ir][1]
					nto := aranges[ir][2]
					if between (n, nfrom, nto) 
						lexist := true 
					endif
				next
			next 
		endif
		//cprot += typevalue2string(lexist, n, i, inum)+crlf
		if !lexist 
			nsum += n 
			aputone (anum, inum, -n)
		endif
	next 
next 
msginfo (typevalue2string(nsum))
return

function searchpossible()
nsum := 0
cprot := ""
for i := 1 upto alen(aneartickets)
	dlgprogressupdatetext(getshell(), ntrim(i))
	anum := aneartickets[i]
	for inum := alen(anum) downto 1
		n := anum[inum]
		if n >= 0
			for irules := 1 upto alen(arules)
				lexistr := false
				aranges := arules[irules][2] 
				if i == 1 .and. inum == 1
	//				cprot += typevalue2string(aranges, irules)+crlf
				endif
				for ir := 1 upto alen(aranges)
					nfrom := aranges[ir][1]
					nto := aranges[ir][2]
					if between (n, nfrom, nto) 
						lexistr := true
					endif
				next
				if !lexistr 
					apossible := arules[irules][3] 
					npos := ascandword(apossible, inum, 0)
					if npos > 0
						AAus (apossible, npos)
					endif
				endif
			next 
		endif
	next 
next 
msginfo (typevalue2string(nsum))
return

function getpossibilities()
ap := {}
for irules := 1 upto alen(arules)
	apossible := arules[irules][3] 
	AAdd (ap, aclonemacro(apossible))
next 
arulespos  := acreateone(20, 0)
return 

function reduceall ()
	for i := 1 upto 20 
		macrofunc("reducestep")
	next
return 

function reducestep ()
for irules := 1 upto alen(arules)
	apossible := ap[irules]
	if alen(apossible) == 1
		inum := apossible[1]
		aputone (arulespos, irules, inum)
		for irules2 := 1 upto alen(arules)
			apossible := ap[irules2]
			npos := ascandword(apossible, inum, 0)
			if npos > 0
				AAus (apossible, npos)
			endif
		next
		exit
	endif
next
return 

function youridcard()
cprot := ""
nres := 1.0
for i := 1 upto 6
	nrulespos := arulespos[i]
	a := ayourticket[1]
	n := a[nrulespos]
	cprot += typevalue2string(i, nrulespos, n)+crlf
	nres := nres * n
next 
msginfo (typevalue2string(nres, cprot))
return 



export cdirectory
export ninput
export npart
export cprot 
export nrules 
export arules := {}
export ayourticket := {}
export aneartickets := {}
export ap
export arulespos 