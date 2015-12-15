//
//  KeyboardModel.swift
//  iBalezator
//
//  Created by m2sar on 11/04/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import Foundation

class KeyboardModel : GameModel
{
    var keyboardAnswer: String?
    var lastQuestion = Note(frette: 0, corde: 0)
    //var curNote : Note?
    
    override init(){
        super.init()
    }
}