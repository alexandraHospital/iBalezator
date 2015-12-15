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
    let DEG_MI = 3 - 1

    init(){
        
    }
    

    
    
    /* Retourne la note une octave en dessous 
    */
    
    
    
    
    func putNoteOnStaff(note : Note, pos : Int, isBad : Bool)
    {
        var nbSem :Int;
        var nbInt : Int;
        var i : Int ;
        var noteLeft : Double;
        var bottomStaff : Int;
        var isSharp : Bool;
        
        i = self.DEG_MI
        nbSem = Note(frette : 0,  corde : 6).semiTonesBetween(note)
        nbInt = 0;
        isSharp = false;

        while(nbSem > 0)
        {
            nbSem = nbSem - self.MAJOR_SCALE[i % self.MAJOR_SCALE.count];
            i++;
            if(nbSem >= 0){
                nbInt++
            }
            else{
                isSharp = nbSem < 0
            }
        }
        
        bottomStaff = (self.staffView?.getBottomStaff())!
        
        let xN = self.staffView?.getPosLeft(pos)
        let yN = CGFloat(Double(bottomStaff) - (Double(nbInt) * Double((self.staffView?.STEP)!)))
        
        if(isBad){
            if(isSharp){
                self.staffView?.drawBadSharp(xN!,y:yN)
            }
            self.staffView?.drawBadNote(xN!, y : yN)
        }else{
            if(isSharp){
                self.staffView?.drawQuestionSharp(xN!,y:yN)
            }
            self.staffView?.drawQuestionNote(xN!, y : yN)
        }
    }
    
    func putNotesOnStaff(notes : [Note])
    {
        for var i = 0; i < notes.count; ++i {
            
            //S'il y a un octava, dessiner une note une octave plus bas
            if (self.superController?.mainMod.staffModel.octava == i) {
                
                for var j = i; j < notes.count; ++j {

                    println("\(notes[j].getName()) : \(notes[j].frette) \(notes[j].corde) plus bas")
                    var noteOct = notes[j].octaveDown()
                    println("Nouveau \(noteOct.getName()) : \(noteOct.frette) \(noteOct.corde)")
                    self.putNoteOnStaff(noteOct, pos: j, isBad : false)

                }
                break
            }
            else {
                //println("\(notes[i].getName()) : \(notes[i].frette) \(notes[i].corde) bouge pas")
                self.putNoteOnStaff(notes[i], pos: i, isBad : false)
            }
            

        }
    }
}