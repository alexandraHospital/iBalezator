//
//  Note.swift
//  iBalezator
//
//  Created by m2sar on 10/03/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import Foundation


class Note {
    var frette: Int
    var corde: Int
    
    /* Noms des notes */
    var notes = ["Do", "Do#", "Ré", "Ré#", "Mi", "Fa", "Fa#", "Sol", "Sol#", "La", "La#", "Si"]
    let TUNNING_ITV : [Int] = [-1, -1, 5, 4, 5, 5, 5]
    //var adj : Array<Array<Int>>
   // var emptyDictionary = Dictionary<Float: Array[Note]()>()
    
    init(frette: Int, corde: Int){
        self.frette = frette;
        self.corde = corde;
    }
    
    /* Donne la note correspondant à la corde et à la frette
    * Entrée : un numéro (int) de corde et un numéro (int) de frette
    * Sortie : une note (chaine de caractères pour l'instant)
    */
    
    func getName() -> String{
        
        var note = ""
        
        switch corde {
        case 1, 6: // corde Mi grave
            note = notes[(4+frette)%12]
            
        case 5: // corde La
            note = notes[(9+frette)%12]
            
        case 4: // corde ré
            note = notes[(2+frette)%12]
            
        case 3: // corde sol
            note = notes[(7+frette)%12]
            
        case 2: // corde si
            note = notes[(11+frette)%12]
            
        default:
            note = "ERREUR"
            
        }
        
        return note
        
    }
    
    //Plus tard : Méthode getMidiNumber()
    

    func compareTo(note : Note) -> Bool{
        return ((note.frette == self.frette) && (note.corde == self.corde));
    }
    

    //TODO aigu ==> grave, grave ==> aigu
    func semiTonesBetween(to : Note) -> Int
    {
        var itvString = 0;
        var interval = 0;
        
        for(var i = self.corde; i > to.corde; --i ){
            itvString = itvString + self.TUNNING_ITV[i]
        }
        
        interval = (itvString + (abs(to.frette - self.frette)))
        //println("Interval : \(interval)")
        return interval;
    }
    
    /*  Retourne une note une octave en dessous
    */
    func octaveDown() -> Note
    {
        var cond =  Conductor()
        var freqDown : Float = cond.getFrequency(self) / Float(2)
        var newNote : Note?
        


        for var c = self.corde; c<=6;++c
        {
            for var f = 0; f<=24;++f
            {
                if(self.corde == c && self.frette == f){
                 //   println("CORDE : \(self.corde) FRETTE : \(self.frette)")
                    break;
                }

                newNote = Note(frette : f,corde: c)
                //println("freqDown : \(Int(freqDown)) et \(Int(cond.getFrequency(newNote!)))")
                if(Int(freqDown) == Int(cond.getFrequency(newNote!))){
                   // println("IF : freqDown : \(Int(freqDown)) et \(Int(cond.getFrequency(newNote!)))")
                    return newNote!;
                }

            }
        }
        return newNote!
    }



    
}
