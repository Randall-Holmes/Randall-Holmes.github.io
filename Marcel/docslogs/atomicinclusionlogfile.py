from graph import *

deff ("C", "Ax>exaexb")
deft ("I", "{x=xa")
start ("AxAyX:a:axI:byCexy")

"""

Line number 0



----



0.  (Ax : (Ay : ((I(a:x) C y) == x e y)))

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  (Ay : ((I(a:x'!) C y) == x'! e y))

by lines [-1]
Next!"""

right()

"""

Line number 2



----



0.  ((I(a:x'!) C y'!) == x'! e y'!)

by lines [-1]
Next!"""

right()

"""

Line number 3




0.  (I(a:x'!) C y'!)
----



0.  x'! e y'!

by lines [-1]
Next!"""

left()

"""

Line number 5




0.  (A@x : (@x e I(a:x'!) -> @x e y'!))
----



0.  x'! e y'!

by lines [-1]
Next!"""

left()

"""

Line number 6




0.  (x*? e I(a:x'!) -> x*? e y'!)

1.  (A@x : (@x e I(a:x'!) -> @x e y'!))
----



0.  x'! e y'!

by lines [-1]
Next!"""

left()

"""

Line number 7




0.  (A@x : (@x e I(a:x'!) -> @x e y'!))
----



0.  x*? e I(a:x'!)

1.  x'! e y'!

by lines [-1]
Next!"""

right()

"""

Line number 9




0.  (A@x : (@x e I(a:x'!) -> @x e y'!))
----



0.  x*? e {@x | @x = x'!}

1.  x'! e y'!

by lines [-1]
Next!"""

right()

"""

Line number 10




0.  (A@x : (@x e I(a:x'!) -> @x e y'!))
----



0.  x*? = x'!

1.  x'! e y'!

by lines [-1]
Next!"""

right()

"""

Line number 11




0.  (A@x : (@x e I(a:x'!) -> @x e y'!))
----



0.  (Ax'' : (x'' e x*? == x'' e x'!))

1.  x'! e y'!

by lines [-1]
Next!"""

right()

"""

Line number 12




0.  (A@x : (@x e I(a:x'!) -> @x e y'!))
----



0.  (x'*! e x*? == x'*! e x'!)

1.  x'! e y'!

by lines [-1]
Next!"""

right()

"""

Line number 13




0.  x'*! e x*?

1.  (A@x : (@x e I(a:x'!) -> @x e y'!))
----



0.  x'*! e x'!

1.  x'! e y'!

by lines [-1]
Next!"""

done()

"""

Line number 14




0.  x'*! e x'!

1.  (A@x : (@x e I(a:x'!) -> @x e y'!))
----



0.  x'*! e x'!

1.  x'! e y'!

by lines [-1]
Next!"""

done()

"""

Line number 8




0.  x'! e y'!

1.  (A@x : (@x e I(a:x'!) -> @x e y'!))
----



0.  x'! e y'!

by lines [-1]
Next!"""

done()

"""

Line number 4




0.  x'! e y'!
----



0.  (I(a:x'!) C y'!)

by lines [-1]
Next!"""

right()

"""

Line number 15




0.  x'! e y'!
----



0.  (A@x : (@x e I(a:x'!) -> @x e y'!))

by lines [-1]
Next!"""

right()

"""

Line number 16




0.  x'! e y'!
----



0.  (x*'! e I(a:x'!) -> x*'! e y'!)

by lines [-1]
Next!"""

right()

"""

Line number 17




0.  x*'! e I(a:x'!)

1.  x'! e y'!
----



0.  x*'! e y'!

by lines [-1]
Next!"""

left()

"""

Line number 18




0.  x*'! e {@x | @x = x'!}

1.  x'! e y'!
----



0.  x*'! e y'!

by lines [-1]
Next!"""

left()

"""

Line number 19




0.  x*'! = x'!

1.  x'! e y'!
----



0.  x*'! e y'!

by lines [-1]
Next!"""

left()

"""

Line number 20




0.  (Ax** : (x*'! e x** == x'! e x**))

1.  x'! e y'!
----



0.  x*'! e y'!

by lines [-1]
Next!"""

left()

"""

Line number 21




0.  (x*'! e x'''? == x'! e x'''?)

1.  (Ax** : (x*'! e x** == x'! e x**))

2.  x'! e y'!
----



0.  x*'! e y'!

by lines [-1]
Next!"""

left()

"""

Line number 22




0.  (x*'! e x'''? -> x'! e x'''?)

1.  (x'! e x'''? -> x*'! e x'''?)

2.  (Ax** : (x*'! e x** == x'! e x**))

3.  x'! e y'!
----



0.  x*'! e y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 22




0.  (x'! e x'''? -> x*'! e x'''?)

1.  (Ax** : (x*'! e x** == x'! e x**))

2.  x'! e y'!

3.  (x*'! e x'''? -> x'! e x'''?)
----



0.  x*'! e y'!

by lines [-1]
Next!"""

left()

"""

Line number 23




0.  (Ax** : (x*'! e x** == x'! e x**))

1.  x'! e y'!

2.  (x*'! e x'''? -> x'! e x'''?)
----



0.  x'! e x'''?

1.  x*'! e y'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 23




0.  x'! e y'!

1.  (x*'! e x'''? -> x'! e x'''?)

2.  (Ax** : (x*'! e x** == x'! e x**))
----



0.  x'! e x'''?

1.  x*'! e y'!

by lines [-1]
Next!"""

done()

"""

Line number 24




0.  x*'! e y'!

1.  (Ax** : (x*'! e x** == x'! e x**))

2.  x'! e y'!

3.  (x*'! e y'! -> x'! e y'!)
----



0.  x*'! e y'!

by lines [-1]
Next!"""

done()

"""Done!"""

