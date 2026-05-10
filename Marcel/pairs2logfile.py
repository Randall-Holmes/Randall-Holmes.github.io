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

done()
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

setunknown ("x'*'","{u-'xu")
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

done()
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

setunknown ("x**'","{ue''''xu")

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

done()
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

done()
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

right()

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
setunknown ("x'*''","{ue'xu")

"""

Line number 75




0.  (y''! e {u | x'! e u} == {@x | (@x = x'! V @x = x'!)} e {u | x'! e u})

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 76




0.  (y''! e {u | x'! e u} -> {@x | (@x = x'! V @x = x'!)} e {u | x'! e u})

1.  ({@x | (@x = x'! V @x = x'!)} e {u | x'! e u} -> y''! e {u | x'! e u})

2.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

3.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 77




0.  ({@x | (@x = x'! V @x = x'!)} e {u | x'! e u} -> y''! e {u | x'! e u})

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!
----



0.  y''! e {u | x'! e u}

1.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 79




0.  ({@x | (@x = x'! V @x = x'!)} e {u | x'! e u} -> y''! e {u | x'! e u})

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!
----



0.  x'! e y''!

1.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 80




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!
----



0.  {@x | (@x = x'! V @x = x'!)} e {u | x'! e u}

1.  x'! e y''!

2.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 82




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!
----



0.  x'! e {@x | (@x = x'! V @x = x'!)}

1.  x'! e y''!

2.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 83




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!
----



0.  (x'! = x'! V x'! = x'!)

1.  x'! e y''!

2.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 84




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!
----



0.  x'! = x'!

1.  x'! = x'!

2.  x'! e y''!

3.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 85




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!
----



0.  (Ax'*'* : (x'*'* e x'! == x'*'* e x'!))

1.  x'! = x'!

2.  x'! e y''!

3.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 86




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!
----



0.  (x'**'! e x'! == x'**'! e x'!)

1.  x'! = x'!

2.  x'! e y''!

3.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 87




0.  x'**'! e x'!

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!
----



0.  x'**'! e x'!

1.  x'! = x'!

2.  x'! e y''!

3.  x''! e y''!

by lines [-1]
Next!"""

done()

"""

Line number 88




0.  x'**'! e x'!

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!
----



0.  x'**'! e x'!

1.  x'! = x'!

2.  x'! e y''!

3.  x''! e y''!

by lines [-1]
Next!"""

done()

"""

Line number 81




0.  y''! e {u | x'! e u}

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!
----



0.  x'! e y''!

1.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 89




0.  x'! e y''!

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!
----



0.  x'! e y''!

1.  x''! e y''!

by lines [-1]
Next!"""

done()

"""

Line number 78




0.  {@x | (@x = x'! V @x = x'!)} e {u | x'! e u}

1.  ({@x | (@x = x'! V @x = x'!)} e {u | x'! e u} -> y''! e {u | x'! e u})

2.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

3.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 90




0.  x'! e {@x | (@x = x'! V @x = x'!)}

1.  ({@x | (@x = x'! V @x = x'!)} e {u | x'! e u} -> y''! e {u | x'! e u})

2.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

3.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 91




0.  (x'! = x'! V x'! = x'!)

1.  ({@x | (@x = x'! V @x = x'!)} e {u | x'! e u} -> y''! e {u | x'! e u})

2.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

3.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 91




0.  ({@x | (@x = x'! V @x = x'!)} e {u | x'! e u} -> y''! e {u | x'! e u})

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!

3.  (x'! = x'! V x'! = x'!)
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 92




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!

2.  (x'! = x'! V x'! = x'!)
----



0.  {@x | (@x = x'! V @x = x'!)} e {u | x'! e u}

1.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 94




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!

2.  (x'! = x'! V x'! = x'!)
----



0.  x'! e {@x | (@x = x'! V @x = x'!)}

1.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 95




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!

2.  (x'! = x'! V x'! = x'!)
----



0.  (x'! = x'! V x'! = x'!)

1.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 96




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!

2.  (x'! = x'! V x'! = x'!)
----



0.  x'! = x'!

1.  x'! = x'!

2.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 97




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!

2.  (x'! = x'! V x'! = x'!)
----



0.  (Ax'*** : (x'*** e x'! == x'*** e x'!))

1.  x'! = x'!

2.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 98




0.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

1.  x'! = x''!

2.  (x'! = x'! V x'! = x'!)
----



0.  (x*'''! e x'! == x*'''! e x'!)

1.  x'! = x'!

2.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 99




0.  x*'''! e x'!

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!

3.  (x'! = x'! V x'! = x'!)
----



0.  x*'''! e x'!

1.  x'! = x'!

2.  x''! e y''!

by lines [-1]
Next!"""

done()

"""

Line number 100




0.  x*'''! e x'!

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!

3.  (x'! = x'! V x'! = x'!)
----



0.  x*'''! e x'!

1.  x'! = x'!

2.  x''! e y''!

by lines [-1]
Next!"""

done()

"""

Line number 93




0.  y''! e {u | x'! e u}

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!

3.  (x'! = x'! V x'! = x'!)
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 101




0.  x'! e y''!

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  x'! = x''!

3.  (x'! = x'! V x'! = x'!)
----



0.  x''! e y''!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 101




0.  x'! = x''!

1.  (x'! = x'! V x'! = x'!)

2.  x'! e y''!

3.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 102




0.  (Ax*''* : (x'! e x*''* == x''! e x*''*))

1.  (x'! = x'! V x'! = x'!)

2.  x'! e y''!

3.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 103




0.  (x'! e x*'*'? == x''! e x*'*'?)

1.  (Ax*''* : (x'! e x*''* == x''! e x*''*))

2.  (x'! = x'! V x'! = x'!)

3.  x'! e y''!

4.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))
----



0.  x''! e y''!

by lines [-1]
Next!"""

setunknown ("x*'*'","''y")

"""

Line number 103




0.  (x'! e y''! == x''! e y''!)

1.  (Ax*''* : (x'! e x*''* == x''! e x*''*))

2.  (x'! = x'! V x'! = x'!)

3.  x'! e y''!

4.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 104




0.  (x'! e y''! -> x''! e y''!)

1.  (x''! e y''! -> x'! e y''!)

2.  (Ax*''* : (x'! e x*''* == x''! e x*''*))

3.  (x'! = x'! V x'! = x'!)

4.  x'! e y''!

5.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 105




0.  (x''! e y''! -> x'! e y''!)

1.  (Ax*''* : (x'! e x*''* == x''! e x*''*))

2.  (x'! = x'! V x'! = x'!)

3.  x'! e y''!

4.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))
----



0.  x'! e y''!

1.  x''! e y''!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 105




0.  x'! e y''!

1.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))

2.  (x''! e y''! -> x'! e y''!)

3.  (Ax*''* : (x'! e x*''* == x''! e x*''*))

4.  (x'! = x'! V x'! = x'!)
----



0.  x'! e y''!

1.  x''! e y''!

by lines [-1]
Next!"""

done()

"""

Line number 106




0.  x''! e y''!

1.  (x''! e y''! -> x'! e y''!)

2.  (Ax*''* : (x'! e x*''* == x''! e x*''*))

3.  (x'! = x'! V x'! = x'!)

4.  x'! e y''!

5.  (Ax''** : (y''! e x''** == {@x | (@x = x'! V @x = x'!)} e x''**))
----



0.  x''! e y''!

by lines [-1]
Next!"""

done()

"""

Line number 72




0.  y''! = (x'! P y'!)

1.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 107




0.  y''! = {@x | (@x = x'! V @x = y'!)}

1.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 108




0.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

1.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 109




0.  (y''! e x**''? == {@x | (@x = x'! V @x = y'!)} e x**''?)

1.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

2.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 110




0.  (y''! e x**''? -> {@x | (@x = x'! V @x = y'!)} e x**''?)

1.  ({@x | (@x = x'! V @x = y'!)} e x**''? -> y''! e x**''?)

2.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

3.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

setunknown ("x**''","{ue''xu")

"""

Line number 110




0.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

1.  ({@x | (@x = x'! V @x = y'!)} e {u | x''! e u} -> y''! e {u | x''! e u})

2.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

3.  x'! = x''!
----



0.  x''! e y''!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 110




0.  ({@x | (@x = x'! V @x = y'!)} e {u | x''! e u} -> y''! e {u | x''! e u})

1.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

2.  x'! = x''!

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 111




0.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

1.  x'! = x''!

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})
----



0.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

1.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 113




0.  (y''! e x**'*? == {@x | (@x = x'! V @x = y'!)} e x**'*?)

1.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

2.  x'! = x''!

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})
----



0.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

1.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 114




0.  (y''! e x**'*? -> {@x | (@x = x'! V @x = y'!)} e x**'*?)

1.  ({@x | (@x = x'! V @x = y'!)} e x**'*? -> y''! e x**'*?)

2.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

3.  x'! = x''!

4.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})
----



0.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

1.  x''! e y''!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 114




0.  ({@x | (@x = x'! V @x = y'!)} e x**'*? -> y''! e x**'*?)

1.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

2.  x'! = x''!

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (y''! e x**'*? -> {@x | (@x = x'! V @x = y'!)} e x**'*?)
----



0.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

1.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 115




0.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

1.  x'! = x''!

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (y''! e x**'*? -> {@x | (@x = x'! V @x = y'!)} e x**'*?)
----



0.  {@x | (@x = x'! V @x = y'!)} e x**'*?

1.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

2.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 115




0.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

1.  x'! = x''!

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (y''! e x**'*? -> {@x | (@x = x'! V @x = y'!)} e x**'*?)
----



0.  {@x | (@x = x'! V @x = y'!)} e x**'*?

1.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

2.  x''! e y''!

by lines [-1]
Next!"""

setunknown ("x**'*","{ue''xu")

"""

Line number 115




0.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

1.  x'! = x''!

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})
----



0.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

1.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

2.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 117




0.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

1.  x'! = x''!

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})
----



0.  x''! e {@x | (@x = x'! V @x = y'!)}

1.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

2.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 118




0.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

1.  x'! = x''!

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})
----



0.  (x''! = x'! V x''! = y'!)

1.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

2.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 119




0.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

1.  x'! = x''!

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})
----



0.  x''! = x'!

1.  x''! = y'!

2.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

3.  x''! e y''!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 119




0.  x'! = x''!

1.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))
----



0.  x''! = x'!

1.  x''! = y'!

2.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

3.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 120




0.  (Ax***' : (x'! e x***' == x''! e x***'))

1.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))
----



0.  x''! = x'!

1.  x''! = y'!

2.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

3.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 121




0.  (x'! e x****? == x''! e x****?)

1.  (Ax***' : (x'! e x***' == x''! e x***'))

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))
----



0.  x''! = x'!

1.  x''! = y'!

2.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

3.  x''! e y''!

by lines [-1]
Next!"""

setunknown ("x****","{u-u'x")
setunknown ("x****","{u=u'x")

"""

Line number 121




0.  (x'! e {u | u = x'!} == x''! e {u | u = x'!})

1.  (Ax***' : (x'! e x***' == x''! e x***'))

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))
----



0.  x''! = x'!

1.  x''! = y'!

2.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

3.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 122




0.  (x'! e {u | u = x'!} -> x''! e {u | u = x'!})

1.  (x''! e {u | u = x'!} -> x'! e {u | u = x'!})

2.  (Ax***' : (x'! e x***' == x''! e x***'))

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

5.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))
----



0.  x''! = x'!

1.  x''! = y'!

2.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

3.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 123




0.  (x''! e {u | u = x'!} -> x'! e {u | u = x'!})

1.  (Ax***' : (x'! e x***' == x''! e x***'))

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))
----



0.  x'! e {u | u = x'!}

1.  x''! = x'!

2.  x''! = y'!

3.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

4.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 125




0.  (x''! e {u | u = x'!} -> x'! e {u | u = x'!})

1.  (Ax***' : (x'! e x***' == x''! e x***'))

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))
----



0.  x'! = x'!

1.  x''! = x'!

2.  x''! = y'!

3.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

4.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 126




0.  (x''! e {u | u = x'!} -> x'! e {u | u = x'!})

1.  (Ax***' : (x'! e x***' == x''! e x***'))

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))
----



0.  (Ax''''' : (x''''' e x'! == x''''' e x'!))

1.  x''! = x'!

2.  x''! = y'!

3.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

4.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 127




0.  (x''! e {u | u = x'!} -> x'! e {u | u = x'!})

1.  (Ax***' : (x'! e x***' == x''! e x***'))

2.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))
----



0.  (x''''*! e x'! == x''''*! e x'!)

1.  x''! = x'!

2.  x''! = y'!

3.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

4.  x''! e y''!

by lines [-1]
Next!"""

right()

"""

Line number 128




0.  x''''*! e x'!

1.  (x''! e {u | u = x'!} -> x'! e {u | u = x'!})

2.  (Ax***' : (x'! e x***' == x''! e x***'))

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

5.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))
----



0.  x''''*! e x'!

1.  x''! = x'!

2.  x''! = y'!

3.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

4.  x''! e y''!

by lines [-1]
Next!"""

done()

"""

Line number 129




0.  x''''*! e x'!

1.  (x''! e {u | u = x'!} -> x'! e {u | u = x'!})

2.  (Ax***' : (x'! e x***' == x''! e x***'))

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

5.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))
----



0.  x''''*! e x'!

1.  x''! = x'!

2.  x''! = y'!

3.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

4.  x''! e y''!

by lines [-1]
Next!"""

done()

"""

Line number 124




0.  x''! e {u | u = x'!}

1.  (x''! e {u | u = x'!} -> x'! e {u | u = x'!})

2.  (Ax***' : (x'! e x***' == x''! e x***'))

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

5.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))
----



0.  x''! = x'!

1.  x''! = y'!

2.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

3.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 130




0.  x''! = x'!

1.  (x''! e {u | u = x'!} -> x'! e {u | u = x'!})

2.  (Ax***' : (x'! e x***' == x''! e x***'))

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

5.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))
----



0.  x''! = x'!

1.  x''! = y'!

2.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

3.  x''! e y''!

by lines [-1]
Next!"""

done()

"""

Line number 116




0.  y''! e {u | x''! e u}

1.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

2.  x'! = x''!

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})
----



0.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

1.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 131




0.  x''! e y''!

1.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

2.  x'! = x''!

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})
----



0.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

1.  x''! e y''!

by lines [-1]
Next!"""

getright(1)

"""

Line number 131




0.  x''! e y''!

1.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

2.  x'! = x''!

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})

4.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})
----



0.  x''! e y''!

1.  {@x | (@x = x'! V @x = y'!)} e {u | x''! e u}

by lines [-1]
Next!"""

done()

"""

Line number 112




0.  y''! e {u | x''! e u}

1.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

2.  x'! = x''!

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})
----



0.  x''! e y''!

by lines [-1]
Next!"""

left()

"""

Line number 132




0.  x''! e y''!

1.  (Ax*'** : (y''! e x*'** == {@x | (@x = x'! V @x = y'!)} e x*'**))

2.  x'! = x''!

3.  (y''! e {u | x''! e u} -> {@x | (@x = x'! V @x = y'!)} e {u | x''! e u})
----



0.  x''! e y''!

by lines [-1]
Next!"""

done()

"""Done!"""

