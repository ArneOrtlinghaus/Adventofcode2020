function Start()
cdirectory := "C:\prog\Adventofcode2020\day25"
ninput := 11
nmaxtransform := 100000000
if ninput == 1
	n1 := 17807724
	n2 := 5764801
elseif ninput == 11
	n1 := 7573546
	n2 := 17786549	
endif	
npart := 1
cprot := ""
return

function transformall ()
a1 := macrofunc ("transformarray", {n1, false})
a2 := macrofunc ("transformarray", {n2, true})
return 

function transformarray (nsubject, lnumberiskey)
n := 1 
a := clsdictionaryStringstring{}

for i := 1 upto nmaxtransform
	n := (1.0*n) * (1.0*nsubject)
	ndiv := floor(n / 20201227.0)
	n := n - (ndiv*20201227.0)
	if lnumberiskey
		a:addorupdate(alltrim(str(n, 20, 0)), ntrim(i))
	else 
		a:addorupdate(ntrim(i), alltrim(str(n, 20, 0)))
	endif
next 
return a

function getkeys ()
nkey1 := macrofunc ("getkey", {n1, l2})
nkey2 := macrofunc ("getkey", {n2, l1})
return 

function getkey (npublic, l)
n := 1 
nsubject := npublic
lfound := false
for i := 1 upto l
	n := (1.0*n) * (1.0*nsubject)
	ndiv := floor(n / 20201227.0)
	n := n - (ndiv*20201227.0)
next 
return n

function getloops ()
l1 := macrofunc ("getloop", {n1})
l2 := macrofunc ("getloop", {n2})
return 

function getloop (npublic)
n := 1 
nsubject := 7
lfound := false
for i := 1 upto nmaxtransform
	n := (1.0*n) * (1.0*nsubject)
	ndiv := floor(n / 20201227.0)
	n := n - (ndiv*20201227.0)
	if n == npublic
		lfound := true 
		exit
	endif
next 
return i

function comp()
lfound := false
for i1 := 1 upto a1:count
	nn1 := a1:getvalue(ntrim(i1))
	if a2:Exists(nn1)
		msginfo ("res: " + typevalue2string(nn1, i1, a2:getvalue(nn1)))
		lfound := true
		exit
	endif
	if lfound 
		exit 
	endif 
next 
return 

export cdirectory
export ninput
export npart
export cprot 
export nmaxtransform
export n1 
export n2 
export a1 
export a2
export anumbers
export l1 
export l2
export nkey1 
export nkey2