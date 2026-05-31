from graph2 import *
#setlog("editarith")

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



0.  (Ax* : (x* e x'! == x* e N))

by lines [-1]
Next!"""

right()

"""

Line number 5




0.  x'! e Z
----



0.  (x''! e x'! == x''! e N)

by lines [-1]
Next!"""

right()

"""

Line number 6




0.  x''! e x'!

1.  x'! e Z
----



0.  x''! e N

by lines [-1]
Next!"""

right()

"""

Line number 8




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

Line number 7




0.  x''! e N

1.  x'! e Z
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 15




0.  x''! e {@x | ~@x = @x}

1.  x'! e Z
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 16




0.  ~x''! = x''!

1.  x'! e Z
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 17




0.  x'! e Z
----



0.  x''! = x''!

1.  x''! e x'!

by lines [-1]
Next!"""

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

Line number 18




0.  x'! = N
----



0.  x'! e {@x | (A@y : ~@y e @x)}

by lines [-1]
Next!"""

right()

"""

Line number 19




0.  x'! = N
----



0.  (A@y : ~@y e x'!)

by lines [-1]
Next!"""

right()

"""

Line number 20




0.  x'! = N
----



0.  ~y*! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 21




0.  (Ax'* : (x'! e x'* == N e x'*))
----



0.  ~y*! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 22




0.  (x'! e x*'? == N e x*'?)

1.  (Ax'* : (x'! e x'* == N e x'*))
----



0.  ~y*! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 23




0.  (x'! e x*'? -> N e x*'?)

1.  (N e x*'? -> x'! e x*'?)

2.  (Ax'* : (x'! e x'* == N e x'*))
----



0.  ~y*! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 24




0.  (N e x*'? -> x'! e x*'?)

1.  (Ax'* : (x'! e x'* == N e x'*))
----



0.  x'! e x*'?

1.  ~y*! e x'!

by lines [-1]
Next!"""

back()
back()
getleft(1)

"""

Line number 23




0.  (N e x*'? -> x'! e x*'?)

1.  (Ax'* : (x'! e x'* == N e x'*))

2.  (x'! e x*'? -> N e x*'?)
----



0.  ~y*! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 24




0.  (Ax'* : (x'! e x'* == N e x'*))

1.  (x'! e x*'? -> N e x*'?)
----



0.  N e x*'?

1.  ~y*! e x'!

by lines [-1]
Next!"""

back()
back()
back()
back()
left()

"""

Line number 22




0.  (x'! e x*'? == N e x*'?)

1.  (Ax'* : (x'! e x'* == N e x'*))
----



0.  ~y*! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 23




0.  (x'! e x*'? -> N e x*'?)

1.  (N e x*'? -> x'! e x*'?)

2.  (Ax'* : (x'! e x'* == N e x'*))
----



0.  ~y*! e x'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 23




0.  (N e x*'? -> x'! e x*'?)

1.  (Ax'* : (x'! e x'* == N e x'*))

2.  (x'! e x*'? -> N e x*'?)
----



0.  ~y*! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 24




0.  (Ax'* : (x'! e x'* == N e x'*))

1.  (x'! e x*'? -> N e x*'?)
----



0.  N e x*'?

1.  ~y*! e x'!

by lines [-1]
Next!"""

skip()

"""

Line number 25




0.  x'! e x*'?

1.  (Ax'* : (x'! e x'* == N e x'*))

2.  (x'! e x*'? -> N e x*'?)
----



0.  ~y*! e x'!

by lines [-1]
Next!"""

done()

"""

Line number 24




0.  (Ax'* : (x'! e x'* == N e x'*))

1.  (x'! e {x** | ~y*! e x**}
   -> N e {x** | ~y*! e x**})
----



0.  N e {x** | ~y*! e x**}

1.  ~y*! e x'!

by lines [-1]
Next!"""

right()

"""

Line number 26




0.  (Ax'* : (x'! e x'* == N e x'*))

1.  (x'! e {x** | ~y*! e x**}
   -> N e {x** | ~y*! e x**})
----



0.  ~y*! e N

1.  ~y*! e x'!

by lines [-1]
Next!"""

right()

"""

Line number 27




0.  y*! e N

1.  (Ax'* : (x'! e x'* == N e x'*))

2.  (x'! e {x** | ~y*! e x**}
   -> N e {x** | ~y*! e x**})
----



0.  ~y*! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 28




0.  y*! e {@x | ~@x = @x}

1.  (Ax'* : (x'! e x'* == N e x'*))

2.  (x'! e {x** | ~y*! e x**}
   -> N e {x** | ~y*! e x**})
----



0.  ~y*! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 29




0.  ~y*! = y*!

1.  (Ax'* : (x'! e x'* == N e x'*))

2.  (x'! e {x** | ~y*! e x**}
   -> N e {x** | ~y*! e x**})
----



0.  ~y*! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 30




0.  (Ax'* : (x'! e x'* == N e x'*))

1.  (x'! e {x** | ~y*! e x**}
   -> N e {x** | ~y*! e x**})
----



0.  y*! = y*!

1.  ~y*! e x'!

by lines [-1]
Next!"""

done()

"""Done!"""

savetheorem('ZEN')
deft ("S", "{xEuEv&eua&~evu=x{wVewu=wv")
deff ("*I", "Ax>exae:axSa")
deft ("*N", "{nAi>&eZi:ai*Ieni")
start ("eZ*N")

"""

Line number 0



----



0.  Z e N*

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  Z e {@n | (A@i : ((Z e @i
   & I*(a:@i))
   -> @n e @i))}

by lines [-1]
Next!"""

right()

"""

Line number 2



----



0.  (A@i : ((Z e @i
   & I*(a:@i))
   -> Z e @i))

by lines [-1]
Next!"""

right()

"""

Line number 3



----



0.  ((Z e i'!
   & I*(a:i'!))
   -> Z e i'!)

by lines [-1]
Next!"""

right()

"""

Line number 4




0.  (Z e i'!
   & I*(a:i'!))
----



0.  Z e i'!

by lines [-1]
Next!"""

left()

"""

Line number 5




0.  Z e i'!

1.  I*(a:i'!)
----



0.  Z e i'!

by lines [-1]
Next!"""

done()

"""Done!"""

savetheorem('PEANO1')
start ("Ax>ex*Ne:axS*N")

"""

Line number 0



----



0.  (Ax : (x e N*
   -> S(a:x) e N*))

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  (x'! e N*
   -> S(a:x'!) e N*)

by lines [-1]
Next!"""

right()

"""

Line number 2




0.  x'! e N*
----



0.  S(a:x'!) e N*

by lines [-1]
Next!"""

right()

"""

Line number 3




0.  x'! e N*
----



0.  S(a:x'!)
   e {@n | (A@i : ((Z e @i
   & I*(a:@i))
   -> @n e @i))}

by lines [-1]
Next!"""

right()

"""

Line number 4




0.  x'! e N*
----



0.  (A@i : ((Z e @i
   & I*(a:@i))
   -> S(a:x'!) e @i))

by lines [-1]
Next!"""

right()

"""

Line number 5




0.  x'! e N*
----



0.  ((Z e i'!
   & I*(a:i'!))
   -> S(a:x'!) e i'!)

by lines [-1]
Next!"""

right()

"""

Line number 6




0.  (Z e i'!
   & I*(a:i'!))

1.  x'! e N*
----



0.  S(a:x'!) e i'!

by lines [-1]
Next!"""

left()

"""

Line number 7




0.  Z e i'!

1.  I*(a:i'!)

2.  x'! e N*
----



0.  S(a:x'!) e i'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 7




0.  x'! e N*

1.  Z e i'!

2.  I*(a:i'!)
----



0.  S(a:x'!) e i'!

by lines [-1]
Next!"""

left()

"""

Line number 8




0.  x'! e {@n | (A@i : ((Z e @i
   & I*(a:@i))
   -> @n e @i))}

1.  Z e i'!

2.  I*(a:i'!)
----



0.  S(a:x'!) e i'!

by lines [-1]
Next!"""

left()

"""

Line number 9




0.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

1.  Z e i'!

2.  I*(a:i'!)
----



0.  S(a:x'!) e i'!

by lines [-1]
Next!"""

left()

"""

Line number 10




0.  ((Z e i*?
   & I*(a:i*?))
   -> x'! e i*?)

1.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

2.  Z e i'!

3.  I*(a:i'!)
----



0.  S(a:x'!) e i'!

by lines [-1]
Next!"""

left()

"""

Line number 11




0.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

1.  Z e i'!

2.  I*(a:i'!)
----



0.  (Z e i*?
   & I*(a:i*?))

1.  S(a:x'!) e i'!

by lines [-1]
Next!"""

right()

"""

Line number 13




0.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

1.  Z e i'!

2.  I*(a:i'!)
----



0.  Z e i*?

1.  S(a:x'!) e i'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 13




0.  Z e i'!

1.  I*(a:i'!)

2.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))
----



0.  Z e i*?

1.  S(a:x'!) e i'!

by lines [-1]
Next!"""

done()

"""

Line number 14




0.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

1.  Z e i'!

2.  I*(a:i'!)
----



0.  I*(a:i'!)

1.  S(a:x'!) e i'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 14




0.  I*(a:i'!)

1.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

2.  Z e i'!
----



0.  I*(a:i'!)

1.  S(a:x'!) e i'!

by lines [-1]
Next!"""

done()

"""

Line number 12




0.  x'! e i'!

1.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

2.  Z e i'!

3.  I*(a:i'!)
----



0.  S(a:x'!) e i'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 12




0.  I*(a:i'!)

1.  x'! e i'!

2.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

3.  Z e i'!
----



0.  S(a:x'!) e i'!

by lines [-1]
Next!"""

left()

"""

Line number 15




0.  (A@x : (@x e i'!
   -> S(a:@x) e i'!))

1.  x'! e i'!

2.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

3.  Z e i'!
----



0.  S(a:x'!) e i'!

by lines [-1]
Next!"""

left()

"""

Line number 16




0.  (x*? e i'!
   -> S(a:x*?) e i'!)

1.  (A@x : (@x e i'!
   -> S(a:@x) e i'!))

2.  x'! e i'!

3.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

4.  Z e i'!
----



0.  S(a:x'!) e i'!

by lines [-1]
Next!"""

left()

"""

Line number 17




0.  (A@x : (@x e i'!
   -> S(a:@x) e i'!))

1.  x'! e i'!

2.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

3.  Z e i'!
----



0.  x*? e i'!

1.  S(a:x'!) e i'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 17




0.  x'! e i'!

1.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

2.  Z e i'!

3.  (A@x : (@x e i'!
   -> S(a:@x) e i'!))
----



0.  x*? e i'!

1.  S(a:x'!) e i'!

by lines [-1]
Next!"""

done()

"""

Line number 18




0.  S(a:x'!) e i'!

1.  (A@x : (@x e i'!
   -> S(a:@x) e i'!))

2.  x'! e i'!

3.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

4.  Z e i'!
----



0.  S(a:x'!) e i'!

by lines [-1]
Next!"""

done()

"""Done!"""

savetheorem('PEANO2')
start ("Aa>(& eZa :aa*I)(Ax > ex*N exa)")

"""

Line number 0



----



0.  (Aa : ((Z e a
   & I*(a:a))
   -> (Ax : (x e N* -> x e a))))

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  ((Z e a'!
   & I*(a:a'!))
   -> (Ax : (x e N* -> x e a'!)))

by lines [-1]
Next!"""

right()

"""

Line number 2




0.  (Z e a'!
   & I*(a:a'!))
----



0.  (Ax : (x e N* -> x e a'!))

by lines [-1]
Next!"""

right()

"""

Line number 3




0.  (Z e a'!
   & I*(a:a'!))
----



0.  (x'! e N* -> x'! e a'!)

by lines [-1]
Next!"""

right()

"""

Line number 4




0.  x'! e N*

1.  (Z e a'!
   & I*(a:a'!))
----



0.  x'! e a'!

by lines [-1]
Next!"""

left()

"""

Line number 5




0.  x'! e {@n | (A@i : ((Z e @i
   & I*(a:@i))
   -> @n e @i))}

1.  (Z e a'!
   & I*(a:a'!))
----



0.  x'! e a'!

by lines [-1]
Next!"""

left()

"""

Line number 6




0.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

1.  (Z e a'!
   & I*(a:a'!))
----



0.  x'! e a'!

by lines [-1]
Next!"""

left()

"""

Line number 7




0.  ((Z e i'?
   & I*(a:i'?))
   -> x'! e i'?)

1.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

2.  (Z e a'!
   & I*(a:a'!))
----



0.  x'! e a'!

by lines [-1]
Next!"""

left()

"""

Line number 8




0.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

1.  (Z e a'!
   & I*(a:a'!))
----



0.  (Z e i'?
   & I*(a:i'?))

1.  x'! e a'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 8




0.  (Z e a'!
   & I*(a:a'!))

1.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))
----



0.  (Z e i'?
   & I*(a:i'?))

1.  x'! e a'!

by lines [-1]
Next!"""

left()

"""

Line number 10




0.  Z e a'!

1.  I*(a:a'!)

2.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))
----



0.  (Z e i'?
   & I*(a:i'?))

1.  x'! e a'!

by lines [-1]
Next!"""

right()

"""

Line number 11




0.  Z e a'!

1.  I*(a:a'!)

2.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))
----



0.  Z e i'?

1.  x'! e a'!

by lines [-1]
Next!"""

done()

"""

Line number 12




0.  Z e a'!

1.  I*(a:a'!)

2.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))
----



0.  I*(a:a'!)

1.  x'! e a'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 12




0.  I*(a:a'!)

1.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

2.  Z e a'!
----



0.  I*(a:a'!)

1.  x'! e a'!

by lines [-1]
Next!"""

done()

"""

Line number 9




0.  x'! e a'!

1.  (A@i : ((Z e @i
   & I*(a:@i))
   -> x'! e @i))

2.  (Z e a'!
   & I*(a:a'!))
----



0.  x'! e a'!

by lines [-1]
Next!"""

done()

"""Done!"""

savetheorem('INDUCTION')
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




0.  (Ax* : (Z e x*
   == S(a:x'!) e x*))
----



by lines [-1]
Next!"""

left()

"""

Line number 4




0.  (Z e x''?
   == S(a:x'!) e x''?)

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))
----



by lines [-1]
Next!"""

setunknown ("x''","{uAx>exuEyeyx")

"""

Line number 4




0.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   == S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))
----



by lines [-1]
Next!"""

left()

"""

Line number 5




0.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

1.  (S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> Z e {u | (Ax : (x e u -> (Ey : y e x)))})

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))
----



by lines [-1]
Next!"""

getleft(1)

"""

Line number 5




0.  (S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> Z e {u | (Ax : (x e u -> (Ey : y e x)))})

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 6




0.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

1.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))}

by lines [-1]
Next!"""

right()

"""

Line number 8




0.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

1.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  (Ax : (x e S(a:x'!)
   -> (Ey : y e x)))

by lines [-1]
Next!"""

right()

"""

Line number 9




0.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

1.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  (x'*! e S(a:x'!)
   -> (Ey : y e x'*!))

by lines [-1]
Next!"""

right()

"""

Line number 10




0.  x'*! e S(a:x'!)

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  (Ey : y e x'*!)

by lines [-1]
Next!"""

left()

"""

Line number 11




0.  x'*! e {@x | (E@u : (E@v : (@u e x'!
   & (~@v e @u
   & @x = {@w | (@w e @u V @w = @v)}))))}

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  (Ey : y e x'*!)

by lines [-1]
Next!"""

left()

"""

Line number 12




0.  (E@u : (E@v : (@u e x'!
   & (~@v e @u
   & x'*! = {@w | (@w e @u V @w = @v)}))))

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  (Ey : y e x'*!)

by lines [-1]
Next!"""

left()

"""

Line number 13




0.  (E@v : (u'! e x'!
   & (~@v e u'!
   & x'*! = {@w | (@w e u'! V @w = @v)})))

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  (Ey : y e x'*!)

by lines [-1]
Next!"""

left()

"""

Line number 14




0.  (u'! e x'!
   & (~v'! e u'!
   & x'*! = {@w | (@w e u'! V @w = v'!)}))

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  (Ey : y e x'*!)

by lines [-1]
Next!"""

right()

"""

Line number 15




0.  (u'! e x'!
   & (~v'! e u'!
   & x'*! = {@w | (@w e u'! V @w = v'!)}))

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  y'? e x'*!

1.  (Ey : y e x'*!)

by lines [-1]
Next!"""

setunknown ("y'","v")

"""

Line number 15




0.  (u'! e x'!
   & (~v'! e u'!
   & x'*! = {@w | (@w e u'! V @w = v'!)}))

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  v e x'*!

1.  (Ey : y e x'*!)

by lines [-1]
Next!"""

left()

"""

Line number 16




0.  u'! e x'!

1.  (~v'! e u'!
   & x'*! = {@w | (@w e u'! V @w = v'!)})

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

3.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  v e x'*!

1.  (Ey : y e x'*!)

by lines [-1]
Next!"""

getleft(1)

"""

Line number 16




0.  (~v'! e u'!
   & x'*! = {@w | (@w e u'! V @w = v'!)})

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

3.  u'! e x'!
----



0.  v e x'*!

1.  (Ey : y e x'*!)

by lines [-1]
Next!"""

left()

"""

Line number 17




0.  ~v'! e u'!

1.  x'*! = {@w | (@w e u'! V @w = v'!)}

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

3.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

4.  u'! e x'!
----



0.  v e x'*!

1.  (Ey : y e x'*!)

by lines [-1]
Next!"""

getleft(1)

"""

Line number 17




0.  x'*! = {@w | (@w e u'! V @w = v'!)}

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

3.  u'! e x'!

4.  ~v'! e u'!
----



0.  v e x'*!

1.  (Ey : y e x'*!)

by lines [-1]
Next!"""

varelim()

"""

Line number 18




0.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

1.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

2.  u'! e x'!

3.  ~v'! e u'!
----



0.  v e {@w | (@w e u'! V @w = v'!)}

1.  (Ey : y e {@w | (@w e u'! V @w = v'!)})

by lines [-1]
Next!"""

right()

"""

Line number 19




0.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

1.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

2.  u'! e x'!

3.  ~v'! e u'!
----



0.  (v e u'! V v = v'!)

1.  (Ey : y e {@w | (@w e u'! V @w = v'!)})

by lines [-1]
Next!"""

right()

"""

Line number 20




0.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

1.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

2.  u'! e x'!

3.  ~v'! e u'!
----



0.  v e u'!

1.  v = v'!

2.  (Ey : y e {@w | (@w e u'! V @w = v'!)})

by lines [-1]
Next!"""

back()
back()
back()
back()
back()
back()
back()
back()
back()
setunknown ("y'","'v")

"""

Line number 15




0.  (u'! e x'!
   & (~v'! e u'!
   & x'*! = {@w | (@w e u'! V @w = v'!)}))

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  v'! e x'*!

1.  (Ey : y e x'*!)

by lines [-1]
Next!"""

left()

"""

Line number 16




0.  u'! e x'!

1.  (~v'! e u'!
   & x'*! = {@w | (@w e u'! V @w = v'!)})

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

3.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  v'! e x'*!

1.  (Ey : y e x'*!)

by lines [-1]
Next!"""

getleft(1)

"""

Line number 16




0.  (~v'! e u'!
   & x'*! = {@w | (@w e u'! V @w = v'!)})

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

3.  u'! e x'!
----



0.  v'! e x'*!

1.  (Ey : y e x'*!)

by lines [-1]
Next!"""

left()

"""

Line number 17




0.  ~v'! e u'!

1.  x'*! = {@w | (@w e u'! V @w = v'!)}

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

3.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

4.  u'! e x'!
----



0.  v'! e x'*!

1.  (Ey : y e x'*!)

by lines [-1]
Next!"""

getleft(1)

"""

Line number 17




0.  x'*! = {@w | (@w e u'! V @w = v'!)}

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

3.  u'! e x'!

4.  ~v'! e u'!
----



0.  v'! e x'*!

1.  (Ey : y e x'*!)

by lines [-1]
Next!"""

varelim()

"""

Line number 18




0.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

1.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

2.  u'! e x'!

3.  ~v'! e u'!
----



0.  v'! e {@w | (@w e u'! V @w = v'!)}

1.  (Ey : y e {@w | (@w e u'! V @w = v'!)})

by lines [-1]
Next!"""

right()

"""

Line number 19




0.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

1.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

2.  u'! e x'!

3.  ~v'! e u'!
----



0.  (v'! e u'! V v'! = v'!)

1.  (Ey : y e {@w | (@w e u'! V @w = v'!)})

by lines [-1]
Next!"""

right()

"""

Line number 20




0.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

1.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

2.  u'! e x'!

3.  ~v'! e u'!
----



0.  v'! e u'!

1.  v'! = v'!

2.  (Ey : y e {@w | (@w e u'! V @w = v'!)})

by lines [-1]
Next!"""

getleft(1)

"""

Line number 20




0.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

1.  u'! e x'!

2.  ~v'! e u'!

3.  (Ax* : (Z e x*
   == S(a:x'!) e x*))
----



0.  v'! e u'!

1.  v'! = v'!

2.  (Ey : y e {@w | (@w e u'! V @w = v'!)})

by lines [-1]
Next!"""

getright(1)

"""

Line number 20




0.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})

1.  u'! e x'!

2.  ~v'! e u'!

3.  (Ax* : (Z e x*
   == S(a:x'!) e x*))
----



0.  v'! = v'!

1.  (Ey : y e {@w | (@w e u'! V @w = v'!)})

2.  v'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 7




0.  Z e {u | (Ax : (x e u -> (Ey : y e x)))}

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 21




0.  (Ax : (x e Z -> (Ey : y e x)))

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 22




0.  (x*'? e Z -> (Ey : y e x*'?))

1.  (Ax : (x e Z -> (Ey : y e x)))

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

3.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 23




0.  (Ax : (x e Z -> (Ey : y e x)))

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  x*'? e Z

by lines [-1]
Next!"""

right()

"""

Line number 25




0.  (Ax : (x e Z -> (Ey : y e x)))

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  x*'? e {@x | (A@y : ~@y e @x)}

by lines [-1]
Next!"""

right()

"""

Line number 26




0.  (Ax : (x e Z -> (Ey : y e x)))

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  (A@y : ~@y e x*'?)

by lines [-1]
Next!"""

right()

"""

Line number 27




0.  (Ax : (x e Z -> (Ey : y e x)))

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  ~y*! e x*'?

by lines [-1]
Next!"""

right()

"""

Line number 28




0.  y*! e x*'?

1.  (Ax : (x e Z -> (Ey : y e x)))

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

3.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



by lines [-1]
Next!"""

setunknown ("x*'","N")

"""

Line number 28




0.  y*! e N

1.  (Ax : (x e Z -> (Ey : y e x)))

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

3.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 29




0.  y*! e {@x | ~@x = @x}

1.  (Ax : (x e Z -> (Ey : y e x)))

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

3.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 30




0.  ~y*! = y*!

1.  (Ax : (x e Z -> (Ey : y e x)))

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

3.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 31




0.  (Ax : (x e Z -> (Ey : y e x)))

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  y*! = y*!

by lines [-1]
Next!"""

done()

"""

Line number 24




0.  (Ey : y e N)

1.  (Ax : (x e Z -> (Ey : y e x)))

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

3.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 32




0.  y''! e N

1.  (Ax : (x e Z -> (Ey : y e x)))

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

3.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 33




0.  y''! e {@x | ~@x = @x}

1.  (Ax : (x e Z -> (Ey : y e x)))

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

3.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 34




0.  ~y''! = y''!

1.  (Ax : (x e Z -> (Ey : y e x)))

2.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

3.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



by lines [-1]
Next!"""

left()

"""

Line number 35




0.  (Ax : (x e Z -> (Ey : y e x)))

1.  (Ax* : (Z e x*
   == S(a:x'!) e x*))

2.  (Z e {u | (Ax : (x e u -> (Ey : y e x)))}
   -> S(a:x'!)
   e {u | (Ax : (x e u -> (Ey : y e x)))})
----



0.  y''! = y''!

by lines [-1]
Next!"""

done()

"""Done!"""

savetheorem('PEANO3')
