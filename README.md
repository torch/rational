Rational numbers
================

Implement rational number operations, with appropriate operators.
Example of usage:

```lua
> rat = require 'rational'

> print(rat(5, 4) * rat(3, 6))
5/8

> print(rat(5, 4) + rat(3, 6))
7/4

> print(rat(5, 2) - rat(3, 6))
2

> print(rat(5, 2) / rat(3, 6))
5

> print(rat(5, 2)^3)
125/8

> print(-rat(5, 6))
-5/6

> print(rat(5, 6) == rat(25, 30))
true

> print(rat(5, 6) <= rat(25, 30))
true

> print(rat(5, 6) < rat(5, 4))
true

> print(rat(5, 6) <= rat(5, 4))
true

> print(rat(5, 6) > rat(5, 4))
false

> print(rat.max(rat(5, 6), rat(5, 4)))
5/4

> print(rat.min(rat(5, 6), rat(5, 4)))
5/6
```

Converting to a `number` can be done with the `()` operator:
```lua
print(rat(5, 6)())
0.83333333333333
```
