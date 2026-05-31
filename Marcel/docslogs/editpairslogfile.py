from graph2 import *

#setlog("newpairslog")
deft ("P", "{xV=xa=xb")
deft ("O", ":a:aa:baP:b:aa:bbPP")
deft ("'P", "{xAy>eyaexy")
start ("AxAy=:a:ax:byO'P{u=xu")

"""

Line number 0



----



0.  (Ax : (Ay : P'(a:(x O y))
   = {u | x = u}))

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  (Ay : P'(a:(x'! O y))
   = {u | x'! = u})

by lines [-1]
Next!"""

right()

"""

Line number 2



----



0.  P'(a:(x'! O y'!))
   = {u | x'! = u}

by lines [-1]
Next!"""

right()

"""

Line number 3



----



0.  (Ax* : (x* e P'(a:(x'! O y'!))
   == x* e {u | x'! = u}))

by lines [-1]
Next!"""

right()

"""

Line number 4



----



0.  (x''! e P'(a:(x'! O y'!))
   == x''! e {u | x'! = u})

by lines [-1]
Next!"""

right()

"""

Line number 5




0.  x''! e P'(a:(x'! O y'!))
----



0.  x''! e {u | x'! = u}

by lines [-1]
Next!"""

right()

"""

Line number 7




0.  x''! e P'(a:(x'! O y'!))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 8




0.  x''! e {@x | (A@y : (@y e (x'! O y'!)
   -> @x e @y))}
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 9




0.  (A@y : (@y e (x'! O y'!)
   -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 10




0.  (y*? e (x'! O y'!)
   -> x''! e y*?)

1.  (A@y : (@y e (x'! O y'!)
   -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 11




0.  (A@y : (@y e (x'! O y'!)
   -> x''! e @y))
----



0.  y*? e (x'! O y'!)

1.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 13




0.  (A@y : (@y e (x'! O y'!)
   -> x''! e @y))
----



0.  y*? e ((x'! P x'!)
   P (x'! P y'!))

1.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 14




0.  (A@y : (@y e (x'! O y'!)
   -> x''! e @y))
----



0.  y*? e {@x | (@x = (x'! P x'!)
   V @x = (x'! P y'!))}

1.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 15




0.  (A@y : (@y e (x'! O y'!)
   -> x''! e @y))
----



0.  (y*? = (x'! P x'!)
   V y*? = (x'! P y'!))

1.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 16




0.  (A@y : (@y e (x'! O y'!)
   -> x''! e @y))
----



0.  y*? = (x'! P x'!)

1.  y*? = (x'! P y'!)

2.  x'! = x''!

by lines [-1]
Next!"""

done()

"""

Line number 12




0.  x''! e (x'! P x'!)

1.  (A@y : (@y e (x'! O y'!)
   -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 17




0.  x''! e {@x | (@x = x'! V @x = x'!)}

1.  (A@y : (@y e (x'! O y'!)
   -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 18




0.  (x''! = x'! V x''! = x'!)

1.  (A@y : (@y e (x'! O y'!)
   -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 19




0.  x''! = x'!

1.  (A@y : (@y e (x'! O y'!)
   -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

varelim()

"""

Line number 21




0.  (A@y : (@y e (x'! O y'!)
   -> x'! e @y))
----



0.  x'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 20




0.  x''! = x'!

1.  (A@y : (@y e (x'! O y'!)
   -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

varelim()

"""

Line number 22




0.  (A@y : (@y e (x'! O y'!)
   -> x'! e @y))
----



0.  x'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 6




0.  x''! e {u | x'! = u}
----



0.  x''! e P'(a:(x'! O y'!))

by lines [-1]
Next!"""

left()

"""

Line number 23




0.  x'! = x''!
----



0.  x''! e P'(a:(x'! O y'!))

by lines [-1]
Next!"""

right()

"""

Line number 24




0.  x'! = x''!
----



0.  x''! e {@x | (A@y : (@y e (x'! O y'!)
   -> @x e @y))}

by lines [-1]
Next!"""

right()

"""

Line number 25




0.  x'! = x''!
----



0.  (A@y : (@y e (x'! O y'!)
   -> x''! e @y))

by lines [-1]
Next!"""

right()

"""

Line number 26




0.  x'! = x''!
----



0.  (y''! e (x'! O y'!)
   -> x''! e y''!)

by lines [-1]
Next!"""

varelim()

"""

Line number 27



----



0.  (y''! e (x''! O y'!)
   -> x''! e y''!)

by lines [-1]
Next!"""

right()

"""

Line number 28




0.  y''! e (x''! O y'!)
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 29




0.  y''! e ((x''! P x''!)
   P (x''! P y'!))
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 30




0.  y''! e {@x | (@x = (x''! P x''!)
   V @x = (x''! P y'!))}
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 31




0.  (y''! = (x''! P x''!)
   V y''! = (x''! P y'!))
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 32




0.  y''! = (x''! P x''!)
----



0.  x''! e y''!

by lines [-1]
Next!"""

varelim()

"""

Line number 34



----



0.  x''! e (x''! P x''!)

by lines [-1]
Next!"""

right()

"""

Line number 35



----



0.  x''! e {@x | (@x = x''! V @x = x''!)}

by lines [-1]
Next!"""

right()

"""

Line number 36



----



0.  (x''! = x''! V x''! = x''!)

by lines [-1]
Next!"""

right()

"""

Line number 37



----



0.  x''! = x''!

1.  x''! = x''!

by lines [-1]
Next!"""

done()

"""

Line number 33




0.  y''! = (x''! P y'!)
----



0.  x''! e y''!

by lines [-1]
Next!"""

varelim()

"""

Line number 38



----



0.  x''! e (x''! P y'!)

by lines [-1]
Next!"""

right()

"""

Line number 39



----



0.  x''! e {@x | (@x = x''! V @x = y'!)}

by lines [-1]
Next!"""

right()

"""

Line number 40



----



0.  (x''! = x''! V x''! = y'!)

by lines [-1]
Next!"""

right()

"""

Line number 41



----



0.  x''! = x''!

1.  x''! = y'!

by lines [-1]
Next!"""

done()

"""Done!"""

savetheorem("Proj1")

deft ("U", "{xEyAzXezx=zy")
deft ("*P", "{xe{y&exyeyaU")
start ("AxAy=:a:ax:byO*P{u=uy")

"""

Line number 0



----



0.  (Ax : (Ay : P*(a:(x O y))
   = {u | u = y}))

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  (Ay : P*(a:(x'! O y))
   = {u | u = y})

by lines [-1]
Next!"""

right()

"""

Line number 2



----



0.  P*(a:(x'! O y'!))
   = {u | u = y'!}

by lines [-1]
Next!"""

right()

"""

Line number 3



----



0.  (Ax* : (x* e P*(a:(x'! O y'!))
   == x* e {u | u = y'!}))

by lines [-1]
Next!"""

right()

"""

Line number 4



----



0.  (x''! e P*(a:(x'! O y'!))
   == x''! e {u | u = y'!})

by lines [-1]
Next!"""

right()

"""

Line number 5




0.  x''! e P*(a:(x'! O y'!))
----



0.  x''! e {u | u = y'!}

by lines [-1]
Next!"""

right()

"""

Line number 7




0.  x''! e P*(a:(x'! O y'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 8




0.  x''! e {@x | {@y | (@x e @y
   & @y e (x'! O y'!))} e U}
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 9




0.  {@y | (x''! e @y
   & @y e (x'! O y'!))} e U
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 10




0.  {@y | (x''! e @y
   & @y e (x'! O y'!))}
   e {@x | (E@y : (A@z : (@z e @x == @z = @y)))}
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 11




0.  (E@y : (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 12




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 13




0.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == z'? = y*!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 14




0.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

1.  (z'? = y*!
   -> z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 15




0.  (z'? = y*!
   -> z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))
----



0.  z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 17




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))
----



0.  z'? = y*!

1.  z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

2.  x''! = y'!

by lines [-1]
Next!"""

back()
back()
back()
getleft(1)

"""

Line number 14




0.  (z'? = y*!
   -> z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 15




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

1.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  z'? = y*!

1.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 17




0.  (z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == z*? = y*!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  z'? = y*!

1.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 18




0.  (z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z*? = y*!)

1.  (z*? = y*!
   -> z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

3.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  z'? = y*!

1.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 19




0.  (z*? = y*!
   -> z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 21




0.  (z*? = y*!
   -> z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  (x''! e z*?
   & z*? e (x'! O y'!))

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 22




0.  (z*? = y*!
   -> z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  x''! e z*?

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 22




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

1.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

2.  (z*? = y*!
   -> z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))})
----



0.  x''! e z*?

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 24




0.  (z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == z''? = y*!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  (z*? = y*!
   -> z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))})
----



0.  x''! e z*?

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 25




0.  (z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z''? = y*!)

1.  (z''? = y*!
   -> z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

3.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

4.  (z*? = y*!
   -> z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))})
----



0.  x''! e z*?

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 26




0.  (z''? = y*!
   -> z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  (z*? = y*!
   -> z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))})
----



0.  z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  x''! e z*?

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 28




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

1.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

2.  (z*? = y*!
   -> z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))})
----



0.  z''? = y*!

1.  z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

2.  x''! e z*?

3.  z'? = y*!

4.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 28




0.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

1.  (z*? = y*!
   -> z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))
----



0.  z''? = y*!

1.  z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

2.  x''! e z*?

3.  z'? = y*!

4.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 30




0.  (z*? = y*!
   -> z*? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))
----



0.  z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  z''? = y*!

2.  z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

3.  x''! e z*?

4.  z'? = y*!

5.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 32




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))
----



0.  z*? = y*!

1.  z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

2.  z''? = y*!

3.  z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

4.  x''! e z*?

5.  z'? = y*!

6.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 33




0.  y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))
----



0.  z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  z''? = y*!

2.  z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

3.  x''! e y*!

4.  z'? = y*!

5.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 34




0.  y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))
----



0.  (x''! e z'?
   & z'? e (x'! O y'!))

1.  z''? = y*!

2.  z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

3.  x''! e y*!

4.  z'? = y*!

5.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 34




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

1.  y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}
----



0.  (x''! e z'?
   & z'? e (x'! O y'!))

1.  z''? = y*!

2.  z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

3.  x''! e y*!

4.  z'? = y*!

5.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 34




0.  y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))
----



0.  (x''! e z'?
   & z'? e (x'! O y'!))

1.  z''? = y*!

2.  z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

3.  x''! e y*!

4.  z'? = y*!

5.  x''! = y'!

by lines [-1]
Next!"""

getright(1)

"""

Line number 34




0.  y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))
----



0.  z''? = y*!

1.  z''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

2.  x''! e y*!

3.  z'? = y*!

4.  x''! = y'!

5.  (x''! e z'?
   & z'? e (x'! O y'!))

by lines [-1]
Next!"""

done()

"""

Line number 31




0.  z'? = y*!

1.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))
----



0.  y*! = y*!

1.  y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}

2.  x''! e y*!

3.  z'? = y*!

4.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 29




0.  y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})
----



0.  y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  x''! e y*!

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 35




0.  y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})
----



0.  (x''! e y*!
   & y*! e (x'! O y'!))

1.  x''! e y*!

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 36




0.  (x''! e y*!
   & y*! e (x'! O y'!))

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})
----



0.  (x''! e y*!
   & y*! e (x'! O y'!))

1.  x''! e y*!

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 37




0.  x''! e y*!

1.  y*! e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

3.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

4.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})
----



0.  (x''! e y*!
   & y*! e (x'! O y'!))

1.  x''! e y*!

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

getright(1)

"""

Line number 37




0.  x''! e y*!

1.  y*! e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

3.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

4.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})
----



0.  x''! e y*!

1.  z'? = y*!

2.  x''! = y'!

3.  (x''! e y*!
   & y*! e (x'! O y'!))

by lines [-1]
Next!"""

done()

"""

Line number 27




0.  y*! = y*!

1.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

3.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

4.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})
----



0.  x''! e y*!

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 27




0.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

4.  y*! = y*!
----



0.  x''! e y*!

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 38




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

1.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

2.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

3.  y*! = y*!
----



0.  y*! = y*!

1.  x''! e y*!

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 39




0.  y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

4.  y*! = y*!
----



0.  x''! e y*!

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 40




0.  (x''! e y*!
   & y*! e (x'! O y'!))

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

4.  y*! = y*!
----



0.  x''! e y*!

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 41




0.  x''! e y*!

1.  y*! e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

3.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

4.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

5.  y*! = y*!
----



0.  x''! e y*!

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 23




0.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  y*! e (x'! O y'!)

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 42




0.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  y*! e ((x'! P x'!)
   P (x'! P y'!))

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 43




0.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  y*! e {@x | (@x = (x'! P x'!)
   V @x = (x'! P y'!))}

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 44




0.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  (y*! = (x'! P x'!)
   V y*! = (x'! P y'!))

1.  z'? = y*!

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 45




0.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  y*! = (x'! P x'!)

1.  y*! = (x'! P y'!)

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 46




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

1.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  y*! = y*!

1.  y*! = (x'! P x'!)

2.  y*! = (x'! P y'!)

3.  z'? = y*!

4.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 48




0.  (z'*? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == z'*? = y*!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  y*! = y*!

1.  y*! = (x'! P x'!)

2.  y*! = (x'! P y'!)

3.  z'? = y*!

4.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 47




0.  y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  y*! = (x'! P x'!)

1.  y*! = (x'! P y'!)

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 49




0.  (x''! e y*!
   & y*! e (x'! O y'!))

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  y*! = (x'! P x'!)

1.  y*! = (x'! P y'!)

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 50




0.  x''! e y*!

1.  y*! e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

3.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  y*! = (x'! P x'!)

1.  y*! = (x'! P y'!)

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 50




0.  y*! e (x'! O y'!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  x''! e y*!
----



0.  y*! = (x'! P x'!)

1.  y*! = (x'! P y'!)

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 51




0.  y*! e ((x'! P x'!)
   P (x'! P y'!))

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  x''! e y*!
----



0.  y*! = (x'! P x'!)

1.  y*! = (x'! P y'!)

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 52




0.  y*! e {@x | (@x = (x'! P x'!)
   V @x = (x'! P y'!))}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  x''! e y*!
----



0.  y*! = (x'! P x'!)

1.  y*! = (x'! P y'!)

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 53




0.  (y*! = (x'! P x'!)
   V y*! = (x'! P y'!))

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  x''! e y*!
----



0.  y*! = (x'! P x'!)

1.  y*! = (x'! P y'!)

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 54




0.  y*! = (x'! P x'!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  x''! e y*!
----



0.  y*! = (x'! P x'!)

1.  y*! = (x'! P y'!)

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 55




0.  y*! = (x'! P y'!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  x''! e y*!
----



0.  y*! = (x'! P x'!)

1.  y*! = (x'! P y'!)

2.  z'? = y*!

3.  x''! = y'!

by lines [-1]
Next!"""

getright(1)

"""

Line number 55




0.  y*! = (x'! P y'!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)

3.  x''! e y*!
----



0.  y*! = (x'! P y'!)

1.  z'? = y*!

2.  x''! = y'!

3.  y*! = (x'! P x'!)

by lines [-1]
Next!"""

done()

"""

Line number 20




0.  y*! = y*!

1.  (y*! = y*!
   -> y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

3.  (z'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z'? = y*!)
----



0.  z'? = y*!

1.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 16




0.  y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> y*! = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 56




0.  (x''! e y*!
   & y*! e (x'! O y'!))

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> y*! = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 57




0.  x''! e y*!

1.  y*! e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

3.  (y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> y*! = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 57




0.  y*! e (x'! O y'!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> y*! = y*!)

3.  x''! e y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 58




0.  y*! e ((x'! P x'!)
   P (x'! P y'!))

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> y*! = y*!)

3.  x''! e y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 59




0.  y*! e {@x | (@x = (x'! P x'!)
   V @x = (x'! P y'!))}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> y*! = y*!)

3.  x''! e y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 60




0.  (y*! = (x'! P x'!)
   V y*! = (x'! P y'!))

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> y*! = y*!)

3.  x''! e y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 61




0.  y*! = (x'! P x'!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> y*! = y*!)

3.  x''! e y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

varelim()

"""

Line number 63




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

1.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

2.  x''! e (x'! P x'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 63




0.  x''! e (x'! P x'!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 64




0.  x''! e {@x | (@x = x'! V @x = x'!)}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 65




0.  (x''! = x'! V x''! = x'!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 66




0.  x''! = x'!

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 66




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

1.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

2.  x''! = x'!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 68




0.  (z*'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == z*'? = (x'! P x'!))

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 69




0.  (z*'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z*'? = (x'! P x'!))

1.  (z*'? = (x'! P x'!)
   -> z*'? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 70




0.  (z*'? = (x'! P x'!)
   -> z*'? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!
----



0.  z*'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 72




0.  (z*'? = (x'! P x'!)
   -> z*'? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!
----



0.  (x''! e z*'?
   & z*'? e (x'! O y'!))

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 73




0.  (z*'? = (x'! P x'!)
   -> z*'? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!
----



0.  x''! e z*'?

1.  x''! = y'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 73




0.  x''! = x'!

1.  (z*'? = (x'! P x'!)
   -> z*'? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x''! e z*'?

1.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 74




0.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!
----



0.  {z** | z** = x'!}
   e (x'! O y'!)

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 75




0.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!
----



0.  {z** | z** = x'!}
   e ((x'! P x'!)
   P (x'! P y'!))

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 76




0.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!
----



0.  {z** | z** = x'!}
   e {@x | (@x = (x'! P x'!)
   V @x = (x'! P y'!))}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 77




0.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!
----



0.  ({z** | z** = x'!}
   = (x'! P x'!)
   V {z** | z** = x'!}
   = (x'! P y'!))

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 78




0.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!
----



0.  {z** | z** = x'!}
   = (x'! P x'!)

1.  {z** | z** = x'!}
   = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 79




0.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!
----



0.  (Ax'* : (x'* e {z** | z** = x'!}
   == x'* e (x'! P x'!)))

1.  {z** | z** = x'!}
   = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 80




0.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!
----



0.  (x*'! e {z** | z** = x'!}
   == x*'! e (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 81




0.  x*'! e {z** | z** = x'!}

1.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  x*'! e (x'! P x'!)

1.  {z** | z** = x'!}
   = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 83




0.  x*'! = x'!

1.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  x*'! e (x'! P x'!)

1.  {z** | z** = x'!}
   = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 84




0.  x*'! = x'!

1.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  x*'! e {@x | (@x = x'! V @x = x'!)}

1.  {z** | z** = x'!}
   = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 85




0.  x*'! = x'!

1.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  (x*'! = x'! V x*'! = x'!)

1.  {z** | z** = x'!}
   = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 86




0.  x*'! = x'!

1.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  x*'! = x'!

1.  x*'! = x'!

2.  {z** | z** = x'!}
   = (x'! P y'!)

3.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 82




0.  x*'! e (x'! P x'!)

1.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  x*'! e {z** | z** = x'!}

1.  {z** | z** = x'!}
   = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 87




0.  x*'! e (x'! P x'!)

1.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  x*'! = x'!

1.  {z** | z** = x'!}
   = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 88




0.  x*'! e {@x | (@x = x'! V @x = x'!)}

1.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  x*'! = x'!

1.  {z** | z** = x'!}
   = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 89




0.  (x*'! = x'! V x*'! = x'!)

1.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  x*'! = x'!

1.  {z** | z** = x'!}
   = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 90




0.  x*'! = x'!

1.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  x*'! = x'!

1.  {z** | z** = x'!}
   = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 91




0.  x*'! = x'!

1.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  x*'! = x'!

1.  {z** | z** = x'!}
   = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 71




0.  {z** | z** = x'!}
   = (x'! P x'!)

1.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 71




0.  ({z** | z** = x'!}
   = (x'! P x'!)
   -> {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!

4.  {z** | z** = x'!}
   = (x'! P x'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 92




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

1.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

2.  x''! = x'!

3.  {z** | z** = x'!}
   = (x'! P x'!)
----



0.  {z** | z** = x'!}
   = (x'! P x'!)

1.  x''! = y'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 92




0.  {z** | z** = x'!}
   = (x'! P x'!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!
----



0.  {z** | z** = x'!}
   = (x'! P x'!)

1.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 93




0.  {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!

4.  {z** | z** = x'!}
   = (x'! P x'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 93




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

1.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

2.  x''! = x'!

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 94




0.  (z'''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == z'''? = (x'! P x'!))

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!

4.  {z** | z** = x'!}
   = (x'! P x'!)

5.  {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 94




0.  x''! = x'!

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}

3.  (z'''? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == z'''? = (x'! P x'!))

4.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

varelim()

"""

Line number 95




0.  {z** | z** = x'!}
   = (x'! P x'!)

1.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

2.  (z'''? e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == z'''? = (x'! P x'!))

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 95




0.  (z'''? e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == z'''? = (x'! P x'!))

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 96




0.  (z'''? e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> z'''? = (x'! P x'!))

1.  (z'''? = (x'! P x'!)
   -> z'''? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  {z** | z** = x'!}
   = (x'! P x'!)

5.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 97




0.  (z'''? = (x'! P x'!)
   -> z'''? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  z'''? e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 99




0.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

1.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

2.  {z** | z** = x'!}
   = (x'! P x'!)

3.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  z'''? = (x'! P x'!)

1.  z'''? e {@y | (x'! e @y
   & @y e (x'! O y'!))}

2.  x'! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 99




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  z'''? = (x'! P x'!)

1.  z'''? e {@y | (x'! e @y
   & @y e (x'! O y'!))}

2.  x'! = y'!

by lines [-1]
Next!"""

getright(1)

"""

Line number 99




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  z'''? e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  x'! = y'!

2.  z'''? = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 101




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  (x'! e z'''?
   & z'''? e (x'! O y'!))

1.  x'! = y'!

2.  z'''? = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 102




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  x'! e z'''?

1.  x'! = y'!

2.  z'''? = (x'! P x'!)

by lines [-1]
Next!"""

skip()

"""

Line number 103




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  z'''? e (x'! O y'!)

1.  x'! = y'!

2.  z'''? = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 104




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  z'''? e ((x'! P x'!)
   P (x'! P y'!))

1.  x'! = y'!

2.  z'''? = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 105




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  z'''? e {@x | (@x = (x'! P x'!)
   V @x = (x'! P y'!))}

1.  x'! = y'!

2.  z'''? = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 106




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  (z'''? = (x'! P x'!)
   V z'''? = (x'! P y'!))

1.  x'! = y'!

2.  z'''? = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 107




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  z'''? = (x'! P x'!)

1.  z'''? = (x'! P y'!)

2.  x'! = y'!

3.  z'''? = (x'! P x'!)

by lines [-1]
Next!"""

getright(1)

"""

Line number 107




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  z'''? = (x'! P y'!)

1.  x'! = y'!

2.  z'''? = (x'! P x'!)

3.  z'''? = (x'! P x'!)

by lines [-1]
Next!"""

done()

"""

Line number 100




0.  (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 108




0.  (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  (x'! e (x'! P y'!)
   & (x'! P y'!)
   e (x'! O y'!))

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 109




0.  (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! e (x'! P y'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 111




0.  (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! e {@x | (@x = x'! V @x = y'!)}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 112




0.  (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  (x'! = x'! V x'! = y'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 113




0.  (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = x'!

1.  x'! = y'!

2.  x'! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 110




0.  (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  (x'! P y'!)
   e (x'! O y'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 114




0.  (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  (x'! P y'!)
   e ((x'! P x'!)
   P (x'! P y'!))

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 115




0.  (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  (x'! P y'!)
   e {@x | (@x = (x'! P x'!)
   V @x = (x'! P y'!))}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 116




0.  (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  ((x'! P y'!)
   = (x'! P x'!)
   V (x'! P y'!)
   = (x'! P y'!))

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 117




0.  (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  (x'! P y'!)
   = (x'! P x'!)

1.  (x'! P y'!)
   = (x'! P y'!)

2.  x'! = y'!

by lines [-1]
Next!"""

getright(1)

"""

Line number 117




0.  (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  {z** | z** = x'!}
   = (x'! P x'!)

4.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  (x'! P y'!)
   = (x'! P y'!)

1.  x'! = y'!

2.  (x'! P y'!)
   = (x'! P x'!)

by lines [-1]
Next!"""

done()

"""

Line number 98




0.  (x'! P y'!)
   = (x'! P x'!)

1.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  {z** | z** = x'!}
   = (x'! P x'!)

5.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 118




0.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

1.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  {z** | z** = x'!}
   = (x'! P x'!)

5.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 119




0.  ((x'! P y'!) e x'''?
   == (x'! P x'!) e x'''?)

1.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

5.  {z** | z** = x'!}
   = (x'! P x'!)

6.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = y'!

by lines [-1]
Next!"""

setunknown ("x'''","{ue'yu")

"""

Line number 119




0.  ((x'! P y'!)
   e {u | y'! e u}
   == (x'! P x'!)
   e {u | y'! e u})

1.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

5.  {z** | z** = x'!}
   = (x'! P x'!)

6.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 120




0.  ((x'! P y'!)
   e {u | y'! e u}
   -> (x'! P x'!)
   e {u | y'! e u})

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

6.  {z** | z** = x'!}
   = (x'! P x'!)

7.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 121




0.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

1.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

5.  {z** | z** = x'!}
   = (x'! P x'!)

6.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  (x'! P y'!)
   e {u | y'! e u}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 123




0.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

1.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

5.  {z** | z** = x'!}
   = (x'! P x'!)

6.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  y'! e (x'! P y'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 124




0.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

1.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

5.  {z** | z** = x'!}
   = (x'! P x'!)

6.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  y'! e {@x | (@x = x'! V @x = y'!)}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 125




0.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

1.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

5.  {z** | z** = x'!}
   = (x'! P x'!)

6.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  (y'! = x'! V y'! = y'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 126




0.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

1.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

5.  {z** | z** = x'!}
   = (x'! P x'!)

6.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  y'! = x'!

1.  y'! = y'!

2.  x'! = y'!

by lines [-1]
Next!"""

getright(1)

"""

Line number 126




0.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

1.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

5.  {z** | z** = x'!}
   = (x'! P x'!)

6.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  y'! = y'!

1.  x'! = y'!

2.  y'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 122




0.  (x'! P x'!)
   e {u | y'! e u}

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

6.  {z** | z** = x'!}
   = (x'! P x'!)

7.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 127




0.  y'! e (x'! P x'!)

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

6.  {z** | z** = x'!}
   = (x'! P x'!)

7.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 128




0.  y'! e {@x | (@x = x'! V @x = x'!)}

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

6.  {z** | z** = x'!}
   = (x'! P x'!)

7.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 129




0.  (y'! = x'! V y'! = x'!)

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

6.  {z** | z** = x'!}
   = (x'! P x'!)

7.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 130




0.  y'! = x'!

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

6.  {z** | z** = x'!}
   = (x'! P x'!)

7.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = y'!

by lines [-1]
Next!"""

varelim()

"""

Line number 132




0.  ((x'! P x'!)
   e {u | x'! e u}
   -> (x'! P x'!)
   e {u | x'! e u})

1.  (Ax** : ((x'! P x'!) e x**
   == (x'! P x'!) e x**))

2.  ((x'! P x'!)
   = (x'! P x'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O x'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

5.  {z** | z** = x'!}
   = (x'! P x'!)

6.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O x'!))}
----



0.  x'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 131




0.  y'! = x'!

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax** : ((x'! P y'!) e x**
   == (x'! P x'!) e x**))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

6.  {z** | z** = x'!}
   = (x'! P x'!)

7.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
----



0.  x'! = y'!

by lines [-1]
Next!"""

varelim()

"""

Line number 133




0.  ((x'! P x'!)
   e {u | x'! e u}
   -> (x'! P x'!)
   e {u | x'! e u})

1.  (Ax** : ((x'! P x'!) e x**
   == (x'! P x'!) e x**))

2.  ((x'! P x'!)
   = (x'! P x'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O x'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

5.  {z** | z** = x'!}
   = (x'! P x'!)

6.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O x'!))}
----



0.  x'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 67




0.  x''! = x'!

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 67




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

1.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

2.  x''! = x'!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 134




0.  (z''*? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == z''*? = (x'! P x'!))

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

3.  x''! = x'!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 135




0.  (z''*? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z''*? = (x'! P x'!))

1.  (z''*? = (x'! P x'!)
   -> z''*? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  x''! = x'!
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(4)

"""

Line number 135




0.  x''! = x'!

1.  (z''*? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> z''*? = (x'! P x'!))

2.  (z''*? = (x'! P x'!)
   -> z''*? e {@y | (x''! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

varelim()

"""

Line number 136




0.  (z''*? e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> z''*? = (x'! P x'!))

1.  (z''*? = (x'! P x'!)
   -> z''*? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 137




0.  (z''*? = (x'! P x'!)
   -> z''*? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  z''*? e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 139




0.  (z''*? = (x'! P x'!)
   -> z''*? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  (x'! e z''*?
   & z''*? e (x'! O y'!))

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 140




0.  (z''*? = (x'! P x'!)
   -> z''*? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! e z''*?

1.  x'! = y'!

by lines [-1]
Next!"""

skip()

"""

Line number 141




0.  (z''*? = (x'! P x'!)
   -> z''*? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  z''*? e (x'! O y'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 142




0.  (z''*? = (x'! P x'!)
   -> z''*? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  z''*? e ((x'! P x'!)
   P (x'! P y'!))

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 143




0.  (z''*? = (x'! P x'!)
   -> z''*? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  z''*? e {@x | (@x = (x'! P x'!)
   V @x = (x'! P y'!))}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 144




0.  (z''*? = (x'! P x'!)
   -> z''*? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  (z''*? = (x'! P x'!)
   V z''*? = (x'! P y'!))

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 145




0.  (z''*? = (x'! P x'!)
   -> z''*? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  z''*? = (x'! P x'!)

1.  z''*? = (x'! P y'!)

2.  x'! = y'!

by lines [-1]
Next!"""

getright(1)

"""

Line number 145




0.  (z''*? = (x'! P x'!)
   -> z''*? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  z''*? = (x'! P y'!)

1.  x'! = y'!

2.  z''*? = (x'! P x'!)

by lines [-1]
Next!"""

done()

"""

Line number 138




0.  (x'! P y'!)
   = (x'! P x'!)

1.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 146




0.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

1.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 147




0.  ((x'! P y'!) e x'*'?
   == (x'! P x'!) e x'*'?)

1.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

setunknown ("x'*'","{ue'yu")

"""

Line number 147




0.  ((x'! P y'!)
   e {u | y'! e u}
   == (x'! P x'!)
   e {u | y'! e u})

1.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 148




0.  ((x'! P y'!)
   e {u | y'! e u}
   -> (x'! P x'!)
   e {u | y'! e u})

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 149




0.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

1.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  (x'! P y'!)
   e {u | y'! e u}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 151




0.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

1.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  y'! e (x'! P y'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 152




0.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

1.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  y'! e {@x | (@x = x'! V @x = y'!)}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 153




0.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

1.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  (y'! = x'! V y'! = y'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 154




0.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

1.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  y'! = x'!

1.  y'! = y'!

2.  x'! = y'!

by lines [-1]
Next!"""

getright(1)

"""

Line number 154




0.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

1.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

2.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  y'! = y'!

1.  x'! = y'!

2.  y'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 150




0.  (x'! P x'!)
   e {u | y'! e u}

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 155




0.  y'! e (x'! P x'!)

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 156




0.  y'! e {@x | (@x = x'! V @x = x'!)}

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 157




0.  (y'! = x'! V y'! = x'!)

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 158




0.  y'! = x'!

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

varelim()

"""

Line number 160




0.  ((x'! P x'!)
   e {u | x'! e u}
   -> (x'! P x'!)
   e {u | x'! e u})

1.  (Ax''* : ((x'! P x'!) e x''*
   == (x'! P x'!) e x''*))

2.  ((x'! P x'!)
   = (x'! P x'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O x'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 159




0.  y'! = x'!

1.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

2.  (Ax''* : ((x'! P y'!) e x''*
   == (x'! P x'!) e x''*))

3.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

5.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

varelim()

"""

Line number 161




0.  ((x'! P x'!)
   e {u | x'! e u}
   -> (x'! P x'!)
   e {u | x'! e u})

1.  (Ax''* : ((x'! P x'!) e x''*
   == (x'! P x'!) e x''*))

2.  ((x'! P x'!)
   = (x'! P x'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O x'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   == @z = (x'! P x'!)))

4.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 62




0.  y*! = (x'! P y'!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = y*!))

2.  (y*! e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> y*! = y*!)

3.  x''! e y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

varelim()

"""

Line number 162




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

1.  ((x'! P y'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

2.  x''! e (x'! P y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 162




0.  x''! e (x'! P y'!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 163




0.  x''! e {@x | (@x = x'! V @x = y'!)}

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 164




0.  (x''! = x'! V x''! = y'!)

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 165




0.  x''! = x'!

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

skip()

"""

Line number 166




0.  x''! = y'!

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 6




0.  x''! e {u | u = y'!}
----



0.  x''! e P*(a:(x'! O y'!))

by lines [-1]
Next!"""

skip()

"""

Line number 102




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  x'! e (x'! P y'!)

1.  x'! = y'!

2.  (x'! P y'!)
   = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 167




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  x'! e {@x | (@x = x'! V @x = y'!)}

1.  x'! = y'!

2.  (x'! P y'!)
   = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 168




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  (x'! = x'! V x'! = y'!)

1.  x'! = y'!

2.  (x'! P y'!)
   = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 169




0.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

1.  {z** | z** = x'!}
   = (x'! P x'!)

2.  {z** | z** = x'!}
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))
----



0.  x'! = x'!

1.  x'! = y'!

2.  x'! = y'!

3.  (x'! P y'!)
   = (x'! P x'!)

by lines [-1]
Next!"""

done()

"""

Line number 140




0.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! e (x'! P y'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 170




0.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! e {@x | (@x = x'! V @x = y'!)}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 171




0.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  (x'! = x'! V x'! = y'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 172




0.  ((x'! P y'!)
   = (x'! P x'!)
   -> (x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P x'!)))

2.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P x'!)
   = (x'! P x'!))
----



0.  x'! = x'!

1.  x'! = y'!

2.  x'! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 165




0.  x''! = x'!

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 165




0.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

1.  ((x'! P y'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

2.  x''! = x'!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 173




0.  (z'*'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == z'*'? = (x'! P y'!))

1.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

3.  x''! = x'!
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 173




0.  x''! = x'!

1.  (z'*'? e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == z'*'? = (x'! P y'!))

2.  (A@z : (@z e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

3.  ((x'! P y'!)
   e {@y | (x''! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

varelim()

"""

Line number 174




0.  (z'*'? e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == z'*'? = (x'! P y'!))

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 175




0.  (z'*'? e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> z'*'? = (x'! P y'!))

1.  (z'*'? = (x'! P y'!)
   -> z'*'? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

3.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 176




0.  (z'*'? = (x'! P y'!)
   -> z'*'? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  z'*'? e {@y | (x'! e @y
   & @y e (x'! O y'!))}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 178




0.  (z'*'? = (x'! P y'!)
   -> z'*'? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  (x'! e z'*'?
   & z'*'? e (x'! O y'!))

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 179




0.  (z'*'? = (x'! P y'!)
   -> z'*'? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x'! e z'*'?

1.  x'! = y'!

by lines [-1]
Next!"""

skip()

"""

Line number 180




0.  (z'*'? = (x'! P y'!)
   -> z'*'? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  z'*'? e (x'! O y'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 181




0.  (z'*'? = (x'! P y'!)
   -> z'*'? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  z'*'? e ((x'! P x'!)
   P (x'! P y'!))

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 182




0.  (z'*'? = (x'! P y'!)
   -> z'*'? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  z'*'? e {@x | (@x = (x'! P x'!)
   V @x = (x'! P y'!))}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 183




0.  (z'*'? = (x'! P y'!)
   -> z'*'? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  (z'*'? = (x'! P x'!)
   V z'*'? = (x'! P y'!))

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 184




0.  (z'*'? = (x'! P y'!)
   -> z'*'? e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  z'*'? = (x'! P x'!)

1.  z'*'? = (x'! P y'!)

2.  x'! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 177




0.  (x'! P x'!)
   = (x'! P y'!)

1.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

3.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 185




0.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

1.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

3.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 186




0.  ((x'! P x'!) e x*''?
   == (x'! P y'!) e x*''?)

1.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

2.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

4.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 187




0.  ((x'! P x'!) e x*''?
   -> (x'! P y'!) e x*''?)

1.  ((x'! P y'!) e x*''?
   -> (x'! P x'!) e x*''?)

2.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

3.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

5.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

back()
setunknown ("x*''","{ue'yu")

"""

Line number 187




0.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})

1.  ((x'! P y'!)
   e {u | y'! e u}
   -> (x'! P x'!)
   e {u | y'! e u})

2.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

3.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

5.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x'! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 187




0.  ((x'! P y'!)
   e {u | y'! e u}
   -> (x'! P x'!)
   e {u | y'! e u})

1.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

2.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

4.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

5.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 188




0.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

1.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

3.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

4.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})
----



0.  (x'! P y'!)
   e {u | y'! e u}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 190




0.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

1.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

3.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

4.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})
----



0.  y'! e (x'! P y'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 191




0.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

1.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

3.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

4.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})
----



0.  y'! e {@x | (@x = x'! V @x = y'!)}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 192




0.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

1.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

3.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

4.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})
----



0.  (y'! = x'! V y'! = y'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 193




0.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

1.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

3.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

4.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})
----



0.  y'! = x'!

1.  y'! = y'!

2.  x'! = y'!

by lines [-1]
Next!"""

getright(1)

"""

Line number 193




0.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

1.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

3.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

4.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})
----



0.  y'! = y'!

1.  x'! = y'!

2.  y'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 189




0.  (x'! P x'!)
   e {u | y'! e u}

1.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

2.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

4.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

5.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 194




0.  y'! e (x'! P x'!)

1.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

2.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

4.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

5.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 195




0.  y'! e {@x | (@x = x'! V @x = x'!)}

1.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

2.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

4.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

5.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 196




0.  (y'! = x'! V y'! = x'!)

1.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

2.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

4.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

5.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})
----



0.  x'! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 197




0.  y'! = x'!

1.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

2.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

4.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

5.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})
----



0.  x'! = y'!

by lines [-1]
Next!"""

varelim()

"""

Line number 199




0.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P x'!) e x'**))

1.  ((x'! P x'!)
   = (x'! P x'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O x'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  ((x'! P x'!)
   e {u | x'! e u}
   -> (x'! P x'!)
   e {u | x'! e u})
----



0.  x'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 198




0.  y'! = x'!

1.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P y'!) e x'**))

2.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

4.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))

5.  ((x'! P x'!)
   e {u | y'! e u}
   -> (x'! P y'!)
   e {u | y'! e u})
----



0.  x'! = y'!

by lines [-1]
Next!"""

varelim()

"""

Line number 200




0.  (Ax'** : ((x'! P x'!) e x'**
   == (x'! P x'!) e x'**))

1.  ((x'! P x'!)
   = (x'! P x'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O x'!))})

2.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   == @z = (x'! P x'!)))

3.  ((x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   -> (x'! P x'!)
   = (x'! P x'!))

4.  ((x'! P x'!)
   e {u | x'! e u}
   -> (x'! P x'!)
   e {u | x'! e u})
----



0.  x'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 6




0.  x''! e {u | u = y'!}
----



0.  x''! e P*(a:(x'! O y'!))

by lines [-1]
Next!"""

skip()

"""

Line number 179




0.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x'! e (x'! P x'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 201




0.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x'! e {@x | (@x = x'! V @x = x'!)}

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 202




0.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  (x'! = x'! V x'! = x'!)

1.  x'! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 203




0.  ((x'! P x'!)
   = (x'! P y'!)
   -> (x'! P x'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   == @z = (x'! P y'!)))

2.  ((x'! P y'!)
   e {@y | (x'! e @y
   & @y e (x'! O y'!))}
   -> (x'! P y'!)
   = (x'! P y'!))
----



0.  x'! = x'!

1.  x'! = x'!

2.  x'! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 6




0.  x''! e {u | u = y'!}
----



0.  x''! e P*(a:(x'! O y'!))

by lines [-1]
Next!"""


"""

Line number 6




0.  x''! e {u | u = y'!}
----



0.  x''! e P*(a:(x'! O y'!))

by lines [-1]
Next!"""

left()

"""

Line number 204




0.  x''! = y'!
----



0.  x''! e P*(a:(x'! O y'!))

by lines [-1]
Next!"""

varelim()

"""

Line number 205



----



0.  y'! e P*(a:(x'! O y'!))

by lines [-1]
Next!"""

right()

"""

Line number 206



----



0.  y'! e {@x | {@y | (@x e @y
   & @y e (x'! O y'!))} e U}

by lines [-1]
Next!"""

right()

"""

Line number 207



----



0.  {@y | (y'! e @y
   & @y e (x'! O y'!))} e U

by lines [-1]
Next!"""

right()

"""

Line number 208



----



0.  {@y | (y'! e @y
   & @y e (x'! O y'!))}
   e {@x | (E@y : (A@z : (@z e @x == @z = @y)))}

by lines [-1]
Next!"""

right()

"""

Line number 209



----



0.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 210



----



0.  (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = y''?))

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 211



----



0.  (z'**! e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == z'**! = y''?)

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 212




0.  z'**! e {@y | (y'! e @y
   & @y e (x'! O y'!))}
----



0.  z'**! = y''?

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 214




0.  (y'! e z'**!
   & z'**! e (x'! O y'!))
----



0.  z'**! = y''?

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 215




0.  y'! e z'**!

1.  z'**! e (x'! O y'!)
----



0.  z'**! = y''?

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 215




0.  z'**! e (x'! O y'!)

1.  y'! e z'**!
----



0.  z'**! = y''?

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 216




0.  z'**! e ((x'! P x'!)
   P (x'! P y'!))

1.  y'! e z'**!
----



0.  z'**! = y''?

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 217




0.  z'**! e {@x | (@x = (x'! P x'!)
   V @x = (x'! P y'!))}

1.  y'! e z'**!
----



0.  z'**! = y''?

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 218




0.  (z'**! = (x'! P x'!)
   V z'**! = (x'! P y'!))

1.  y'! e z'**!
----



0.  z'**! = y''?

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 219




0.  z'**! = (x'! P x'!)

1.  y'! e z'**!
----



0.  z'**! = y''?

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

skip()

"""

Line number 220




0.  z'**! = (x'! P y'!)

1.  y'! e z'**!
----



0.  z'**! = y''?

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 213




0.  z'**! = (x'! P y'!)
----



0.  z'**! e {@y | (y'! e @y
   & @y e (x'! O y'!))}

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

varelim()

"""

Line number 221



----



0.  (x'! P y'!)
   e {@y | (y'! e @y
   & @y e (x'! O y'!))}

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 222



----



0.  (y'! e (x'! P y'!)
   & (x'! P y'!)
   e (x'! O y'!))

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 223



----



0.  y'! e (x'! P y'!)

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 225



----



0.  y'! e {@x | (@x = x'! V @x = y'!)}

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 226



----



0.  (y'! = x'! V y'! = y'!)

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 227



----



0.  y'! = x'!

1.  y'! = y'!

2.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

getright(1)

"""

Line number 227



----



0.  y'! = y'!

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

2.  y'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 224



----



0.  (x'! P y'!)
   e (x'! O y'!)

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 228



----



0.  (x'! P y'!)
   e ((x'! P x'!)
   P (x'! P y'!))

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 229



----



0.  (x'! P y'!)
   e {@x | (@x = (x'! P x'!)
   V @x = (x'! P y'!))}

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 230



----



0.  ((x'! P y'!)
   = (x'! P x'!)
   V (x'! P y'!)
   = (x'! P y'!))

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 231



----



0.  (x'! P y'!)
   = (x'! P x'!)

1.  (x'! P y'!)
   = (x'! P y'!)

2.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

getright(1)

"""

Line number 231



----



0.  (x'! P y'!)
   = (x'! P y'!)

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

2.  (x'! P y'!)
   = (x'! P x'!)

by lines [-1]
Next!"""

done()

"""

Line number 219




0.  z'**! = (x'! P x'!)

1.  y'! e z'**!
----



0.  z'**! = (x'! P y'!)

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

varelim()

"""

Line number 232




0.  y'! e (x'! P x'!)
----



0.  (x'! P x'!)
   = (x'! P y'!)

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 233




0.  y'! e {@x | (@x = x'! V @x = x'!)}
----



0.  (x'! P x'!)
   = (x'! P y'!)

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 234




0.  (y'! = x'! V y'! = x'!)
----



0.  (x'! P x'!)
   = (x'! P y'!)

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 235




0.  y'! = x'!
----



0.  (x'! P x'!)
   = (x'! P y'!)

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

varelim()

"""

Line number 237



----



0.  (x'! P x'!)
   = (x'! P x'!)

1.  (E@y : (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 236




0.  y'! = x'!
----



0.  (x'! P x'!)
   = (x'! P y'!)

1.  (E@y : (A@z : (@z e {@y | (y'! e @y
   & @y e (x'! O y'!))}
   == @z = @y)))

by lines [-1]
Next!"""

varelim()

"""

Line number 238



----



0.  (x'! P x'!)
   = (x'! P x'!)

1.  (E@y : (A@z : (@z e {@y | (x'! e @y
   & @y e (x'! O x'!))}
   == @z = @y)))

by lines [-1]
Next!"""

done()

"""Done!"""
savetheorem("Proj2")
