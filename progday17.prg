function Start()
cdirectory := "C:\prog\Adventofcode2020\day17"
ninput := 11
npart := 1

nstart := 7+1
ndim := 8+8+8
macrofunc("Read")

cprot := ""
istep := 0
return

function read()
cfile := faddbackslash(cdirectory)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
a := string2arraykeepposition(c, crlf)

// z, y, x
adata := {}
for iw := 1 upto ndim
	aw := ACreateThree(ndim, ndim, ndim, ".")
	AAdd (adata, aw)
next	
iw := nstart
iz := nstart
for iy := 1 upto alen(a)
	c := alltrim(a[iy])
	for ix := 1 upto len(c)
		c2 := substr(c, ix, 1)
		aw := adata[iw]
		APutThree(aw, iz, nstart+iy, nstart+ix, c2)
	next
next
return 

function allsteps()
for i := 1 upto 6
	macrofunc("nextstep")
next 
macrofunc("count")
return 

function count()
nsum := 0
for iw := 2 upto ndim-1
	for iz := 2 upto ndim-1
		for iy := 2 upto ndim-1
			for ix := 2 upto ndim-1
				c := adata[iw, iz, iy, ix]
				if c == "#"
					nsum += 1
				endif 
			next 
		next 
	next 
next
msginfo (typevalue2string(nsum))
return
	
function nextstep()
// z, y, x
istep += 1
//cprot += "Step " + ntrim(istep)+crlf
adatan := {}
for iw := 1 upto ndim
	aw := ACreateThree(ndim, ndim, ndim, ".")
	AAdd (adatan, aw)
next	

for iw := 2 upto ndim-1
	dlgprogressupdatetext(getshell(), ntrim(istep) + " " + ntrim(iw))
	for iz := 2 upto ndim-1
		for iy := 2 upto ndim-1
			for ix := 2 upto ndim-1
				c := adata[iw, iz, iy, ix]
				cn := ""
				for iw1 := -1 upto 1
					for iz1 := -1 upto 1
						for iy1 := -1 upto 1
							for ix1 := -1 upto 1
								if iw1 <> 0 .or. iz1 <> 0 .or. iy1 <> 0 .or. ix1 <> 0
									cn += adata[iw+iw1, iz+iz1, iy+iy1, ix+ix1]
								endif
							next 
						next 
					next
				next
				n := occurs("#", cn)
				// If a cube is active and exactly 2 or 3 of its neighbors are also active, the cube remains active. Otherwise, the cube becomes inactive.
				// If a cube is inactive but exactly 3 of its neighbors are active, the cube becomes active. Otherwise, the cube remains inactive.

				if c == "#"
					if n == 2 .or. n == 3
						//msginfo ("remain " + typevalue2string(ix, iy, iz, n, cn))
						aw := adatan[iw]
						APutThree(aw, iz, iy, ix, "#")
//						cprot += "remain " + typevalue2string(ix, iy, iz, n, cn)+crlf
					endif
				else 
					if n == 3
						//msginfo ("activate " + typevalue2string(ix, iy, iz, n, cn))
						aw := adatan[iw]
						APutThree(aw, iz, iy, ix, "#")
//						cprot += "new  " + typevalue2string(ix, iy, iz, n, cn)+crlf
					endif
				endif

			next 
		next 
	next
next
adata := adatan
//macrofunc("count")

return 

export cdirectory
export ninput
export npart
export cprot 
export istep 
export adata
export nstart
export ndim