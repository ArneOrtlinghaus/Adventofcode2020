function Start()
cdir := "C:\prog\Adventofcode2020\day8"
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
	c := a[i]
	a2 := string2array(c, " ")
	aadd (adata, {a2[1], val(a2[2])})
next
adataori := ACloneMacro(adata)
nexecutedall := 0
nlen := alen(adata)
amodified := ACreateone(nlen, false)

nexecuted := 0
return 

function execallall()
	nline := 1
	do while nexecutedall <= 1000  .and. nline <> 999991
		nexecutedall += 1
		adata := ACloneMacro(adataori)
		macrofunc("changenext", {})
		macrofunc("execall", {})
	enddo
	msginfo (typevalue2string(nline, nacc, nexecuted, nexecutedall))
return 

function changenext()
for i := 1 upto nlen
	ccommand := adata[i][1] 
	if !amodified[i]
		if ccommand == "jmp" .or. ccommand == "nop"
			if ccommand == "jmp"
				ccommand := "nop"
			elseif ccommand == "nop"
				ccommand := "jmp"
			endif
			APuttwo(adata, i, 1, ccommand)
			APutone(amodified, i, true)
			exit
		endif
	endif
next
return 

function execall()
nline := 1
nacc := 0
avisited := ACreateone(alen(adata), false)
do while nline <= alen(adata)
	dlgprogressupdatetext(getshell(), typevalue2string(nline, nacc, nexecuted))
	macrofunc("execnext", {})
	if nline <> 999999 .and. nline > alen(adata)
		msginfo ("finished: " + ntrim(nacc))
		nline := 999991
		return 
	endif
enddo	
return 

function execnext()
if nline > alen(adata)
	msginfo ("finished: " + ntrim(nacc))
	nline := 999991
	return 
endif
if avisited[nline] 
//	msginfo ("finished: " + ntrim(nacc))
	nline := 999999
	return 
endif
nexecuted += 1
APutone(avisited, nline, true)
ccommand := adata[nline][1] 
n := adata[nline][2] 
if ccommand == "acc"
	nacc += n
	nline += 1
elseif ccommand == "jmp"
	nline += n
elseif ccommand == "nop"
	nline += 1
else 
msgerror ("wrong command " + ccommand + " " + ntrim(nline))
endif
//msginfo (typevalue2string(nline, nacc, nexecuted))
return





export cdir
export ninput 
export adata
export avisited
export nline
export nacc
export nexecuted
export nexecutedall
export nlen
export adataori
export amodified