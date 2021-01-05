function Start()
cdirectory := "C:\prog\Adventofcode2020\day20"
ninput := 11
npart := 1
cprot := ""
aborders := {}
macrofunc("Read")
macrofunc("calcbordersall")
macrofunc("calcborderarray")

ndim := sqrt(alen(atiles))

return

function calcroughsea()
n := 0
nlen := alen(aimage)
for iy := 1 upto nlen
	for ix := 1 upto nlen
		c := aimage[iy,ix]
		if c == "#"
			n += 1
		endif 
	next 
next 

msginfo (typevalue2string(n, n-(nfound*15)))
return


function createmonster()
amonster := {}
for i := 1 upto 3
	if i == 1
		c:= "                  #" 
	elseif i == 2
		c :="#    ##    ##    ###"
	else	
		c := " #  #  #  #  #  #"
	endif
	a2 := {} 
	for i2 := 1 upto len(c)
		c2 := substr(c, i2,1)
		if c2 == " "
			c2 := "."
		endif
		aadd (a2, c2)
	next 
	aadd (amonster, a2)
next

return

function searchmonster()
nfound := 0
cprot := ""
nlen := alen(aimage)
for iloop := 1 upto 2
	for iy := 1 upto nlen
		for ix := 1 upto nlen
		dlgprogressupdatetext(getshell(), ntrim(iy) + " " + ntrim(ix))

			if macrofunc ("searchmonsterposx", {iy, ix, 1, 1})
				nfound += 1
			endif
			if macrofunc ("searchmonsterposx", {iy, ix, 1, -1})
				nfound += 1
			endif
			if macrofunc ("searchmonsterposx", {iy, ix, -1, 1})
				nfound += 1
			endif
			if macrofunc ("searchmonsterposx", {iy, ix, -1, -1})
				nfound += 1
			endif
		next 
	next
	if iloop == 1
		macrofunc ("transposeimage")
	endif
next

msginfo (typevalue2string(nfound))
return

function transposeimage()
nlen := alen(aimage)
aimagenew := acreatetwo (nlen, nlen, "")
for iy := 1 upto nlen
for ix := 1 upto nlen
	c := aimage[iy,ix]
	aputtwo (aimagenew, ix, iy, c)
next 
next 
aimage := aimagenew 
return 

function Mirrorimagey()
nlen := alen(aimage)
aimagenew := acreatetwo (nlen, nlen, "")
for iy := 1 upto nlen
for ix := 1 upto nlen
	c := aimage[iy,ix]
	iynew := nlen-iy+1
	aputtwo (aimagenew, iynew, ix, c)
next 
next 
aimage := aimagenew 
return 

function Mirrorimagex()
nlen := alen(aimage)
aimagenew := acreatetwo (nlen, nlen, "")
for iy := 1 upto nlen
for ix := 1 upto nlen
	c := aimage[iy,ix]
	ixnew := nlen-ix+1
	aputtwo (aimagenew, iy, ixnew, c)
next 
next 
aimage := aimagenew 
return 

function searchmonsterposx (iyoffset, ixoffset, iydiff, ixdiff)
lfound := true
for iloop := 1 upto 2
	iy := iyoffset
	for iymonster := 1 upto 3
		ix := ixoffset
		amonsterline := amonster[iymonster]
		for ixmonster := 1 upto alen(amonsterline)
			if !between(ix, 1, alen(aimage)) .or. !between(iy, 1, alen(aimage)) 
				lfound := false
			endif
			if lfound 
				if lfound
					cmonster := amonster[iymonster, ixmonster] 
					if cmonster == "#"
						cimage := aimage[iy,ix] 
						if iloop == 2
							aputtwo (aimage, iy, ix, "O")
						else
							if !(cimage==cmonster)
								lfound := false 
							endif
						endif
					endif
				endif
			endif
			if !lfound 
				exit 
			endif
			ix += ixdiff
		next 
		iy += iydiff
		if !lfound 
			exit 
		endif
	next 
	if !lfound 
		exit 
	endif
next
return lfound
 


function generateimage()
aimage := acreatetwo (8*ndim, 8*ndim, "")
iyoffset := 0
for iygrid := 1 upto ndim 
	ixoffset := 0
	for ixgrid := 1 upto ndim 
		ntilecurrent := agrid[iygrid, ixgrid]
		irow := ascanusual(adata, ntilecurrent, 1)
		amem := adata[irow,2]
		for iy := 2 upto 9
			for ix := 2 upto 9
				c := amem[iy,ix]
				aputtwo (aimage, iy+iyoffset-1,ix+ixoffset-1, c)
			next
		next
		ixoffset += 8
	next 
	iyoffset += 8
next 

return 


function generateimageborders()
aimage := acreatetwo (10*ndim, 10*ndim, "?")
iyoffset := 0
for iygrid := 1 upto ndim 
	ixoffset := 0
	for ixgrid := 1 upto ndim 
		ntilecurrent := agrid[iygrid, ixgrid]
		if ntilecurrent > 0
			irow := ascanusual(adata, ntilecurrent, 1)
			amem := adata[irow,2]
			
			lmirrorx := false
			if ixgrid > 1
				ix := 1 
				for iy := 1 upto 10
					c := amem[iy,ix]
					ci := aimage [iy+iyoffset,ix+ixoffset-1]
					if !(c == ci) 
						lmirrorx := true 
					endif
				next
			endif
			if lmirrorx 
				msginfo ("mirrorx " + typevalue2string(ntilecurrent))
			endif
			for iy := 1 upto 10
				for ix := 1 upto 10
					c := amem[iy,ix]
					aputtwo (aimage, iy+iyoffset,ix+ixoffset, c)
				next
			next
		endif
		ixoffset += 10
	next 
	iyoffset += 10
next 
c := ""
for iy := 1 upto alen(aimage)
	for ix := 1 upto alen(aimage)
		c += aimage[iy,ix]
	next 
	c += crlf
next
return c

function arrangetileother()
cprot += "arrangetileother"+typevalue2string(ntileother, CSEARCHBORDER, csearchother, lmirrorother)+ crlf
macrofunc("gettileotherborderinfo")
// drehen 
if CSEARCHBORDER == "R" .and. inlist (csearchother, "U", "O")
	cprot += "transpose"+crlf
	macrofunc("transpose")
	macrofunc("gettileotherborderinfo")
elseif CSEARCHBORDER == "U" .and. inlist (csearchother, "L", "R")
	cprot += "transpose"+crlf
	macrofunc("transpose")
	macrofunc("gettileotherborderinfo")
endif
if CSEARCHBORDER == "R" .and. csearchother == "R"
	cprot += "mirrorx 1"+crlf
	macrofunc("Mirrorx")
	macrofunc("gettileotherborderinfo")
elseif CSEARCHBORDER == "U" .and. csearchother == "U"
	cprot += "mirrory 1"+crlf
	macrofunc("Mirrory")
	macrofunc("gettileotherborderinfo")
endif
if CSEARCHBORDER == "R" .and. lmirrorother
 	cprot += "mirrory 2"+crlf
 	macrofunc("Mirrory")
 	macrofunc("gettileotherborderinfo")
elseif CSEARCHBORDER == "U" .and. lmirrorother
 	cprot += "mirrorx 2"+crlf
 	macrofunc("Mirrorx")
 	macrofunc("gettileotherborderinfo")
endif
return 

function gettileotherborderinfo()
ab := adata[irow,3]
npos := ascanusual(ab, nselfprimecontrol, 2)
lmirrorother := false
if npos == 0
	npos := ascanusual(ab, nselfprimecontrol, 3)
	lmirrorother := true
endif
if npos == 0
	msgerror ("primenotfound "+typevalue2string(ab, nselfprimecontrol))
	return 
endif
abordersother := ab[npos]
if npos == 1
	csearchother := "O"
elseif npos == 2
	csearchother := "R"
elseif npos == 3
	csearchother := "U"
elseif npos == 4
	csearchother := "L"
endif	

cprot += "tileborderinfo " + typevalue2string(csearchother, lmirrorother)+crlf
return 

function transpose()
amem := adata[irow,2]
amemnew := acreatetwo (10, 10, "")
for iy := 1 upto 10
for ix := 1 upto 10
	c := amem[iy,ix]
	aputtwo (amemnew, ix, iy, c)
next 
next 
amem := amemnew 
aputtwo (adata, irow, 2, amem)
macrofunc("calcborders", {})
return 


function Mirrory()
amem := adata[irow,2]
amemnew := acreatetwo (10, 10, "")
for iy := 1 upto 10
for ix := 1 upto 10
	c := amem[iy,ix]
	iynew := 10-iy+1
	aputtwo (amemnew, iynew, ix, c)
next 
next 
amem := amemnew 
aputtwo (adata, irow, 2, amem)
macrofunc("calcborders", {})
return 

function Mirrorx()
amem := adata[irow,2]
amemnew := acreatetwo (10, 10, "")
for iy := 1 upto 10
for ix := 1 upto 10
	c := amem[iy,ix]
	ixnew := 10-ix+1
	aputtwo (amemnew, iy, ixnew, c)
next 
next 
amem := amemnew 
aputtwo (adata, irow, 2, amem)
macrofunc("calcborders", {})
return 

function searchgrid()
macrofunc ("Start")
cprot := ""
agrid := acreatetwo(ndim, ndim, 0)
if ninput == 1
aputtwo(agrid, 1, 1, 2971)
else 
	ntilecurrent := 3931
	aputtwo(agrid, 1, 1, ntilecurrent)
	irow := ascanusual(adata, ntilecurrent, 1)
	macrofunc("Mirrory")
	macrofunc("calcbordersall")
	macrofunc("calcborderarray")
endif

/ / erste Zeile
nysearch := 1
ntilecurrent := agrid[1,1]
csearchborder := "R"
for nxsearch := 2 upto ndim
	if !macrofunc ("searchneighbor")
		return 
	endif
	macrofunc("calcbordersall")
	macrofunc("calcborderarray")
	ntilecurrent := ntileother
next

for nysearch := 2 upto ndim
	csearchborder := "U"
	for nxsearch := 1 upto ndim
		ntilecurrent := agrid[nysearch-1,nxsearch]
		if !macrofunc ("searchneighbor")
			return 
		endif
		macrofunc("calcbordersall")
		macrofunc("calcborderarray")
		ntilecurrent := ntileother
	next
next
return 


function searchneighbor()
nbordersexist := 8
if inlist (nxsearch, 1, ndim)
	nbordersexist -= 1
endif
if inlist (nysearch, 1, ndim)
	nbordersexist -= 1
endif
npos := ascanusual(atiles, ntilecurrent, 1)
if npos == 0
	msgerror ("tile not found searchneighbor tilecurrent " + typevalue2string(ntilecurrent))
	return 
endif
ab := atiles[npos][4]

//{{{1489, 3, 157586, 41470, "L"}
//, {2971, 1, 157586, 41470, "R"}
//}
//, {{2971, 0, 1595, 494, "O"}
//}
//, {{2971, 2, 50141, 1870, "U"}
//, {2729, 0, 50141, 1870, "O"}
//}
//, {{2971, 3, 1785, 52003, "L"}
//}
//}
lfound := false
for ib := 1 upto alen(ab)
	abb := ab[ib]
	if alen(abb) == 2
		for ibb := 1 upto alen(abb)
			ntile :=abb[ibb,1]
			if ntile == ntilecurrent .and.  abb[ibb,5] == csearchborder 
				lfound := true
			endif 
			if lfound
				if ibb == 1
					aother := abb[2]
				else
					aother := abb[1]
				endif
				ntile := aother[1]
				if macrofunc("existingrid", {ntile})
					lfound := false
				endif
			endif
			if lfound 
				exit
			endif
		next
		if lfound 
			exit 
		endif
	endif
next
if lfound
	ntileother := ntile
// msginfo ("Searchneighbor " + typevalue2string(nxsearch, nysearch, ntilecurrent, ntileother))
 

	aputtwo (agrid, nysearch, nxsearch, ntile)

	irow := ascanusual(adata, ntilecurrent, 1)

	nselfprimeother := aother[3]

	ab := adata[irow,3]
	npos := ascanusual(ab, nselfprimeother, 2)
	lmirrorother := false
	if npos == 0
		npos := ascanusual(ab, nselfprimeother, 3)
	endif
	if npos == 0
		msgerror ("primenotfound "+typevalue2string(ab, nselfprimecontrol))
		return 
	endif
	nselfprimecontrol := ab[npos][2] 
	

	irow := ascanusual(adata, ntile, 1)

	macrofunc("arrangetileother")
else 
	msgerror ("Tile not found searchneighbor tile other " + typevalue2string(ntilecurrent, csearchborder))
endif	
return lfound

function existingrid (ntile) 
lexist := false
for iy := 1 upto ndim 
for ix := 1 upto ndim 
	if agrid[iy,ix] == ntile 
		lexist := true 
		exit
	endif 
next 
	if lexist 
		exit
	endif
next

return lexist
function read()
cfile := faddbackslash(cdirectory)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
a := string2arraykeepposition(c, crlf)
adata := {}
arow := {}
for i := 1 upto alen(a)
	c := alltrim(a[i])
	cprot += ntrim(i) + " " + c + crlf
	if !Empty(c)
		csearch := "Tile "
		if substr(c, 1, 5) == csearch
			if !Empty(arow) 
				AAdd (adata, arow)
			endif
			c := strtran(c, csearch, "")
			c := strtran(c, ":", "")
			c := val(c)
			amem := {}
			arow := {c, amem, {}}
		else 
			a2 := {}
			for i2 := 1 upto len(c)
				cx := substr(c, i2, 1)
				aadd (a2, cx)
			next
			aadd (amem, a2)
		endif
	endif
next
if !Empty(arow) 
	AAdd (adata, arow)
endif
irow := 1
return 

function calcborderarray()
aborders := {}
for irow := 1 upto alen(adata)
   adir := adata[irow,3]
	ntile := adata[irow,1]
	for idir := 1 upto alen(adir)
		n := adir[idir,1]
		npos := ascanstring (aborders, n, 1)
		if npos == 0
			aadd (aborders, {n, {}})
			npos := alen(aborders)
		endif
		ap := aborders[npos,2] 
		if idir == 1
			cdir := "O"
		elseif idir == 2 
			cdir := "R"
		elseif idir == 3
			cdir := "U"
		elseif idir == 4
			cdir := "L"
		endif
		AAdd (ap, {ntile, idir-1, adir[idir,2], adir[idir,3], cdir})
	next
next
atiles := {}
for i := 1 upto alen(aborders)
	a := aborders[i][2]
	for i2 := 1 upto alen(a)
		ntile := a[i2,1]
		npos := ascanusual(atiles, ntile, 1)
		if npos == 0
			AAdd (atiles, {ntile, {}, 0, {}})
			npos := alen(atiles)
		endif
		ax := atiles[npos][2]
		n := atiles[npos][3]
		Aadd (ax, alen(a))
		n += alen(a)
		aputtwo (atiles, npos, 3, n)
		ax := atiles[npos][4]
		Aadd (ax, a)
	next
next
return 

function calcbordersall()
aborders := {}
for irow := 1 upto alen(adata)
	macrofunc("calcborders", {})
next

function calcborders()
a := {}
a2 := macrofunc("calcborder", {0})
AAdd (a, a2)
a2 := macrofunc("calcborder", {1})
AAdd (a, a2)
a2 := macrofunc("calcborder", {2})
AAdd (a, a2)
a2 := macrofunc("calcborder", {3})
AAdd (a, a2)
	aputtwo (adata, irow,3,a)
return  

function calcborder(ndir)
// 0: oberer Rand 
// 2: unterer Rand
// 1: linker Rand 
// 3: rechter Rand
amem := adata[irow,2]
n := 1 
nexact := 1
nexactu := 1
aprimeexact := {2, 3, 5, 7, 11, 13, 17, 19, 23, 29}
aprimeexactu := {29, 23, 19, 17, 13, 11, 7, 5, 3, 2}
if ndir == 0
	iy := 1
	for ix := 1 upto 10
		c := amem[iy,ix]
		if c == "#"
			nexact := nexact * aprimeexact[ix]
			nexactu := nexactu * aprimeexactu[ix]
		endif
	next
elseif ndir == 2
	iy := 10
	for ix := 1 upto 10
		c := amem[iy,ix]
		if c == "#"
			nexact := nexact * aprimeexact[ix]
			nexactu := nexactu * aprimeexactu[ix]
		endif
	next
elseif ndir == 3
	ix := 1
	for iy := 1 upto 10
		c := amem[iy,ix]
		if c == "#"
			nexact := nexact * aprimeexact[iy]
			nexactu := nexactu * aprimeexactu[iy]
		endif
	next
elseif ndir == 1
	ix := 10
	for iy := 1 upto 10
		c := amem[iy,ix]
		if c == "#"
			nexact := nexact * aprimeexact[iy]
			nexactu := nexactu * aprimeexactu[iy]
		endif
	next
endif
c := ntrim(min(nexact,nexactu))+"_"+ntrim(max(nexact,nexactu))
return {c, nexact, nexactu}


export cdirectory
export ninput
export npart
export cprot 

export adata 
export irow 
export aborders
export atiles
export ndim

export agrid
export ntilecurrent
export ntileother
export nxsearch
export nysearch
export csearchborder
export aother
export nselfprimecontrol
export abordersother

export csearchother
export lmirrorother
export amem
export aimage
export amonster
export nfound