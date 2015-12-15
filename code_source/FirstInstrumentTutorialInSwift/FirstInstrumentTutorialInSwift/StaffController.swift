//
//  StaffController.swift
//  iBalezator
//
//  Created by m2sar on 09/04/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import Foundation
import UIKit

class StaffController {
    
    //Référence vers le contrôleur principal
    var superController : ViewController?
    var staffView : StaffView?
    
    let STEP = 5.0//TODO ???
    
    let MAJOR_SCALE : [Int] = [2, 2, 1, 2, 2, 2, 1]
    let DEG_MI = 3

    init(){
        
    }
    

    
    func putNoteOnStaff(note : Note, pos : Int)
    {
        var nbSem :Int;
        var nbInt : Int;
        var i : Int ;
        var noteLeft : Double;
        var bottomStaff : Int;
        
        i = self.DEG_MI
        nbSem = Note(frette : 0,  corde : 6).semiTonesBetween(note)
        nbInt = 0

        while(nbSem > 0){
            //if nbsem strictement inférieur à 0, dièze
            nbSem = nbSem - self.MAJOR_SCALE[i % self.MAJOR_SCALE.count];
            i++;
            nbInt++
        }
        
        bottomStaff = (self.staffView?.getBottomStaff())!
        
        let xN = self.staffView?.getPosLeft(pos)
        let yN = CGFloat(Double(bottomStaff) - (Double(nbInt) * Double((self.staffView?.STEP)!)))
        self.staffView?.drawNote(xN!, y : yN)
        
        if(nbSem == 0){
            self.staffView?.drawSharp(xN!,y:yN)
        }
    }
    
    func putNotesOnStaff(notes : [Note])
    {
        for var i = 0; i < notes.count; ++i {
            self.putNoteOnStaff(notes[i], pos: i)
        }
    }
}