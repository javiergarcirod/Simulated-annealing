
Pkg.add("StatsBase") 
using StatsBase


function colisiones(p)
colisiones=0
for i in 1:nRei-1
for j in i+1:nRei
colisiones=colisiones + (j-i == abs(p[j]-p[i]))
end
end
colisiones
end

colisiones(p)

function otra(p)
ij=sample(1:nRei,2,replace=false)
apoyo=p[ij[1]]
p[ij[1]]=p[ij[2]]
p[ij[2]]=apoyo
p
end


nRei=80
p=sample(1:nRei,nRei,replace=false)

temp=nRei
iter=0
maxiter=100000
sol0=sample(1:nRei,nRei,replace=false)
val0=colisiones(sol0)




while iter<maxiter && val0>0
sol1= otra(sol0)
val1=colisiones(sol1)
if val1 <= val0
alfa=1
else
alfa=exp((val0-val1)/temp)
end
prob=sample([0,1],WeightVec([1-alfa,alfa]))
if prob==1
sol0=sol1
val0=val1
end
iter=iter+1
temp=temp*0.995
end


println("Mejor solución=",sol0,"  ","y mejor resultado=",val0)
