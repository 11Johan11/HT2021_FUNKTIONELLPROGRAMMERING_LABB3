type Binding = (Variable,Value)
type State = [Binding]
type Variable = String
data Value = Intval Integer deriving (Eq, Ord,Show)

--Uppgift 1
get :: Variable -> State -> Value
get v s = head [y | (x,y) <- s, x==v] 

onion :: Variable -> Value -> State -> State
onion v a = map (\(x,y) -> if x == v then (x,a) else (x,y)) 
-- //////////////////////////


data Expression = Var Variable |
 Lit Value |
 Aop Op Expression Expression      -- Aritmetic operators  --Aop "+" "x" "y"
 deriving (Eq, Ord, Show)

type Op = String

--Uppgift 2
eval:: Expression -> State -> Value
eval (Var v) state = get v state  --Hämta ex: "x" från state
eval (Lit v) state = v --Lit(Intval 5) = Intval 5
eval (Aop op e1 e2) state = apply op (eval e1 state) (eval e2 state) -- Missing apply op now
                            where
                            apply "+" (Intval l) (Intval r) = Intval(l + r)
                            apply "-" (Intval l) (Intval r) = Intval(l - r)
                            apply "/" (Intval l) (Intval r) = Intval(div l r) --Endast heltalsdivision
                            apply "*" (Intval l) (Intval r) = Intval(l*r)
-- //////////////////////////

data Bexpression = Blit Bvalue |
 Bop Op Bexpression Bexpression |   -- Boolean operators
 Rop Op Expression Expression       -- Relational operators 	
 deriving (Eq, Ord,Show)

data Bvalue = Boolval Bool deriving (Eq, Ord,Show)


--Uppgift 3
beval :: Bexpression -> State -> Bvalue
beval (Blit v) state = v
beval (Bop op e1 e2) state = bapply op (beval e1 state) (beval e2 state)
                            where
                            bapply "&&" (Boolval l) (Boolval r) = Boolval(l && r)
                            bapply "||" (Boolval l) (Boolval r) = Boolval(l || r)

beval (Rop op e1 e2) state = rapply op (eval e1 state) (eval e2 state)
                            where
                            rapply ">" (Intval l) (Intval r) = Boolval(l > r)
                            rapply "<" (Intval l) (Intval r) = Boolval(l < r)
                            rapply "!=" (Intval l) (Intval r) = Boolval(l /= r)
                            rapply "==" (Intval l) (Intval r) = Boolval(l == r)
                            rapply "<=" (Intval l) (Intval r) = Boolval(l <= r)
                            rapply ">=" (Intval l) (Intval r) = Boolval(l >= r)
-- //////////////////////////

data Statement = Skip |
 Assignment Target Source |
 Block Blocktype |
 Loop Test Body |
 Conditional Test Thenbranch Elsebranch
 deriving (Show)

type Target = Variable
type Source = Expression
type Test = Bexpression
type Body = Statement
type Thenbranch = Statement
type Elsebranch = Statement

data Blocktype = Nil |
 Nonnil Statement Blocktype
 deriving (Show)


--Uppgift 4 & 5
m::Statement->State->State
m Skip env = env -- Exempel användning: if p then x else skip  blir ju då en vanlig if sats utan else
m (Block Nil) env = env
m (Assignment t s) env = onion t (eval s env) env 
m (Loop test body) env = head $ filter (\x -> beval test x /= Boolval True) (iterate (m body) env) 
m (Conditional test tb eb) env = if beval test env == Boolval True then m tb env else m eb env 
m (Block (Nonnil c block)) env = m (Block block) (m c env)
-- //////////////////////////

run :: Statement -> State 
run program = m program s1

s1::State
s1=[("x", Intval 0), ("y", Intval 0)]




{--

KÖREXEMPEL!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

--}
{--
ENKEL ADDITION
--}

h0 :: State
h0 = run (Assignment "x" (Aop "+" (Lit(Intval 5)) (Lit(Intval 5))))


{--
ENKEL IF SATS UTAN ELSE
MOTSVARIGHET I PYTHON
if y == 0 && x == 0:
  x = 100
--}

b0 :: State
b0 = run ( (Conditional (Bop ("&&") (Rop "==" (Var "x") (Lit(Intval 0))) (Rop "==" (Var "y") (Lit(Intval 0)))) (Assignment "x" (Lit(Intval 100))) Skip))

-------------------FAKULITET
{--

MOTSVARIGHET I PYTHON
def factorial n:
  x = n
  y = x
  while x != 1:
    y = y * (x - 1)
    x = (x - 1)
  return y
--}

c1 :: Statement
c1 = (Assignment "y" (Var "x"))
-- y = y * (x - 1)
c2 :: Statement
c2 = (Assignment "y" (Aop "*" (Var "y") (Aop "-" (Var "x") (Lit(Intval 1)))))
-- x = (x - 1)
c3 :: Statement
c3 = (Assignment "x" (Aop "-" (Var "x") (Lit(Intval 1))))
--While x != 1
--(Loop (Rop "!=" (Var "x") (Lit(Intval 1))) (Block (Nonnil c2 (Nonnil c3 Nil))))

--factorial (Intval 9)
factorial :: Value -> Value
factorial n = get "y" (run (Block (Nonnil (Assignment "x" (Lit(n))) (Nonnil c1 (Nonnil (Loop (Rop "!=" (Var "x") (Lit(Intval 1))) (Block (Nonnil c2 (Nonnil c3 Nil)))) Nil))))) 


{--
def modulo (a,b):
 x = a//b
 y = b * x
 y = a - y
 return y
--}

modulo :: Value -> Value -> Value
modulo a b = get "y" ( run (Block (Nonnil (Assignment "x" (Aop "/" (Lit(a)) (Lit(b)))) (Nonnil (Assignment "y" (Aop "*" (Lit(b)) (Var "x"))) (Nonnil (Assignment "y" (Aop "-" (Lit(a)) (Var "y"))) Nil)))) )


