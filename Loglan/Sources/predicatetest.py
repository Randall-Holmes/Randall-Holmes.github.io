from loglan import *

def ctest(s):
    Utteras('Complex',s)

def btest(s):
    Utteras('Borrowing',s)

ctest('bakteriyrodhopsini')

ctest('iglluymao')

ctest('rodhopsiniymao')
    
ctest('bamfoamoa')

ctest('moayiglluymao')

ctest('bremaoycmalo')

ctest('kerflofybou')

Utter("Midja'nolepoladjan, clu'valameris")

Utter("Lemikerflofybo'ugakla'flolo, angui'li")

Utter("mifir'palepolo, igllu'yangui'ligadan'zalepotit'cimi")

Utter("le, igllu'ymaogasad'ji")

Utter("igllu'y, cmamad'zo")

Utter("igllu'ycmamad'zo")

Utter("iglluycmamadzo")

Utter ("le, cmayigllu'ymaogasad'ji")

Utter("cma'lozao, i'gllu zao mad'zo")

Utter("cma'lozao, igllu'ymadzo")

Utter("Midja'nolepoletojun'timre'nugagud'bi")

Utter("La Djan, ci Sadji, ci Smit")

Utter("ladjan, cisad'jicismit")  #bad

Utter("ladjan, cisad'ji, ci smit")

Utter("ladjan, cisad'jijetu, ci smit")

Utter("La Djan ci Sadji, je Tu ci Smit")

Utter("La Djan ci Sadji, la Meris, ci Smit")  #*bad* parse!

Utter("La Djan ci Sadji, je la Meris, ci Smit")  #still not quite what is wanted

Utter("La Djan ci Sadji, je la Meris, gue ci Smit")  #Ta da!

print('why does this fail')

Utter ("ladjan, ci, sa'djijelameris, gueci smit")  #fails

Utter ("ladjan, cisa'djijelameris")  #oops!

Utter ("ladjan, cisa'djije, lameris")

Utter("ladjan, cisa'djije, lameris, guecismit")
#the reasons why pauses are needed are subtle




