//
//  KeyboardController.swift
//  iBalezator
//
//  Created by m2sar on 28/02/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit

class KeyboardController {
    
    
    /* Retourne la note correspondant au bouton
    *  Entrée : un bouton (UIButton)
    *  Sortie : une note (chaine de caractères pour l'instant)
    */
    func buttonToNote(button: UIButton) -> String {
        var note = ""
        
        note = button.titleLabel!.text!
        
        return note
    }
    
}