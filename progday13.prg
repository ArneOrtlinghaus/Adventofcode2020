function Start()
cdirectory := "C:\prog\Adventofcode2020\day13"
ninput := 0
npart := 1
macrofunc("Read0")
return

function read0()
ntsmin := 939
abus := {7,13,59,31,19}
return 

function read1()
ntsmin := 1001287
abus := {13,37,461,17,19,29,739,41,23}
return 

function read0b()
abus := {7,13,0,0,59,0,31,19}
return 

function read1b()
abus := {13,0,0,0,0,0,0,37,0,0,0,0,0,461,0,0,0,0,0,0,0,0,0,0,0,0,0,17,0,0,0,0,19,0,0,0,0,0,0,0,0,0,29,0,739,0,0,0,0,0,0,0,0,0,41,0,0,0,0,0,0,0,0,0,0,0,0,23}
return 

function read0c()
abus := {17,0,13,19}
return 

function read0d()
abus := {1789,37,47,1889}
return 

function calcb()
c := ""
for ibus := 1 upto alen(abus)
		nbus := abus[ibus]
		if nbus > 0
			nmod := nbus-(ibus-1)
			do while nmod < 0 
				nmod += nbus 
			enddo
			do while nmod >= nbus
				nmod -= nbus 
			enddo
			c += ntrim(nmod) 
			c += " " + ntrim(nbus)+crlf
		endif
next 

return


// https://www.dcode.fr/chinese-remainder
// 0 13
// 30 37
// 448 461
// 7 17
// 6 19
// 16 29
// 695 739
// 28 41
// 2 23
// x=552612234243498 x≡0mod13x≡30mod37x≡448mod461x≡7mod17x≡6mod19x≡16mod29x≡695mod739x≡28mod41x≡2mod23


function calc()
cprot := ""
for ibus := 1 upto alen(abus)
	nbus := abus[ibus]
   nts := (integer(ntsmin/nbus))*nbus
	cprot += ntrim(nbus) + " " + ntrim(nts) 
   nts += nbus	
	cprot += " " + ntrim(nts) 
	nmin := nts-ntsmin
	cprot += " " + ntrim(nmin) 
	cprot +=" " + ntrim(nmin*nbus) +crlf
next

return 

export cdirectory
export ninput
export npart

export ntsmin 
export abus
export cprot







