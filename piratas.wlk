class Barco {
    const tripulantes = #{}
    var misionActual
    var capacidad 

    method agregarTripulante(unTripulante){
        if (unTripulante.esUtilParaLaMision(misionActual)) tripulantes.add(unTripulante)
    }

    method quitarTripulante(unTripulante){
        unTripulante.remove(unTripulante)
    }

    method tieneSuficienteTripulacion()= tripulantes.size() >= capacidad*0.9
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
}

class Mision {

    method pirataUtil(unPirata)=  

}
class BusquedaDelTesoro inherits Mision{
    method pirataUtil(unPirata)= 
}

class ConvertirseEnLeyenda {
  
}

class Saqueo {
  
}