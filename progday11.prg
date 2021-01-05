function Start()
cdir := "C:\prog\Adventofcode2020\day11"
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
for i := 1 upto alen(a)
	c := alltrim(a[i])
	a2 := {}
	for i2 := 1 upto len(c)
		c2 := substr(c, i2, 1)
		aadd (a2, c2)
	next
	nx := len(a2)
	aadd (adata, a2)
next
ny := alen(adata)

return 

function execall ()
lmodified := true
n := 0
nocc := macrofunc ("count")
do while lmodified 
   n += 1
	dlgprogressupdatetext(getshell(), ntrim(n) + " " + ntrim(nocc))
	macrofunc("nextround")
	nocc := macrofunc ("count")
enddo	
return 

function nextround ()
adatanew := ACloneMacro(adata)
lmodified := false
for iy := 1 upto ny 
	for ix := 1 upto nx
		c := adata[iy,ix]
		if c == "L"
			nocc := macrofunc("occupiedaround2", {ix, iy})
			if nocc == 0
				lmodified := true
				c := "#"
				APutTwo(adatanew, iy, ix, c)
			endif
		elseif c == "#"
			nocc := macrofunc("occupiedaround2", {ix, iy})
			if nocc >= 5 // 4
				lmodified := true
				c := "L"
				APutTwo(adatanew, iy, ix, c)
			endif
		endif		
	next 
next
adata := adatanew
return 

function count ()
nocc := 0
for iy := 1 upto ny 
	for ix := 1 upto nx
		c := adata[iy,ix]
		if c == "#"
			nocc += 1
		endif 
	next 
next 
return nocc

function occupiedaround2 (ix, iy)
nocc := 0
for iyidx := -1 upto 1
	for ixidx := -1 upto 1
		if iyidx <> 0 .or. ixidx <> 0
			lgoon := true 
			ixn := ix 
			iyn := iy 
			do while lgoon 
				ixn += ixidx 
				iyn += iyidx 
				if between (ixn, 1, nx)
					if between (iyn, 1, ny)
						c := adata[iyn,ixn]
						if c == "#" 
							nocc += 1
							lgoon := false 
						elseif c == "L" 
							lgoon := false 
						endif
					else 
						lgoon := false
					endif
				else 
					lgoon := false
				endif
			enddo
		endif
	next
next
//if ix == 7 .and. iy == 1
//msginfo (typevalue2string(nocc))
//endif
return nocc



function occupiedaround1 (ix, iy)
nocc := 0
for iyn := iy-1 upto iy+1
	if between (iyn, 1, ny)
		for ixn := ix-1 upto ix+1
			if between (ixn, 1, nx) 
				if iyn <> iy .or. ixn <> ix 
					if adata[iyn,ixn] == "#"
						nocc += 1
					endif
				endif
			endif
		next
	endif 
next
//if ix == 7 .and. iy == 1
//msginfo (typevalue2string(nocc))
//endif
return nocc

export lmodified
export cdir
export ninput 
export adata
export nx 
export ny
export npart
export adatanew