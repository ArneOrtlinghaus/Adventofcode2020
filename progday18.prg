function Start()
cdirectory := "C:\prog\Adventofcode2020\day18"
ninput := 11
npart := 1

macrofunc("Read")

cprot := ""
return

function read()
cfile := faddbackslash(cdirectory)+"input"
cfile +=ntrim(ninput)
cfile +=".txt"
c := ffileread(cfile)
c := trimcrlf(c)
//a := string2arraykeepposition(c, crlf)
a := string2array(c, crlf)

adata := {}
for i := 1 upto alen(a)
c := a[i] 
//1 + (2 * 3) + (4 * (5 + 6))
c := strtran(c, "(", " ( ")
c := strtran(c, ")", " ) ")
c := strtran(c, "  ", " ")
aadd (adata, c)
next

return 

function calc()
cprot := ""
fsum := 0.0
for i := 1 upto alen(adata)
	cline := adata[i]
	a := string2array(cline, " ")
	f := macrofunc("Parse",{a, 1, alen(a)})
	fsum += f + 0.0
	cprot += typevalue2string(f) + " " + cline+crlf
next 
msginfo (typevalue2string(fsum))
return 


function Parse(a, na, ne)
cprot += "panfang " + typevalue2string(na, ne, a[na], a[ne]) +crlf
astack := {}
f := 0
np := 0
i := na
do while i <= ne
   c := a[i]
   c := alltrim(c)
   if c == "+" .or. c == "*"
		AAdd (astack, {f, c})
      // cprot += "fp = " + typevalue2string(fp, f, cop) +crlf
   elseif c == "("
      i2 := i +1
      np += 1
      do while np > 0 .and. i2 <= ne
         c := a[i2]
         if c == "("
            np += 1
         elseif c == ")"
            np := np - 1
         endif
         if np > 0
            i2 += 1
         endif
      enddo
      //      msginfo(typevalue2string(i, i2, np, c))
      f := macrofunc("Parse",{a, i+1, i2-1})
      i := i2
   else
      f := val(c)
   endif
   i += 1
enddo
AAdd (astack, {f, ""})
//msginfo (typevalue2string(astack,))
//cprot += "pende stack " + typevalue2string(astack) +crlf
for i := alen(astack)-1 downto 1
	 c := astack[i,2]
	 if c == "+"
		f := astack[i,1]
		f2 := astack[i+1,1]
		f := f + f2
		aputtwo (astack, i+1, 1, f)
		AAus (astack, i)
	endif
next 
//cprot += "pende stack b " + typevalue2string(astack) +crlf
for i := alen(astack)-1 downto 1
	 c := astack[i,2]
	 if c == "*"
		f := astack[i,1]
		f2 := astack[i+1,1]
		f := f * f2 * 1.0
		aputtwo (astack, i+1, 1, f)
		AAus (astack, i)
	endif
next 
//cprot += "pende stack e " + typevalue2string(astack) +crlf
//msginfo (typevalue2string(astack,f))
//cprot += "pende " + typevalue2string(f, na, ne, a[na], a[ne]) +crlf
return f



export cdirectory
export ninput
export npart
export cprot 

export adata

export cline 
