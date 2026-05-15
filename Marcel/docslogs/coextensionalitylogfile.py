from graph import *

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

getleft(1)

"""

Line number 5




0.  (Ax : (x e a'! == x e b'!))

1.  a'! e u'!
----



0.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 7




0.  (x'? e a'! == x'? e b'!)

1.  (Ax : (x e a'! == x e b'!))

2.  a'! e u'!
----



0.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 8




0.  (x'? e a'! -> x'? e b'!)

1.  (x'? e b'! -> x'? e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  a'! e u'!
----



0.  b'! e u'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 8




0.  a'! e u'!

1.  (x'? e a'! -> x'? e b'!)

2.  (x'? e b'! -> x'? e a'!)

3.  (Ax : (x e a'! == x e b'!))
----



0.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 9




0.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

1.  (x'? e a'! -> x'? e b'!)

2.  (x'? e b'! -> x'? e a'!)

3.  (Ax : (x e a'! == x e b'!))
----



0.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 10




0.  (x'*? e u'! V (Ex'' : ~(x'' e a'! == x'' e x'*?)))

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  (x'? e a'! -> x'? e b'!)

3.  (x'? e b'! -> x'? e a'!)

4.  (Ax : (x e a'! == x e b'!))
----



0.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 11




0.  x'*? e u'!

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  (x'? e a'! -> x'? e b'!)

3.  (x'? e b'! -> x'? e a'!)

4.  (Ax : (x e a'! == x e b'!))
----



0.  b'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 12




0.  (Ex'' : ~(x'' e a'! == x'' e b'!))

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  (x'? e a'! -> x'? e b'!)

3.  (x'? e b'! -> x'? e a'!)

4.  (Ax : (x e a'! == x e b'!))
----



0.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 13




0.  ~(x*'! e a'! == x*'! e b'!)

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  (x'? e a'! -> x'? e b'!)

3.  (x'? e b'! -> x'? e a'!)

4.  (Ax : (x e a'! == x e b'!))
----



0.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 14




0.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

1.  (x'? e a'! -> x'? e b'!)

2.  (x'? e b'! -> x'? e a'!)

3.  (Ax : (x e a'! == x e b'!))
----



0.  (x*'! e a'! == x*'! e b'!)

1.  b'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 14




0.  (x'? e a'! -> x'? e b'!)

1.  (x'? e b'! -> x'? e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))
----



0.  (x*'! e a'! == x*'! e b'!)

1.  b'! e u'!

by lines [-1]
Next!"""

right()

"""

Line number 15




0.  x*'! e a'!

1.  (x'? e a'! -> x'? e b'!)

2.  (x'? e b'! -> x'? e a'!)

3.  (Ax : (x e a'! == x e b'!))

4.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))
----



0.  x*'! e b'!

1.  b'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 15




0.  (x'? e a'! -> x'? e b'!)

1.  (x'? e b'! -> x'? e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

4.  x*'! e a'!
----



0.  x*'! e b'!

1.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 17




0.  (x'? e b'! -> x'? e a'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  x*'! e a'!
----



0.  x'? e a'!

1.  x*'! e b'!

2.  b'! e u'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 17




0.  x*'! e a'!

1.  (x'? e b'! -> x'? e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))
----



0.  x'? e a'!

1.  x*'! e b'!

2.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 19




0.  (Ax** : (x** e a'! V (Ex''' : ~(x''' e x*'! == x''' e x**))))

1.  (x'? e b'! -> x'? e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))
----



0.  x'? e a'!

1.  x*'! e b'!

2.  b'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 19




0.  (x'? e b'! -> x'? e a'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  (Ax** : (x** e a'! V (Ex''' : ~(x''' e x*'! == x''' e x**))))
----



0.  x'? e a'!

1.  x*'! e b'!

2.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 20




0.  (Ax : (x e a'! == x e b'!))

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  (Ax** : (x** e a'! V (Ex''' : ~(x''' e x*'! == x''' e x**))))
----



0.  x'? e b'!

1.  x'? e a'!

2.  x*'! e b'!

3.  b'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 20




0.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

1.  (Ax** : (x** e a'! V (Ex''' : ~(x''' e x*'! == x''' e x**))))

2.  (Ax : (x e a'! == x e b'!))
----



0.  x'? e b'!

1.  x'? e a'!

2.  x*'! e b'!

3.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 22




0.  (x''*? e u'! V (Ex'' : ~(x'' e a'! == x'' e x''*?)))

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  (Ax** : (x** e a'! V (Ex''' : ~(x''' e x*'! == x''' e x**))))

3.  (Ax : (x e a'! == x e b'!))
----



0.  x'? e b'!

1.  x'? e a'!

2.  x*'! e b'!

3.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 23




0.  x''*? e u'!

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  (Ax** : (x** e a'! V (Ex''' : ~(x''' e x*'! == x''' e x**))))

3.  (Ax : (x e a'! == x e b'!))
----



0.  x'? e b'!

1.  x'? e a'!

2.  x*'! e b'!

3.  b'! e u'!

by lines [-1]
Next!"""

getright(3)

"""

Line number 23




0.  x''*? e u'!

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  (Ax** : (x** e a'! V (Ex''' : ~(x''' e x*'! == x''' e x**))))

3.  (Ax : (x e a'! == x e b'!))
----



0.  b'! e u'!

1.  x'? e b'!

2.  x'? e a'!

3.  x*'! e b'!

by lines [-1]
Next!"""

done()

"""

Line number 24




0.  (Ex'' : ~(x'' e a'! == x'' e b'!))

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  (Ax** : (x** e a'! V (Ex''' : ~(x''' e x*'! == x''' e x**))))

3.  (Ax : (x e a'! == x e b'!))
----



0.  x'? e b'!

1.  x'? e a'!

2.  x*'! e b'!

3.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 25




0.  ~(x'*'! e a'! == x'*'! e b'!)

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  (Ax** : (x** e a'! V (Ex''' : ~(x''' e x*'! == x''' e x**))))

3.  (Ax : (x e a'! == x e b'!))
----



0.  x'? e b'!

1.  x'? e a'!

2.  x*'! e b'!

3.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 26




0.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

1.  (Ax** : (x** e a'! V (Ex''' : ~(x''' e x*'! == x''' e x**))))

2.  (Ax : (x e a'! == x e b'!))
----



0.  (x'*'! e a'! == x'*'! e b'!)

1.  x'? e b'!

2.  x'? e a'!

3.  x*'! e b'!

4.  b'! e u'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 26




0.  (Ax : (x e a'! == x e b'!))

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  (Ax** : (x** e a'! V (Ex''' : ~(x''' e x*'! == x''' e x**))))
----



0.  (x'*'! e a'! == x'*'! e b'!)

1.  x'? e b'!

2.  x'? e a'!

3.  x*'! e b'!

4.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 27




0.  (x'**? e a'! == x'**? e b'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  (Ax** : (x** e a'! V (Ex''' : ~(x''' e x*'! == x''' e x**))))
----



0.  (x'*'! e a'! == x'*'! e b'!)

1.  x'? e b'!

2.  x'? e a'!

3.  x*'! e b'!

4.  b'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 21




0.  x'? e a'!

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  (Ax** : (x** e a'! V (Ex''' : ~(x''' e x*'! == x''' e x**))))
----



0.  x'? e a'!

1.  x*'! e b'!

2.  b'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 18




0.  x'? e b'!

1.  (x'? e b'! -> x'? e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

4.  x*'! e a'!
----



0.  x*'! e b'!

1.  b'! e u'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 18




0.  (Ax : (x e a'! == x e b'!))

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  x*'! e a'!

3.  x'? e b'!

4.  (x'? e b'! -> x'? e a'!)
----



0.  x*'! e b'!

1.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 28




0.  (x*''? e a'! == x*''? e b'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  x*'! e a'!

4.  x'? e b'!

5.  (x'? e b'! -> x'? e a'!)
----



0.  x*'! e b'!

1.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 29




0.  (x*''? e a'! -> x*''? e b'!)

1.  (x*''? e b'! -> x*''? e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

4.  x*'! e a'!

5.  x'? e b'!

6.  (x'? e b'! -> x'? e a'!)
----



0.  x*'! e b'!

1.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 30




0.  (x*''? e b'! -> x*''? e a'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  x*'! e a'!

4.  x'? e b'!

5.  (x'? e b'! -> x'? e a'!)
----



0.  x*''? e a'!

1.  x*'! e b'!

2.  b'! e u'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 30




0.  x*'! e a'!

1.  x'? e b'!

2.  (x'? e b'! -> x'? e a'!)

3.  (x*''? e b'! -> x*''? e a'!)

4.  (Ax : (x e a'! == x e b'!))

5.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))
----



0.  x*''? e a'!

1.  x*'! e b'!

2.  b'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 31




0.  x*'! e b'!

1.  (x*'! e b'! -> x*'! e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

4.  x*'! e a'!

5.  x'? e b'!

6.  (x'? e b'! -> x'? e a'!)
----



0.  x*'! e b'!

1.  b'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 16




0.  x*'! e b'!

1.  (x'? e a'! -> x'? e b'!)

2.  (x'? e b'! -> x'? e a'!)

3.  (Ax : (x e a'! == x e b'!))

4.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))
----



0.  x*'! e a'!

1.  b'! e u'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 16




0.  (x'? e b'! -> x'? e a'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  x*'! e b'!

4.  (x'? e a'! -> x'? e b'!)
----



0.  x*'! e a'!

1.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 32




0.  (Ax : (x e a'! == x e b'!))

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  x*'! e b'!

3.  (x'? e a'! -> x'? e b'!)
----



0.  x'? e b'!

1.  x*'! e a'!

2.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 34




0.  (x*'*? e a'! == x*'*? e b'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  x*'! e b'!

4.  (x'? e a'! -> x'? e b'!)
----



0.  x'? e b'!

1.  x*'! e a'!

2.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 35




0.  (x*'*? e a'! -> x*'*? e b'!)

1.  (x*'*? e b'! -> x*'*? e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

4.  x*'! e b'!

5.  (x'? e a'! -> x'? e b'!)
----



0.  x'? e b'!

1.  x*'! e a'!

2.  b'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 35




0.  (x*'*? e b'! -> x*'*? e a'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  x*'! e b'!

4.  (x'? e a'! -> x'? e b'!)

5.  (x*'*? e a'! -> x*'*? e b'!)
----



0.  x'? e b'!

1.  x*'! e a'!

2.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 36




0.  (Ax : (x e a'! == x e b'!))

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  x*'! e b'!

3.  (x'? e a'! -> x'? e b'!)

4.  (x*'*? e a'! -> x*'*? e b'!)
----



0.  x*'*? e b'!

1.  x'? e b'!

2.  x*'! e a'!

3.  b'! e u'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 36




0.  x*'! e b'!

1.  (x'? e a'! -> x'? e b'!)

2.  (x*'*? e a'! -> x*'*? e b'!)

3.  (Ax : (x e a'! == x e b'!))

4.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))
----



0.  x*'*? e b'!

1.  x'? e b'!

2.  x*'! e a'!

3.  b'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 37




0.  x*'! e a'!

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  x*'! e b'!

4.  (x'? e a'! -> x'? e b'!)

5.  (x*'! e a'! -> x*'! e b'!)
----



0.  x'? e b'!

1.  x*'! e a'!

2.  b'! e u'!

by lines [-1]
Next!"""

getright(1)

"""

Line number 37




0.  x*'! e a'!

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  x*'! e b'!

4.  (x'? e a'! -> x'? e b'!)

5.  (x*'! e a'! -> x*'! e b'!)
----



0.  x*'! e a'!

1.  b'! e u'!

2.  x'? e b'!

by lines [-1]
Next!"""

done()

"""

Line number 33




0.  x'? e a'!

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  x*'! e b'!

4.  (x'? e a'! -> x'? e b'!)
----



0.  x*'! e a'!

1.  b'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 33




0.  (Ax : (x e a'! == x e b'!))

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  x*'! e b'!

3.  (x'? e a'! -> x'? e b'!)

4.  x'? e a'!
----



0.  x*'! e a'!

1.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 38




0.  (x**'? e a'! == x**'? e b'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  x*'! e b'!

4.  (x'? e a'! -> x'? e b'!)

5.  x'? e a'!
----



0.  x*'! e a'!

1.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 39




0.  (x**'? e a'! -> x**'? e b'!)

1.  (x**'? e b'! -> x**'? e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

4.  x*'! e b'!

5.  (x'? e a'! -> x'? e b'!)

6.  x'? e a'!
----



0.  x*'! e a'!

1.  b'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 39




0.  (x**'? e b'! -> x**'? e a'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  x*'! e b'!

4.  (x'? e a'! -> x'? e b'!)

5.  x'? e a'!

6.  (x**'? e a'! -> x**'? e b'!)
----



0.  x*'! e a'!

1.  b'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 40




0.  (Ax : (x e a'! == x e b'!))

1.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

2.  x*'! e b'!

3.  (x'? e a'! -> x'? e b'!)

4.  x'? e a'!

5.  (x**'? e a'! -> x**'? e b'!)
----



0.  x**'? e b'!

1.  x*'! e a'!

2.  b'! e u'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 40




0.  x*'! e b'!

1.  (x'? e a'! -> x'? e b'!)

2.  x'? e a'!

3.  (x**'? e a'! -> x**'? e b'!)

4.  (Ax : (x e a'! == x e b'!))

5.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))
----



0.  x**'? e b'!

1.  x*'! e a'!

2.  b'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 41




0.  x*'! e a'!

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax* : (x* e u'! V (Ex'' : ~(x'' e a'! == x'' e x*))))

3.  x*'! e b'!

4.  (x'? e a'! -> x'? e b'!)

5.  x'? e a'!

6.  (x*'! e a'! -> x*'! e b'!)
----



0.  x*'! e a'!

1.  b'! e u'!

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

Line number 42




0.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

1.  (Ax : (x e a'! == x e b'!))
----



0.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 43




0.  (x'''*? e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x'''*?)))

1.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

2.  (Ax : (x e a'! == x e b'!))
----



0.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 44




0.  x'''*? e u'!

1.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

2.  (Ax : (x e a'! == x e b'!))
----



0.  a'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 45




0.  (Ex'''' : ~(x'''' e b'! == x'''' e a'!))

1.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

2.  (Ax : (x e a'! == x e b'!))
----



0.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 46




0.  ~(x''*'! e b'! == x''*'! e a'!)

1.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

2.  (Ax : (x e a'! == x e b'!))
----



0.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 47




0.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

1.  (Ax : (x e a'! == x e b'!))
----



0.  (x''*'! e b'! == x''*'! e a'!)

1.  a'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 47




0.  (Ax : (x e a'! == x e b'!))

1.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))
----



0.  (x''*'! e b'! == x''*'! e a'!)

1.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 48




0.  (x''**? e a'! == x''**? e b'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))
----



0.  (x''*'! e b'! == x''*'! e a'!)

1.  a'! e u'!

by lines [-1]
Next!"""

right()

"""

Line number 49




0.  x''*'! e b'!

1.  (x''*'! e a'! == x''*'! e b'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))
----



0.  x''*'! e a'!

1.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 51




0.  (Ax'*'' : (x'*'' e b'! V (Ex'*'* : ~(x'*'* e x''*'! == x'*'* e x'*''))))

1.  (x''*'! e a'! == x''*'! e b'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))
----



0.  x''*'! e a'!

1.  a'! e u'!

by lines [-1]
Next!"""

back()
back()
getleft(1)

"""

Line number 49




0.  (x''*'! e a'! == x''*'! e b'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

3.  x''*'! e b'!
----



0.  x''*'! e a'!

1.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 51




0.  (x''*'! e a'! -> x''*'! e b'!)

1.  (x''*'! e b'! -> x''*'! e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

4.  x''*'! e b'!
----



0.  x''*'! e a'!

1.  a'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 51




0.  (x''*'! e b'! -> x''*'! e a'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

3.  x''*'! e b'!

4.  (x''*'! e a'! -> x''*'! e b'!)
----



0.  x''*'! e a'!

1.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 52




0.  (Ax : (x e a'! == x e b'!))

1.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

2.  x''*'! e b'!

3.  (x''*'! e a'! -> x''*'! e b'!)
----



0.  x''*'! e b'!

1.  x''*'! e a'!

2.  a'! e u'!

by lines [-1]
Next!"""

getleft(2)

"""

Line number 52




0.  x''*'! e b'!

1.  (x''*'! e a'! -> x''*'! e b'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))
----



0.  x''*'! e b'!

1.  x''*'! e a'!

2.  a'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 53




0.  x''*'! e a'!

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

3.  x''*'! e b'!

4.  (x''*'! e a'! -> x''*'! e b'!)
----



0.  x''*'! e a'!

1.  a'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 50




0.  x''*'! e a'!

1.  (x''*'! e a'! == x''*'! e b'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))
----



0.  x''*'! e b'!

1.  a'! e u'!

by lines [-1]
Next!"""

getleft(1)

"""

Line number 50




0.  (x''*'! e a'! == x''*'! e b'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

3.  x''*'! e a'!
----



0.  x''*'! e b'!

1.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 54




0.  (x''*'! e a'! -> x''*'! e b'!)

1.  (x''*'! e b'! -> x''*'! e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

4.  x''*'! e a'!
----



0.  x''*'! e b'!

1.  a'! e u'!

by lines [-1]
Next!"""

left()

"""

Line number 55




0.  (x''*'! e b'! -> x''*'! e a'!)

1.  (Ax : (x e a'! == x e b'!))

2.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

3.  x''*'! e a'!
----



0.  x''*'! e a'!

1.  x''*'! e b'!

2.  a'! e u'!

by lines [-1]
Next!"""

getleft(3)

"""

Line number 55




0.  x''*'! e a'!

1.  (x''*'! e b'! -> x''*'! e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))
----



0.  x''*'! e a'!

1.  x''*'! e b'!

2.  a'! e u'!

by lines [-1]
Next!"""

done()

"""

Line number 56




0.  x''*'! e b'!

1.  (x''*'! e b'! -> x''*'! e a'!)

2.  (Ax : (x e a'! == x e b'!))

3.  (Ax*** : (x*** e u'! V (Ex'''' : ~(x'''' e b'! == x'''' e x***))))

4.  x''*'! e a'!
----



0.  x''*'! e b'!

1.  a'! e u'!

by lines [-1]
Next!"""

done()

"""Done!"""

