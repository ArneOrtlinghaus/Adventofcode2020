function Start()
cdir := "C:\prog\Adventofcode2020\day5"
ninput := 1
macrofunc("Read")
return

function getinfo ()
cseq := "FBFBBFFRLR"
nid := macrofunc("getid", {cseq})
return

function getid (cseq)
irow := macrofunc("getindex", {substr(cseq, 1, 7), 1, 128})
icol := macrofunc("getindex", {substr(cseq, 8, 10), 1, 8})
nid := irow * 8 + icol
return nid

function getindex (cseq, nmin, nmax)

for i := 1 upto len(cseq)
	// 1 8   -> 8v ->4v  -> 4
	// 4 8   -> 
	cch := substr(cseq, i, 1)
	nv := nmax-nmin+1
	nv := nv / 2
	if cch == "F" .or. cch == "L"
		// 1 8   -> 4   nmax := nmin+ (nmax-nmin-1)/2
		nmax := nmax- nv
	else 
		nmin := nmin+ nv
	endif
	//msginfo (typevalue2string(i, cch, nv, nmin, nmax))
next
nmin := nmin - 1
return nmin


function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
//a := string2arraykeepposition(c, crlf)
a := string2array(c, crlf)
adata := {}
cp := ""
for i := 1 upto alen(a)
	cp := a[i]
   if !Empty(cp)
	   aadd (adata, cp)
	endif
next
return 

function walk1 ()
nidmax := 0
for i := 1 upto alen(adata)
	cseq := adata[i]
	nid := macrofunc("getid", {cseq})
	nidmax := max(nidmax, nid)
next
msginfo (typevalue2string(nidmax))
return 


function walk2 ()
a := ACreateone(128*8, true)
for i := 1 upto alen(adata)
	cseq := adata[i]
	nid := macrofunc("getid", {cseq})
	APutone(a, nid+1, false)
next
a2 := {}
for i := 1 upto alen(a)
	if a[i]
		aadd (a2, i-1)
	endif
next
msginfo (typevalue2string(a2))
return 



export cdir
export ninput 
export adata
