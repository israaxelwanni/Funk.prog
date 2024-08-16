{-
with the otermoast reduction path the number of evaluations is smaller

(outermoast)
fst (1+2,2+3)
v v v   (applying fst)
1+2
v v v   (applying +)
3

(innermoast)
fst (1+2,2+3)
v v v   (applying + to 1+2)
fst (3,2+3)
v v v   (applying + to 2+3)
fst (3,5)
v v v   (applying fst)
3



-}