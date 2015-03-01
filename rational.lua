local argcheck = require 'argcheck'

local rational = {}
local mt

rational.new = argcheck{
   {name="n", type="number"},
   {name="d", type="number", default=1},
   call =
      function(n, d)
         assert(d ~= 0, "denominator cannot zero")
         assert(n == math.floor(n) and d == math.floor(d), "integer expected")
         if d < 0 then
            n, d = -n, -d
         end
         local gcd = rational.gcd(n, d)
         local self = {n=n/gcd, d=d/gcd}
         setmetatable(self, mt)
         return self
      end
}

rational.gcd = argcheck{
   {name="m", type="number"},
   {name="n", type="number"},
   call =
      function(m, n)
         if m < 0 then
            m = -m
         end
         if n < 0 then
            n = -n
         end
         while m ~= 0 do
            m, n = n % m, m
         end
         return n
      end
}

rational.add = argcheck{
   {name="a", type="rational.number"},
   {name="b", type="rational.number"},
   call =
      function(a, b)
         return rational.new(
            a.n * b.d + b.n * a.d,
            a.d * b.d
         )
      end
}

rational.unm = argcheck{
   {name="a", type="rational.number"},
   call =
      function(a)
         return rational.new(-a.n, a.d)
      end
}

rational.sub = argcheck{
   {name="a", type="rational.number"},
   {name="b", type="rational.number"},
   call =
      function(a, b)
         return rational.new(
            a.n * b.d - b.n * a.d,
            a.d * b.d
         )
      end
}

rational.mul = argcheck{
   {name="a", type="rational.number"},
   {name="b", type="rational.number"},
   call =
      function(a, b)
         return rational.new(
            a.n * b.n,
            a.d * b.d
         )
      end
}

rational.pow = argcheck{
   {name="a", type="rational.number"},
   {name="n", type="number"},
   call =
      function(a, n)
         return rational.new(
            a.n^n,
            a.d^n
         )
      end
}

rational.div = argcheck{
   {name="a", type="rational.number"},
   {name="b", type="rational.number"},
   call =
      function(a, b)
         assert(b.n ~= 0, "division by zero")
         return rational.new(
            a.n * b.d,
            a.d * b.n
         )
      end
}

rational.tostring = argcheck{
   {name="a", type="rational.number"},
   call =
      function(a)
         if a.d == 1 then
            return string.format("%d", a.n)
         else
            return string.format("%d/%d", a.n, a.d)
         end
      end
}

rational.tonumber = argcheck{
   {name="a", type="rational.number"},
   call =
      function(a)
         return a.n/a.d
      end
}

rational.eq = argcheck{
   {name="a", type="rational.number"},
   {name="b", type="rational.number"},
   call =
      function(a, b)
         return a.n == b.n and a.d == b.d
      end
}

rational.lt = argcheck{
   {name="a", type="rational.number"},
   {name="b", type="rational.number"},
   call =
      function(a, b)
         local r = rational.sub(a, b)
         return r.n < 0
      end
}

rational.le = argcheck{
   {name="a", type="rational.number"},
   {name="b", type="rational.number"},
   call =
      function(a, b)
         local r = rational.sub(a, b)
         return r.n <= 0
      end
}

rational.max = argcheck{
   {name="a", type="rational.number"},
   {name="b", type="rational.number"},
   call =
      function(a, b)
         return a >= b and a or b
      end
}

rational.min = argcheck{
   {name="a", type="rational.number"},
   {name="b", type="rational.number"},
   call =
      function(a, b)
         return a <= b and a or b
      end
}

mt = {
   __index = rational,
   __typename = "rational.number",
   __tonumber = rational.tonumber,
   __tostring = rational.tostring,
   __unm =
      function(a, a)
         return rational.unm(a)
      end,
   __add = rational.add,
   __sub = rational.sub,
   __mul = rational.mul,
   __pow = rational.pow,
   __div = rational.div,
   __eq = rational.eq,
   __lt = rational.lt,
   __le = rational.le,
   __call = rational.tonumber
}

local ctor = {}
setmetatable(ctor,
             {__index=rational,
              __newindex=rational,
              __call =
                 function(self, ...)
                    return rational.new(...)
                 end})

return ctor
