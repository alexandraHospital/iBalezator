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
    var notes = ["do", "do#", "ré", "ré#", "mi", "fa", "fa#", "sol", "sol#", "la", "la#", "si"]
    
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
        case 1, 6:
            note = notes[(4+frette)%12]
            
        case 5:
            note = notes[(9+frette)%12]
            
        case 4:
            note = notes[(2+frette)%12]
            
        case 3:
            note = notes[(7+frette)%12]
            
        case 2:
            note = notes[(11+frette)%12]
            
        default:
            note = "ERREUR"
            
        }
        
        return note
        
    }
    
    //Plus tard : Méthode getMidiNumber()
    

    
    
}
