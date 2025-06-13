class Barco {
    const property tripulantes = #{}
    var misionActual
    const capacidad

    method cambiarMision(nuevaMision){
        misionActual = nuevaMision
        tripulantes.removeAll(self.tripulacionNoCalifica(nuevaMision))
    }


    method agregarTripulante(unTripulante){
        if (misionActual.cumpleRequisitos(unTripulante)) && capacidad > tripulantes.size {tripulantes.add(unTripulante)}
    }

    method quitarTripulante(unTripulante){
        unTripulante.remove(unTripulante)
    }

    method tieneSuficienteTripulacion()= tripulantes.size() >= capacidad*0.9
    method barcoContieneitem(unItem)= tripulantes.any({t=>t.tieneunItem(unItem)})
    method puedeSerSaqueadoPor(unPirata) = unPirata.estaPasadoDeGrog()
    method esVulnerable(otroBarco)= otroBarco.cantidadTripulantes() >= self.cantidadTripulantes() / 2
    method cantidadTripulantes() = tripulantes.size()
    method tripulacionNoCalifica(unaMision)= tripulantes.filter{t=> not unaMision.esUtil(t)}
    method anclarEnCiudad(unaCiudad){
        self.todosTomanGrog(5)
        self.todosGastan(1)
        self.removerAlMasBorracho()
        unaCiudad.sumarUnHabitante()
    }
    method todosTomanGrog(cantidad){tripulantes.forEach{t=>t.tomarGrog(cantidad)}}


}



class Pirata {
    const items = []

    var nivelDeEbriedad 
    var cantidadDeDinero

    method agregarItem(unObjeto) {
        items.add(unObjeto)
    }
    method quitarItem(unObjeto) {
        items.remove(unObjeto)
    }
    method esUtilParaLaMision(unaMision){unaMision.pirataUtil(self)}
    method tieneMenosMonedadQue(cantMonedas)= cantidadDeDinero <= cantMonedas
    method tieneUnItem(unItem)= items.contains(unItem) 
    method tieneAlMenosItems(cantidad) = items.size()>= cantidad
    method estaPasadoDeGrog() = nivelDeEbriedad >= 90
    method seAnima(unObjetivo)= unObjetivo.puedeSerSaqueadoPor(self)
    method nivelDeEbriedadMayorA(unValor)= nivelDeEbriedad < unValor
    method esUtil(unaMision)=  unaMision.esUtil(self)
}

class Mision {

    method puedeCompletarLaMision(unBarco)= unBarco.tieneSuficienteTripulacion()
     


}
class BusquedaDelTesoro inherits Mision{
    const itemsRequeridos= #{"brujula","mapa","grog"}
    method requisito(unBarco) = unBarco.barcoContieneitem("llave de cofre")
    override method puedeCompletarLaMision(unBarco) {return super(unBarco) && self.requisito(unBarco)}
    method esUtil(unPirata)= not unPirata.items().asSet().intersection(itemsRequeridos).isEmpty() &&
                              unPirata.tieneMenosMonedadQue(5)

}

class ConvertirseEnLeyenda inherits Mision {
    const itemObligatorio

    method esUtil(unPirata)= unPirata.tieneAlMenositems(10) && unPirata.tieneItem(itemObligatorio)
  
}

class Saqueo {
    var objetivo

    
    method esUtil(unPirata){ 
      return  unPirata.tieneMenosMonedadQue(monedasDeterminadas.valor()) &&
              unPirata.seAnimaA(objetivo)
    }

    method barcoCumpleCondicion(unBarco)= unBarco.barcoContieneitem("llave de cofre")
  
}

object monedasDeterminadas {
    var property valor = 0
}

class Ciudad {
    var cantidadDeHabitantes
    method puedeSerSaqueadoPor(unPirata)= unPirata.nivelDeEbriedadMayorA(50)
    method esVulnerable(otroBarco) {
        return otroBarco.cantTripulantes() 


    }

}