function Start()
cdir := "C:\prog\Adventofcode2020\day4"
ninput := 1
npart := 1
macrofunc("Read")
return

function read()
cfile := faddbackslash(cdir)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
a := string2arraykeepposition(c, crlf)
adata := {}
cp := ""
for i := 1 upto alen(a)
	c := alltrim(a[i])
	if !empty(c)
	cp += " " + c 
	else 
	   if !Empty(cp)
		   aadd (adata, cp)
		   cp := ""
		endif
	endif
next
   if !Empty(cp)
	   aadd (adata, cp)
	   cp := ""
	endif
return 

function walk ()
nsum := 0
for i := 1 upto alen(adata)
	cp := adata[i]
	app := macrofunc("parsepp", {cp})
	lok := macrofunc("checkok", {app})
	if lok 
		nsum += 1
	endif
	//msginfo (typevalue2string(lok, app))
next
return nsum

function checkok (app)
lok := true 
cprot := ""
aprops := {"byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"}
for iprop := 1 upto alen(aprops)
	cprop := aprops[iprop]
	c := ArrayGetValueTwodim(app, cprop, 1, 2, "")
	c := alltrim(c)
	if lok .and. empty(c)
		lok := false
	endif
	if lok 
		cprot += cprop+crlf
		if cprop == "byr"
    // byr (Birth Year) - four digits; at least 1920 and at most 2002.
			n := val(c)
			if !between(n, 1920,2002)
				lok := false 
			endif
		elseif cprop =="iyr"
    // iyr (Issue Year) - four digits; at least 2010 and at most 2020.
			n := val(c)
			if !between(n, 2010,2020)
				lok := false 
			endif
		elseif cprop =="eyr"
    // eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
			n := val(c)
			if !between(n, 2020,2030)
				lok := false 
			endif
		elseif cprop =="hgt"
    // hgt (Height) - a number followed by either cm or in:
    //     If cm, the number must be at least 150 and at most 193.
    //     If in, the number must be at least 59 and at most 76.
			if right(c, 2) == "cm"
			   c := substr(c, 1, len(c)-2)
				n := val(c)
				if !between(n, 150,193)
					lok := false 
				endif
			elseif right(c, 2) == "in"
			   c := substr(c, 1, len(c)-2)
				n := val(c)
				if !between(n, 59,76)
					lok := false 
				endif
			else 
				lok := false
			endif
		elseif cprop =="hcl"
    // hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
			if !(substr(c,1,1)=="#")
				lok := false 
			endif
			if len(c) <> 7
				lok := false 
			endif
			for ic := 2 upto len(c)
				cch := substr(c, ic,1)
				if !between(cch, "0", "9") .and. !between(cch, "a", "f")
					lok := false 
				endif
			next
		elseif cprop =="ecl"
    // ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
		if !inlist (c, "amb","blu","brn","gry","grn","hzl","oth")
			lok := false 
		endif
		elseif cprop =="pid"
    // pid (Passport ID) - a nine-digit number, including leading zeroes.
			if len(c) <> 9
				lok := false 
			endif
			for ic := 1 upto len(c)
				cch := substr(c, ic,1)
				if !between(cch, "0", "9")
					lok := false 
				endif
			next
		endif
	endif
	if !lok 
		exit 
	endif
next

//msginfo (Typevalue2string(lok, cprot, app))

return  lok 


function parsepp (cp)
// " ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm"
cp := alltrim(cp)
a := string2array(cp, " ")
app := {}
for i := 1 upto alen(a)
   cx := a[i]
   ax := string2array(cx, ":")
   AAdd (app, ax)  
next
return app


export cdir
export npart
export ninput 
export adata
