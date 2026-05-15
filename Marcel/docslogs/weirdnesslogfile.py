from graph import *

start ("AyEuAx>exyeuy")

"""

Line number 0



----



0.  (Ay : (Eu : (Ax : (x e y -> u e y))))

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  (Eu : (Ax : (x e y'! -> u e y'!)))

by lines [-1]
Next!"""

right()

"""

Line number 2



----



0.  (Ax : (x e y' -> u'? e y'))

1.  (Eu : (Ax : (x e y' -> u e y')))

by lines [-1]
Next!"""

right()

"""

Line number 3



----



0.  (x'! e y' -> u'? e y')

1.  (Eu : (Ax : (x e y' -> u e y')))

by lines [-1]
Next!"""

right()

"""

Line number 4




0.  x'! e y'
----



0.  u'? e y'

1.  (Eu : (Ax : (x e y' -> u e y')))

by lines [-1]
Next!"""

done()
getright(1)

"""

Line number 4




0.  x'! e y'
----



0.  (Eu : (Ax : (x e y' -> u e y')))

1.  u'? e y'

by lines [-1]
Next!"""

right()

"""

Line number 5




0.  x' e y'
----



0.  (Ax : (x e y' -> u*? e y'))

1.  (Eu : (Ax : (x e y' -> u e y')))

2.  u'? e y'

by lines [-1]
Next!"""

right()

"""

Line number 6




0.  x' e y'
----



0.  (x*! e y' -> u*? e y')

1.  (Eu : (Ax : (x e y' -> u e y')))

2.  u'? e y'

by lines [-1]
Next!"""

right()

"""

Line number 7




0.  x*! e y'

1.  x' e y'
----



0.  u*? e y'

1.  (Eu : (Ax : (x e y' -> u e y')))

2.  u'? e y'

by lines [-1]
Next!"""

getleft(1)

"""

Line number 7




0.  x' e y'

1.  x*! e y'
----



0.  u*? e y'

1.  (Eu : (Ax : (x e y' -> u e y')))

2.  u'? e y'

by lines [-1]
Next!"""

done()

"""Done!"""

"""

Line number 0



----



0.  (Ay : (Eu : (Ax : (x e y -> u e y))))

by lines [1]

Line number 1



----



0.  (Eu : (Ax : (x e y' -> u e y')))

by lines [2]

Line number 2



----



0.  (Ax : (x e y' -> u'? e y'))

1.  (Eu : (Ax : (x e y' -> u e y')))

by lines [3]

Line number 3



----



0.  (x' e y' -> u'? e y')

1.  (Eu : (Ax : (x e y' -> u e y')))

by lines [4]

Line number 4




0.  x' e y'
----



0.  (Eu : (Ax : (x e y' -> u e y')))

1.  u'? e y'

by lines [5]

Line number 5




0.  x' e y'
----



0.  (Ax : (x e y' -> x' e y'))

1.  (Eu : (Ax : (x e y' -> u e y')))

2.  u'? e y'

by lines [6]

Line number 6




0.  x' e y'
----



0.  (x*! e y' -> x' e y')

1.  (Eu : (Ax : (x e y' -> u e y')))

2.  u'? e y'

by lines [7]

Line number 7




0.  x' e y'

1.  x*! e y'
----



0.  x' e y'

1.  (Eu : (Ax : (x e y' -> u e y')))

2.  u'? e y'

by lines []"""