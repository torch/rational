local rat = require 'rational'

assert((rat(5, 4) * rat(3, 6))() == 5/4 * 3/6)
assert((rat(5, 4) + rat(3, 6))() == 5/4 + 3/6)
assert((rat(5, 2) - rat(3, 6))() == 5/2 - 3/6)
assert((rat(5, 2) / rat(3, 6))() == 5/2 / (3/6))
assert((rat(5, 2)^3)() == (5/2)^3)
assert((-rat(5, 6))() == -5/6)

assert(rat(5, 6) == rat(25, 30))
assert(rat(5, 6) <= rat(25, 30))
assert(rat(5, 6) < rat(5, 4))
assert(rat(5, 6) <= rat(5, 4))

assert(rat.max(rat(5, 6), rat(5, 4)) == rat(5, 4))
assert(rat.min(rat(5, 6), rat(5, 4)) == rat(5, 6))

assert(tostring(rat(10, 12)) == '5/6')
assert(tostring(rat(10, 2)) == '5')

print('PASSED')
