from graph import *

deff ("C", "Ax>exaexb")
start ("AxAyAz > & :ax:byC :ay:bzC :ax:bzC")

"""

Line number 0



----



0.  (Ax : (Ay : (Az : (((x C y) & (y C z)) -> (x C z)))))

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  (Ay : (Az : (((x'! C y) & (y C z)) -> (x'! C z))))

by lines [-1]
Next!"""

right()

"""

Line number 2



----



0.  (Az : (((x'! C y'!) & (y'! C z)) -> (x'! C z)))

by lines [-1]
Next!"""

right()

"""

Line number 3



----



0.  (((x'! C y'!) & (y'! C z'!)) -> (x'! C z'!))

by lines [-1]
Next!"""

right()

"""

Line number 4




0.  ((x'! C y'!) & (y'! C z'!))
----



0.  (x'! C z'!)

by lines [-1]
Next!"""

right()

"""

Line number 5




0.  ((x'! C y'!) & (y'! C z'!))
----



0.  (A@x : (@x e x'! -> @x e z'!))

by lines [-1]
Next!"""

right()

"""

Line number 6




0.  ((x'! C y'!) & (y'! C z'!))
----



0.  (x*! e x'! -> x*! e z'!)

by lines [-1]
Next!"""

right()

"""

Line number 7




0.  x*! e x'!

1.  ((x'! C y'!) & (y'! C z'!))
----



0.  x*! e z'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 7




0.  ((x'! C y'!) & (y'! C z'!))

1.  x*! e x'!
----



0.  x*! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 8




0.  (x'! C y'!)

1.  (y'! C z'!)

2.  x*! e x'!
----



0.  x*! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 9




0.  (A@x : (@x e x'! -> @x e y'!))

1.  (y'! C z'!)

2.  x*! e x'!
----



0.  x*! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 10




0.  (x''? e x'! -> x''? e y'!)

1.  (A@x : (@x e x'! -> @x e y'!))

2.  (y'! C z'!)

3.  x*! e x'!
----



0.  x*! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 11




0.  (A@x : (@x e x'! -> @x e y'!))

1.  (y'! C z'!)

2.  x*! e x'!
----



0.  x''? e x'!

1.  x*! e z'!

by lines [-1]
Next!"""

setunknown ("x''","*x")

"""

Line number 11




0.  (A@x : (@x e x'! -> @x e y'!))

1.  (y'! C z'!)

2.  x*! e x'!
----



0.  x*! e x'!

1.  x*! e z'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 11




0.  x*! e x'!

1.  (A@x : (@x e x'! -> @x e y'!))

2.  (y'! C z'!)
----



0.  x*! e x'!

1.  x*! e z'!

by lines [-1]
Next!"""

done()

"""

Line number 12




0.  x*! e y'!

1.  (A@x : (@x e x'! -> @x e y'!))

2.  (y'! C z'!)

3.  x*! e x'!
----



0.  x*! e z'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 12




0.  (y'! C z'!)

1.  x*! e x'!

2.  x*! e y'!

3.  (A@x : (@x e x'! -> @x e y'!))
----



0.  x*! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 13




0.  (A@x : (@x e y'! -> @x e z'!))

1.  x*! e x'!

2.  x*! e y'!

3.  (A@x : (@x e x'! -> @x e y'!))
----



0.  x*! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 14




0.  (x'*? e y'! -> x'*? e z'!)

1.  (A@x : (@x e y'! -> @x e z'!))

2.  x*! e x'!

3.  x*! e y'!

4.  (A@x : (@x e x'! -> @x e y'!))
----



0.  x*! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 15




0.  (A@x : (@x e y'! -> @x e z'!))

1.  x*! e x'!

2.  x*! e y'!

3.  (A@x : (@x e x'! -> @x e y'!))
----



0.  x'*? e y'!

1.  x*! e z'!

by lines [-1]
Next!"""

setunknown ("x'*","*x")

"""

Line number 15




0.  (A@x : (@x e y'! -> @x e z'!))

1.  x*! e x'!

2.  x*! e y'!

3.  (A@x : (@x e x'! -> @x e y'!))
----



0.  x*! e y'!

1.  x*! e z'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 15




0.  x*! e y'!

1.  (A@x : (@x e x'! -> @x e y'!))

2.  (A@x : (@x e y'! -> @x e z'!))

3.  x*! e x'!
----



0.  x*! e y'!

1.  x*! e z'!

by lines [-1]
Next!"""

done()

"""

Line number 16




0.  x*! e z'!

1.  (A@x : (@x e y'! -> @x e z'!))

2.  x*! e x'!

3.  x*! e y'!

4.  (A@x : (@x e x'! -> @x e y'!))
----



0.  x*! e z'!

by lines [-1]
Next!"""

done()

"""Done!"""

"""

Line number 0



----



0.  (Ax : (Ay : (Az : (((x C y) & (y C z)) -> (x C z)))))

by lines [1]

Line number 1



----



0.  (Ay : (Az : (((x'! C y) & (y C z)) -> (x'! C z))))

by lines [2]

Line number 2



----



0.  (Az : (((x'! C y'!) & (y'! C z)) -> (x'! C z)))

by lines [3]

Line number 3



----



0.  (((x'! C y'!) & (y'! C z'!)) -> (x'! C z'!))

by lines [4]

Line number 4




0.  ((x'! C y'!) & (y'! C z'!))
----



0.  (x'! C z'!)

by lines [5]

Line number 5




0.  ((x'! C y'!) & (y'! C z'!))
----



0.  (A@x : (@x e x'! -> @x e z'!))

by lines [6]

Line number 6




0.  ((x'! C y'!) & (y'! C z'!))
----



0.  (x*! e x'! -> x*! e z'!)

by lines [7]

Line number 7




0.  ((x'! C y'!) & (y'! C z'!))

1.  x*! e x'!
----



0.  x*! e z'!

by lines [8]

Line number 8




0.  (x'! C y'!)

1.  (y'! C z'!)

2.  x*! e x'!
----



0.  x*! e z'!

by lines [9]

Line number 9




0.  (A@x : (@x e x'! -> @x e y'!))

1.  (y'! C z'!)

2.  x*! e x'!
----



0.  x*! e z'!

by lines [10]

Line number 10




0.  (x*! e x'! -> x*! e y'!)

1.  (A@x : (@x e x'! -> @x e y'!))

2.  (y'! C z'!)

3.  x*! e x'!
----



0.  x*! e z'!

by lines [11, 12]

Line number 11




0.  x*! e x'!

1.  (A@x : (@x e x'! -> @x e y'!))

2.  (y'! C z'!)
----



0.  x*! e x'!

1.  x*! e z'!

by lines []

Line number 12




0.  (y'! C z'!)

1.  x*! e x'!

2.  x*! e y'!

3.  (A@x : (@x e x'! -> @x e y'!))
----



0.  x*! e z'!

by lines [13]

Line number 13




0.  (A@x : (@x e y'! -> @x e z'!))

1.  x*! e x'!

2.  x*! e y'!

3.  (A@x : (@x e x'! -> @x e y'!))
----



0.  x*! e z'!

by lines [14]

Line number 14




0.  (x*! e y'! -> x*! e z'!)

1.  (A@x : (@x e y'! -> @x e z'!))

2.  x*! e x'!

3.  x*! e y'!

4.  (A@x : (@x e x'! -> @x e y'!))
----



0.  x*! e z'!

by lines [15, 16]

Line number 15




0.  x*! e y'!

1.  (A@x : (@x e x'! -> @x e y'!))

2.  (A@x : (@x e y'! -> @x e z'!))

3.  x*! e x'!
----



0.  x*! e y'!

1.  x*! e z'!

by lines []

Line number 16




0.  x*! e z'!

1.  (A@x : (@x e y'! -> @x e z'!))

2.  x*! e x'!

3.  x*! e y'!

4.  (A@x : (@x e x'! -> @x e y'!))
----



0.  x*! e z'!

by lines []"""