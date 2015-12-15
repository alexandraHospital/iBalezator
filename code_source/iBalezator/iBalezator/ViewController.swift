//
//  ViewController.swift
//  FirstInstrumentTutorialInSwift
//
//  Created by Nicholas Arner on 4/11/15.
//  Copyright (c) 2015 AudioKit. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    let SCORE_BAR_HEIGHT = 35.0 as CGFloat
    
    let keyboardController = KeyboardController()
    let neckController = NeckController()
    let scoreController = ScoreController()
    let staffController = StaffController()
    let helpController = HelpController()
    
    var keyboardView: KeyboardView?
    var neckView: NeckView?
    var scoreView: ScoreView?
    var staffView: StaffView?
    var helpView: HelpView?
    
    let mainMod = MainModel()
    let cond = Conductor()
    
    var timerPending = false;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.mainMod.curMode = true
        self.neckKeybMode()
        self.linkArchitecture()
        self.newNeckQuestion()
    }
    
    func linkArchitecture()
    {
        let ecran = UIScreen.mainScreen().bounds;
        self.helpView = HelpView(frame:CGRectMake(0,0,ecran.width,ecran.height))
        
        self.neckController.superController = self as ViewController
        self.keyboardController.superController = self as ViewController
        self.scoreController.superController =  self as ViewController
        self.helpController.superController = self as ViewController
        self.staffController.superController = self as ViewController
        
        self.keyboardView?.controller = self.keyboardController
        self.keyboardController.keyboardView = self.keyboardView
        
        self.neckView?.controller = self.neckController
        self.neckController.neckView = self.neckView
        
        self.scoreView?.controller = self.scoreController
        self.scoreController.scoreView = self.scoreView
        
        self.staffView?.controller = self.staffController
        self.staffController.staffView = self.staffView
        
        self.helpView?.controller = self.helpController
        self.helpController.helpView = self.helpView
    }
    
    func changeMode()
    {
        if(!self.timerPending)
        {
            if(self.mainMod.curMode)
            {
                self.mainMod.curMode = false
                self.staffNeckMode()
                self.neckView?.deleteAllMarkers()
                self.endScroll()
            }
            else{
                self.mainMod.curMode = true
                self.mainMod.staffModel.octava = -1
                self.neckKeybMode()
                self.newNeckQuestion()
            }
            
            self.updateScore()
        }
    }
    
    func neckKeybMode()
    {
        let ecran = UIScreen.mainScreen();
        var neckKeyb : UIView;
        
        var hScore = self.SCORE_BAR_HEIGHT
        var hNeck = ((ecran.bounds.height * 54.5)  / 100)
        var hKeyb = ((ecran.bounds.height * 35)    / 100)
        
        let fScore = CGRectMake(0, 0, ecran.bounds.width, hScore)
        let fNeck = CGRectMake(0, hScore, ecran.bounds.width, hNeck)
        let fKeyb = CGRectMake(0, hScore + hNeck, ecran.bounds.width, hKeyb)
        
        if(self.staffView == nil){
            self.staffView = StaffView(frame : fNeck)
        }
        else{
            self.staffView?.removeFromSuperview()
        }
        
        if(self.scoreView == nil)
        {
            self.scoreView = ScoreView(frame: fScore)
            self.view.addSubview(scoreView!)
        }
        else{
            self.scoreView?.frame = fScore;
        }
        
        if(self.neckView == nil){
            self.neckView = NeckView(frame: fNeck )
            self.view.addSubview(neckView!)
        }
        else{
            self.neckView?.frame = fNeck
        }
        
        if(self.keyboardView == nil){
            keyboardView = KeyboardView(frame: fKeyb )
            self.view.addSubview(keyboardView!)
        }
        else{
            self.keyboardView?.frame = fKeyb
            self.view.addSubview(self.keyboardView!)
        }
    }
    
    func staffNeckMode()
    {
        
        self.mainMod.staffModel.maxSizeSet = self.staffView!.maxNotesOnStaff()
        let ecran = UIScreen.mainScreen()
        var staffNeck : UIView
        
        /* Portée / Manche */
        let hScore = self.SCORE_BAR_HEIGHT
        let hStaff = ((ecran.bounds.height * 35) / 100)
        let hNeck = ((ecran.bounds.height * 54.5) / 100)
        
        let fScore = CGRectMake(0, 0, ecran.bounds.width, hScore)
        let fStaff = CGRectMake(0, hScore, ecran.bounds.width, hStaff)
        let fNeck = CGRectMake(0, hScore + hStaff, ecran.bounds.width, hNeck)
        
        if(self.keyboardView == nil){
            self.keyboardView = KeyboardView(frame : fStaff)
        }
        else{
            self.keyboardView?.removeFromSuperview()
        }
        
        if(self.scoreView == nil)
        {
            self.scoreView =  ScoreView(frame: fScore)
            self.view.addSubview(scoreView!)
        }
        else{
            self.scoreView?.frame = fScore
        }
        
        if(self.staffView == nil){
            staffView = StaffView(frame: fStaff )
            self.view.addSubview(staffView!)
        }
        else{
            self.staffView?.frame = fStaff
            self.view.addSubview(self.staffView!)
        }
        
        if(self.neckView == nil){
            neckView = NeckView(frame: fNeck )
            self.view.addSubview(neckView!)
        }
        else{
            self.neckView?.frame = fNeck;
        }
    }
    
    /* Vérifie que la note tapée sur le manche est la même
    que la note tirée aléatoirement */
    func checkNeckAnswer(note : Note)
    {
        var freqQuest : Int;
        var freqAnsw : Int;

       // println("\(self.mainMod.staffModel.indCurNote)")
        
        if(!self.mainMod.curMode && !self.timerPending)
        {
            self.mainMod.staffModel.curNoteNeck = note
            //self.cond.playNote(note)
            
            freqQuest = Int(cond.getFrequency(self.mainMod.staffModel.curSet[self.mainMod.staffModel.indCurNote]))
            freqAnsw = Int(cond.getFrequency(note))
            
            if (freqQuest == freqAnsw)
            {
                // Bonne réponse
                self.mainMod.nbGoodAns++
                self.staffView?.drawRectStaff(self.mainMod.staffModel.indCurNote, color: 1)
                self.mainMod.staffModel.indCurNote++
                self.cond.playNote(note)
                self.timerPending = true;
                self.staffView?.deleteBadNote()
                
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()) {
                        sleep(1)
                        if(self.mainMod.staffModel.indCurNote == self.mainMod.staffModel.maxSizeSet)
                        {
                            self.generateNewStaffSet()
                            self.staffView?.drawNewStaff()
                        }
                        self.newStaffQuestion()
                        self.timerPending = false;
                        self.staffView?.deleteBadNote()
                    }
                }
            }
            else
            {
                // Mauvaise réponse
                
                //Si la note question et la note réponse n'ont pas besoin d'octava
                if(!self.checkOctava(self.mainMod.staffModel.curSet[self.mainMod.staffModel.indCurNote]) && !self.checkOctava(note))
                {
                    self.staffView?.deleteBadNote()
                    self.staffController.putNoteOnStaff(note, pos : self.mainMod.staffModel.indCurNote, isBad : true)
                }
                    
                //Si la note question et la note réponse ont besoin d'octava
                else if(self.checkOctava(self.mainMod.staffModel.curSet[self.mainMod.staffModel.indCurNote]) && self.checkOctava(note))
                {
                    self.staffView?.deleteBadNote()
                    self.staffController.putNoteOnStaff(note.octaveDown(), pos : self.mainMod.staffModel.indCurNote, isBad : true)
                }
                
                else {
                    self.staffView?.deleteBadNote()
                }
                
                self.mainMod.nbBadAns++
                self.staffView?.drawRectStaff(self.mainMod.staffModel.indCurNote, color: 2)
                self.cond.playNote(note)
                
            }
            self.updateScore()
        }
    }
    
    /* Vérifie que la note tapée sur le clavier est la même
    que la note tirée aléatoirement (nous parlons ici en chaine
    de caractères seulement) */
    func checkKeyboardAnswer(note : String)
    {
        self.mainMod.keyboardModel.keyboardAnswer = note
        

        if(self.mainMod.curMode && !self.timerPending)
        {
            
            if (note == self.mainMod.keyboardModel.curQuestion!.getName())
            {
                //Bonne réponse
                
                self.mainMod.nbGoodAns++
                self.neckView?.putRightMarker(self.mainMod.keyboardModel.curQuestion!)
                self.mainMod.keyboardModel.lastQuestion = self.mainMod.keyboardModel.curQuestion!
                self.cond.playNote(mainMod.keyboardModel.curQuestion!)
                self.timerPending = true
                
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()) {
                        sleep(1)
                        self.newNeckQuestion()
                        self.timerPending = false;
                    }
                }
            }
            else
            {
               //Mauvaise réponse
                
                self.mainMod.nbBadAns++
                var wrongNote = neckController.findNote(self.mainMod.keyboardModel.curQuestion!, bad: note)
                self.cond.playNote(wrongNote)
                self.neckView!.putWrongMarker(wrongNote);
            }
            self.updateScore()
        }
        
    }
    
    func showHelp()
    {
        if(!self.timerPending)
        {
            let ecran = UIScreen.mainScreen()
            let wHelp = ecran.bounds.width
            let hHelp = ecran.bounds.height
            
            self.scoreView?.removeFromSuperview()
            self.neckView?.removeFromSuperview()
            
            if(self.mainMod.curMode){
                self.keyboardView?.removeFromSuperview()
            }
            else{
                self.staffView?.removeFromSuperview()
            }
            
            self.view.addSubview(self.helpView!)
        }
    }
    
    func closeHelp()
    {
        //  self.view.subviews.removeFromSuperview(helpView!)
        println("ferme l'aide")
        
        self.helpView?.removeFromSuperview()
        self.view.addSubview(self.scoreView!)
        self.view.addSubview(self.neckView!)
        
        if(self.mainMod.curMode){
            self.view.addSubview(self.keyboardView!)
        }
        else {
            self.view.addSubview(self.staffView!)
        }
    }
    
    func updateScore()
    {
        var totAns = (self.mainMod.nbGoodAns + self.mainMod.nbBadAns)
        
        if(totAns > 0){
            var perc = Double((self.mainMod.nbGoodAns * 100) / totAns)
            self.scoreController.updateScore(perc)
        }
    }
    
    func newNeckQuestion()
    {
        if(self.mainMod.curMode == true)
        {
            var note = self.neckController.randomNoteVisible()
            while(note.compareTo(self.mainMod.keyboardModel.lastQuestion)) {
                note = self.neckController.randomNoteVisible()
            }
            println("NEW QUESTION : \(note)")
            self.mainMod.keyboardModel.curQuestion = note
            self.cond.playNote(self.mainMod.keyboardModel.curQuestion!)
            self.neckView!.markerPending(note)
        }
    }
    
    //TODO renommer octava en indOctava
    //TODO note chevauche 8va : magic number C#
    //TODO note non-affichable
    //TODO octave below != down
    //vérifier les constantes (let)
    func generateNewStaffSet()
    {
        let overlap8va = Note(frette:18,corde:1)
        let tooHigh = Note(frette:24,corde:1)
        
        
        var prevNote:Note;
        var nxtNote : Note;
        self.mainMod.staffModel.curSet=[Note]()
        self.mainMod.staffModel.indCurNote = 0
        
        self.mainMod.staffModel.octava = -1
        prevNote = Note(frette: -1, corde: -1)
        for var i = 0; i < self.mainMod.staffModel.maxSizeSet ; ++i
        {
            do
            {
                nxtNote = self.neckController.randomNoteVisible()
                
                //aléatoire peu aléatoire
                if(nxtNote.compareTo(prevNote)){
                    continue;
                }
                
                if(self.checkOctava(nxtNote))
                {
                    if(self.cond.getFrequency(nxtNote) >= self.cond.getFrequency(tooHigh)){
                        continue;//15ma impossible (trop aiguë)
                    }
                    
                    if(self.checkOctavaImpossible(nxtNote)){
                        continue;//peut pas être octaviée (trop grave)
                    }
                    
                    //première nécessaire
                    if( self.mainMod.staffModel.octava == -1 )
                    {
                        if(self.cond.getFrequency(nxtNote) >= self.cond.getFrequency(overlap8va)){
                            continue;//note chevauche 8va
                        }
                        self.mainMod.staffModel.octava = i
                    }
                }
                break;
            } while(true);
            
            prevNote = nxtNote
            self.mainMod.staffModel.curSet.append(nxtNote);
        }
        self.newStaffQuestion()
    }
    
    
    
    func checkOctava(note : Note) -> Bool {
        if (note.frette == 12 && note.corde == 1 || note.frette >= 13){
            return true
        }
        return false
    }
    
    func checkOctavaImpossible(note : Note) -> Bool
    {
        let lowestNote = Note(frette:0,corde:6)
        return self.cond.getFrequency(note.octaveDown()) < self.cond.getFrequency(lowestNote)
    
    }

    
    /*  
        Cette fonction parcourt le tableau des notes tirées au sort pour la portée
        Dès qu'une note "trop aigue" est rencontrée, les notes suivantes sont
        retirées au sort pour être aigues aussi.
        Cette fonction sert pour le 8va.
    */
/*    func checkOctava(note : Note) -> Bool {
        return note.frette == 12 && note.corde == 1 || note.frette >= 13
    }
*/
    
    func newStaffQuestion()
    {
        println("Réponse : C: \(self.mainMod.staffModel.curSet[self.mainMod.staffModel.indCurNote].corde) F: \(self.mainMod.staffModel.curSet[self.mainMod.staffModel.indCurNote].frette)")
        
        if(self.mainMod.curMode == false)
        {
            println("\(self.mainMod.staffModel.indCurNote)")
            self.cond.playNote(self.mainMod.staffModel.curSet[self.mainMod.staffModel.indCurNote])
            self.staffView?.drawRectStaff(self.mainMod.staffModel.indCurNote, color: 0)
            
            if (self.mainMod.staffModel.indCurNote >= self.mainMod.staffModel.octava && self.mainMod.staffModel.octava != -1) {
                println("oct:\(self.mainMod.staffModel.octava)")
                
                if (self.mainMod.staffModel.indCurNote == self.mainMod.staffModel.octava) {
                    self.staffView?.drawOctava(CGFloat(self.mainMod.staffModel.indCurNote));
                }

                self.staffController.putNoteOnStaff(self.mainMod.staffModel.curSet[self.mainMod.staffModel.indCurNote].octaveDown(), pos : self.mainMod.staffModel.indCurNote, isBad : false)
            }
            
            else {
                 self.staffController.putNoteOnStaff(self.mainMod.staffModel.curSet[self.mainMod.staffModel.indCurNote], pos : self.mainMod.staffModel.indCurNote, isBad : false)
            }

           
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func endScroll()
    {
        if(self.mainMod.curMode){
            self.newNeckQuestion()
        }
        else{
            self.staffView?.drawNewStaff()
            self.generateNewStaffSet()
            self.staffView?.drawRectStaff(self.mainMod.staffModel.indCurNote, color: 0)
        }
    }
}
