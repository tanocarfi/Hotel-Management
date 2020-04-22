import UIKit

/// COMPITO DEL 20/04/2020
/// Studente: Gaetano Carfì

/// QUESITI
/// 1. Cosa sono le tuple?
/* Le tuple raggruppano più valori in un singolo valore composto. I valori all'interno di una tupla possono essere di qualsiasi tipo e potrebbero non essere dello stesso tipo l'uno dell'altro.*/

/// 2. Quanti modi conosci per rappresentare una tupla?
/* Per rappresnetare una tupla vi sono 2 metodi:
 let language = ("Swift", "Programming Language")
 let language = (name: "Kotlin", type: "Programming Language")*/

/// 3. Dato un array di elementi array = [“A”, “B”, “E”, “D”] come posso effettuare la modifiche di “E” in “C”
/* Posso effettuare la modifica in questa maniera:
 array[2] = "C"*/

/// 4. Come posso accedere in maniera diretta al value di un Dictionary?
/* Posso accedere in maniera diretta al valore presente in un Dictionary scrivendo così:
 simpleDictionary["Typescript"]*/

/// 5. Fare un esempio di Optional Binding con una variabile Optional
/* Ecco un esempio di Optional Binding:
 var optionalName: String?
 if let name = optionalName {
     print(name)
 } else {
     print("optionalName is NIL or has no value")
 }
*/

/// 6. Stesso esempio di sopra ma con Guard.
/* Ecco un esempio di Guard:
 func fullName(optionalName: String?) -> String {
     guard let name = optionalName else { return "Name is nil"}
     return "name is \(name)"
 }
 */

/// 7. Cosa sono le Computed property e a cosa servono.
/* Le Computed Property sono delle proprietà speciali che possono svolgere dei calcoli quando vi si accede o si prova a modificarne il loro valore. Un esempio sono le funzioni get e set.*/




/// ESERCIZIO SWIFT
/* Un Albergo richiede la creazione di un’applicazione per la gestione e prenotazione delle sue camere.

L’albergo gestisce delle Stanze.
Ogni camera ha una property che la identifica univocamente.
Esistono due tipologie di Stanza: Singola e Doppia.
La Singola può ospitare al massimo una persona ed in più qualche singola (non tutte) può avere la possibilità di avere un cucinino.
La Doppia può ospitare due persone, non può avere cucinino ma qualche doppia (non tutte) potrebbe avere la possibilità di aggiungere un terzo lettino (cosa che non può avere la stanza singola)
Ogni camera può essere prenotata.
Una funzione dell’albergo mostra tutte le camere libere sia singole che doppie ognuna con le sue caratteristiche (Cucinino / Terzo lettino).
Una funzione dell’Albergo permette di prenotare una camera che sia identificata come “libera” in base alla scelta svolta dall’utente. (Singola, Singola con Cucinino, Doppia, Doppia con Lettino)

Se un utente chiede di prenotare una stanza “Singola” o “Doppia” (e con le opportuni varianti) la nostra funzione deve essere in grado di effettuare una ricerca tra tutte le stanze in modo da poter ritornare una stanza che non sia occupata per poterla in seguito prenotare.
Se non ci sono stanze libere, deve mandare in Output un messaggio all’utente: “Ci dispiace ma non ci sono al momento stanze con le caratteristiche da Lei richieste.”
Se esiste la Stanza e questa è libera, un’altra funzione deve permettere all’utente di prenotarla, settando la stessa come occupata.
Trovare il modo migliore per simulare la prenotazione di una stanza.
Utilizzate L’ereditarietà typeCasting e DownCasting e Extension dove serve.*/

class Hotel {
    // creo un array con le stanze
    var rooms: [HotelRoom] = []
    
    init() {}
    
    // funzione che mi mostra le camere libere
    func showHotelRooms() {
        for item in self.rooms {
            if item.reserved == false {
                if let room = item as? SingleHotelRoom {
                    print("La camera \(item.CPid) è libera e cucinino \(room.kitchenette)!")
                } else if let room = item as? DoubleHotelRoom {
                    print("La camera \(item.CPid) è libera e lettino \(room.cot)!")
                }
            }
        }
    }
    
    // funzione che mi cerca le camere per tipo
    func searchRoomForType(type: String) -> [HotelRoom] {
        var rooms: [HotelRoom] = []
        switch type {
        case "singola":
            for item in self.rooms {
                if item is SingleHotelRoom {
                    if item.reserved == false {
                        if let single = item as? SingleHotelRoom {
                            if single.kitchenette == false {
                                rooms.append(item)
                            }
                        }
                    }
                }
            }
            return rooms
        case "singola con cucinino":
            for item in self.rooms {
                if item is SingleHotelRoom {
                    if item.reserved == false {
                        if let single = item as? SingleHotelRoom {
                            if single.kitchenette == true {
                                rooms.append(item)
                            }
                        }
                    }
                }
            }
            return rooms
        case "doppia":
            for item in self.rooms {
                if item is DoubleHotelRoom {
                    if item.reserved == false {
                        if let doubleRoom = item as? DoubleHotelRoom {
                            if doubleRoom.cot == false {
                                rooms.append(item)
                            }
                        }
                    }
                }
            }
            return rooms
        case "doppia con lettino":
            for item in self.rooms {
                if item is DoubleHotelRoom {
                    if item.reserved == false {
                        if let doubleRoom = item as? DoubleHotelRoom {
                            if doubleRoom.cot == true {
                                rooms.append(item)
                            }
                        }
                    }
                }
            }
            return rooms
        default:
            print("Errore! Comando non trovato!")
        }
        return rooms
    }
    
    // funzione che mi permette di prenotare una camera
    func bookingRoom(type: String) {
        let result = searchRoomForType(type: type)
        if result.count == 0 {
            print("Non ci sono camere disponibili")
        } else {
            for item in result {
                item.reserved = true
                print("Camera \(item.CPid) prenotata")
            }
        }
    }
}

class HotelRoom {
    private var id: Int
    var reserved: Bool
    
    init(id: Int, reserved: Bool) {
        self.id = id
        self.reserved = reserved
    }
    
    // get-only
    var CPid: Int {
        get {
            return self.id
        }
        set(newId) {
            self.id = newId
        }
    }
}

class SingleHotelRoom: HotelRoom {
    var kitchenette: Bool
    
    init(kitchenette: Bool, id: Int, reserved: Bool) {
        self.kitchenette = kitchenette
        super.init(id: id, reserved: reserved)
    }
}

class DoubleHotelRoom: HotelRoom {
    var cot: Bool
    
    init(cot: Bool, id: Int, reserved: Bool) {
        self.cot = cot
        super.init(id: id, reserved: reserved)
    }
}

// inizializzo l'hotel
var hotelMonteverde = Hotel.init()

// inizializzo le camere singole con cucinino e senza
var firstSingle = SingleHotelRoom.init(kitchenette: false, id: 25, reserved: false)
var secondSingleKitchen = SingleHotelRoom.init(kitchenette: true, id: 14, reserved: true)
var thirdSingle = SingleHotelRoom.init(kitchenette: false, id: 20, reserved: true)
var fourthSingleKitchen = SingleHotelRoom.init(kitchenette: true, id: 12, reserved: false)

// inizializzo le camere doppie con lettino e non
var firstDuoble = DoubleHotelRoom.init(cot: false, id: 10, reserved: true)
var secondDoubleCot = DoubleHotelRoom.init(cot: true, id: 22, reserved: false)
var thirdDouble = DoubleHotelRoom.init(cot: false, id: 16, reserved: false)
var fourthDoubleCot = DoubleHotelRoom.init(cot: true, id: 13, reserved: true)

// aggiungo le camere nell'array `rooms` dell'albergo
hotelMonteverde.rooms.append(firstSingle)
hotelMonteverde.rooms.append(secondSingleKitchen)
hotelMonteverde.rooms.append(thirdSingle)
hotelMonteverde.rooms.append(fourthSingleKitchen)

hotelMonteverde.rooms.append(firstDuoble)
hotelMonteverde.rooms.append(secondDoubleCot)
hotelMonteverde.rooms.append(thirdDouble)
hotelMonteverde.rooms.append(fourthDoubleCot)

// controllo le camere libere
hotelMonteverde.showHotelRooms()

print()

// ricerco le camere libere per tipo
hotelMonteverde.searchRoomForType(type: "singola")
hotelMonteverde.searchRoomForType(type: "singola con cucinino")
hotelMonteverde.searchRoomForType(type: "doppia")
hotelMonteverde.searchRoomForType(type: "doppia con lettino")

print()

// prenoto una camera
hotelMonteverde.bookingRoom(type: "singola")
