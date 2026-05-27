from graph2 import *

start ("AaAb>AxXexaexbAuXeauebu")

"""

Line number 0



----



0.  (Aa : (Ab : ((Ax : (x e a == x e b)) -> (Au : (a e u == b e u)))))

by lines [-1]
Next!"""

right()

"""

Line number 1



----



0.  (Ab : ((Ax : (x e a'! == x e b)) -> (Au : (a'! e u == b e u))))

by lines [-1]
Next!"""

right()

"""

Line number 2



----



0.  ((Ax : (x e a'! == x e b'!)) -> (Au : (a'! e u == b'! e u)))

by lines [-1]
Next!"""

right()

"""

Line number 3




0.  (Ax : (x e a'! == x e b'!))
----



0.  (Au : (a'! e u == b'! e u))

by lines [-1]
Next!"""

right()

"""

Line number 4




0.  (Ax : (x e a'! == x e b'!))
----



0.  (a'! e u'! == b'! e u'!)

by lines [-1]
Next!"""

right()

"""

Line number 5




0.  a'! e u'!

1.  (Ax : (x e a'! == x e b'!))
----



0.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 7




0.  (Ax' : ((Ax* : (x* e a'! == x* e x')) -> x' e u'!))

1.  (Ax : (x e a'! == x e b'!))
----



0.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 8




0.  ((Ax* : (x* e a'! == x* e x''?)) -> x''? e u'!)

1.  (Ax' : ((Ax* : (x* e a'! == x* e x')) -> x' e u'!))

2.  (Ax : (x e a'! == x e b'!))
----



0.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 9




0.  (Ax' : ((Ax* : (x* e a'! == x* e x')) -> x' e u'!))

1.  (Ax : (x e a'! == x e b'!))
----



0.  (Ax* : (x* e a'! == x* e x''?))

1.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 11




0.  ((Ax* : (x* e a'! == x* e x'*?)) -> x'*? e u'!)

1.  (Ax' : ((Ax* : (x* e a'! == x* e x')) -> x' e u'!))

2.  (Ax : (x e a'! == x e b'!))
----



0.  (Ax* : (x* e a'! == x* e x''?))

1.  b'! e u'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 11




0.  (Ax : (x e a'! == x e b'!))

1.  ((Ax* : (x* e a'! == x* e x'*?)) -> x'*? e u'!)

2.  (Ax' : ((Ax* : (x* e a'! == x* e x')) -> x' e u'!))
----



0.  (Ax* : (x* e a'! == x* e x''?))

1.  b'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 10




0.  b'! e u'!

1.  (Ax' : ((Ax* : (x* e a'! == x* e x')) -> x' e u'!))

2.  (Ax : (x e a'! == x e b'!))
----



0.  b'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 6




0.  b'! e u'!

1.  (Ax : (x e a'! == x e b'!))
----



0.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 12




0.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

1.  (Ax : (x e a'! == x e b'!))
----



0.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 13




0.  ((Ax''' : (x''' e b'! == x''' e x''*?)) -> x''*? e u'!)

1.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

2.  (Ax : (x e a'! == x e b'!))
----



0.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 14




0.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

1.  (Ax : (x e a'! == x e b'!))
----



0.  (Ax''' : (x''' e b'! == x''' e x''*?))

1.  a'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 14




0.  (Ax : (x e a'! == x e b'!))

1.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  (Ax''' : (x''' e b'! == x''' e x''*?))

1.  a'! e u'!

by lines [-1]
Next!"""

right()

"""

Line number 16




0.  (Ax : (x e a'! == x e b'!))

1.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  (x'**! e b'! == x'**! e x''*?)

1.  a'! e u'!

by lines [-1]
Next!"""

right()

"""

Line number 17




0.  x'**! e b'!

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  x'**! e x''*?

1.  a'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 18




0.  x'**! e b'!

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  x'**! e b'!

1.  a'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 15




0.  b'! e u'!

1.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

2.  (Ax : (x e a'! == x e b'!))
----



0.  a'! e u'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 15




0.  (Ax : (x e a'! == x e b'!))

1.  b'! e u'!

2.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 19




0.  (x*''? e a'! == x*''? e b'!)

1.  (Ax : (x e a'! == x e b'!))

2.  b'! e u'!

3.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 20




0.  (x*''? e a'! -> x*''? e b'!)

1.  (x*''? e b'! -> x*''? e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  b'! e u'!

4.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  a'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 20




0.  (x*''? e b'! -> x*''? e a'!)

1.  (Ax : (x e a'! == x e b'!))

2.  b'! e u'!

3.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

4.  (x*''? e a'! -> x*''? e b'!)
----



0.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 21




0.  (Ax : (x e a'! == x e b'!))

1.  b'! e u'!

2.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

3.  (x*''? e a'! -> x*''? e b'!)
----



0.  x*''? e b'!

1.  a'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 21




0.  b'! e u'!

1.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

2.  (x*''? e a'! -> x*''? e b'!)

3.  (Ax : (x e a'! == x e b'!))
----



0.  x*''? e b'!

1.  a'! e u'!

by lines [-1]
Next!"""

back()
back()
back()
back()
back()
back()
getleft(2)

"""

Line number 15




0.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

1.  (Ax : (x e a'! == x e b'!))

2.  b'! e u'!
----



0.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 19




0.  ((Ax''' : (x''' e b'! == x''' e x*''?)) -> x*''? e u'!)

1.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

2.  (Ax : (x e a'! == x e b'!))

3.  b'! e u'!
----



0.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 20




0.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

1.  (Ax : (x e a'! == x e b'!))

2.  b'! e u'!
----



0.  (Ax''' : (x''' e b'! == x''' e x*''?))

1.  a'! e u'!

by lines [-1]
Next!"""

right()

"""

Line number 22




0.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

1.  (Ax : (x e a'! == x e b'!))

2.  b'! e u'!
----



0.  (x*'*! e b'! == x*'*! e x*''?)

1.  a'! e u'!

by lines [-1]
Next!"""

right()

"""

Line number 23




0.  x*'*! e b'!

1.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

2.  (Ax : (x e a'! == x e b'!))

3.  b'! e u'!
----



0.  x*'*! e x*''?

1.  a'! e u'!

by lines [-1]
Next!"""

setunknown ("x*''","'a")

"""

Line number 23




0.  x*'*! e b'!

1.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

2.  (Ax : (x e a'! == x e b'!))

3.  b'! e u'!
----



0.  x*'*! e a'!

1.  a'! e u'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 23




0.  (Ax : (x e a'! == x e b'!))

1.  b'! e u'!

2.  x*'*! e b'!

3.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  x*'*! e a'!

1.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 25




0.  (x**'? e a'! == x**'? e b'!)

1.  (Ax : (x e a'! == x e b'!))

2.  b'! e u'!

3.  x*'*! e b'!

4.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  x*'*! e a'!

1.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 26




0.  (x**'? e a'! -> x**'? e b'!)

1.  (x**'? e b'! -> x**'? e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  b'! e u'!

4.  x*'*! e b'!

5.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  x*'*! e a'!

1.  a'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 26




0.  (x**'? e b'! -> x**'? e a'!)

1.  (Ax : (x e a'! == x e b'!))

2.  b'! e u'!

3.  x*'*! e b'!

4.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

5.  (x**'? e a'! -> x**'? e b'!)
----



0.  x*'*! e a'!

1.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 27




0.  (Ax : (x e a'! == x e b'!))

1.  b'! e u'!

2.  x*'*! e b'!

3.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

4.  (x**'? e a'! -> x**'? e b'!)
----



0.  x**'? e b'!

1.  x*'*! e a'!

2.  a'! e u'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 27




0.  x*'*! e b'!

1.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

2.  (x**'? e a'! -> x**'? e b'!)

3.  (Ax : (x e a'! == x e b'!))

4.  b'! e u'!
----



0.  x**'? e b'!

1.  x*'*! e a'!

2.  a'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 28




0.  x*'*! e a'!

1.  (Ax : (x e a'! == x e b'!))

2.  b'! e u'!

3.  x*'*! e b'!

4.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

5.  (x*'*! e a'! -> x*'*! e b'!)
----



0.  x*'*! e a'!

1.  a'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 24




0.  x*'*! e a'!

1.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

2.  (Ax : (x e a'! == x e b'!))

3.  b'! e u'!
----



0.  x*'*! e b'!

1.  a'! e u'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 24




0.  (Ax : (x e a'! == x e b'!))

1.  b'! e u'!

2.  x*'*! e a'!

3.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  x*'*! e b'!

1.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 29




0.  (x***? e a'! == x***? e b'!)

1.  (Ax : (x e a'! == x e b'!))

2.  b'! e u'!

3.  x*'*! e a'!

4.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  x*'*! e b'!

1.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 30




0.  (x***? e a'! -> x***? e b'!)

1.  (x***? e b'! -> x***? e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  b'! e u'!

4.  x*'*! e a'!

5.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  x*'*! e b'!

1.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 31




0.  (x***? e b'! -> x***? e a'!)

1.  (Ax : (x e a'! == x e b'!))

2.  b'! e u'!

3.  x*'*! e a'!

4.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  x***? e a'!

1.  x*'*! e b'!

2.  a'! e u'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 31




0.  x*'*! e a'!

1.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

2.  (x***? e b'! -> x***? e a'!)

3.  (Ax : (x e a'! == x e b'!))

4.  b'! e u'!
----



0.  x***? e a'!

1.  x*'*! e b'!

2.  a'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 32




0.  x*'*! e b'!

1.  (x*'*! e b'! -> x*'*! e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  b'! e u'!

4.  x*'*! e a'!

5.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))
----



0.  x*'*! e b'!

1.  a'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 21




0.  a'! e u'!

1.  (Ax** : ((Ax''' : (x''' e b'! == x''' e x**)) -> x** e u'!))

2.  (Ax : (x e a'! == x e b'!))

3.  b'! e u'!
----



0.  a'! e u'!

by lines [-1]
Next!"""

done()

"""Done!"""

