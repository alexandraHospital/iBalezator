//
//  KeyboardController.swift
//  iBalezator
//
//  Created by m2sar on 28/02/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit

class KeyboardController {
    
    //Référence vers le contrôleur principal
    var superController: ViewController?
    var keyboardView : KeyboardView?
    
    /* Retourne la note correspondant au bouton
    *  Entrée : un bouton (UIButton)
    *  Sortie : une note (chaine de caractères pour l'instant)
    */
    
    
    init (){
    }
    
    func buttonToNote(button: UIButton) -> String {
        var note = ""
        
        note = button.titleLabel!.text!
        
        return note
    }
    
    func pressed(sender: UIButton!){
        var note = self.buttonToNote(sender)
        println("note : \(note)")
        
        superController!.checkKeyboardAnswer(note)

    }

    func swipeUp(){
        self.superController?.changeMode()
    }
}