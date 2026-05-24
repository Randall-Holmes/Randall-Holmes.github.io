from graph import *

deft ("Z", "{xAy~eyx")
deft ("N", "{x~=xx")
start ("AxXexZ=xN")

"""

Line number 0



----



0.  (Ax : (x e Z == x = N))

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  (x'! e Z == x'! = N)

by lines [-1]
Next!"""

right()

"""

Line number 2




0.  x'! e Z
----



0.  x'! = N

by lines [-1]
Next!"""

right()

"""

Line number 4




0.  x'! e Z
----



0.  x'! = {@x | ~@x = @x}

by lines [-1]
Next!"""

right()

"""

Line number 5




0.  x'! e Z
----



0.  (Ax* : (x* e x'! == x* e {@x | ~@x = @x}))

by lines [-1]
Next!"""

right()

"""

Line number 6




0.  x'! e Z
----



0.  (x''! e x'! == x''! e {@x | ~@x = @x})

by lines [-1]
Next!"""

right()

"""

Line number 7




0.  x''! e x'!

1.  x'! e Z
----



0.  x''! e {@x | ~@x = @x}

by lines [-1]
Next!"""

right()

"""

Line number 9




0.  x''! e x'!

1.  x'! e Z
----



0.  ~x''! = x''!

by lines [-1]
Next!"""

right()

"""

Line number 10




0.  x''! = x''!

1.  x''! e x'!

2.  x'! e Z
----



by lines [-1]
Next!"""

getleft(2)

"""

Line number 10




0.  x'! e Z

1.  x''! = x''!

2.  x''! e x'!
----



by lines [-1]
Next!"""

left()

"""

Line number 11




0.  x'! e {@x | (A@y : ~@y e @x)}

1.  x''! = x''!

2.  x''! e x'!
----



by lines [-1]
Next!"""

left()

"""

Line number 12




0.  (A@y : ~@y e x'!)

1.  x''! = x''!

2.  x''! e x'!
----



by lines [-1]
Next!"""

left()

"""

Line number 13




0.  ~y'? e x'!

1.  (A@y : ~@y e x'!)

2.  x''! = x''!

3.  x''! e x'!
----



by lines [-1]
Next!"""

left()

"""

Line number 14




0.  (A@y : ~@y e x'!)

1.  x''! = x''!

2.  x''! e x'!
----



0.  y'? e x'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 14




0.  x''! e x'!

1.  (A@y : ~@y e x'!)

2.  x''! = x''!
----



0.  y'? e x'!

by lines [-1]
Next!"""

done()

"""

Line number 8




0.  x''! e {@x | ~@x = @x}

1.  x'! e Z
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 15




0.  ~x''! = x''!

1.  x'! e Z
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 16




0.  x'! e Z
----



0.  x''! = x''!

1.  x''! e x'!

by lines [-1]
Next!"""

right()

"""

Line number 17




0.  x'! e Z
----



0.  (Ax'* : (x'* e x''! == x'* e x''!))

1.  x''! e x'!

by lines [-1]
Next!"""

back()
back()
done()

"""

Line number 3




0.  x'! = N
----



0.  x'! e Z

by lines [-1]
Next!"""

right()

"""

Line number 17




0.  x'! = N
----



0.  x'! e {@x | (A@y : ~@y e @x)}

by lines [-1]
Next!"""

right()

"""

Line number 18




0.  x'! = N
----



0.  (A@y : ~@y e x'!)

by lines [-1]
Next!"""

right()

"""

Line number 19




0.  x'! = N
----



0.  ~y*! e x'!

by lines [-1]
Next!"""

right()

"""

Line number 20




0.  y*! e x'!

1.  x'! = N
----



by lines [-1]
Next!"""

getleft(1)

"""

Line number 20




0.  x'! = N

1.  y*! e x'!
----



by lines [-1]
Next!"""

left()

"""

Line number 21




0.  x'! = {@x | ~@x = @x}

1.  y*! e x'!
----



by lines [-1]
Next!"""

left()

"""

Line number 22




0.  (Ax'* : (x'! e x'* == {@x | ~@x = @x} e x'*))

1.  y*! e x'!
----



by lines [-1]
Next!"""

left()

"""

Line number 23




0.  (x'! e x*'? == {@x | ~@x = @x} e x*'?)

1.  (Ax'* : (x'! e x'* == {@x | ~@x = @x} e x'*))

2.  y*! e x'!
----



by lines [-1]
Next!"""

left()

"""

Line number 24




0.  (x'! e x*'? -> {@x | ~@x = @x} e x*'?)

1.  ({@x | ~@x = @x} e x*'? -> x'! e x*'?)

2.  (Ax'* : (x'! e x'* == {@x | ~@x = @x} e x'*))

3.  y*! e x'!
----



by lines [-1]
Next!"""

left()

"""

Line number 25




0.  ({@x | ~@x = @x} e x*'? -> x'! e x*'?)

1.  (Ax'* : (x'! e x'* == {@x | ~@x = @x} e x'*))

2.  y*! e x'!
----



0.  x'! e x*'?

by lines [-1]
Next!"""

getleft(2)

"""

Line number 25




0.  y*! e x'!

1.  ({@x | ~@x = @x} e x*'? -> x'! e x*'?)

2.  (Ax'* : (x'! e x'* == {@x | ~@x = @x} e x'*))
----



0.  x'! e x*'?

by lines [-1]
Next!"""

done()

"""

Line number 26




0.  {@x | ~@x = @x} e {x** | y*! e x**}

1.  ({@x | ~@x = @x} e {x** | y*! e x**} -> x'! e {x** | y*! e x**})

2.  (Ax'* : (x'! e x'* == {@x | ~@x = @x} e x'*))

3.  y*! e x'!
----



by lines [-1]
Next!"""

left()

"""

Line number 27




0.  y*! e {@x | ~@x = @x}

1.  ({@x | ~@x = @x} e {x** | y*! e x**} -> x'! e {x** | y*! e x**})

2.  (Ax'* : (x'! e x'* == {@x | ~@x = @x} e x'*))

3.  y*! e x'!
----



by lines [-1]
Next!"""

left()

"""

Line number 28




0.  ~y*! = y*!

1.  ({@x | ~@x = @x} e {x** | y*! e x**} -> x'! e {x** | y*! e x**})

2.  (Ax'* : (x'! e x'* == {@x | ~@x = @x} e x'*))

3.  y*! e x'!
----



by lines [-1]
Next!"""

left()

"""

Line number 29




0.  ({@x | ~@x = @x} e {x** | y*! e x**} -> x'! e {x** | y*! e x**})

1.  (Ax'* : (x'! e x'* == {@x | ~@x = @x} e x'*))

2.  y*! e x'!
----



0.  y*! = y*!

by lines [-1]
Next!"""

done()

"""Done!"""

savetheorem('ZEN')
deft ("S", "{xEuEv&eua&~evu=x{wVewu=wv")
start ("Ax~=Z:axS")

"""

Line number 0



----



0.  (Ax : ~Z = S(a:x))

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  ~Z = S(a:x'!)

by lines [-1]
Next!"""

right()

"""

Line number 2




0.  Z = S(a:x'!)
----



by lines [-1]
Next!"""

left()

"""

Line number 3




0.  Z = {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))}
----



by lines [-1]
Next!"""

left()

"""

Line number 4




0.  {@x | (A@y : ~@y e @x)} = {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))}
----



by lines [-1]
Next!"""

left()

"""

Line number 5




0.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))
----



by lines [-1]
Next!"""

left()

"""

Line number 6




0.  ({@x | (A@y : ~@y e @x)} e x''? == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x''?)

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))
----



by lines [-1]
Next!"""

left()

"""

Line number 7




0.  ({@x | (A@y : ~@y e @x)} e x''? -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x''?)

1.  ({@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x''? -> {@x | (A@y : ~@y e @x)} e x''?)

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))
----



by lines [-1]
Next!"""

getleft(1)

"""

Line number 7




0.  ({@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x''? -> {@x | (A@y : ~@y e @x)} e x''?)

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e x''? -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x''?)
----



by lines [-1]
Next!"""

setunknown ("x''","{xAy>eyxEzezy")

"""

Line number 7




0.  ({@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))})

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 8




0.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

1.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))}

by lines [-1]
Next!"""

right()

"""

Line number 10




0.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

1.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  (Ay : (y e {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} -> (Ez : z e y)))

by lines [-1]
Next!"""

right()

"""

Line number 11




0.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

1.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  (y'! e {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} -> (Ez : z e y'!))

by lines [-1]
Next!"""

right()

"""

Line number 12




0.  y'! e {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))}

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  (Ez : z e y'!)

by lines [-1]
Next!"""

left()

"""

Line number 13




0.  (E@u : (E@v : (@u e x'! & (~@v e @u & y'! = {@w | (@w e @u V @w = @v)}))))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  (Ez : z e y'!)

by lines [-1]
Next!"""

left()

"""

Line number 14




0.  (E@v : (u'! e x'! & (~@v e u'! & y'! = {@w | (@w e u'! V @w = @v)})))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  (Ez : z e y'!)

by lines [-1]
Next!"""

left()

"""

Line number 15




0.  (u'! e x'! & (~v'! e u'! & y'! = {@w | (@w e u'! V @w = v'!)}))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  (Ez : z e y'!)

by lines [-1]
Next!"""

right()

"""

Line number 16




0.  (u'! e x'! & (~v'! e u'! & y'! = {@w | (@w e u'! V @w = v'!)}))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  z'? e y'!

1.  (Ez : z e y'!)

by lines [-1]
Next!"""

left()

"""

Line number 17




0.  u'! e x'!

1.  (~v'! e u'! & y'! = {@w | (@w e u'! V @w = v'!)})

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  z'? e y'!

1.  (Ez : z e y'!)

by lines [-1]
Next!"""

getleft(1)

"""

Line number 17




0.  (~v'! e u'! & y'! = {@w | (@w e u'! V @w = v'!)})

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

3.  u'! e x'!
----



0.  z'? e y'!

1.  (Ez : z e y'!)

by lines [-1]
Next!"""

left()

"""

Line number 18




0.  ~v'! e u'!

1.  y'! = {@w | (@w e u'! V @w = v'!)}

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

4.  u'! e x'!
----



0.  z'? e y'!

1.  (Ez : z e y'!)

by lines [-1]
Next!"""

getleft(1)

"""

Line number 18




0.  y'! = {@w | (@w e u'! V @w = v'!)}

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

3.  u'! e x'!

4.  ~v'! e u'!
----



0.  z'? e y'!

1.  (Ez : z e y'!)

by lines [-1]
Next!"""

left()

"""

Line number 19




0.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

3.  u'! e x'!

4.  ~v'! e u'!
----



0.  z'? e y'!

1.  (Ez : z e y'!)

by lines [-1]
Next!"""

left()

"""

Line number 20




0.  (y'! e x*'? == {@w | (@w e u'! V @w = v'!)} e x*'?)

1.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

4.  u'! e x'!

5.  ~v'! e u'!
----



0.  z'? e y'!

1.  (Ez : z e y'!)

by lines [-1]
Next!"""

left()

"""

Line number 21




0.  (y'! e x*'? -> {@w | (@w e u'! V @w = v'!)} e x*'?)

1.  ({@w | (@w e u'! V @w = v'!)} e x*'? -> y'! e x*'?)

2.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))

3.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

4.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

5.  u'! e x'!

6.  ~v'! e u'!
----



0.  z'? e y'!

1.  (Ez : z e y'!)

by lines [-1]
Next!"""

getleft(1)

"""

Line number 21




0.  ({@w | (@w e u'! V @w = v'!)} e x*'? -> y'! e x*'?)

1.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

4.  u'! e x'!

5.  ~v'! e u'!

6.  (y'! e x*'? -> {@w | (@w e u'! V @w = v'!)} e x*'?)
----



0.  z'? e y'!

1.  (Ez : z e y'!)

by lines [-1]
Next!"""

left()

"""

Line number 22




0.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

3.  u'! e x'!

4.  ~v'! e u'!

5.  (y'! e x*'? -> {@w | (@w e u'! V @w = v'!)} e x*'?)
----



0.  {@w | (@w e u'! V @w = v'!)} e x*'?

1.  z'? e y'!

2.  (Ez : z e y'!)

by lines [-1]
Next!"""

skip()

"""

Line number 23




0.  y'! e x*'?

1.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

4.  u'! e x'!

5.  ~v'! e u'!

6.  (y'! e x*'? -> {@w | (@w e u'! V @w = v'!)} e x*'?)
----



0.  z'? e y'!

1.  (Ez : z e y'!)

by lines [-1]
Next!"""

done()

"""

Line number 9




0.  {@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))}

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



by lines [-1]
Next!"""

skip()

"""

Line number 22




0.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

3.  u'! e x'!

4.  ~v'! e u'!

5.  (y'! e y'! -> {@w | (@w e u'! V @w = v'!)} e y'!)
----



0.  {@w | (@w e u'! V @w = v'!)} e y'!

1.  y'! e y'!

2.  (Ez : z e y'!)

by lines [-1]
Next!"""

back()
back()
back()
back()
setunknown ("z'","'v")

"""

Line number 23




0.  y'! e x*'?

1.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

4.  u'! e x'!

5.  ~v'! e u'!

6.  (y'! e x*'? -> {@w | (@w e u'! V @w = v'!)} e x*'?)
----



0.  v'! e y'!

1.  (Ez : z e y'!)

by lines [-1]
Next!"""

done()

"""

Line number 9




0.  {@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))}

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



by lines [-1]
Next!"""

skip()

"""

Line number 22




0.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

3.  u'! e x'!

4.  ~v'! e u'!

5.  (y'! e {x** | v'! e x**} -> {@w | (@w e u'! V @w = v'!)} e {x** | v'! e x**})
----



0.  {@w | (@w e u'! V @w = v'!)} e {x** | v'! e x**}

1.  v'! e y'!

2.  (Ez : z e y'!)

by lines [-1]
Next!"""

right()

"""

Line number 24




0.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

3.  u'! e x'!

4.  ~v'! e u'!

5.  (y'! e {x** | v'! e x**} -> {@w | (@w e u'! V @w = v'!)} e {x** | v'! e x**})
----



0.  v'! e {@w | (@w e u'! V @w = v'!)}

1.  v'! e y'!

2.  (Ez : z e y'!)

by lines [-1]
Next!"""

right()

"""

Line number 25




0.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

3.  u'! e x'!

4.  ~v'! e u'!

5.  (y'! e {x** | v'! e x**} -> {@w | (@w e u'! V @w = v'!)} e {x** | v'! e x**})
----



0.  (v'! e u'! V v'! = v'!)

1.  v'! e y'!

2.  (Ez : z e y'!)

by lines [-1]
Next!"""

left()

"""

Line number 26




0.  (y'! e x**? == {@w | (@w e u'! V @w = v'!)} e x**?)

1.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

4.  u'! e x'!

5.  ~v'! e u'!

6.  (y'! e {x** | v'! e x**?} -> {@w | (@w e u'! V @w = v'!)} e {x** | v'! e x**?})
----



0.  (v'! e u'! V v'! = v'!)

1.  v'! e y'!

2.  (Ez : z e y'!)

by lines [-1]
Next!"""

back()
right()

"""

Line number 27




0.  (y'! e x**? == {@w | (@w e u'! V @w = v'!)} e x**?)

1.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

4.  u'! e x'!

5.  ~v'! e u'!

6.  (y'! e {x** | v'! e x**?} -> {@w | (@w e u'! V @w = v'!)} e {x** | v'! e x**?})
----



0.  v'! e u'!

1.  v'! = v'!

2.  v'! e y'!

3.  (Ez : z e y'!)

by lines [-1]
Next!"""

getleft(2)

"""

Line number 27




0.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

1.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

2.  u'! e x'!

3.  ~v'! e u'!

4.  (y'! e {x** | v'! e x**?} -> {@w | (@w e u'! V @w = v'!)} e {x** | v'! e x**?})

5.  (y'! e x**? == {@w | (@w e u'! V @w = v'!)} e x**?)

6.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))
----



0.  v'! e u'!

1.  v'! = v'!

2.  v'! e y'!

3.  (Ez : z e y'!)

by lines [-1]
Next!"""

getright(2)

"""

Line number 27




0.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

1.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

2.  u'! e x'!

3.  ~v'! e u'!

4.  (y'! e {x** | v'! e x**?} -> {@w | (@w e u'! V @w = v'!)} e {x** | v'! e x**?})

5.  (y'! e x**? == {@w | (@w e u'! V @w = v'!)} e x**?)

6.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))
----



0.  v'! e y'!

1.  (Ez : z e y'!)

2.  v'! e u'!

3.  v'! = v'!

by lines [-1]
Next!"""

getright(3)

"""

Line number 27




0.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

1.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})

2.  u'! e x'!

3.  ~v'! e u'!

4.  (y'! e {x** | v'! e x**?} -> {@w | (@w e u'! V @w = v'!)} e {x** | v'! e x**?})

5.  (y'! e x**? == {@w | (@w e u'! V @w = v'!)} e x**?)

6.  (Ax'* : (y'! e x'* == {@w | (@w e u'! V @w = v'!)} e x'*))
----



0.  v'! = v'!

1.  v'! e y'!

2.  (Ez : z e y'!)

3.  v'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 9




0.  {@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))}

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 28




0.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 29




0.  (y*? e {@x | (A@y : ~@y e @x)} -> (Ez : z e y*?))

1.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 30




0.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  y*? e {@x | (A@y : ~@y e @x)}

by lines [-1]
Next!"""

right()

"""

Line number 32




0.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  (A@y : ~@y e y*?)

by lines [-1]
Next!"""

right()

"""

Line number 33




0.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  ~y''! e y*?

by lines [-1]
Next!"""

setunknown ("y*","N")

"""

Line number 33




0.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  ~y''! e N

by lines [-1]
Next!"""

right()

"""

Line number 34




0.  y''! e N

1.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 35




0.  y''! e {@x | ~@x = @x}

1.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 36




0.  ~y''! = y''!

1.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 37




0.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  y''! = y''!

by lines [-1]
Next!"""

done()

"""

Line number 31




0.  (Ez : z e N)

1.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 38




0.  z*! e N

1.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 39




0.  z*! e {@x | ~@x = @x}

1.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 40




0.  ~z*! = z*!

1.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

2.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

3.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 41




0.  (Ay : (y e {@x | (A@y : ~@y e @x)} -> (Ez : z e y)))

1.  (Ax* : ({@x | (A@y : ~@y e @x)} e x* == {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e x*))

2.  ({@x | (A@y : ~@y e @x)} e {x | (Ay : (y e x -> (Ez : z e y)))} -> {@x | (E@u : (E@v : (@u e x'! & (~@v e @u & @x = {@w | (@w e @u V @w = @v)}))))} e {x | (Ay : (y e x -> (Ez : z e y)))})
----



0.  z*! = z*!

by lines [-1]
Next!"""

done()

"""Done!"""

savetheorem('PEANO3')
