//
//  StaffModel.swift
//  iBalezator
//
//  Created by m2sar on 11/04/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import Foundation

class StaffModel : GameModel{
    var curSet = [Note]()
    var indCurNote:Int
    var curNoteNeck : Note?
    var maxSizeSet : Int
    var octava : Int
    var wrongNoteNeck : Note?
    

    
    override init(){
        
        self.maxSizeSet = 1
//TODO MVCiser
                
        self.indCurNote = 0
        self.octava = -1
    }
}