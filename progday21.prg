function Start()
cdirectory := "C:\prog\Adventofcode2020\day21"
ninput := 11
npart := 1
cprot := ""
macrofunc("Read")

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
		// mxmxvkd kfcds sqjhc nhms (contains dairy, fish)
		a2 := string2array(c, " (") 
		aingr := string2array(a2[1], " ") 
		c := a2[2]
		c := strtran(c, "contains ", "")
		c := strtran(c, ",", "")
		c := strtran(c, ")", "")
		aallerg := string2array(c, " ") 
		AAdd (adata, {aingr, aallerg})
	endif
next

aingrall := {}
for i := 1 upto alen(adata)
	aingr := adata[i][1]
	for i2 := 1 upto alen(aingr)
		c := aingr[i2]
		npos := ascanstring(aingrall, c, 1)
		if npos == 0
			AAdd (aingrall, {c, false, {}, ""})
			npos := alen(aingrall)
		endif
		a := aingrall[npos,3]
		AAdd (a, i)
	next
next

aallergall := {}
for i := 1 upto alen(adata)
	aallerg := adata[i][2]
	for i2 := 1 upto alen(aallerg)
		c := aallerg[i2]
		npos := ascanstring(aallergall, c, 1)
		if npos == 0
			AAdd (aallergall, {c, false, {}, ""})
			npos := alen(aallergall)
		endif
		a := aallergall[npos,3]
		AAdd (a, i)
	next
next

irow := 1
return 

function sumingrnoallerg()
nsum := 0
for i := 1 upto alen(aingrall)
	if !aingrall[i,2]
		nsum += alen(aingrall[i,3])
	endif
next 
msginfo (typevalue2string(nsum))
return 

function listallingr()
c := ""
asorttwodim(aallergall,1,true)
for i := 1 upto alen(aallergall)
	c := addstring(c,aallergall[i,4],",")
next 
msginfo (c)
return 


function reduceallergall()
lfoundall := true 
do while lfoundall
	lfoundall := false
	for i := alen(aallergall) downto 1 
		lfound := macrofunc("reduceallerg", {i})
		if lfound 
			//aaus (aallergall, i)
			lfoundall := true 
		endif 
	next 
enddo
return lfoundall

function reduceallergsingle()
	lfound := macrofunc("reduceallerg", {2})
return lfound 

function reduceallerg(iallergall)
lfound := false
callerg := aallergall[iallergall,1]
if !aallergall[iallergall,2]
	arows := aallergall[iallergall,3]
	aingrsum := {}
	nrows := alen(arows)
	for irow := 1 upto alen(arows)
		aingr := adata[arows[irow]][1]
		for i2 := 1 upto alen(aingr)
			c := aingr[i2]
			npos := ascanstring(aingrsum, c, 1)
			if npos == 0
				AAdd (aingrsum, {c, 0})
				npos := alen(aingrsum)
			endif
			n := aingrsum[npos,2]
			n += 1
			aputtwo (aingrsum, npos, 2, n)
		next
	next
	n := 0
	for i := 1 upto alen(aingrsum)
		if aingrsum[i,2] == nrows 
			n += 1
		endif
	next
	if n == 1
		for i := 1 upto alen(aingrsum)
			if aingrsum[i,2] == nrows 
				cingr := aingrsum[i][1]
			//msginfo (typevalue2string(callerg, cingr))
				lfound := true
				aputtwo (aallergall, iallergall,2, true)
				npos := ascanstring(aingrall, cingr, 1)
				//aaus (aingrall, npos)
				aputtwo (aallergall, iallergall,2, true)
				aputtwo (aallergall, iallergall,4, cingr)
				for irow := 1 upto alen(adata)
					aingr := adata[irow][1]
					//msginfo (typevalue2string(aingr, irow, arows[irow]))

					for i2 := alen(aingr) downto 1 
						c := aingr[i2]
						if c == cingr
							aaus (aingr, i2)
						endif
					next
				next

			endif
		next
	endif
endif
return lfound


export cdirectory
export ninput
export npart
export cprot 
export aingrall 
export aallergall 
export adata 
export irow 
