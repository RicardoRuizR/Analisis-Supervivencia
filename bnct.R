#Importamos los datos a utilizar

bnct <- read_excel("C:/Users/jesus/Downloads/bnct.xlsx")

#Hacemos el ajuste 

supervtipo <- survfit(Surv(tiempo,delta)~rad+radbpa,data = bnct)


#Graficamos las funciones de supervivencia

plot(supervtipo,main="Estimacion funcion de supervivencia",
     xlab = "Tiempo",ylab = "Supervivencia",col=c("black","red","blue"))
legend("bottomleft",legend = c("Sin tratamiento","Radiacion","Radiacion+BPA"),
       col=c("black","red","blue"),lty = c(1,1,1))

#creamos los datos por pares
superv.r <- survfit(Surv(tiempo,delta)~1,data = bnct[1:20,])

supervtipo.r <- survfit(Surv(tiempo,delta)~rad,data = bnct[1:20,])

superv.rb <- survfit(Surv(tiempo,delta)~1,data = bnct[c(1:10,21:30),])

supervtipo.rb <- survfit(Surv(tiempo,delta)~radbpa,data = bnct[c(1:10,21:30),])

superv.rrb <- survfit(Surv(tiempo,delta)~1,data = bnct[11:30,])

supervtipo.rrb <- survfit(Surv(tiempo,delta)~rad,data = bnct[11:30,])

#Obtenemos el numero de eventos ocurridos en total, 
#el numero de personas en riesgo en cada tiempo y los tiempos de ocurrencia

tiempo.r <- summary(superv.r)$time

y.r <- summary(superv.r)$n.risk

muertes.r <- summary(superv.r)$n.event

#Obtenemos las personas sin tratamiento en riesgo en cada tiempo
yj.r <- summary(supervtipo.r,time=tiempo.r)

y1.r <- c(yj.r$n.risk[1:9],0,0)

#Numero de muertes de pacientes sin tratamiento en cada tiempo
muertes1.r <- c(yj.r$n.event[1:9],0,0)


#Prueba de rango logaritmico

Znum= sum(1*(muertes1.r-y1.r*(muertes.r/y.r)))
Zden= sqrt(sum(1^2*((y1.r/y.r)*(1-(y1.r/y.r))*(y.r-muertes.r)/(y.r-1)*muertes.r)))
Z=Znum/Zden


#Obtenemos el numero de eventos ocurridos en total, 
#el numero de personas en riesgo en cada tiempo y los tiempos de ocurrencia

tiempo.rb <- summary(superv.rb)$time

y.rb <- summary(superv.rb)$n.risk

muertes.rb <- summary(superv.rb)$n.event

#Obtenemos las personas sin tratamiento en riesgo en cada tiempo
yj.rb <- summary(supervtipo.rb,time=tiempo.rb)

y1.rb <- c(yj.rb$n.risk[1:8],rep(0,7))

#Numero de muertes de pacientes sin tratamiento en cada tiempo
muertes1.rb <- c(yj.rb$n.event[1:8],rep(0,7))


#Prueba de rango logaritmico

Znum= sum(1*(muertes1.rb-y1.rb*(muertes.rb/y.rb)))
Zden= sqrt(sum(1^2*((y1.rb/y.rb)*(1-(y1.rb/y.rb))*(y.rb-muertes.rb)/(y.rb-
                                                                       1)*muertes.rb)))
Z=Znum/Zden

#Obtenemos el numero de eventos ocurridos en total, 
#el numero de personas en riesgo en cada tiempo y los tiempos de ocurrencia

tiempo.rrb <- summary(superv.rrb)$time

y.rrb <- summary(superv.rrb)$n.risk

muertes.rrb <- summary(superv.rrb)$n.event

#Obtenemos las personas sin tratamiento en riesgo en cada tiempo
yj.rrb <- summary(supervtipo.rrb,time=tiempo.rrb)

y1.rrb <- c(yj.rrb$n.risk[12:19],rep(0,3))

#Numero de muertes de pacientes sin tratamiento en cada tiempo
muertes1.rrb <- c(yj.rrb$n.event[12:19],rep(0,3))


#Prueba de rango logaritmico

Znum= sum(1*(muertes1.rrb-y1.rrb*(muertes.rrb/y.rrb)))
Zden= sqrt(sum(1^2*((y1.rrb/y.rrb)*(1-(y1.rrb/y.rrb))*(y.rrb-muertes.rrb)/(y.rrb-
                                                                             1)*muertes.rrb)))
Z=Znum/Zden

#Hagamos el estadístico que se necesita para la prueba de tendencia

#Hacemos el ajuste completo

superv <- survfit(Surv(tiempo,delta)~1,data = bnct)

tiempo <- summary(superv)$time

#Obtenemos el numero de eventos ocurridos en total, 
#el numero de personas en riesgo en cada tiempo y los tiempos de ocurrencia

#Para las personas sin tratamiento



y<- summary(superv, time= tiempo)$n.risk

muertes<- summary(superv,time=tiempo)$n.event

y1 <- c(summary(supervtipo,time=tiempo)$n.risk[1:9],rep(0,7))

muertes1 <- c(summary(supervtipo,time=tiempo)$n.event[1:9],rep(0,7))

#para las personas con solo radiacion

y1r <- c(summary(supervtipo,time=tiempo)$n.risk[26:38],0,0,0)

muertes1r <- c(summary(supervtipo,time=tiempo)$n.event[26:38],0,0,0)

#Para pacientes con radiacion y bpa

y1rb <- summary(supervtipo,time=tiempo)$n.risk[10:25]

muertes1rb <- summary(supervtipo,time=tiempo)$n.event[10:25]


#Para la prueba log rango hacemos el estadistico

Z1 <- sum(1*(muertes1-y1*(muertes/y)))

Z2<- sum(1*(muertes1r-y1r*(muertes/y)))

Z3<- sum(1*(muertes1rb-y1rb*(muertes/y)))

Z<-c(Z1,Z2,Z3)

#Obtenemos la matriz de covarianzas

sigma11<-sum(1^2*((y1/y)*(1-(y1/y))*((y-muertes)/(y-1))*muertes))

sigma22<-sum(1^2*((y1r/y)*(1-(y1r/y))*((y-muertes)/(y-1))*muertes))

sigma33<-sum(1^2*((y1rb/y)*(1-(y1rb/y))*((y-muertes)/(y-1))*muertes))

sigma12<-sum(1^2*(y1/y)*(y1r/y)*((y-muertes)/(y-1))*muertes)

sigma13<-sum(1^2*(y1/y)*(y1rb/y)*((y-muertes)/(y-1))*muertes)

sigma23<-sum(1^2*(y1r/y)*(y1rb/y)*((y-muertes)/(y-1))*muertes)

sigma<-matrix(c(sigma11,sigma12,sigma13,sigma12,sigma22,sigma23,sigma13,sigma23,sigm
                a33), nrow = 3, ncol = 3)

Znum=0

for(i in 1:3){
  Znum=i*Z[i]+Znum
}

Zden=0

for (j in 1:3) {
  for (i in 1:3) {
    Zden=j*i*sigma[j,i]
  }
}

Z <- Znum/sqrt(Zden)

2*pnorm(q=-2.4978,lower.tail = TRUE)

#Ahora hagamos un ajuste a un modelo lineal

fit_ratas <- coxph(Surv(tiempo,delta)~rad + radbpa, data = datos, 
                   method = "breslow")
summary(fit_ratas)

#Podemos obtener la matriz de covarianzas
fit_ratas$var

#Para sacar la desviacion estandar de beta1 y beta2 i.e la diagonal se
# realiza lo siguiente
desv.es <- sqrt(diag(fit_ratas$var))
coeficientes <- fit_ratas$coefficients
resultado <- cbind(coeficientes,desv.es)

#Intervalo de confianza de animal irradiado comparado animal sin tratamiento  
exp((fit_ratas$coef[1]+c(-1,1)*1.96*sqrt(fit_ratas$var[1,1])))

#beta1 = beta2 = 0 realiza la prueba, P-valor de la prueba beta igual a cero.
summary(fit_ratas)

#beta1 = beta2
c <- matrix(nrow=1,ncol=2,data=c(1,-1))
linearHypothesis(fit_ratas,c,rhs = 0)

#primero obtenemos el riesgo relativo
dif <- fit_ratas$coef[2]-fit_ratas$coef[1]
exp(dif)
#luego obtenemos el error estándar de la diferencia de los coeficientes
sedif <- fit_ratas$var[1,1]+fit_ratas$var[2,2]-2*fit_ratas$var[1,2]
#entonces el intervalo de confianza queda 
exp((dif+c(-1,1)*1.96*sqrt(sedif)))

#I(rad+radbpa) hace un ajuste como una sola variable
fit_ratase <- coxph(Surv(tiempo,delta)~I(rad + radbpa), data = datos, 
                    method = "breslow")
summary(fit_ratase)

