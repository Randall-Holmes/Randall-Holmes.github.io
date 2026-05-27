from graph2 import *

start ("AxAyAz>&=xy=yz=xz")

"""

Line number 0



----



0.  (Ax : (Ay : (Az : ((x = y & y = z) -> x = z))))

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  (Ay : (Az : ((x'! = y & y = z) -> x'! = z)))

by lines [-1]
Next!"""

right()

"""

Line number 2



----



0.  (Az : ((x'! = y'! & y'! = z) -> x'! = z))

by lines [-1]
Next!"""

right()

"""

Line number 3



----



0.  ((x'! = y'! & y'! = z'!) -> x'! = z'!)

by lines [-1]
Next!"""

right()

"""

Line number 4




0.  (x'! = y'! & y'! = z'!)
----



0.  x'! = z'!

by lines [-1]
Next!"""

right()

"""

Line number 5




0.  (x'! = y'! & y'! = z'!)
----



0.  (Ax* : (x* e x'! == x* e z'!))

by lines [-1]
Next!"""

right()

"""

Line number 6




0.  (x'! = y'! & y'! = z'!)
----



0.  (x''! e x'! == x''! e z'!)

by lines [-1]
Next!"""

right()

"""

Line number 7




0.  x''! e x'!

1.  (x'! = y'! & y'! = z'!)
----



0.  x''! e z'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 7




0.  (x'! = y'! & y'! = z'!)

1.  x''! e x'!
----



0.  x''! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 9




0.  x'! = y'!

1.  y'! = z'!

2.  x''! e x'!
----



0.  x''! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 10




0.  (Ax'* : (x'! e x'* == y'! e x'*))

1.  y'! = z'!

2.  x''! e x'!
----



0.  x''! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 11




0.  (x'! e x*'? == y'! e x*'?)

1.  (Ax'* : (x'! e x'* == y'! e x'*))

2.  y'! = z'!

3.  x''! e x'!
----



0.  x''! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 12




0.  (x'! e x*'? -> y'! e x*'?)

1.  (y'! e x*'? -> x'! e x*'?)

2.  (Ax'* : (x'! e x'* == y'! e x'*))

3.  y'! = z'!

4.  x''! e x'!
----



0.  x''! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 13




0.  (y'! e x*'? -> x'! e x*'?)

1.  (Ax'* : (x'! e x'* == y'! e x'*))

2.  y'! = z'!

3.  x''! e x'!
----



0.  x'! e x*'?

1.  x''! e z'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 13




0.  x''! e x'!

1.  (y'! e x*'? -> x'! e x*'?)

2.  (Ax'* : (x'! e x'* == y'! e x'*))

3.  y'! = z'!
----



0.  x'! e x*'?

1.  x''! e z'!

by lines [-1]
Next!"""

done()

"""

Line number 14




0.  y'! e {x** | x''! e x**}

1.  (y'! e {x** | x''! e x**} -> x'! e {x** | x''! e x**})

2.  (Ax'* : (x'! e x'* == y'! e x'*))

3.  y'! = z'!

4.  x''! e x'!
----



0.  x''! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 15




0.  x''! e y'!

1.  (y'! e {x** | x''! e x**} -> x'! e {x** | x''! e x**})

2.  (Ax'* : (x'! e x'* == y'! e x'*))

3.  y'! = z'!

4.  x''! e x'!
----



0.  x''! e z'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 15




0.  y'! = z'!

1.  x''! e x'!

2.  x''! e y'!

3.  (y'! e {x** | x''! e x**} -> x'! e {x** | x''! e x**})

4.  (Ax'* : (x'! e x'* == y'! e x'*))
----



0.  x''! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 16




0.  (Ax** : (y'! e x** == z'! e x**))

1.  x''! e x'!

2.  x''! e y'!

3.  (y'! e {x** | x''! e x**} -> x'! e {x** | x''! e x**})

4.  (Ax'* : (x'! e x'* == y'! e x'*))
----



0.  x''! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 17




0.  (y'! e x'''? == z'! e x'''?)

1.  (Ax** : (y'! e x** == z'! e x**))

2.  x''! e x'!

3.  x''! e y'!

4.  (y'! e {x** | x''! e x**} -> x'! e {x** | x''! e x**})

5.  (Ax'* : (x'! e x'* == y'! e x'*))
----



0.  x''! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 18




0.  (y'! e x'''? -> z'! e x'''?)

1.  (z'! e x'''? -> y'! e x'''?)

2.  (Ax** : (y'! e x** == z'! e x**))

3.  x''! e x'!

4.  x''! e y'!

5.  (y'! e {x** | x''! e x**} -> x'! e {x** | x''! e x**})

6.  (Ax'* : (x'! e x'* == y'! e x'*))
----



0.  x''! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 19




0.  (z'! e x'''? -> y'! e x'''?)

1.  (Ax** : (y'! e x** == z'! e x**))

2.  x''! e x'!

3.  x''! e y'!

4.  (y'! e {x** | x''! e x**} -> x'! e {x** | x''! e x**})

5.  (Ax'* : (x'! e x'* == y'! e x'*))
----



0.  y'! e x'''?

1.  x''! e z'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 19




0.  x''! e y'!

1.  (y'! e {x** | x''! e x**} -> x'! e {x** | x''! e x**})

2.  (Ax'* : (x'! e x'* == y'! e x'*))

3.  (z'! e x'''? -> y'! e x'''?)

4.  (Ax** : (y'! e x** == z'! e x**))

5.  x''! e x'!
----



0.  y'! e x'''?

1.  x''! e z'!

by lines [-1]
Next!"""

done()

"""

Line number 20




0.  z'! e {x''* | x''! e x''*}

1.  (z'! e {x''* | x''! e x''*} -> y'! e {x''* | x''! e x''*})

2.  (Ax** : (y'! e x** == z'! e x**))

3.  x''! e x'!

4.  x''! e y'!

5.  (y'! e {x** | x''! e x**} -> x'! e {x** | x''! e x**})

6.  (Ax'* : (x'! e x'* == y'! e x'*))
----



0.  x''! e z'!

by lines [-1]
Next!"""

left()

"""

Line number 21




0.  x''! e z'!

1.  (z'! e {x''* | x''! e x''*} -> y'! e {x''* | x''! e x''*})

2.  (Ax** : (y'! e x** == z'! e x**))

3.  x''! e x'!

4.  x''! e y'!

5.  (y'! e {x** | x''! e x**} -> x'! e {x** | x''! e x**})

6.  (Ax'* : (x'! e x'* == y'! e x'*))
----



0.  x''! e z'!

by lines [-1]
Next!"""

done()

"""

Line number 8




0.  x''! e z'!

1.  (x'! = y'! & y'! = z'!)
----



0.  x''! e x'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 8




0.  (x'! = y'! & y'! = z'!)

1.  x''! e z'!
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 22




0.  x'! = y'!

1.  y'! = z'!

2.  x''! e z'!
----



0.  x''! e x'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 22




0.  y'! = z'!

1.  x''! e z'!

2.  x'! = y'!
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 23




0.  (Ax''* : (y'! e x''* == z'! e x''*))

1.  x''! e z'!

2.  x'! = y'!
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 24




0.  (y'! e x'*'? == z'! e x'*'?)

1.  (Ax''* : (y'! e x''* == z'! e x''*))

2.  x''! e z'!

3.  x'! = y'!
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 25




0.  (y'! e x'*'? -> z'! e x'*'?)

1.  (z'! e x'*'? -> y'! e x'*'?)

2.  (Ax''* : (y'! e x''* == z'! e x''*))

3.  x''! e z'!

4.  x'! = y'!
----



0.  x''! e x'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 25




0.  (z'! e x'*'? -> y'! e x'*'?)

1.  (Ax''* : (y'! e x''* == z'! e x''*))

2.  x''! e z'!

3.  x'! = y'!

4.  (y'! e x'*'? -> z'! e x'*'?)
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 26




0.  (Ax''* : (y'! e x''* == z'! e x''*))

1.  x''! e z'!

2.  x'! = y'!

3.  (y'! e x'*'? -> z'! e x'*'?)
----



0.  z'! e x'*'?

1.  x''! e x'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 26




0.  x''! e z'!

1.  x'! = y'!

2.  (y'! e x'*'? -> z'! e x'*'?)

3.  (Ax''* : (y'! e x''* == z'! e x''*))
----



0.  z'! e x'*'?

1.  x''! e x'!

by lines [-1]
Next!"""

done()

"""

Line number 27




0.  y'! e {x'** | x''! e x'**}

1.  (Ax''* : (y'! e x''* == z'! e x''*))

2.  x''! e z'!

3.  x'! = y'!

4.  (y'! e {x'** | x''! e x'**} -> z'! e {x'** | x''! e x'**})
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 28




0.  x''! e y'!

1.  (Ax''* : (y'! e x''* == z'! e x''*))

2.  x''! e z'!

3.  x'! = y'!

4.  (y'! e {x'** | x''! e x'**} -> z'! e {x'** | x''! e x'**})
----



0.  x''! e x'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 28




0.  x'! = y'!

1.  (y'! e {x'** | x''! e x'**} -> z'! e {x'** | x''! e x'**})

2.  x''! e y'!

3.  (Ax''* : (y'! e x''* == z'! e x''*))

4.  x''! e z'!
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 29




0.  (Ax'** : (x'! e x'** == y'! e x'**))

1.  (y'! e {x'** | x''! e x'**} -> z'! e {x'** | x''! e x'**})

2.  x''! e y'!

3.  (Ax''* : (y'! e x''* == z'! e x''*))

4.  x''! e z'!
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 30




0.  (x'! e x*''? == y'! e x*''?)

1.  (Ax'** : (x'! e x'** == y'! e x'**))

2.  (y'! e {x'** | x''! e x'**} -> z'! e {x'** | x''! e x'**})

3.  x''! e y'!

4.  (Ax''* : (y'! e x''* == z'! e x''*))

5.  x''! e z'!
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 31




0.  (x'! e x*''? -> y'! e x*''?)

1.  (y'! e x*''? -> x'! e x*''?)

2.  (Ax'** : (x'! e x'** == y'! e x'**))

3.  (y'! e {x'** | x''! e x'**} -> z'! e {x'** | x''! e x'**})

4.  x''! e y'!

5.  (Ax''* : (y'! e x''* == z'! e x''*))

6.  x''! e z'!
----



0.  x''! e x'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 31




0.  (y'! e x*''? -> x'! e x*''?)

1.  (Ax'** : (x'! e x'** == y'! e x'**))

2.  (y'! e {x'** | x''! e x'**} -> z'! e {x'** | x''! e x'**})

3.  x''! e y'!

4.  (Ax''* : (y'! e x''* == z'! e x''*))

5.  x''! e z'!

6.  (x'! e x*''? -> y'! e x*''?)
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 32




0.  (Ax'** : (x'! e x'** == y'! e x'**))

1.  (y'! e {x'** | x''! e x'**} -> z'! e {x'** | x''! e x'**})

2.  x''! e y'!

3.  (Ax''* : (y'! e x''* == z'! e x''*))

4.  x''! e z'!

5.  (x'! e x*''? -> y'! e x*''?)
----



0.  y'! e x*''?

1.  x''! e x'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 32




0.  x''! e y'!

1.  (Ax''* : (y'! e x''* == z'! e x''*))

2.  x''! e z'!

3.  (x'! e x*''? -> y'! e x*''?)

4.  (Ax'** : (x'! e x'** == y'! e x'**))

5.  (y'! e {x'** | x''! e x'**} -> z'! e {x'** | x''! e x'**})
----



0.  y'! e x*''?

1.  x''! e x'!

by lines [-1]
Next!"""

done()

"""

Line number 33




0.  x'! e {x*'* | x''! e x*'*}

1.  (Ax'** : (x'! e x'** == y'! e x'**))

2.  (y'! e {x'** | x''! e x'**} -> z'! e {x'** | x''! e x'**})

3.  x''! e y'!

4.  (Ax''* : (y'! e x''* == z'! e x''*))

5.  x''! e z'!

6.  (x'! e {x*'* | x''! e x*'*} -> y'! e {x*'* | x''! e x*'*})
----



0.  x''! e x'!

by lines [-1]
Next!"""

left()

"""

Line number 34




0.  x''! e x'!

1.  (Ax'** : (x'! e x'** == y'! e x'**))

2.  (y'! e {x'** | x''! e x'**} -> z'! e {x'** | x''! e x'**})

3.  x''! e y'!

4.  (Ax''* : (y'! e x''* == z'! e x''*))

5.  x''! e z'!

6.  (x'! e {x*'* | x''! e x*'*} -> y'! e {x*'* | x''! e x*'*})
----



0.  x''! e x'!

by lines [-1]
Next!"""

done()

"""Done!"""

