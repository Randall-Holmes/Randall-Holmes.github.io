from graph import *

deft ("P", "{xV=xa=xb")
deft ("O", ":a:aa:baP:b:aa:bbPP")
deft ("'P", "{xAy>eyaexy")
start ("AxAy=:a:ax:byO'P{u=xu")

"""

Line number 0



----



0.  (Ax : (Ay : P'(a:(x O y)) = {u | x = u}))

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  (Ay : P'(a:(x'! O y)) = {u | x'! = u})

by lines [-1]
Next!"""

right()

"""

Line number 2



----



0.  P'(a:(x'! O y'!)) = {u | x'! = u}

by lines [-1]
Next!"""

right()

"""

Line number 3



----



0.  {@x | (A@y : (@y e (x'! O y'!) -> @x e @y))} = {u | x'! = u}

by lines [-1]
Next!"""

right()

"""

Line number 4



----



0.  (Ax* : (x* e {@x | (A@y : (@y e (x'! O y'!) -> @x e @y))} == x* e {u | x'! = u}))

by lines [-1]
Next!"""

right()

"""

Line number 5



----



0.  (x''! e {@x | (A@y : (@y e (x'! O y'!) -> @x e @y))} == x''! e {u | x'! = u})

by lines [-1]
Next!"""

right()

"""

Line number 6




0.  x''! e {@x | (A@y : (@y e (x'! O y'!) -> @x e @y))}
----



0.  x''! e {u | x'! = u}

by lines [-1]
Next!"""

right()

"""

Line number 8




0.  x''! e {@x | (A@y : (@y e (x'! O y'!) -> @x e @y))}
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 9




0.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 10




0.  (y*? e (x'! O y'!) -> x''! e y*?)

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 11




0.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  y*? e (x'! O y'!)

1.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 13




0.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  y*? e ((x'! P x'!) P (x'! P y'!))

1.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 14




0.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  y*? e {@x | (@x = (x'! P x'!) V @x = (x'! P y'!))}

1.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 15




0.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  (y*? = (x'! P x'!) V y*? = (x'! P y'!))

1.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 16




0.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  y*? = (x'! P x'!)

1.  y*? = (x'! P y'!)

2.  x'! = x''!

by lines [-1]
Next!"""

setunknown ("y*",":a'x:b'xP")

"""

Line number 16




0.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  (x'! P x'!) = (x'! P x'!)

1.  (x'! P x'!) = (x'! P y'!)

2.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 17




0.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  (x'! P x'!) = {@x | (@x = x'! V @x = x'!)}

1.  (x'! P x'!) = (x'! P y'!)

2.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 18




0.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  {@x | (@x = x'! V @x = x'!)} = {@x | (@x = x'! V @x = x'!)}

1.  (x'! P x'!) = (x'! P y'!)

2.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 19




0.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  (Ax'* : (x'* e {@x | (@x = x'! V @x = x'!)} == x'* e {@x | (@x = x'! V @x = x'!)}))

1.  (x'! P x'!) = (x'! P y'!)

2.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 20




0.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  (x*'! e {@x | (@x = x'! V @x = x'!)} == x*'! e {@x | (@x = x'! V @x = x'!)})

1.  (x'! P x'!) = (x'! P y'!)

2.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 21




0.  x*'! e {@x | (@x = x'! V @x = x'!)}

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x*'! e {@x | (@x = x'! V @x = x'!)}

1.  (x'! P x'!) = (x'! P y'!)

2.  x'! = x''!

by lines [-1]
Next!"""

done()

"""

Line number 22




0.  x*'! e {@x | (@x = x'! V @x = x'!)}

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x*'! e {@x | (@x = x'! V @x = x'!)}

1.  (x'! P x'!) = (x'! P y'!)

2.  x'! = x''!

by lines [-1]
Next!"""

done()

"""

Line number 12




0.  x''! e (x'! P x'!)

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 23




0.  x''! e {@x | (@x = x'! V @x = x'!)}

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 24




0.  (x''! = x'! V x''! = x'!)

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 25




0.  x''! = x'!

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 27




0.  (Ax''* : (x''! e x''* == x'! e x''*))

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 28




0.  (x''! e x'*'? == x'! e x'*'?)

1.  (Ax''* : (x''! e x''* == x'! e x''*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

setunknown ("x'*'","{u='xu")

"""

Line number 28




0.  (x''! e {u | x'! = u} == x'! e {u | x'! = u})

1.  (Ax''* : (x''! e x''* == x'! e x''*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 29




0.  (x''! e {u | x'! = u} -> x'! e {u | x'! = u})

1.  (x'! e {u | x'! = u} -> x''! e {u | x'! = u})

2.  (Ax''* : (x''! e x''* == x'! e x''*))

3.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 29




0.  (x'! e {u | x'! = u} -> x''! e {u | x'! = u})

1.  (Ax''* : (x''! e x''* == x'! e x''*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  (x''! e {u | x'! = u} -> x'! e {u | x'! = u})
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 30




0.  (Ax''* : (x''! e x''* == x'! e x''*))

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

2.  (x''! e {u | x'! = u} -> x'! e {u | x'! = u})
----



0.  x'! e {u | x'! = u}

1.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 32




0.  (Ax''* : (x''! e x''* == x'! e x''*))

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

2.  (x''! e {u | x'! = u} -> x'! e {u | x'! = u})
----



0.  x'! = x'!

1.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 33




0.  (Ax''* : (x''! e x''* == x'! e x''*))

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

2.  (x''! e {u | x'! = u} -> x'! e {u | x'! = u})
----



0.  (Ax'** : (x'** e x'! == x'** e x'!))

1.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 34




0.  (Ax''* : (x''! e x''* == x'! e x''*))

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

2.  (x''! e {u | x'! = u} -> x'! e {u | x'! = u})
----



0.  (x*''! e x'! == x*''! e x'!)

1.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 35




0.  x*''! e x'!

1.  (Ax''* : (x''! e x''* == x'! e x''*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  (x''! e {u | x'! = u} -> x'! e {u | x'! = u})
----



0.  x*''! e x'!

1.  x'! = x''!

by lines [-1]
Next!"""

done()

"""

Line number 36




0.  x*''! e x'!

1.  (Ax''* : (x''! e x''* == x'! e x''*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  (x''! e {u | x'! = u} -> x'! e {u | x'! = u})
----



0.  x*''! e x'!

1.  x'! = x''!

by lines [-1]
Next!"""

done()

"""

Line number 31




0.  x''! e {u | x'! = u}

1.  (Ax''* : (x''! e x''* == x'! e x''*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  (x''! e {u | x'! = u} -> x'! e {u | x'! = u})
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 37




0.  x'! = x''!

1.  (Ax''* : (x''! e x''* == x'! e x''*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  (x''! e {u | x'! = u} -> x'! e {u | x'! = u})
----



0.  x'! = x''!

by lines [-1]
Next!"""

done()

"""

Line number 26




0.  x''! = x'!

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 38




0.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

left()

"""

Line number 39




0.  (x''! e x**'? == x'! e x**'?)

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

setunknown ("x'*'","{u='xu")

"""

Line number 39




0.  (x''! e x**'? == x'! e x**'?)

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x'! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 40




0.  (x''! e x**'? == x'! e x**'?)

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  (Ax*** : (x*** e x'! == x*** e x''!))

by lines [-1]
Next!"""

right()

"""

Line number 41




0.  (x''! e x**'? == x'! e x**'?)

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  (x''''! e x'! == x''''! e x''!)

by lines [-1]
Next!"""

right()

"""

Line number 42




0.  x''''! e x'!

1.  (x''! e x**'? == x'! e x**'?)

2.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

3.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x''''! e x''!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 42




0.  (x''! e x**'? == x'! e x**'?)

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  x''''! e x'!
----



0.  x''''! e x''!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 42




0.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

2.  x''''! e x'!

3.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x''!

by lines [-1]
Next!"""

left()

"""

Line number 44




0.  (x''! e x'''*? == x'! e x'''*?)

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  x''''! e x'!

4.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x''!

by lines [-1]
Next!"""

setunknown ("x'''*","{ue''''xu")

"""

Line number 44




0.  (x''! e {u | x''''! e u} == x'! e {u | x''''! e u})

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  x''''! e x'!

4.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x''!

by lines [-1]
Next!"""

left()

"""

Line number 45




0.  (x''! e {u | x''''! e u} -> x'! e {u | x''''! e u})

1.  (x'! e {u | x''''! e u} -> x''! e {u | x''''! e u})

2.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

3.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

4.  x''''! e x'!

5.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x''!

by lines [-1]
Next!"""

left()

"""

Line number 46




0.  (x'! e {u | x''''! e u} -> x''! e {u | x''''! e u})

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  x''''! e x'!

4.  (x''! e x**'? == x'! e x**'?)
----



0.  x''! e {u | x''''! e u}

1.  x''''! e x''!

by lines [-1]
Next!"""

right()

"""

Line number 48




0.  (x'! e {u | x''''! e u} -> x''! e {u | x''''! e u})

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  x''''! e x'!

4.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x''!

1.  x''''! e x''!

by lines [-1]
Next!"""

left()

"""

Line number 49




0.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

2.  x''''! e x'!

3.  (x''! e x**'? == x'! e x**'?)
----



0.  x'! e {u | x''''! e u}

1.  x''''! e x''!

2.  x''''! e x''!

by lines [-1]
Next!"""

right()

"""

Line number 51




0.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

2.  x''''! e x'!

3.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x'!

1.  x''''! e x''!

2.  x''''! e x''!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 51




0.  x''''! e x'!

1.  (x''! e x**'? == x'! e x**'?)

2.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

3.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x''''! e x'!

1.  x''''! e x''!

2.  x''''! e x''!

by lines [-1]
Next!"""

done()

"""

Line number 50




0.  x''! e {u | x''''! e u}

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  x''''! e x'!

4.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x''!

1.  x''''! e x''!

by lines [-1]
Next!"""

left()

"""

Line number 52




0.  x''''! e x''!

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  x''''! e x'!

4.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x''!

1.  x''''! e x''!

by lines [-1]
Next!"""

done()

"""

Line number 47




0.  x'! e {u | x''''! e u}

1.  (x'! e {u | x''''! e u} -> x''! e {u | x''''! e u})

2.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

3.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

4.  x''''! e x'!

5.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x''!

by lines [-1]
Next!"""

left()

"""

Line number 53




0.  x''''! e x'!

1.  (x'! e {u | x''''! e u} -> x''! e {u | x''''! e u})

2.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

3.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

4.  x''''! e x'!

5.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x''!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 53




0.  (x'! e {u | x''''! e u} -> x''! e {u | x''''! e u})

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  x''''! e x'!

4.  (x''! e x**'? == x'! e x**'?)

5.  x''''! e x'!
----



0.  x''''! e x''!

by lines [-1]
Next!"""

left()

"""

Line number 54




0.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

2.  x''''! e x'!

3.  (x''! e x**'? == x'! e x**'?)

4.  x''''! e x'!
----



0.  x'! e {u | x''''! e u}

1.  x''''! e x''!

by lines [-1]
Next!"""

right()

"""

Line number 56




0.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

2.  x''''! e x'!

3.  (x''! e x**'? == x'! e x**'?)

4.  x''''! e x'!
----



0.  x''''! e x'!

1.  x''''! e x''!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 56




0.  x''''! e x'!

1.  (x''! e x**'? == x'! e x**'?)

2.  x''''! e x'!

3.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

4.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x''''! e x'!

1.  x''''! e x''!

by lines [-1]
Next!"""

done()

"""

Line number 55




0.  x''! e {u | x''''! e u}

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  x''''! e x'!

4.  (x''! e x**'? == x'! e x**'?)

5.  x''''! e x'!
----



0.  x''''! e x''!

by lines [-1]
Next!"""

left()

"""

Line number 57




0.  x''''! e x''!

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  x''''! e x'!

4.  (x''! e x**'? == x'! e x**'?)

5.  x''''! e x'!
----



0.  x''''! e x''!

by lines [-1]
Next!"""

done()

"""

Line number 43




0.  x''''! e x''!

1.  (x''! e x**'? == x'! e x**'?)

2.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

3.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x''''! e x'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 43




0.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

1.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

2.  x''''! e x''!

3.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 58




0.  (x''! e x''*'? == x'! e x''*'?)

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  x''''! e x''!

4.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 59




0.  (x''! e x''*'? -> x'! e x''*'?)

1.  (x'! e x''*'? -> x''! e x''*'?)

2.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

3.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

4.  x''''! e x''!

5.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x'!

by lines [-1]
Next!"""

setunknown ("x''*'","{ue''''xu")

"""

Line number 59




0.  (x''! e {u | x''''! e u} -> x'! e {u | x''''! e u})

1.  (x'! e {u | x''''! e u} -> x''! e {u | x''''! e u})

2.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

3.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

4.  x''''! e x''!

5.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 60




0.  (x'! e {u | x''''! e u} -> x''! e {u | x''''! e u})

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  x''''! e x''!

4.  (x''! e x**'? == x'! e x**'?)
----



0.  x''! e {u | x''''! e u}

1.  x''''! e x'!

by lines [-1]
Next!"""

right()

"""

Line number 62




0.  (x'! e {u | x''''! e u} -> x''! e {u | x''''! e u})

1.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

2.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

3.  x''''! e x''!

4.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x''!

1.  x''''! e x'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 62




0.  x''''! e x''!

1.  (x''! e x**'? == x'! e x**'?)

2.  (x'! e {u | x''''! e u} -> x''! e {u | x''''! e u})

3.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

4.  (A@y : (@y e (x'! O y'!) -> x''! e @y))
----



0.  x''''! e x''!

1.  x''''! e x'!

by lines [-1]
Next!"""

done()

"""

Line number 61




0.  x'! e {u | x''''! e u}

1.  (x'! e {u | x''''! e u} -> x''! e {u | x''''! e u})

2.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

3.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

4.  x''''! e x''!

5.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 63




0.  x''''! e x'!

1.  (x'! e {u | x''''! e u} -> x''! e {u | x''''! e u})

2.  (Ax*'* : (x''! e x*'* == x'! e x*'*))

3.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

4.  x''''! e x''!

5.  (x''! e x**'? == x'! e x**'?)
----



0.  x''''! e x'!

by lines [-1]
Next!"""

done()

"""

Line number 7




0.  x''! e {u | x'! = u}
----



0.  x''! e {@x | (A@y : (@y e (x'! O y'!) -> @x e @y))}

by lines [-1]
Next!"""

left()

"""

Line number 64




0.  x'! = x''!
----



0.  x''! e {@x | (A@y : (@y e (x'! O y'!) -> @x e @y))}

by lines [-1]
Next!"""

right()

"""

Line number 65




0.  x'! = x''!
----



0.  (A@y : (@y e (x'! O y'!) -> x''! e @y))

by lines [-1]
Next!"""

right()

"""

Line number 66




0.  x'! = x''!
----



0.  (y''! e (x'! O y'!) -> x''! e y''!)

by lines [-1]
Next!"""

right()

"""

Line number 67




0.  y''! e (x'! O y'!)

1.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 68




0.  y''! e ((x'! P x'!) P (x'! P y'!))

1.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 69




0.  y''! e {@x | (@x = (x'! P x'!) V @x = (x'! P y'!))}

1.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 70




0.  (y''! = (x'! P x'!) V y''! = (x'! P y'!))

1.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 71




0.  y''! = (x'! P x'!)

1.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 73




0.  y''! = {@x | (@x = x'! V @x = x'!)}

1.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 74




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 75




0.  (y''! e x'*''? == {@x | (@x = x'! V @x = x'!)} e x'*''?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 76




0.  (y''! e x'*''? -> {@x | (@x = x'! V @x = x'!)} e x'*''?)

1.  ({@x | (@x = x'! V @x = x'!)} e x'*''? -> y''! e x'*''?)

2.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

3.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 77




0.  ({@x | (@x = x'! V @x = x'!)} e x'*''? -> y''! e x'*''?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!
----



0.  y''! e x'*''?

1.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 79




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!
----



0.  {@x | (@x = x'! V @x = x'!)} e x'*''?

1.  y''! e x'*''?

2.  x''! e y''!

by lines [-1]
Next!"""

back()
back()
back()
back()
back()
left()

"""

Line number 75




0.  (y''! e x'*''? == {@x | (@x = x'! V @x = x'!)} e x'*''?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 76




0.  (y''! e x'*''? -> {@x | (@x = x'! V @x = x'!)} e x'*''?)

1.  ({@x | (@x = x'! V @x = x'!)} e x'*''? -> y''! e x'*''?)

2.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

3.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 77




0.  ({@x | (@x = x'! V @x = x'!)} e x'*''? -> y''! e x'*''?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!
----



0.  y''! e x'*''?

1.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 79




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!
----



0.  {@x | (@x = x'! V @x = x'!)} e x'*''?

1.  y''! e x'*''?

2.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 81




0.  (y''! e x'*'*? == {@x | (@x = x'! V @x = x'!)} e x'*'*?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!
----



0.  {@x | (@x = x'! V @x = x'!)} e x'*''?

1.  y''! e x'*''?

2.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 82




0.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

1.  ({@x | (@x = x'! V @x = x'!)} e x'*'*? -> y''! e x'*'*?)

2.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

3.  x'! = x''!
----



0.  {@x | (@x = x'! V @x = x'!)} e x'*''?

1.  y''! e x'*''?

2.  x''! e y''!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 82




0.  ({@x | (@x = x'! V @x = x'!)} e x'*'*? -> y''! e x'*'*?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!

3.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)
----



0.  {@x | (@x = x'! V @x = x'!)} e x'*''?

1.  y''! e x'*''?

2.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 83




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!

2.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)
----



0.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

1.  {@x | (@x = x'! V @x = x'!)} e x'*''?

2.  y''! e x'*''?

3.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 85




0.  (y''! e x'**'? == {@x | (@x = x'! V @x = x'!)} e x'**'?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!

3.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)
----



0.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

1.  {@x | (@x = x'! V @x = x'!)} e x'*''?

2.  y''! e x'*''?

3.  x''! e y''!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 85




0.  x'! = x''!

1.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

2.  (y''! e x'**'? == {@x | (@x = x'! V @x = x'!)} e x'**'?)

3.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))
----



0.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

1.  {@x | (@x = x'! V @x = x'!)} e x'*''?

2.  y''! e x'*''?

3.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 86




0.  (Ax'*** : (x'! e x'*** == x''! e x'***))

1.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

2.  (y''! e x'**'? == {@x | (@x = x'! V @x = x'!)} e x'**'?)

3.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))
----



0.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

1.  {@x | (@x = x'! V @x = x'!)} e x'*''?

2.  y''! e x'*''?

3.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 87




0.  (x'! e x*'''? == x''! e x*'''?)

1.  (Ax'*** : (x'! e x'*** == x''! e x'***))

2.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

3.  (y''! e x'**'? == {@x | (@x = x'! V @x = x'!)} e x'**'?)

4.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))
----



0.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

1.  {@x | (@x = x'! V @x = x'!)} e x'*''?

2.  y''! e x'*''?

3.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 88




0.  (x'! e x*'''? -> x''! e x*'''?)

1.  (x''! e x*'''? -> x'! e x*'''?)

2.  (Ax'*** : (x'! e x'*** == x''! e x'***))

3.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

4.  (y''! e x'**'? == {@x | (@x = x'! V @x = x'!)} e x'**'?)

5.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))
----



0.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

1.  {@x | (@x = x'! V @x = x'!)} e x'*''?

2.  y''! e x'*''?

3.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 89




0.  (x''! e x*'''? -> x'! e x*'''?)

1.  (Ax'*** : (x'! e x'*** == x''! e x'***))

2.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

3.  (y''! e x'**'? == {@x | (@x = x'! V @x = x'!)} e x'**'?)

4.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))
----



0.  x'! e x*'''?

1.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

2.  {@x | (@x = x'! V @x = x'!)} e x'*''?

3.  y''! e x'*''?

4.  x''! e y''!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 89




0.  (y''! e x'**'? == {@x | (@x = x'! V @x = x'!)} e x'**'?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  (x''! e x*'''? -> x'! e x*'''?)

3.  (Ax'*** : (x'! e x'*** == x''! e x'***))

4.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)
----



0.  x'! e x*'''?

1.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

2.  {@x | (@x = x'! V @x = x'!)} e x'*''?

3.  y''! e x'*''?

4.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 91




0.  (y''! e x'**'? -> {@x | (@x = x'! V @x = x'!)} e x'**'?)

1.  ({@x | (@x = x'! V @x = x'!)} e x'**'? -> y''! e x'**'?)

2.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

3.  (x''! e x*'''? -> x'! e x*'''?)

4.  (Ax'*** : (x'! e x'*** == x''! e x'***))

5.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)
----



0.  x'! e x*'''?

1.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

2.  {@x | (@x = x'! V @x = x'!)} e x'*''?

3.  y''! e x'*''?

4.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 92




0.  ({@x | (@x = x'! V @x = x'!)} e x'**'? -> y''! e x'**'?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  (x''! e x*'''? -> x'! e x*'''?)

3.  (Ax'*** : (x'! e x'*** == x''! e x'***))

4.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)
----



0.  y''! e x'**'?

1.  x'! e x*'''?

2.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

3.  {@x | (@x = x'! V @x = x'!)} e x'*''?

4.  y''! e x'*''?

5.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 94




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  (x''! e x*'''? -> x'! e x*'''?)

2.  (Ax'*** : (x'! e x'*** == x''! e x'***))

3.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)
----



0.  {@x | (@x = x'! V @x = x'!)} e x'**'?

1.  y''! e x'**'?

2.  x'! e x*'''?

3.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

4.  {@x | (@x = x'! V @x = x'!)} e x'*''?

5.  y''! e x'*''?

6.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 96




0.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  (x''! e x*'''? -> x'! e x*'''?)

3.  (Ax'*** : (x'! e x'*** == x''! e x'***))

4.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)
----



0.  {@x | (@x = x'! V @x = x'!)} e x'**'?

1.  y''! e x'**'?

2.  x'! e x*'''?

3.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

4.  {@x | (@x = x'! V @x = x'!)} e x'*''?

5.  y''! e x'*''?

6.  x''! e y''!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 96




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  (x''! e x*'''? -> x'! e x*'''?)

2.  (Ax'*** : (x'! e x'*** == x''! e x'***))

3.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

4.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)
----



0.  {@x | (@x = x'! V @x = x'!)} e x'**'?

1.  y''! e x'**'?

2.  x'! e x*'''?

3.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

4.  {@x | (@x = x'! V @x = x'!)} e x'*''?

5.  y''! e x'*''?

6.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 97




0.  (y''! e x*'*'? == {@x | (@x = x'! V @x = x'!)} e x*'*'?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  (x''! e x*'''? -> x'! e x*'''?)

3.  (Ax'*** : (x'! e x'*** == x''! e x'***))

4.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

5.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)
----



0.  {@x | (@x = x'! V @x = x'!)} e x'**'?

1.  y''! e x'**'?

2.  x'! e x*'''?

3.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

4.  {@x | (@x = x'! V @x = x'!)} e x'*''?

5.  y''! e x'*''?

6.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 98




0.  (y''! e x*'*'? -> {@x | (@x = x'! V @x = x'!)} e x*'*'?)

1.  ({@x | (@x = x'! V @x = x'!)} e x*'*'? -> y''! e x*'*'?)

2.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

3.  (x''! e x*'''? -> x'! e x*'''?)

4.  (Ax'*** : (x'! e x'*** == x''! e x'***))

5.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

6.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)
----



0.  {@x | (@x = x'! V @x = x'!)} e x'**'?

1.  y''! e x'**'?

2.  x'! e x*'''?

3.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

4.  {@x | (@x = x'! V @x = x'!)} e x'*''?

5.  y''! e x'*''?

6.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 99




0.  ({@x | (@x = x'! V @x = x'!)} e x*'*'? -> y''! e x*'*'?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  (x''! e x*'''? -> x'! e x*'''?)

3.  (Ax'*** : (x'! e x'*** == x''! e x'***))

4.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

5.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)
----



0.  y''! e x*'*'?

1.  {@x | (@x = x'! V @x = x'!)} e x'**'?

2.  y''! e x'**'?

3.  x'! e x*'''?

4.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

5.  {@x | (@x = x'! V @x = x'!)} e x'*''?

6.  y''! e x'*''?

7.  x''! e y''!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 99




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  (x''! e x*'''? -> x'! e x*'''?)

2.  (Ax'*** : (x'! e x'*** == x''! e x'***))

3.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

4.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)

5.  ({@x | (@x = x'! V @x = x'!)} e x*'*'? -> y''! e x*'*'?)
----



0.  y''! e x*'*'?

1.  {@x | (@x = x'! V @x = x'!)} e x'**'?

2.  y''! e x'**'?

3.  x'! e x*'''?

4.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

5.  {@x | (@x = x'! V @x = x'!)} e x'*''?

6.  y''! e x'*''?

7.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 101




0.  (y''! e x*'**? == {@x | (@x = x'! V @x = x'!)} e x*'**?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  (x''! e x*'''? -> x'! e x*'''?)

3.  (Ax'*** : (x'! e x'*** == x''! e x'***))

4.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

5.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)

6.  ({@x | (@x = x'! V @x = x'!)} e x*'*'? -> y''! e x*'*'?)
----



0.  y''! e x*'*'?

1.  {@x | (@x = x'! V @x = x'!)} e x'**'?

2.  y''! e x'**'?

3.  x'! e x*'''?

4.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

5.  {@x | (@x = x'! V @x = x'!)} e x'*''?

6.  y''! e x'*''?

7.  x''! e y''!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 101




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  (x''! e x*'''? -> x'! e x*'''?)

2.  (Ax'*** : (x'! e x'*** == x''! e x'***))

3.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

4.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)

5.  ({@x | (@x = x'! V @x = x'!)} e x*'*'? -> y''! e x*'*'?)

6.  (y''! e x*'**? == {@x | (@x = x'! V @x = x'!)} e x*'**?)
----



0.  y''! e x*'*'?

1.  {@x | (@x = x'! V @x = x'!)} e x'**'?

2.  y''! e x'**'?

3.  x'! e x*'''?

4.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

5.  {@x | (@x = x'! V @x = x'!)} e x'*''?

6.  y''! e x'*''?

7.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 102




0.  (y''! e x**''? == {@x | (@x = x'! V @x = x'!)} e x**''?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  (x''! e x*'''? -> x'! e x*'''?)

3.  (Ax'*** : (x'! e x'*** == x''! e x'***))

4.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

5.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)

6.  ({@x | (@x = x'! V @x = x'!)} e x*'*'? -> y''! e x*'*'?)

7.  (y''! e x*'**? == {@x | (@x = x'! V @x = x'!)} e x*'**?)
----



0.  y''! e x*'*'?

1.  {@x | (@x = x'! V @x = x'!)} e x'**'?

2.  y''! e x'**'?

3.  x'! e x*'''?

4.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

5.  {@x | (@x = x'! V @x = x'!)} e x'*''?

6.  y''! e x'*''?

7.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 103




0.  (y''! e x**''? -> {@x | (@x = x'! V @x = x'!)} e x**''?)

1.  ({@x | (@x = x'! V @x = x'!)} e x**''? -> y''! e x**''?)

2.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

3.  (x''! e x*'''? -> x'! e x*'''?)

4.  (Ax'*** : (x'! e x'*** == x''! e x'***))

5.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

6.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)

7.  ({@x | (@x = x'! V @x = x'!)} e x*'*'? -> y''! e x*'*'?)

8.  (y''! e x*'**? == {@x | (@x = x'! V @x = x'!)} e x*'**?)
----



0.  y''! e x*'*'?

1.  {@x | (@x = x'! V @x = x'!)} e x'**'?

2.  y''! e x'**'?

3.  x'! e x*'''?

4.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

5.  {@x | (@x = x'! V @x = x'!)} e x'*''?

6.  y''! e x'*''?

7.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 104




0.  ({@x | (@x = x'! V @x = x'!)} e x**''? -> y''! e x**''?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  (x''! e x*'''? -> x'! e x*'''?)

3.  (Ax'*** : (x'! e x'*** == x''! e x'***))

4.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

5.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)

6.  ({@x | (@x = x'! V @x = x'!)} e x*'*'? -> y''! e x*'*'?)

7.  (y''! e x*'**? == {@x | (@x = x'! V @x = x'!)} e x*'**?)
----



0.  y''! e x**''?

1.  y''! e x*'*'?

2.  {@x | (@x = x'! V @x = x'!)} e x'**'?

3.  y''! e x'**'?

4.  x'! e x*'''?

5.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

6.  {@x | (@x = x'! V @x = x'!)} e x'*''?

7.  y''! e x'*''?

8.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 106




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  (x''! e x*'''? -> x'! e x*'''?)

2.  (Ax'*** : (x'! e x'*** == x''! e x'***))

3.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

4.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)

5.  ({@x | (@x = x'! V @x = x'!)} e x*'*'? -> y''! e x*'*'?)

6.  (y''! e x*'**? == {@x | (@x = x'! V @x = x'!)} e x*'**?)
----



0.  {@x | (@x = x'! V @x = x'!)} e x**''?

1.  y''! e x**''?

2.  y''! e x*'*'?

3.  {@x | (@x = x'! V @x = x'!)} e x'**'?

4.  y''! e x'**'?

5.  x'! e x*'''?

6.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

7.  {@x | (@x = x'! V @x = x'!)} e x'*''?

8.  y''! e x'*''?

9.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 108




0.  (y''! e x**'*? == {@x | (@x = x'! V @x = x'!)} e x**'*?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  (x''! e x*'''? -> x'! e x*'''?)

3.  (Ax'*** : (x'! e x'*** == x''! e x'***))

4.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

5.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)

6.  ({@x | (@x = x'! V @x = x'!)} e x*'*'? -> y''! e x*'*'?)

7.  (y''! e x*'**? == {@x | (@x = x'! V @x = x'!)} e x*'**?)
----



0.  {@x | (@x = x'! V @x = x'!)} e x**''?

1.  y''! e x**''?

2.  y''! e x*'*'?

3.  {@x | (@x = x'! V @x = x'!)} e x'**'?

4.  y''! e x'**'?

5.  x'! e x*'''?

6.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

7.  {@x | (@x = x'! V @x = x'!)} e x'*''?

8.  y''! e x'*''?

9.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 109




0.  (y''! e x**'*? -> {@x | (@x = x'! V @x = x'!)} e x**'*?)

1.  ({@x | (@x = x'! V @x = x'!)} e x**'*? -> y''! e x**'*?)

2.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

3.  (x''! e x*'''? -> x'! e x*'''?)

4.  (Ax'*** : (x'! e x'*** == x''! e x'***))

5.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

6.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)

7.  ({@x | (@x = x'! V @x = x'!)} e x*'*'? -> y''! e x*'*'?)

8.  (y''! e x*'**? == {@x | (@x = x'! V @x = x'!)} e x*'**?)
----



0.  {@x | (@x = x'! V @x = x'!)} e x**''?

1.  y''! e x**''?

2.  y''! e x*'*'?

3.  {@x | (@x = x'! V @x = x'!)} e x'**'?

4.  y''! e x'**'?

5.  x'! e x*'''?

6.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

7.  {@x | (@x = x'! V @x = x'!)} e x'*''?

8.  y''! e x'*''?

9.  x''! e y''!

by lines [-1]
Next!"""

getright(1)

"""

Line number 109




0.  (y''! e x**'*? -> {@x | (@x = x'! V @x = x'!)} e x**'*?)

1.  ({@x | (@x = x'! V @x = x'!)} e x**'*? -> y''! e x**'*?)

2.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

3.  (x''! e x*'''? -> x'! e x*'''?)

4.  (Ax'*** : (x'! e x'*** == x''! e x'***))

5.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

6.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)

7.  ({@x | (@x = x'! V @x = x'!)} e x*'*'? -> y''! e x*'*'?)

8.  (y''! e x*'**? == {@x | (@x = x'! V @x = x'!)} e x*'**?)
----



0.  y''! e x**''?

1.  y''! e x*'*'?

2.  {@x | (@x = x'! V @x = x'!)} e x'**'?

3.  y''! e x'**'?

4.  x'! e x*'''?

5.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

6.  {@x | (@x = x'! V @x = x'!)} e x'*''?

7.  y''! e x'*''?

8.  x''! e y''!

9.  {@x | (@x = x'! V @x = x'!)} e x**''?

by lines [-1]
Next!"""

left()

"""

Line number 110




0.  ({@x | (@x = x'! V @x = x'!)} e x**'*? -> y''! e x**'*?)

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  (x''! e x*'''? -> x'! e x*'''?)

3.  (Ax'*** : (x'! e x'*** == x''! e x'***))

4.  (y''! e x'*'*? -> {@x | (@x = x'! V @x = x'!)} e x'*'*?)

5.  (y''! e x*''*? == {@x | (@x = x'! V @x = x'!)} e x*''*?)

6.  ({@x | (@x = x'! V @x = x'!)} e x*'*'? -> y''! e x*'*'?)

7.  (y''! e x*'**? == {@x | (@x = x'! V @x = x'!)} e x*'**?)
----



0.  y''! e x**'*?

1.  y''! e x**''?

2.  y''! e x*'*'?

3.  {@x | (@x = x'! V @x = x'!)} e x'**'?

4.  y''! e x'**'?

5.  x'! e x*'''?

6.  {@x | (@x = x'! V @x = x'!)} e x'*'*?

7.  {@x | (@x = x'! V @x = x'!)} e x'*''?

8.  y''! e x'*''?

9.  x''! e y''!

10.  {@x | (@x = x'! V @x = x'!)} e x**''?

by lines [-1]
Next!"""

deft ("U", "{xEyAzXezx=zy")
deft ("*P", "{xe{y&exyeyaU")
start ("AxAy=:a:ax:byO*P{u=uy")

"""

Line number 0



----



0.  (Ax : (Ay : P*(a:(x O y)) = {u | u = y}))

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  (Ay : P*(a:(x'! O y)) = {u | u = y})

by lines [-1]
Next!"""

right()

"""

Line number 2



----



0.  P*(a:(x'! O y'!)) = {u | u = y'!}

by lines [-1]
Next!"""

right()

"""

Line number 3



----



0.  {@x | {@y | (@x e @y & @y e (x'! O y'!))} e U} = {u | u = y'!}

by lines [-1]
Next!"""

right()

"""

Line number 4



----



0.  (Ax* : (x* e {@x | {@y | (@x e @y & @y e (x'! O y'!))} e U} == x* e {u | u = y'!}))

by lines [-1]
Next!"""

right()

"""

Line number 5



----



0.  (x''! e {@x | {@y | (@x e @y & @y e (x'! O y'!))} e U} == x''! e {u | u = y'!})

by lines [-1]
Next!"""

right()

"""

Line number 6




0.  x''! e {@x | {@y | (@x e @y & @y e (x'! O y'!))} e U}
----



0.  x''! e {u | u = y'!}

by lines [-1]
Next!"""

right()

"""

Line number 8




0.  x''! e {@x | {@y | (@x e @y & @y e (x'! O y'!))} e U}
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 9




0.  {@y | (x''! e @y & @y e (x'! O y'!))} e U
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 10




0.  {@y | (x''! e @y & @y e (x'! O y'!))} e {@x | (E@y : (A@z : (@z e @x == @z = @y)))}
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 11




0.  (E@y : (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = @y)))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 12




0.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 13




0.  (z'? e {@y | (x''! e @y & @y e (x'! O y'!))} == z'? = y*!)

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 14




0.  (z'? e {@y | (x''! e @y & @y e (x'! O y'!))} -> z'? = y*!)

1.  (z'? = y*! -> z'? e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 15




0.  (z'? = y*! -> z'? e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  z'? e {@y | (x''! e @y & @y e (x'! O y'!))}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 17




0.  (z'? = y*! -> z'? e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x''! e z'? & z'? e (x'! O y'!))

1.  x''! = y'!

by lines [-1]
Next!"""

back()
back()
back()
getleft(1)

"""

Line number 14




0.  (z'? = y*! -> z'? e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (z'? e {@y | (x''! e @y & @y e (x'! O y'!))} -> z'? = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

setunknown ("z'",":a'x:b'yP")

"""

Line number 14




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 15




0.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

1.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)
----



0.  (x'! P y'!) = y*!

1.  x''! = y'!

by lines [-1]
Next!"""

back()
back()
getleft(2)

"""

Line number 14




0.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

1.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 15




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 17




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x''! e (x'! P y'!) & (x'! P y'!) e (x'! O y'!))

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 18




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! e (x'! P y'!)

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 20




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! e {@x | (@x = x'! V @x = y'!)}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 21




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x''! = x'! V x''! = y'!)

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 22




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 22




0.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

1.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 23




0.  (z*? e {@y | (x''! e @y & @y e (x'! O y'!))} == z*? = y*!)

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

setunknown ("z*","*y")

"""

Line number 23




0.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} == y*! = y*!)

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 24




0.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

1.  (y*! = y*! -> y*! e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 24




0.  (y*! = y*! -> y*! e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 25




0.  (y*! = y*! -> y*! e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)
----



0.  (Ax'* : (x'* e x''! == x'* e x'!))

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

back()
back()
left()

"""

Line number 25




0.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

1.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)
----



0.  y*! = y*!

1.  x''! = x'!

2.  x''! = y'!

3.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 27




0.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

1.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)
----



0.  (Ax'* : (x'* e y*! == x'* e y*!))

1.  x''! = x'!

2.  x''! = y'!

3.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 28




0.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

1.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)
----



0.  (x*'! e y*! == x*'! e y*!)

1.  x''! = x'!

2.  x''! = y'!

3.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 29




0.  x*'! e y*!

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)
----



0.  x*'! e y*!

1.  x''! = x'!

2.  x''! = y'!

3.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 30




0.  x*'! e y*!

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)
----



0.  x*'! e y*!

1.  x''! = x'!

2.  x''! = y'!

3.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 26




0.  y*! e {@y | (x''! e @y & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 31




0.  (x''! e y*! & y*! e (x'! O y'!))

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 32




0.  x''! e y*!

1.  y*! e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 32




0.  y*! e (x'! O y'!)

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

4.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 33




0.  y*! e ((x'! P x'!) P (x'! P y'!))

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

4.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 34




0.  y*! e {@x | (@x = (x'! P x'!) V @x = (x'! P y'!))}

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

4.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 35




0.  (y*! = (x'! P x'!) V y*! = (x'! P y'!))

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

4.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 36




0.  y*! = (x'! P x'!)

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

4.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 38




0.  y*! = {@x | (@x = x'! V @x = x'!)}

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

4.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 39




0.  (Ax** : (y*! e x** == {@x | (@x = x'! V @x = x'!)} e x**))

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

4.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 40




0.  (y*! e x'''? == {@x | (@x = x'! V @x = x'!)} e x'''?)

1.  (Ax** : (y*! e x** == {@x | (@x = x'! V @x = x'!)} e x**))

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

5.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

setunknown ("x'''","{ue''xu")

"""

Line number 40




0.  (y*! e {u | x''! e u} == {@x | (@x = x'! V @x = x'!)} e {u | x''! e u})

1.  (Ax** : (y*! e x** == {@x | (@x = x'! V @x = x'!)} e x**))

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

5.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 41




0.  (y*! e {u | x''! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | x''! e u})

1.  ({@x | (@x = x'! V @x = x'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax** : (y*! e x** == {@x | (@x = x'! V @x = x'!)} e x**))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

6.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 42




0.  ({@x | (@x = x'! V @x = x'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

1.  (Ax** : (y*! e x** == {@x | (@x = x'! V @x = x'!)} e x**))

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

5.  x''! e y*!
----



0.  y*! e {u | x''! e u}

1.  x''! = x'!

2.  x''! = y'!

3.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 44




0.  ({@x | (@x = x'! V @x = x'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

1.  (Ax** : (y*! e x** == {@x | (@x = x'! V @x = x'!)} e x**))

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

5.  x''! e y*!
----



0.  x''! e y*!

1.  x''! = x'!

2.  x''! = y'!

3.  x''! = y'!

by lines [-1]
Next!"""

getleft(5)

"""

Line number 44




0.  x''! e y*!

1.  ({@x | (@x = x'! V @x = x'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax** : (y*! e x** == {@x | (@x = x'! V @x = x'!)} e x**))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)
----



0.  x''! e y*!

1.  x''! = x'!

2.  x''! = y'!

3.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 43




0.  {@x | (@x = x'! V @x = x'!)} e {u | x''! e u}

1.  ({@x | (@x = x'! V @x = x'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax** : (y*! e x** == {@x | (@x = x'! V @x = x'!)} e x**))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

6.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 45




0.  x''! e {@x | (@x = x'! V @x = x'!)}

1.  ({@x | (@x = x'! V @x = x'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax** : (y*! e x** == {@x | (@x = x'! V @x = x'!)} e x**))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

6.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 46




0.  (x''! = x'! V x''! = x'!)

1.  ({@x | (@x = x'! V @x = x'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax** : (y*! e x** == {@x | (@x = x'! V @x = x'!)} e x**))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

6.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 47




0.  x''! = x'!

1.  ({@x | (@x = x'! V @x = x'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax** : (y*! e x** == {@x | (@x = x'! V @x = x'!)} e x**))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

6.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 48




0.  x''! = x'!

1.  ({@x | (@x = x'! V @x = x'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax** : (y*! e x** == {@x | (@x = x'! V @x = x'!)} e x**))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

6.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 37




0.  y*! = (x'! P y'!)

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

4.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 49




0.  y*! = {@x | (@x = x'! V @x = y'!)}

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

4.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 50




0.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

4.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 51




0.  (y*! e x'*'? == {@x | (@x = x'! V @x = y'!)} e x'*'?)

1.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

5.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

setunknown ("x'*'","{ue''xu")

"""

Line number 51




0.  (y*! e {u | x''! e u} == {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

1.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

5.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 52




0.  (y*! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

1.  ({@x | (@x = x'! V @x = y'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

6.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 53




0.  ({@x | (@x = x'! V @x = y'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

1.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

5.  x''! e y*!
----



0.  y*! e {u | x''! e u}

1.  x''! = x'!

2.  x''! = y'!

3.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 55




0.  ({@x | (@x = x'! V @x = y'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

1.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

5.  x''! e y*!
----



0.  x''! e y*!

1.  x''! = x'!

2.  x''! = y'!

3.  x''! = y'!

by lines [-1]
Next!"""

getleft(5)

"""

Line number 55




0.  x''! e y*!

1.  ({@x | (@x = x'! V @x = y'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)
----



0.  x''! e y*!

1.  x''! = x'!

2.  x''! = y'!

3.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 54




0.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

1.  ({@x | (@x = x'! V @x = y'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

6.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 56




0.  x''! e {@x | (@x = x'! V @x = y'!)}

1.  ({@x | (@x = x'! V @x = y'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

6.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 57




0.  (x''! = x'! V x''! = y'!)

1.  ({@x | (@x = x'! V @x = y'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

6.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 58




0.  x''! = x'!

1.  ({@x | (@x = x'! V @x = y'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

6.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 59




0.  x''! = y'!

1.  ({@x | (@x = x'! V @x = y'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

6.  x''! e y*!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 59




0.  ({@x | (@x = x'! V @x = y'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

1.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

5.  x''! e y*!

6.  x''! = y'!
----



0.  x''! = x'!

1.  x''! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

back()
back()
getright(1)

"""

Line number 59




0.  x''! = y'!

1.  ({@x | (@x = x'! V @x = y'!)} e {u | x''! e u} -> y*! e {u | x''! e u})

2.  (Ax''* : (y*! e x''* == {@x | (@x = x'! V @x = y'!)} e x''*))

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (y*! e {@y | (x''! e @y & @y e (x'! O y'!))} -> y*! = y*!)

6.  x''! e y*!
----



0.  x''! = y'!

1.  x''! = y'!

2.  x''! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 19




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x'! P y'!) e (x'! O y'!)

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 60




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x'! P y'!) e ((x'! P x'!) P (x'! P y'!))

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 61




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x'! P y'!) e {@x | (@x = (x'! P x'!) V @x = (x'! P y'!))}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 62




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  ((x'! P y'!) = (x'! P x'!) V (x'! P y'!) = (x'! P y'!))

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 63




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x'! P y'!) = (x'! P x'!)

1.  (x'! P y'!) = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

getright(1)

"""

Line number 63




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x'! P y'!) = (x'! P y'!)

1.  x''! = y'!

2.  (x'! P y'!) = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 64




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x'! P y'!) = {@x | (@x = x'! V @x = y'!)}

1.  x''! = y'!

2.  (x'! P y'!) = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 65




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  {@x | (@x = x'! V @x = y'!)} = {@x | (@x = x'! V @x = y'!)}

1.  x''! = y'!

2.  (x'! P y'!) = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 66




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (Ax'** : (x'** e {@x | (@x = x'! V @x = y'!)} == x'** e {@x | (@x = x'! V @x = y'!)}))

1.  x''! = y'!

2.  (x'! P y'!) = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 67




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x*''! e {@x | (@x = x'! V @x = y'!)} == x*''! e {@x | (@x = x'! V @x = y'!)})

1.  x''! = y'!

2.  (x'! P y'!) = (x'! P x'!)

by lines [-1]
Next!"""

right()

"""

Line number 68




0.  x*''! e {@x | (@x = x'! V @x = y'!)}

1.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x*''! e {@x | (@x = x'! V @x = y'!)}

1.  x''! = y'!

2.  (x'! P y'!) = (x'! P x'!)

by lines [-1]
Next!"""

done()

"""

Line number 69




0.  x*''! e {@x | (@x = x'! V @x = y'!)}

1.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x*''! e {@x | (@x = x'! V @x = y'!)}

1.  x''! = y'!

2.  (x'! P y'!) = (x'! P x'!)

by lines [-1]
Next!"""

done()

"""

Line number 16




0.  (x'! P y'!) = y*!

1.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 16




0.  ((x'! P y'!) = y*! -> (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 70




0.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

1.  (x'! P y'!) = y*!
----



0.  (x'! P y'!) = y*!

1.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 70




0.  (x'! P y'!) = y*!

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x'! P y'!) = y*!

1.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 71




0.  (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 72




0.  (x''! e (x'! P y'!) & (x'! P y'!) e (x'! O y'!))

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 73




0.  x''! e (x'! P y'!)

1.  (x'! P y'!) e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 74




0.  x''! e {@x | (@x = x'! V @x = y'!)}

1.  (x'! P y'!) e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 75




0.  (x''! = x'! V x''! = y'!)

1.  (x'! P y'!) e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 76




0.  x''! = x'!

1.  (x'! P y'!) e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 76




0.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

1.  (x'! P y'!) = y*!

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 78




0.  (z''? e {@y | (x''! e @y & @y e (x'! O y'!))} == z''? = y*!)

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 79




0.  (z''? e {@y | (x''! e @y & @y e (x'! O y'!))} -> z''? = y*!)

1.  (z''? = y*! -> z''? e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 79




0.  (z''? = y*! -> z''? e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  (z''? e {@y | (x''! e @y & @y e (x'! O y'!))} -> z''? = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 80




0.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

1.  (x'! P y'!) = y*!

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  (z''? e {@y | (x''! e @y & @y e (x'! O y'!))} -> z''? = y*!)
----



0.  z''? = y*!

1.  x''! = y'!

by lines [-1]
Next!"""

setunknown ("z''",":a'x:b'yP")

"""

Line number 80




0.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

1.  (x'! P y'!) = y*!

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)
----



0.  (x'! P y'!) = y*!

1.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 80




0.  (x'! P y'!) = y*!

1.  x''! = x'!

2.  (x'! P y'!) e (x'! O y'!)

3.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x'! P y'!) = y*!

1.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 81




0.  (x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))}

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 82




0.  (x''! e (x'! P y'!) & (x'! P y'!) e (x'! O y'!))

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 83




0.  x''! e (x'! P y'!)

1.  (x'! P y'!) e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 84




0.  x''! e {@x | (@x = x'! V @x = y'!)}

1.  (x'! P y'!) e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 85




0.  (x''! = x'! V x''! = y'!)

1.  (x'! P y'!) e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 86




0.  x''! = x'!

1.  (x'! P y'!) e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 86




0.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

1.  (x'! P y'!) = y*!

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 88




0.  (z'*? e {@y | (x''! e @y & @y e (x'! O y'!))} == z'*? = y*!)

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

setunknown ("z'*",":a'x:b'xP")

"""

Line number 88




0.  ((x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))} == (x'! P x'!) = y*!)

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 89




0.  ((x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P x'!) = y*!)

1.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 90




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 92




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  (x''! e (x'! P x'!) & (x'! P x'!) e (x'! O y'!))

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 93




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! e (x'! P x'!)

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 95




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! e {@x | (@x = x'! V @x = x'!)}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 96




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  (x''! = x'! V x''! = x'!)

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 97




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = x'!

1.  x''! = x'!

2.  x''! = y'!

by lines [-1]
Next!"""

getleft(6)

"""

Line number 97




0.  x''! = x'!

1.  (x'! P y'!) e (x'! O y'!)

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  (x'! P y'!) = y*!

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)
----



0.  x''! = x'!

1.  x''! = x'!

2.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 94




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  (x'! P x'!) e (x'! O y'!)

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 98




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  (x'! P x'!) e ((x'! P x'!) P (x'! P y'!))

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 99




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  (x'! P x'!) e {@x | (@x = (x'! P x'!) V @x = (x'! P y'!))}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 100




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  ((x'! P x'!) = (x'! P x'!) V (x'! P x'!) = (x'! P y'!))

1.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 101




0.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

1.  (x'! P y'!) = y*!

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)
----



0.  (x'! P x'!) = y*!

1.  ((x'! P x'!) = (x'! P x'!) V (x'! P x'!) = (x'! P y'!))

2.  x''! = y'!

by lines [-1]
Next!"""

back()
back()
right()

"""

Line number 101




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  (x'! P x'!) = (x'! P x'!)

1.  (x'! P x'!) = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 102




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  (x'! P x'!) = {@x | (@x = x'! V @x = x'!)}

1.  (x'! P x'!) = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 103




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  {@x | (@x = x'! V @x = x'!)} = {@x | (@x = x'! V @x = x'!)}

1.  (x'! P x'!) = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 104




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  (Ax*** : (x*** e {@x | (@x = x'! V @x = x'!)} == x*** e {@x | (@x = x'! V @x = x'!)}))

1.  (x'! P x'!) = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 105




0.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

1.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

2.  (x'! P y'!) = y*!

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)
----



0.  (x''''! e {@x | (@x = x'! V @x = x'!)} == x''''! e {@x | (@x = x'! V @x = x'!)})

1.  (x'! P x'!) = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 106




0.  x''''! e {@x | (@x = x'! V @x = x'!)}

1.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)
----



0.  x''''! e {@x | (@x = x'! V @x = x'!)}

1.  (x'! P x'!) = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 107




0.  x''''! e {@x | (@x = x'! V @x = x'!)}

1.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)
----



0.  x''''! e {@x | (@x = x'! V @x = x'!)}

1.  (x'! P x'!) = (x'! P y'!)

2.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 91




0.  (x'! P x'!) = y*!

1.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 108




0.  {@x | (@x = x'! V @x = x'!)} = y*!

1.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 109




0.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

1.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

back()
back()
left()

"""

Line number 109




0.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

1.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 110




0.  ({@x | (@x = x'! V @x = x'!)} e x'*''? == y*! e x'*''?)

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  (x'! P y'!) = y*!

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

setunknown ("x'*'","{ue'yu")

"""

Line number 110




0.  ({@x | (@x = x'! V @x = x'!)} e x'*''? == y*! e x'*''?)

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  (x'! P y'!) = y*!

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

setunknown ("x'*''","{ue'yu")

"""

Line number 110




0.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} == y*! e {u | y'! e u})

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  (x'! P y'!) = y*!

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 111




0.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

1.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

2.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

3.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

5.  (x'! P y'!) = y*!

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)

8.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

9.  x''! = x'!

10.  (x'! P y'!) e (x'! O y'!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(5)

"""

Line number 111




0.  (x'! P y'!) = y*!

1.  x''! = x'!

2.  (x'! P y'!) e (x'! O y'!)

3.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

7.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

8.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

9.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

10.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 112




0.  {@x | (@x = x'! V @x = y'!)} = y*!

1.  x''! = x'!

2.  (x'! P y'!) e (x'! O y'!)

3.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

7.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

8.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

9.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

10.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 113




0.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

1.  x''! = x'!

2.  (x'! P y'!) e (x'! O y'!)

3.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

7.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

8.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

9.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

10.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 114




0.  ({@x | (@x = x'! V @x = y'!)} e x'**'? == y*! e x'**'?)

1.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

8.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

9.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

10.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

11.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

setunknown ("x'**'","{ue'yu")

"""

Line number 114




0.  ({@x | (@x = x'! V @x = y'!)} e {u | y'! e u} == y*! e {u | y'! e u})

1.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

8.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

9.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

10.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

11.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 115




0.  ({@x | (@x = x'! V @x = y'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

1.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

2.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)

8.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

9.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

10.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

11.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

12.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 116




0.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

1.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

8.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

9.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

10.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

11.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  {@x | (@x = x'! V @x = y'!)} e {u | y'! e u}

1.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 118




0.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

1.  x''! = x'!

2.  (x'! P y'!) e (x'! O y'!)

3.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

7.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

8.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

9.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

10.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  y*! e {u | y'! e u}

1.  {@x | (@x = x'! V @x = y'!)} e {u | y'! e u}

2.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 120




0.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

1.  x''! = x'!

2.  (x'! P y'!) e (x'! O y'!)

3.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

7.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

8.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

9.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

10.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  y'! e y*!

1.  {@x | (@x = x'! V @x = y'!)} e {u | y'! e u}

2.  x''! = y'!

by lines [-1]
Next!"""

back()
back()
left()

"""

Line number 120




0.  ({@x | (@x = x'! V @x = y'!)} e x'***? == y*! e x'***?)

1.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

8.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

9.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

10.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

11.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  y*! e {u | y'! e u}

1.  {@x | (@x = x'! V @x = y'!)} e {u | y'! e u}

2.  x''! = y'!

by lines [-1]
Next!"""

back()
back()
right()

"""

Line number 118




0.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

1.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

8.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

9.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

10.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

11.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  y'! e {@x | (@x = x'! V @x = y'!)}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 119




0.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

1.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

8.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

9.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

10.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

11.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (y'! = x'! V y'! = y'!)

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 120




0.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

1.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

8.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

9.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

10.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

11.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  y'! = x'!

1.  y'! = y'!

2.  x''! = y'!

by lines [-1]
Next!"""

getright(1)

"""

Line number 120




0.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

1.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

8.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

9.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

10.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

11.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  y'! = y'!

1.  x''! = y'!

2.  y'! = x'!

by lines [-1]
Next!"""

right()

"""

Line number 121




0.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

1.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

8.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

9.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

10.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

11.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (Ax'*** : (x'*** e y'! == x'*** e y'!))

1.  x''! = y'!

2.  y'! = x'!

by lines [-1]
Next!"""

right()

"""

Line number 122




0.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

1.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

2.  x''! = x'!

3.  (x'! P y'!) e (x'! O y'!)

4.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

5.  x''! = x'!

6.  (x'! P y'!) e (x'! O y'!)

7.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

8.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

9.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

10.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

11.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  (x*'''! e y'! == x*'''! e y'!)

1.  x''! = y'!

2.  y'! = x'!

by lines [-1]
Next!"""

right()

"""

Line number 123




0.  x*'''! e y'!

1.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

2.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)

8.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

9.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

10.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

11.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

12.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x*'''! e y'!

1.  x''! = y'!

2.  y'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 124




0.  x*'''! e y'!

1.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

2.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)

8.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

9.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

10.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

11.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

12.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x*'''! e y'!

1.  x''! = y'!

2.  y'! = x'!

by lines [-1]
Next!"""

done()

"""

Line number 117




0.  y*! e {u | y'! e u}

1.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

2.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)

8.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

9.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

10.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

11.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

12.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 125




0.  y'! e y*!

1.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

2.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)

8.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

9.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

10.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

11.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

12.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(9)

"""

Line number 125




0.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | y'! e u})

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 126




0.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

1.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  y'! e y*!

4.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

5.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)

8.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

9.  x''! = x'!

10.  (x'! P y'!) e (x'! O y'!)

11.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  y*! e {u | y'! e u}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 128




0.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

1.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  y'! e y*!

4.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

5.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)

8.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

9.  x''! = x'!

10.  (x'! P y'!) e (x'! O y'!)

11.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  y'! e y*!

1.  x''! = y'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 128




0.  y'! e y*!

1.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

2.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

6.  x''! = x'!

7.  (x'! P y'!) e (x'! O y'!)

8.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

9.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

10.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

11.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))
----



0.  y'! e y*!

1.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 127




0.  {@x | (@x = x'! V @x = x'!)} e {u | y'! e u}

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 129




0.  y'! e {@x | (@x = x'! V @x = x'!)}

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 130




0.  (y'! = x'! V y'! = x'!)

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 131




0.  y'! = x'!

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 133




0.  (Ax*''* : (y'! e x*''* == x'! e x*''*))

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 134




0.  (y'! e x*'*'? == x'! e x*'*'?)

1.  (Ax*''* : (y'! e x*''* == x'! e x*''*))

2.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

3.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

5.  y'! e y*!

6.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

7.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)

10.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

11.  x''! = x'!

12.  (x'! P y'!) e (x'! O y'!)

13.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

setunknown ("x*'*'","{u=''xu")

"""

Line number 134




0.  (y'! e {u | x''! = u} == x'! e {u | x''! = u})

1.  (Ax*''* : (y'! e x*''* == x'! e x*''*))

2.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

3.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

5.  y'! e y*!

6.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

7.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)

10.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

11.  x''! = x'!

12.  (x'! P y'!) e (x'! O y'!)

13.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 135




0.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})

1.  (x'! e {u | x''! = u} -> y'! e {u | x''! = u})

2.  (Ax*''* : (y'! e x*''* == x'! e x*''*))

3.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

4.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

6.  y'! e y*!

7.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

8.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

9.  x''! = x'!

10.  (x'! P y'!) e (x'! O y'!)

11.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

12.  x''! = x'!

13.  (x'! P y'!) e (x'! O y'!)

14.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 135




0.  (x'! e {u | x''! = u} -> y'! e {u | x''! = u})

1.  (Ax*''* : (y'! e x*''* == x'! e x*''*))

2.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

3.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

5.  y'! e y*!

6.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

7.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)

10.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

11.  x''! = x'!

12.  (x'! P y'!) e (x'! O y'!)

13.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

14.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 136




0.  (Ax*''* : (y'! e x*''* == x'! e x*''*))

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

13.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})
----



0.  x'! e {u | x''! = u}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 138




0.  (Ax*''* : (y'! e x*''* == x'! e x*''*))

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

13.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})
----



0.  x''! = x'!

1.  x''! = y'!

by lines [-1]
Next!"""

getleft(7)

"""

Line number 138




0.  x''! = x'!

1.  (x'! P y'!) e (x'! O y'!)

2.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

6.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})

7.  (Ax*''* : (y'! e x*''* == x'! e x*''*))

8.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

9.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

10.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

11.  y'! e y*!

12.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

13.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))
----



0.  x''! = x'!

1.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 137




0.  y'! e {u | x''! = u}

1.  (Ax*''* : (y'! e x*''* == x'! e x*''*))

2.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

3.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

5.  y'! e y*!

6.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

7.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)

10.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

11.  x''! = x'!

12.  (x'! P y'!) e (x'! O y'!)

13.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

14.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 139




0.  x''! = y'!

1.  (Ax*''* : (y'! e x*''* == x'! e x*''*))

2.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

3.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

5.  y'! e y*!

6.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

7.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)

10.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

11.  x''! = x'!

12.  (x'! P y'!) e (x'! O y'!)

13.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

14.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 132




0.  y'! = x'!

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 140




0.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 141




0.  (y'! e x**''? == x'! e x**''?)

1.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

2.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

3.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

5.  y'! e y*!

6.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

7.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)

10.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

11.  x''! = x'!

12.  (x'! P y'!) e (x'! O y'!)

13.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

setunknown ("x**''","{u=x''u")

"""

Line number 141




0.  (y'! e {u | x = u''} == x'! e {u | x = u''})

1.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

2.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

3.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

5.  y'! e y*!

6.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

7.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)

10.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

11.  x''! = x'!

12.  (x'! P y'!) e (x'! O y'!)

13.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 142




0.  (y'! e {u | x = u''} -> x'! e {u | x = u''})

1.  (x'! e {u | x = u''} -> y'! e {u | x = u''})

2.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

3.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

4.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

6.  y'! e y*!

7.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

8.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

9.  x''! = x'!

10.  (x'! P y'!) e (x'! O y'!)

11.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

12.  x''! = x'!

13.  (x'! P y'!) e (x'! O y'!)

14.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 142




0.  (x'! e {u | x = u''} -> y'! e {u | x = u''})

1.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

2.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

3.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

5.  y'! e y*!

6.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

7.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)

10.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

11.  x''! = x'!

12.  (x'! P y'!) e (x'! O y'!)

13.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

14.  (y'! e {u | x = u''} -> x'! e {u | x = u''})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 143




0.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

13.  (y'! e {u | x = u''} -> x'! e {u | x = u''})
----



0.  x'! e {u | x = u''}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 145




0.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

13.  (y'! e {u | x = u''} -> x'! e {u | x = u''})
----



0.  x = u''

1.  x''! = y'!

by lines [-1]
Next!"""

back()
back()
back()
back()
back()
back()
setunknown ("x**''","{u=''xu")

"""

Line number 141




0.  (y'! e {u | x''! = u} == x'! e {u | x''! = u})

1.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

2.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

3.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

5.  y'! e y*!

6.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

7.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)

10.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

11.  x''! = x'!

12.  (x'! P y'!) e (x'! O y'!)

13.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 142




0.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})

1.  (x'! e {u | x''! = u} -> y'! e {u | x''! = u})

2.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

3.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

4.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

5.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

6.  y'! e y*!

7.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

8.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

9.  x''! = x'!

10.  (x'! P y'!) e (x'! O y'!)

11.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

12.  x''! = x'!

13.  (x'! P y'!) e (x'! O y'!)

14.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 142




0.  (x'! e {u | x''! = u} -> y'! e {u | x''! = u})

1.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

2.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

3.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

5.  y'! e y*!

6.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

7.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)

10.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

11.  x''! = x'!

12.  (x'! P y'!) e (x'! O y'!)

13.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

14.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 143




0.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

13.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})
----



0.  x'! e {u | x''! = u}

1.  x''! = y'!

by lines [-1]
Next!"""

right()

"""

Line number 145




0.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

1.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

2.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

3.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

4.  y'! e y*!

5.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

6.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

7.  x''! = x'!

8.  (x'! P y'!) e (x'! O y'!)

9.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

10.  x''! = x'!

11.  (x'! P y'!) e (x'! O y'!)

12.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

13.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})
----



0.  x''! = x'!

1.  x''! = y'!

by lines [-1]
Next!"""

getleft(7)

"""

Line number 145




0.  x''! = x'!

1.  (x'! P y'!) e (x'! O y'!)

2.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

3.  x''! = x'!

4.  (x'! P y'!) e (x'! O y'!)

5.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

6.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})

7.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

8.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

9.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

10.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

11.  y'! e y*!

12.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

13.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))
----



0.  x''! = x'!

1.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 144




0.  y'! e {u | x''! = u}

1.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

2.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

3.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

5.  y'! e y*!

6.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

7.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)

10.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

11.  x''! = x'!

12.  (x'! P y'!) e (x'! O y'!)

13.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

14.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

left()

"""

Line number 146




0.  x''! = y'!

1.  (Ax*'** : (y'! e x*'** == x'! e x*'**))

2.  (Ax''** : ({@x | (@x = x'! V @x = x'!)} e x''** == y*! e x''**))

3.  ((x'! P x'!) = y*! -> (x'! P x'!) e {@y | (x''! e @y & @y e (x'! O y'!))})

4.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

5.  y'! e y*!

6.  (y*! e {u | y'! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | y'! e u})

7.  (Ax'*'* : ({@x | (@x = x'! V @x = y'!)} e x'*'* == y*! e x'*'*))

8.  x''! = x'!

9.  (x'! P y'!) e (x'! O y'!)

10.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)

11.  x''! = x'!

12.  (x'! P y'!) e (x'! O y'!)

13.  ({@x | (@x = x'! V @x = x'!)} e {u | y'! e u} -> y*! e {u | y'! e u})

14.  (y'! e {u | x''! = u} -> x'! e {u | x''! = u})
----



0.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 87




0.  x''! = y'!

1.  (x'! P y'!) e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!

4.  x''! = x'!

5.  (x'! P y'!) e (x'! O y'!)

6.  ((x'! P y'!) e {@y | (x''! e @y & @y e (x'! O y'!))} -> (x'! P y'!) = y*!)
----



0.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 77




0.  x''! = y'!

1.  (x'! P y'!) e (x'! O y'!)

2.  (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = y*!))

3.  (x'! P y'!) = y*!
----



0.  x''! = y'!

by lines [-1]
Next!"""

done()

"""

Line number 7




0.  x''! e {u | u = y'!}
----



0.  x''! e {@x | {@y | (@x e @y & @y e (x'! O y'!))} e U}

by lines [-1]
Next!"""

left()

"""

Line number 147




0.  x''! = y'!
----



0.  x''! e {@x | {@y | (@x e @y & @y e (x'! O y'!))} e U}

by lines [-1]
Next!"""

right()

"""

Line number 148




0.  x''! = y'!
----



0.  {@y | (x''! e @y & @y e (x'! O y'!))} e U

by lines [-1]
Next!"""

right()

"""

Line number 149




0.  x''! = y'!
----



0.  {@y | (x''! e @y & @y e (x'! O y'!))} e {@x | (E@y : (A@z : (@z e @x == @z = @y)))}

by lines [-1]
Next!"""

right()

"""

Line number 150




0.  x''! = y'!
----



0.  (E@y : (A@z : (@z e {@y | (x''! e @y & @y e (x'! O y'!))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 151




0.  x'' = y'
----



0.  (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = y''?))

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("y''",":a'x:b'yP")

"""

Line number 151




0.  x'' = y'
----



0.  (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = (x' P y')))

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 152




0.  x'' = y'
----



0.  (z*'! e {@y | (x'' e @y & @y e (x' O y'))} == z*'! = (x' P y'))

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 153




0.  z*'! e {@y | (x'' e @y & @y e (x' O y'))}

1.  x'' = y'
----



0.  z*'! = (x' P y')

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 155




0.  (x'' e z*'! & z*'! e (x' O y'))

1.  x'' = y'
----



0.  z*'! = (x' P y')

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 156




0.  x'' e z*'!

1.  z*'! e (x' O y')

2.  x'' = y'
----



0.  z*'! = (x' P y')

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 157




0.  x'' e z*'!

1.  z*'! e (x' O y')

2.  x'' = y'
----



0.  z*'! = {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 158




0.  x'' e z*'!

1.  z*'! e (x' O y')

2.  x'' = y'
----



0.  (Ax**'* : (x**'* e z*'! == x**'* e {@x | (@x = x' V @x = y')}))

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 159




0.  x'' e z*'!

1.  z*'! e (x' O y')

2.  x'' = y'
----



0.  (x***'! e z*'! == x***'! e {@x | (@x = x' V @x = y')})

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 160




0.  x***'! e z*'!

1.  x'' e z*'!

2.  z*'! e (x' O y')

3.  x'' = y'
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(2)

"""

Line number 160




0.  z*'! e (x' O y')

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 162




0.  z*'! e ((x' P x') P (x' P y'))

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 163




0.  z*'! e {@x | (@x = (x' P x') V @x = (x' P y'))}

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 164




0.  (z*'! = (x' P x') V z*'! = (x' P y'))

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 165




0.  z*'! = (x' P x')

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 167




0.  z*'! = (x' P x')

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!
----



0.  (x***'! = x' V x***'! = y')

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 168




0.  z*'! = (x' P x')

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 169




0.  z*'! = {@x | (@x = x' V @x = x')}

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 170




0.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 171




0.  (z*'! e x'''''? == {@x | (@x = x' V @x = x')} e x'''''?)

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("x'''''","{ue'xu")

"""

Line number 171




0.  (z*'! e {u | x' e u} == {@x | (@x = x' V @x = x')} e {u | x' e u})

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 172




0.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})

1.  ({@x | (@x = x' V @x = x')} e {u | x' e u} -> z*'! e {u | x' e u})

2.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 172




0.  ({@x | (@x = x' V @x = x')} e {u | x' e u} -> z*'! e {u | x' e u})

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 173




0.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  {@x | (@x = x' V @x = x')} e {u | x' e u}

1.  x***'! = x'

2.  x***'! = y'

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 175




0.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x' e {@x | (@x = x' V @x = x')}

1.  x***'! = x'

2.  x***'! = y'

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 176




0.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  (x' = x' V x' = x')

1.  x***'! = x'

2.  x***'! = y'

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 177




0.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x' = x'

1.  x' = x'

2.  x***'! = x'

3.  x***'! = y'

4.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 178




0.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  (Ax''''* : (x''''* e x' == x''''* e x'))

1.  x' = x'

2.  x***'! = x'

3.  x***'! = y'

4.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 179




0.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  (x'''*'! e x' == x'''*'! e x')

1.  x' = x'

2.  x***'! = x'

3.  x***'! = y'

4.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 180




0.  x'''*'! e x'

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x'''*'! e x'

1.  x' = x'

2.  x***'! = x'

3.  x***'! = y'

4.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 181




0.  x'''*'! e x'

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x'''*'! e x'

1.  x' = x'

2.  x***'! = x'

3.  x***'! = y'

4.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 174




0.  z*'! e {u | x' e u}

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 182




0.  x' e z*'!

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(5)

"""

Line number 182




0.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})

1.  x' e z*'!

2.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 183




0.  x' e z*'!

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!
----



0.  z*'! e {u | x' e u}

1.  x***'! = x'

2.  x***'! = y'

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 185




0.  x' e z*'!

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!
----



0.  x' e z*'!

1.  x***'! = x'

2.  x***'! = y'

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 184




0.  {@x | (@x = x' V @x = x')} e {u | x' e u}

1.  x' e z*'!

2.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 186




0.  x' e {@x | (@x = x' V @x = x')}

1.  x' e z*'!

2.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 187




0.  (x' = x' V x' = x')

1.  x' e z*'!

2.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(2)

"""

Line number 187




0.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!

4.  (x' = x' V x' = x')

5.  x' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 188




0.  (z*'! e x'''**? == {@x | (@x = x' V @x = x')} e x'''**?)

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!

5.  (x' = x' V x' = x')

6.  x' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("x'''**","{uex***'u")

"""

Line number 188




0.  (z*'! e {u | x e u'***} == {@x | (@x = x' V @x = x')} e {u | x e u'***})

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!

5.  (x' = x' V x' = x')

6.  x' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

back()
back()
setunknown ("x'''**","{ue'***xu")

"""

Line number 188




0.  (z*'! e {u | x***'! e u} == {@x | (@x = x' V @x = x')} e {u | x***'! e u})

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!

5.  (x' = x' V x' = x')

6.  x' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 189




0.  (z*'! e {u | x***'! e u} -> {@x | (@x = x' V @x = x')} e {u | x***'! e u})

1.  ({@x | (@x = x' V @x = x')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

2.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!

6.  (x' = x' V x' = x')

7.  x' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 190




0.  ({@x | (@x = x' V @x = x')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!

5.  (x' = x' V x' = x')

6.  x' e z*'!
----



0.  z*'! e {u | x***'! e u}

1.  x***'! = x'

2.  x***'! = y'

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 192




0.  ({@x | (@x = x' V @x = x')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

1.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!

5.  (x' = x' V x' = x')

6.  x' e z*'!
----



0.  x***'! e z*'!

1.  x***'! = x'

2.  x***'! = y'

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(3)

"""

Line number 192




0.  x***'! e z*'!

1.  x'' e z*'!

2.  (x' = x' V x' = x')

3.  x' e z*'!

4.  ({@x | (@x = x' V @x = x')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

5.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

6.  x'' = y'
----



0.  x***'! e z*'!

1.  x***'! = x'

2.  x***'! = y'

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 191




0.  {@x | (@x = x' V @x = x')} e {u | x***'! e u}

1.  ({@x | (@x = x' V @x = x')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

2.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!

6.  (x' = x' V x' = x')

7.  x' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 193




0.  x***'! e {@x | (@x = x' V @x = x')}

1.  ({@x | (@x = x' V @x = x')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

2.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!

6.  (x' = x' V x' = x')

7.  x' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 194




0.  (x***'! = x' V x***'! = x')

1.  ({@x | (@x = x' V @x = x')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

2.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!

6.  (x' = x' V x' = x')

7.  x' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 195




0.  x***'! = x'

1.  ({@x | (@x = x' V @x = x')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

2.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!

6.  (x' = x' V x' = x')

7.  x' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 196




0.  x***'! = x'

1.  ({@x | (@x = x' V @x = x')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

2.  (Ax**** : (z*'! e x**** == {@x | (@x = x' V @x = x')} e x****))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!

6.  (x' = x' V x' = x')

7.  x' e z*'!
----



0.  x***'! = x'

1.  x***'! = y'

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 166




0.  z*'! = (x' P y')

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 197




0.  z*'! = {@x | (@x = x' V @x = y')}

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 198




0.  (Ax''*'' : (z*'! e x''*'' == {@x | (@x = x' V @x = y')} e x''*''))

1.  x'' = y'

2.  x***'! e z*'!

3.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 199




0.  (z*'! e x''*'*? == {@x | (@x = x' V @x = y')} e x''*'*?)

1.  (Ax''*'' : (z*'! e x''*'' == {@x | (@x = x' V @x = y')} e x''*''))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("x''*'*","{ue'***xu")

"""

Line number 199




0.  (z*'! e {u | x***'! e u} == {@x | (@x = x' V @x = y')} e {u | x***'! e u})

1.  (Ax''*'' : (z*'! e x''*'' == {@x | (@x = x' V @x = y')} e x''*''))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 200




0.  (z*'! e {u | x***'! e u} -> {@x | (@x = x' V @x = y')} e {u | x***'! e u})

1.  ({@x | (@x = x' V @x = y')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

2.  (Ax''*'' : (z*'! e x''*'' == {@x | (@x = x' V @x = y')} e x''*''))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 201




0.  ({@x | (@x = x' V @x = y')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

1.  (Ax''*'' : (z*'! e x''*'' == {@x | (@x = x' V @x = y')} e x''*''))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!
----



0.  z*'! e {u | x***'! e u}

1.  x***'! e {@x | (@x = x' V @x = y')}

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 203




0.  ({@x | (@x = x' V @x = y')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

1.  (Ax''*'' : (z*'! e x''*'' == {@x | (@x = x' V @x = y')} e x''*''))

2.  x'' = y'

3.  x***'! e z*'!

4.  x'' e z*'!
----



0.  x***'! e z*'!

1.  x***'! e {@x | (@x = x' V @x = y')}

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(3)

"""

Line number 203




0.  x***'! e z*'!

1.  x'' e z*'!

2.  ({@x | (@x = x' V @x = y')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

3.  (Ax''*'' : (z*'! e x''*'' == {@x | (@x = x' V @x = y')} e x''*''))

4.  x'' = y'
----



0.  x***'! e z*'!

1.  x***'! e {@x | (@x = x' V @x = y')}

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 202




0.  {@x | (@x = x' V @x = y')} e {u | x***'! e u}

1.  ({@x | (@x = x' V @x = y')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

2.  (Ax''*'' : (z*'! e x''*'' == {@x | (@x = x' V @x = y')} e x''*''))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 204




0.  x***'! e {@x | (@x = x' V @x = y')}

1.  ({@x | (@x = x' V @x = y')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

2.  (Ax''*'' : (z*'! e x''*'' == {@x | (@x = x' V @x = y')} e x''*''))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 205




0.  (x***'! = x' V x***'! = y')

1.  ({@x | (@x = x' V @x = y')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

2.  (Ax''*'' : (z*'! e x''*'' == {@x | (@x = x' V @x = y')} e x''*''))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!
----



0.  x***'! e {@x | (@x = x' V @x = y')}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 206




0.  (x***'! = x' V x***'! = y')

1.  ({@x | (@x = x' V @x = y')} e {u | x***'! e u} -> z*'! e {u | x***'! e u})

2.  (Ax''*'' : (z*'! e x''*'' == {@x | (@x = x' V @x = y')} e x''*''))

3.  x'' = y'

4.  x***'! e z*'!

5.  x'' e z*'!
----



0.  (x***'! = x' V x***'! = y')

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 161




0.  x***'! e {@x | (@x = x' V @x = y')}

1.  x'' e z*'!

2.  z*'! e (x' O y')

3.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 207




0.  (x***'! = x' V x***'! = y')

1.  x'' e z*'!

2.  z*'! e (x' O y')

3.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 208




0.  x***'! = x'

1.  x'' e z*'!

2.  z*'! e (x' O y')

3.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(2)

"""

Line number 208




0.  z*'! e (x' O y')

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 210




0.  z*'! e ((x' P x') P (x' P y'))

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 211




0.  z*'! e {@x | (@x = (x' P x') V @x = (x' P y'))}

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 212




0.  (z*'! = (x' P x') V z*'! = (x' P y'))

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 213




0.  z*'! = (x' P x')

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 215




0.  z*'! = {@x | (@x = x' V @x = x')}

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 216




0.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 217




0.  (z*'! e x''***? == {@x | (@x = x' V @x = x')} e x''***?)

1.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("x''***","{ue'xu")

"""

Line number 217




0.  (z*'! e {u | x' e u} == {@x | (@x = x' V @x = x')} e {u | x' e u})

1.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 218




0.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})

1.  ({@x | (@x = x' V @x = x')} e {u | x' e u} -> z*'! e {u | x' e u})

2.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

3.  x'' = y'

4.  x***'! = x'

5.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 218




0.  ({@x | (@x = x' V @x = x')} e {u | x' e u} -> z*'! e {u | x' e u})

1.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 219




0.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  {@x | (@x = x' V @x = x')} e {u | x' e u}

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 221




0.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x' e {@x | (@x = x' V @x = x')}

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 222




0.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  (x' = x' V x' = x')

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 223




0.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x' = x'

1.  x' = x'

2.  x***'! e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 224




0.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  (Ax'*''' : (x'*''' e x' == x'*''' e x'))

1.  x' = x'

2.  x***'! e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 225




0.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  (x'*''*! e x' == x'*''*! e x')

1.  x' = x'

2.  x***'! e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 226




0.  x'*''*! e x'

1.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x'*''*! e x'

1.  x' = x'

2.  x***'! e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 227




0.  x'*''*! e x'

1.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x'*''*! e x'

1.  x' = x'

2.  x***'! e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 220




0.  z*'! e {u | x' e u}

1.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 228




0.  x' e z*'!

1.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(3)

"""

Line number 228




0.  x***'! = x'

1.  x'' e z*'!

2.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})

3.  x' e z*'!

4.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

5.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 229




0.  (Ax'*'*' : (x***'! e x'*'*' == x' e x'*'*'))

1.  x'' e z*'!

2.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})

3.  x' e z*'!

4.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

5.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 230




0.  (x***'! e x'*'**? == x' e x'*'**?)

1.  (Ax'*'*' : (x***'! e x'*'*' == x' e x'*'*'))

2.  x'' e z*'!

3.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})

4.  x' e z*'!

5.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

6.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("x'*'**","'*z")

"""

Line number 230




0.  (x***'! e z*'! == x' e z*'!)

1.  (Ax'*'*' : (x***'! e x'*'*' == x' e x'*'*'))

2.  x'' e z*'!

3.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})

4.  x' e z*'!

5.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

6.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 231




0.  (x***'! e z*'! -> x' e z*'!)

1.  (x' e z*'! -> x***'! e z*'!)

2.  (Ax'*'*' : (x***'! e x'*'*' == x' e x'*'*'))

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})

5.  x' e z*'!

6.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

7.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 231




0.  (x' e z*'! -> x***'! e z*'!)

1.  (Ax'*'*' : (x***'! e x'*'*' == x' e x'*'*'))

2.  x'' e z*'!

3.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})

4.  x' e z*'!

5.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

6.  x'' = y'

7.  (x***'! e z*'! -> x' e z*'!)
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 232




0.  (Ax'*'*' : (x***'! e x'*'*' == x' e x'*'*'))

1.  x'' e z*'!

2.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})

3.  x' e z*'!

4.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

5.  x'' = y'

6.  (x***'! e z*'! -> x' e z*'!)
----



0.  x' e z*'!

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(3)

"""

Line number 232




0.  x' e z*'!

1.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

2.  x'' = y'

3.  (x***'! e z*'! -> x' e z*'!)

4.  (Ax'*'*' : (x***'! e x'*'*' == x' e x'*'*'))

5.  x'' e z*'!

6.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})
----



0.  x' e z*'!

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 233




0.  x***'! e z*'!

1.  (Ax'*'*' : (x***'! e x'*'*' == x' e x'*'*'))

2.  x'' e z*'!

3.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = x')} e {u | x' e u})

4.  x' e z*'!

5.  (Ax''**' : (z*'! e x''**' == {@x | (@x = x' V @x = x')} e x''**'))

6.  x'' = y'

7.  (x***'! e z*'! -> x' e z*'!)
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 214




0.  z*'! = (x' P y')

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 234




0.  z*'! = {@x | (@x = x' V @x = y')}

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 235




0.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 236




0.  (z*'! e x'**'*? == {@x | (@x = x' V @x = y')} e x'**'*?)

1.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("x'**'*","{ue'xu")

"""

Line number 236




0.  (z*'! e {u | x' e u} == {@x | (@x = x' V @x = y')} e {u | x' e u})

1.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 236




0.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

1.  x'' = y'

2.  x***'! = x'

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} == {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

back()
left()

"""

Line number 237




0.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

1.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} == {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(5)

"""

Line number 237




0.  (z*'! e {u | x' e u} == {@x | (@x = x' V @x = y')} e {u | x' e u})

1.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

2.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

3.  x'' = y'

4.  x***'! = x'

5.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 238




0.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})

1.  ({@x | (@x = x' V @x = y')} e {u | x' e u} -> z*'! e {u | x' e u})

2.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

3.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

4.  x'' = y'

5.  x***'! = x'

6.  x'' e z*'!
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 238




0.  ({@x | (@x = x' V @x = y')} e {u | x' e u} -> z*'! e {u | x' e u})

1.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

2.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

3.  x'' = y'

4.  x***'! = x'

5.  x'' e z*'!

6.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 239




0.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

1.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  {@x | (@x = x' V @x = y')} e {u | x' e u}

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 241




0.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

1.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  x' e {@x | (@x = x' V @x = y')}

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 242




0.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

1.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  (x' = x' V x' = y')

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 243




0.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

1.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  x' = x'

1.  x' = y'

2.  x***'! e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 244




0.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

1.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  (Ax'**** : (x'**** e x' == x'**** e x'))

1.  x' = y'

2.  x***'! e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 245




0.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

1.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

2.  x'' = y'

3.  x***'! = x'

4.  x'' e z*'!

5.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  (x*''''! e x' == x*''''! e x')

1.  x' = y'

2.  x***'! e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 246




0.  x*''''! e x'

1.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

2.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

3.  x'' = y'

4.  x***'! = x'

5.  x'' e z*'!

6.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  x*''''! e x'

1.  x' = y'

2.  x***'! e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 247




0.  x*''''! e x'

1.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

2.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

3.  x'' = y'

4.  x***'! = x'

5.  x'' e z*'!

6.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  x*''''! e x'

1.  x' = y'

2.  x***'! e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 240




0.  z*'! e {u | x' e u}

1.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

2.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

3.  x'' = y'

4.  x***'! = x'

5.  x'' e z*'!

6.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 248




0.  x' e z*'!

1.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

2.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

3.  x'' = y'

4.  x***'! = x'

5.  x'' e z*'!

6.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(4)

"""

Line number 248




0.  x***'! = x'

1.  x'' e z*'!

2.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})

3.  x' e z*'!

4.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

5.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

6.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 249




0.  (Ax*'''* : (x***'! e x*'''* == x' e x*'''*))

1.  x'' e z*'!

2.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})

3.  x' e z*'!

4.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

5.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

6.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 250




0.  (x***'! e x*''*'? == x' e x*''*'?)

1.  (Ax*'''* : (x***'! e x*'''* == x' e x*'''*))

2.  x'' e z*'!

3.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})

4.  x' e z*'!

5.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

6.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

7.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("x*''*'","'*z")

"""

Line number 250




0.  (x***'! e z*'! == x' e z*'!)

1.  (Ax*'''* : (x***'! e x*'''* == x' e x*'''*))

2.  x'' e z*'!

3.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})

4.  x' e z*'!

5.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

6.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

7.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 251




0.  (x***'! e z*'! -> x' e z*'!)

1.  (x' e z*'! -> x***'! e z*'!)

2.  (Ax*'''* : (x***'! e x*'''* == x' e x*'''*))

3.  x'' e z*'!

4.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})

5.  x' e z*'!

6.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

7.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

8.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 251




0.  (x' e z*'! -> x***'! e z*'!)

1.  (Ax*'''* : (x***'! e x*'''* == x' e x*'''*))

2.  x'' e z*'!

3.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})

4.  x' e z*'!

5.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

6.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

7.  x'' = y'

8.  (x***'! e z*'! -> x' e z*'!)
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 252




0.  (Ax*'''* : (x***'! e x*'''* == x' e x*'''*))

1.  x'' e z*'!

2.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})

3.  x' e z*'!

4.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

5.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

6.  x'' = y'

7.  (x***'! e z*'! -> x' e z*'!)
----



0.  x' e z*'!

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(3)

"""

Line number 252




0.  x' e z*'!

1.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

2.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

3.  x'' = y'

4.  (x***'! e z*'! -> x' e z*'!)

5.  (Ax*'''* : (x***'! e x*'''* == x' e x*'''*))

6.  x'' e z*'!

7.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})
----



0.  x' e z*'!

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 253




0.  x***'! e z*'!

1.  (Ax*'''* : (x***'! e x*'''* == x' e x*'''*))

2.  x'' e z*'!

3.  (z*'! e {u | x' e u} -> {@x | (@x = x' V @x = y')} e {u | x' e u})

4.  x' e z*'!

5.  (z*'! e x'***'? == {@x | (@x = x' V @x = y')} e x'***'?)

6.  (Ax'**'' : (z*'! e x'**'' == {@x | (@x = x' V @x = y')} e x'**''))

7.  x'' = y'

8.  (x***'! e z*'! -> x' e z*'!)
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 209




0.  x***'! = y'

1.  x'' e z*'!

2.  z*'! e (x' O y')

3.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 254




0.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

1.  x'' e z*'!

2.  z*'! e (x' O y')

3.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 255




0.  (x***'! e x*'*''? == y' e x*'*''?)

1.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

2.  x'' e z*'!

3.  z*'! e (x' O y')

4.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("x*'*''","{u=''xu")

"""

Line number 255




0.  (x***'! e {u | x'' = u} == y' e {u | x'' = u})

1.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

2.  x'' e z*'!

3.  z*'! e (x' O y')

4.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 256




0.  (x***'! e {u | x'' = u} -> y' e {u | x'' = u})

1.  (y' e {u | x'' = u} -> x***'! e {u | x'' = u})

2.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

3.  x'' e z*'!

4.  z*'! e (x' O y')

5.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 257




0.  (y' e {u | x'' = u} -> x***'! e {u | x'' = u})

1.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

2.  x'' e z*'!

3.  z*'! e (x' O y')

4.  x'' = y'
----



0.  x***'! e {u | x'' = u}

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 259




0.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

1.  x'' e z*'!

2.  z*'! e (x' O y')

3.  x'' = y'
----



0.  y' e {u | x'' = u}

1.  x***'! e {u | x'' = u}

2.  x***'! e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 261




0.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

1.  x'' e z*'!

2.  z*'! e (x' O y')

3.  x'' = y'
----



0.  x'' = y'

1.  x***'! e {u | x'' = u}

2.  x***'! e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(3)

"""

Line number 261




0.  x'' = y'

1.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

2.  x'' e z*'!

3.  z*'! e (x' O y')
----



0.  x'' = y'

1.  x***'! e {u | x'' = u}

2.  x***'! e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 260




0.  x***'! e {u | x'' = u}

1.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

2.  x'' e z*'!

3.  z*'! e (x' O y')

4.  x'' = y'
----



0.  x***'! e {u | x'' = u}

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 258




0.  y' e {u | x'' = u}

1.  (y' e {u | x'' = u} -> x***'! e {u | x'' = u})

2.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

3.  x'' e z*'!

4.  z*'! e (x' O y')

5.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 262




0.  x'' = y'

1.  (y' e {u | x'' = u} -> x***'! e {u | x'' = u})

2.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

3.  x'' e z*'!

4.  z*'! e (x' O y')

5.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 262




0.  (y' e {u | x'' = u} -> x***'! e {u | x'' = u})

1.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

2.  x'' e z*'!

3.  z*'! e (x' O y')

4.  x'' = y'

5.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 263




0.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

1.  x'' e z*'!

2.  z*'! e (x' O y')

3.  x'' = y'

4.  x'' = y'
----



0.  y' e {u | x'' = u}

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 265




0.  (x***'! e x*'*'*? == y' e x*'*'*?)

1.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

2.  x'' e z*'!

3.  z*'! e (x' O y')

4.  x'' = y'

5.  x'' = y'
----



0.  y' e {u | x'' = u}

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 266




0.  (x***'! e x*'*'*? == y' e x*'*'*?)

1.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

2.  x'' e z*'!

3.  z*'! e (x' O y')

4.  x'' = y'

5.  x'' = y'
----



0.  x'' = y'

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(4)

"""

Line number 266




0.  x'' = y'

1.  x'' = y'

2.  (x***'! e x*'*'*? == y' e x*'*'*?)

3.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

4.  x'' e z*'!

5.  z*'! e (x' O y')
----



0.  x'' = y'

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 264




0.  x***'! e {u | x'' = u}

1.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

2.  x'' e z*'!

3.  z*'! e (x' O y')

4.  x'' = y'

5.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 267




0.  x'' = x***'!

1.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

2.  x'' e z*'!

3.  z*'! e (x' O y')

4.  x'' = y'

5.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 268




0.  (Ax*'**' : (x'' e x*'**' == x***'! e x*'**'))

1.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

2.  x'' e z*'!

3.  z*'! e (x' O y')

4.  x'' = y'

5.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 269




0.  (x'' e x*'***? == x***'! e x*'***?)

1.  (Ax*'**' : (x'' e x*'**' == x***'! e x*'**'))

2.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

3.  x'' e z*'!

4.  z*'! e (x' O y')

5.  x'' = y'

6.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("x*'***","'*z")

"""

Line number 269




0.  (x'' e z*'! == x***'! e z*'!)

1.  (Ax*'**' : (x'' e x*'**' == x***'! e x*'**'))

2.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

3.  x'' e z*'!

4.  z*'! e (x' O y')

5.  x'' = y'

6.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 270




0.  (x'' e z*'! -> x***'! e z*'!)

1.  (x***'! e z*'! -> x'' e z*'!)

2.  (Ax*'**' : (x'' e x*'**' == x***'! e x*'**'))

3.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

4.  x'' e z*'!

5.  z*'! e (x' O y')

6.  x'' = y'

7.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 271




0.  (x***'! e z*'! -> x'' e z*'!)

1.  (Ax*'**' : (x'' e x*'**' == x***'! e x*'**'))

2.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

3.  x'' e z*'!

4.  z*'! e (x' O y')

5.  x'' = y'

6.  x'' = y'
----



0.  x'' e z*'!

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(3)

"""

Line number 271




0.  x'' e z*'!

1.  z*'! e (x' O y')

2.  x'' = y'

3.  x'' = y'

4.  (x***'! e z*'! -> x'' e z*'!)

5.  (Ax*'**' : (x'' e x*'**' == x***'! e x*'**'))

6.  (Ax*''** : (x***'! e x*''** == y' e x*''**))
----



0.  x'' e z*'!

1.  x***'! e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 272




0.  x***'! e z*'!

1.  (x***'! e z*'! -> x'' e z*'!)

2.  (Ax*'**' : (x'' e x*'**' == x***'! e x*'**'))

3.  (Ax*''** : (x***'! e x*''** == y' e x*''**))

4.  x'' e z*'!

5.  z*'! e (x' O y')

6.  x'' = y'

7.  x'' = y'
----



0.  x***'! e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 154




0.  z*'! = (x' P y')

1.  x'' = y'
----



0.  z*'! e {@y | (x'' e @y & @y e (x' O y'))}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 273




0.  z*'! = {@x | (@x = x' V @x = y')}

1.  x'' = y'
----



0.  z*'! e {@y | (x'' e @y & @y e (x' O y'))}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

back()
back()
left()

"""

Line number 273




0.  z*'! = {@x | (@x = x' V @x = y')}

1.  x'' = y'
----



0.  z*'! e {@y | (x'' e @y & @y e (x' O y'))}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 274




0.  (Ax**''' : (z*'! e x**''' == {@x | (@x = x' V @x = y')} e x**'''))

1.  x'' = y'
----



0.  z*'! e {@y | (x'' e @y & @y e (x' O y'))}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 275




0.  (z*'! e x**''*? == {@x | (@x = x' V @x = y')} e x**''*?)

1.  (Ax**''' : (z*'! e x**''' == {@x | (@x = x' V @x = y')} e x**'''))

2.  x'' = y'
----



0.  z*'! e {@y | (x'' e @y & @y e (x' O y'))}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

back()
back()
back()
back()
done()

"""

Line number 154




0.  z*'! = (x' P y')

1.  x'' = y'
----



0.  z*'! e {@y | (x'' e @y & @y e (x' O y'))}

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [273]
Next!"""

right()

"""

Line number 273




0.  z*'! = (x' P y')

1.  x'' = y'
----



0.  (x'' e z*'! & z*'! e (x' O y'))

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 274




0.  z*'! = (x' P y')

1.  x'' = y'
----



0.  x'' e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 274




0.  x'' = y'

1.  z*'! = (x' P y')
----



0.  x'' e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 276




0.  (Ax**''' : (x'' e x**''' == y' e x**'''))

1.  z*'! = (x' P y')
----



0.  x'' e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 277




0.  (x'' e x**''*? == y' e x**''*?)

1.  (Ax**''' : (x'' e x**''' == y' e x**'''))

2.  z*'! = (x' P y')
----



0.  x'' e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("x**''*","'*z")

"""

Line number 277




0.  (x'' e z*'! == y' e z*'!)

1.  (Ax**''' : (x'' e x**''' == y' e x**'''))

2.  z*'! = (x' P y')
----



0.  x'' e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 278




0.  (x'' e z*'! -> y' e z*'!)

1.  (y' e z*'! -> x'' e z*'!)

2.  (Ax**''' : (x'' e x**''' == y' e x**'''))

3.  z*'! = (x' P y')
----



0.  x'' e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 278




0.  (y' e z*'! -> x'' e z*'!)

1.  (Ax**''' : (x'' e x**''' == y' e x**'''))

2.  z*'! = (x' P y')

3.  (x'' e z*'! -> y' e z*'!)
----



0.  x'' e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 279




0.  (Ax**''' : (x'' e x**''' == y' e x**'''))

1.  z*'! = (x' P y')

2.  (x'' e z*'! -> y' e z*'!)
----



0.  y' e z*'!

1.  x'' e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 279




0.  z*'! = (x' P y')

1.  (x'' e z*'! -> y' e z*'!)

2.  (Ax**''' : (x'' e x**''' == y' e x**'''))
----



0.  y' e z*'!

1.  x'' e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 281




0.  z*'! = {@x | (@x = x' V @x = y')}

1.  (x'' e z*'! -> y' e z*'!)

2.  (Ax**''' : (x'' e x**''' == y' e x**'''))
----



0.  y' e z*'!

1.  x'' e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 282




0.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

1.  (x'' e z*'! -> y' e z*'!)

2.  (Ax**''' : (x'' e x**''' == y' e x**'''))
----



0.  y' e z*'!

1.  x'' e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 283




0.  (z*'! e x**'**? == {@x | (@x = x' V @x = y')} e x**'**?)

1.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

2.  (x'' e z*'! -> y' e z*'!)

3.  (Ax**''' : (x'' e x**''' == y' e x**'''))
----



0.  y' e z*'!

1.  x'' e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("x**''*","{ue'yu")

"""

Line number 283




0.  (z*'! e x**'**? == {@x | (@x = x' V @x = y')} e x**'**?)

1.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

2.  (x'' e z*'! -> y' e z*'!)

3.  (Ax**''' : (x'' e x**''' == y' e x**'''))
----



0.  y' e z*'!

1.  x'' e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""


"""

Line number 283




0.  (z*'! e x**'**? == {@x | (@x = x' V @x = y')} e x**'**?)

1.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

2.  (x'' e z*'! -> y' e z*'!)

3.  (Ax**''' : (x'' e x**''' == y' e x**'''))
----



0.  y' e z*'!

1.  x'' e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("x**'**","{ue'yu")

"""

Line number 283




0.  (z*'! e {u | y' e u} == {@x | (@x = x' V @x = y')} e {u | y' e u})

1.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

2.  (x'' e z*'! -> y' e z*'!)

3.  (Ax**''' : (x'' e x**''' == y' e x**'''))
----



0.  y' e z*'!

1.  x'' e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 284




0.  (z*'! e {u | y' e u} -> {@x | (@x = x' V @x = y')} e {u | y' e u})

1.  ({@x | (@x = x' V @x = y')} e {u | y' e u} -> z*'! e {u | y' e u})

2.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

3.  (x'' e z*'! -> y' e z*'!)

4.  (Ax**''' : (x'' e x**''' == y' e x**'''))
----



0.  y' e z*'!

1.  x'' e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 284




0.  ({@x | (@x = x' V @x = y')} e {u | y' e u} -> z*'! e {u | y' e u})

1.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

2.  (x'' e z*'! -> y' e z*'!)

3.  (Ax**''' : (x'' e x**''' == y' e x**'''))

4.  (z*'! e {u | y' e u} -> {@x | (@x = x' V @x = y')} e {u | y' e u})
----



0.  y' e z*'!

1.  x'' e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 285




0.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

1.  (x'' e z*'! -> y' e z*'!)

2.  (Ax**''' : (x'' e x**''' == y' e x**'''))

3.  (z*'! e {u | y' e u} -> {@x | (@x = x' V @x = y')} e {u | y' e u})
----



0.  {@x | (@x = x' V @x = y')} e {u | y' e u}

1.  y' e z*'!

2.  x'' e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 287




0.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

1.  (x'' e z*'! -> y' e z*'!)

2.  (Ax**''' : (x'' e x**''' == y' e x**'''))

3.  (z*'! e {u | y' e u} -> {@x | (@x = x' V @x = y')} e {u | y' e u})
----



0.  y' e {@x | (@x = x' V @x = y')}

1.  y' e z*'!

2.  x'' e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 288




0.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

1.  (x'' e z*'! -> y' e z*'!)

2.  (Ax**''' : (x'' e x**''' == y' e x**'''))

3.  (z*'! e {u | y' e u} -> {@x | (@x = x' V @x = y')} e {u | y' e u})
----



0.  (y' = x' V y' = y')

1.  y' e z*'!

2.  x'' e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 289




0.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

1.  (x'' e z*'! -> y' e z*'!)

2.  (Ax**''' : (x'' e x**''' == y' e x**'''))

3.  (z*'! e {u | y' e u} -> {@x | (@x = x' V @x = y')} e {u | y' e u})
----



0.  y' = x'

1.  y' = y'

2.  y' e z*'!

3.  x'' e z*'!

4.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getright(1)

"""

Line number 289




0.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

1.  (x'' e z*'! -> y' e z*'!)

2.  (Ax**''' : (x'' e x**''' == y' e x**'''))

3.  (z*'! e {u | y' e u} -> {@x | (@x = x' V @x = y')} e {u | y' e u})
----



0.  y' = y'

1.  y' e z*'!

2.  x'' e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

4.  y' = x'

by lines [-1]
Next!"""

right()

"""

Line number 290




0.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

1.  (x'' e z*'! -> y' e z*'!)

2.  (Ax**''' : (x'' e x**''' == y' e x**'''))

3.  (z*'! e {u | y' e u} -> {@x | (@x = x' V @x = y')} e {u | y' e u})
----



0.  (Ax***'' : (x***'' e y' == x***'' e y'))

1.  y' e z*'!

2.  x'' e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

4.  y' = x'

by lines [-1]
Next!"""

right()

"""

Line number 291




0.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

1.  (x'' e z*'! -> y' e z*'!)

2.  (Ax**''' : (x'' e x**''' == y' e x**'''))

3.  (z*'! e {u | y' e u} -> {@x | (@x = x' V @x = y')} e {u | y' e u})
----



0.  (x***'*! e y' == x***'*! e y')

1.  y' e z*'!

2.  x'' e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

4.  y' = x'

by lines [-1]
Next!"""

right()

"""

Line number 292




0.  x***'*! e y'

1.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

2.  (x'' e z*'! -> y' e z*'!)

3.  (Ax**''' : (x'' e x**''' == y' e x**'''))

4.  (z*'! e {u | y' e u} -> {@x | (@x = x' V @x = y')} e {u | y' e u})
----



0.  x***'*! e y'

1.  y' e z*'!

2.  x'' e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

4.  y' = x'

by lines [-1]
Next!"""

done()

"""

Line number 293




0.  x***'*! e y'

1.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

2.  (x'' e z*'! -> y' e z*'!)

3.  (Ax**''' : (x'' e x**''' == y' e x**'''))

4.  (z*'! e {u | y' e u} -> {@x | (@x = x' V @x = y')} e {u | y' e u})
----



0.  x***'*! e y'

1.  y' e z*'!

2.  x'' e z*'!

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

4.  y' = x'

by lines [-1]
Next!"""

done()

"""

Line number 286




0.  z*'! e {u | y' e u}

1.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

2.  (x'' e z*'! -> y' e z*'!)

3.  (Ax**''' : (x'' e x**''' == y' e x**'''))

4.  (z*'! e {u | y' e u} -> {@x | (@x = x' V @x = y')} e {u | y' e u})
----



0.  y' e z*'!

1.  x'' e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 294




0.  y' e z*'!

1.  (Ax**'*' : (z*'! e x**'*' == {@x | (@x = x' V @x = y')} e x**'*'))

2.  (x'' e z*'! -> y' e z*'!)

3.  (Ax**''' : (x'' e x**''' == y' e x**'''))

4.  (z*'! e {u | y' e u} -> {@x | (@x = x' V @x = y')} e {u | y' e u})
----



0.  y' e z*'!

1.  x'' e z*'!

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 280




0.  x'' e z*'!

1.  (Ax**''' : (x'' e x**''' == y' e x**'''))

2.  z*'! = (x' P y')

3.  (x'' e z*'! -> y' e z*'!)
----



0.  x'' e z*'!

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""

Line number 275




0.  z*'! = (x' P y')

1.  x'' = y'
----



0.  z*'! e (x' O y')

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 295




0.  z*'! = {@x | (@x = x' V @x = y')}

1.  x'' = y'
----



0.  z*'! e (x' O y')

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 296




0.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))

1.  x'' = y'
----



0.  z*'! e (x' O y')

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 297




0.  (z*'! e x*****? == {@x | (@x = x' V @x = y')} e x*****?)

1.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))

2.  x'' = y'
----



0.  z*'! e (x' O y')

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

setunknown ("x*****",":a'x:b'yO")

"""

Line number 297




0.  (z*'! e (x' O y') == {@x | (@x = x' V @x = y')} e (x' O y'))

1.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))

2.  x'' = y'
----



0.  z*'! e (x' O y')

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 298




0.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))

1.  ({@x | (@x = x' V @x = y')} e (x' O y') -> z*'! e (x' O y'))

2.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))

3.  x'' = y'
----



0.  z*'! e (x' O y')

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 298




0.  ({@x | (@x = x' V @x = y')} e (x' O y') -> z*'! e (x' O y'))

1.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))

2.  x'' = y'

3.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))
----



0.  z*'! e (x' O y')

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

left()

"""

Line number 299




0.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))

1.  x'' = y'

2.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))
----



0.  {@x | (@x = x' V @x = y')} e (x' O y')

1.  z*'! e (x' O y')

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 301




0.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))

1.  x'' = y'

2.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))
----



0.  {@x | (@x = x' V @x = y')} e ((x' P x') P (x' P y'))

1.  z*'! e (x' O y')

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 302




0.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))

1.  x'' = y'

2.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))
----



0.  {@x | (@x = x' V @x = y')} e {@x | (@x = (x' P x') V @x = (x' P y'))}

1.  z*'! e (x' O y')

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 303




0.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))

1.  x'' = y'

2.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))
----



0.  ({@x | (@x = x' V @x = y')} = (x' P x') V {@x | (@x = x' V @x = y')} = (x' P y'))

1.  z*'! e (x' O y')

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 304




0.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))

1.  x'' = y'

2.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))
----



0.  {@x | (@x = x' V @x = y')} = (x' P x')

1.  {@x | (@x = x' V @x = y')} = (x' P y')

2.  z*'! e (x' O y')

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getleft(1)

"""

Line number 304




0.  x'' = y'

1.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))

2.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))
----



0.  {@x | (@x = x' V @x = y')} = (x' P x')

1.  {@x | (@x = x' V @x = y')} = (x' P y')

2.  z*'! e (x' O y')

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

right()

"""

Line number 305




0.  x'' = y'

1.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))

2.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))
----



0.  {@x | (@x = x' V @x = y')} = {@x | (@x = x' V @x = x')}

1.  {@x | (@x = x' V @x = y')} = (x' P y')

2.  z*'! e (x' O y')

3.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

getright(1)

"""

Line number 305




0.  x'' = y'

1.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))

2.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))
----



0.  {@x | (@x = x' V @x = y')} = (x' P y')

1.  z*'! e (x' O y')

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

3.  {@x | (@x = x' V @x = y')} = {@x | (@x = x' V @x = x')}

by lines [-1]
Next!"""

right()

"""

Line number 306




0.  x'' = y'

1.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))

2.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))
----



0.  {@x | (@x = x' V @x = y')} = {@x | (@x = x' V @x = y')}

1.  z*'! e (x' O y')

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

3.  {@x | (@x = x' V @x = y')} = {@x | (@x = x' V @x = x')}

by lines [-1]
Next!"""

right()

"""

Line number 307




0.  x'' = y'

1.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))

2.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))
----



0.  (Ax'''''' : (x'''''' e {@x | (@x = x' V @x = y')} == x'''''' e {@x | (@x = x' V @x = y')}))

1.  z*'! e (x' O y')

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

3.  {@x | (@x = x' V @x = y')} = {@x | (@x = x' V @x = x')}

by lines [-1]
Next!"""

right()

"""

Line number 308




0.  x'' = y'

1.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))

2.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))
----



0.  (x'''''*! e {@x | (@x = x' V @x = y')} == x'''''*! e {@x | (@x = x' V @x = y')})

1.  z*'! e (x' O y')

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

3.  {@x | (@x = x' V @x = y')} = {@x | (@x = x' V @x = x')}

by lines [-1]
Next!"""

right()

"""

Line number 309




0.  x'''''*! e {@x | (@x = x' V @x = y')}

1.  x'' = y'

2.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))

3.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))
----



0.  x'''''*! e {@x | (@x = x' V @x = y')}

1.  z*'! e (x' O y')

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

3.  {@x | (@x = x' V @x = y')} = {@x | (@x = x' V @x = x')}

by lines [-1]
Next!"""

done()

"""

Line number 310




0.  x'''''*! e {@x | (@x = x' V @x = y')}

1.  x'' = y'

2.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))

3.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))
----



0.  x'''''*! e {@x | (@x = x' V @x = y')}

1.  z*'! e (x' O y')

2.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

3.  {@x | (@x = x' V @x = y')} = {@x | (@x = x' V @x = x')}

by lines [-1]
Next!"""

done()

"""

Line number 300




0.  z*'! e (x' O y')

1.  (Ax****' : (z*'! e x****' == {@x | (@x = x' V @x = y')} e x****'))

2.  x'' = y'

3.  (z*'! e (x' O y') -> {@x | (@x = x' V @x = y')} e (x' O y'))
----



0.  z*'! e (x' O y')

1.  (E@y : (A@z : (@z e {@y | (x'' e @y & @y e (x' O y'))} == @z = @y)))

by lines [-1]
Next!"""

done()

"""Done!"""

