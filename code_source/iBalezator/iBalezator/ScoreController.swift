//
//  ScoreController.swift
//  iBalezator
//
//  Created by m2sar on 21/03/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit
import Darwin

class ScoreController {
    //Référence vers le contrôleur principal
    var superController : ViewController?
    var scoreView : ScoreView?

    init(){
        
    }
    
    func changeMode()
    {
        self.superController?.changeMode()
    }
    
    func updateScore(percGood : Double){
        self.scoreView?.updateScore(percGood)
    }

}
