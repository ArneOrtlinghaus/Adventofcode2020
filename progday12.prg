function Start()
cdirectory := "C:\prog\Adventofcode2020\day12"
ninput := 1
npart := 2
macrofunc("Read")
return

// ne = Osten, nn=Norden
// idir = 0 Norden, 1 Osten, 2 Süden, 3 Westen
//Action N means to move north by the given value.
//    Action S means to move south by the given value.
//    Action E means to move east by the given value.
//    Action W means to move west by the given value.
//    Action L means to turn left the given number of degrees.
//    Action R means to turn right the given number of degrees.
//    Action F means to move forward by the given value in the direction the ship is currently facing.

function read()
cfile := faddbackslash(cdirectory)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
a := string2array(c, crlf)
adata := {}
for i := 1 upto alen(a)
	c := alltrim(a[i])
	cdir := substr(c, 1,1)
	n := val(substr(c, 2))
	aadd (adata, {cdir, n})
next
ndata := alen(adata)

idir := 1
nn := 0
ne := 0
wn := 1
we := 10
irow := 1
cprot := ""
return 

function execnext2 (cdir, n)
// Action N means to move the waypoint north by the given value.
//     Action S means to move the waypoint south by the given value.
//     Action E means to move the waypoint east by the given value.
//     Action W means to move the waypoint west by the given value.
//     Action L means to rotate the waypoint around the ship left (counter-clockwise) the given number of degrees.
//     Action R means to rotate the waypoint around the ship right (clockwise) the given number of degrees.
//     Action F means to move forward to the waypoint a number of times equal to the given value.
if cdir == "N"
wn+= n
elseif cdir == "S"
wn-= n
elseif cdir == "E"
we+= n
elseif cdir == "W"
we-= n
elseif cdir == "L"
idir :=-1*n/90
idir += 4
elseif cdir == "R"
idir :=1*n/90
elseif cdir == "F"
	nn += wn*n
	ne += we*n
else 
	msgerror ("Wrong dir " + cdir)
endif

if cdir == "L" .or. cdir == "R"
	if idir == 1
		wen := wn 
		wn := -we 
		we := wen
	elseif idir == 2
		wn := -wn
		we := -we
	elseif idir == 3
		wen := -wn 
		wn := we 
		we := wen
	endif
endif

cprot += cdir + ntrim(n) + " " + ntrim(nn) + " " + ntrim(ne) +   " " + ntrim(idir) + crlf
return 


function execnext (cdir, n)
if cdir == "N"
nn+= n
elseif cdir == "S"
nn-= n
elseif cdir == "E"
ne+= n
elseif cdir == "W"
ne-= n
elseif cdir == "L"
idir -= 1*n/90
if idir == -1
idir := 3
elseif idir == -2
idir := 2
elseif idir == -3
idir := 1
endif
elseif cdir == "R"
idir += 1*n/90
if idir == 4
idir := 0
elseif idir == 5
idir := 1
elseif idir == 6
idir := 2
endif
elseif cdir == "F"
	if idir == 0
		nn += n
	elseif idir == 1
		ne += n
	elseif idir == 2
		nn -= n
	elseif idir == 3
		ne -= n
	endif
else 
	msgerror ("Wrong dir " + cdir)
endif

cprot += cdir + ntrim(n) + " " + ntrim(nn) + " " + ntrim(ne) +   " " + ntrim(idir) + crlf
return 

function execsingle ()
	cdir := adata[irow][1]
	n := adata[irow][2]
	macrofunc("execnext", {cdir, n})
return 

function execall ()
idir := 1
nn := 0
ne := 0
wn := 1
we := 10

cprot := ""
for i := 1 upto ndata 
	cdir := adata[i][1]
	n := adata[i][2]
	macrofunc("execnext2", {cdir, n})
next
return 


export cdirectory
export ninput
export npart
export ndata
export adata
export idir 
export nn
export ne
export wn
export we
export irow 
export cprot