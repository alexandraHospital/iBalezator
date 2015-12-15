//
//  ViewController.swift
//  FirstInstrumentTutorialInSwift
//
//  Created by Nicholas Arner on 4/11/15.
//  Copyright (c) 2015 AudioKit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
        self.mainMod.curMode = false
        self.staffNeckMode()
        self.linkArchitecture()
        self.endScroll()
        self.cond.play(5)
    }
    
    func linkArchitecture()
    {
        let ecran = UIScreen.mainScreen().bounds;
        self.helpView = HelpView(frame:CGRectMake(0,0,ecran.width,ecran.height))
        
        self.neckController.superController = self as ViewController
        self.keyboardController.superController = self as ViewController
        self.scoreController.superController =  self as ViewController
        self.helpController.superController = self as ViewController
        
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
                self.endScroll()
            }
            else{
                self.mainMod.curMode = true
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
        
        var hScore = ((ecran.bounds.height * 10.5) / 100)
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
        let ecran = UIScreen.mainScreen()
        var staffNeck : UIView
        
        /* Portée / Manche */
        let hScore = ((ecran.bounds.height * 10.5) / 100)
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
        if(!self.mainMod.curMode && !self.timerPending)
        {
            self.mainMod.staffModel.curNoteNeck = note
            self.cond.playNote(note)
            if (note.compareTo(self.mainMod.staffModel.curSet[self.mainMod.staffModel.indCurNote]))
            {
                self.mainMod.nbGoodAns++
                self.staffView?.drawRectStaff(self.mainMod.staffModel.indCurNote, color: 1)
                self.timerPending = true;
                
                let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
                dispatch_async(dispatch_get_global_queue(priority, 0)) {
                    dispatch_async(dispatch_get_main_queue()) {
                        sleep(1)
                        self.newStaffQuestion()
                        self.timerPending = false;
                    }
                }
            }
            else {
                self.neckView!.putWrongMarker(note);
                self.mainMod.nbBadAns++
                self.staffView?.drawRectStaff(self.mainMod.staffModel.indCurNote, color: 2)
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
            println("Compare Keyboard \(note) with \(self.mainMod.keyboardModel.curQuestion!.getName()) :  \(note == (self.mainMod.keyboardModel.curQuestion!.getName()))")
            
            if (note == self.mainMod.keyboardModel.curQuestion!.getName())
            {
                // println("Compare Neck : vrai")
                self.mainMod.nbGoodAns++
                self.neckView?.putRightMarker(self.mainMod.keyboardModel.curQuestion!)
                self.mainMod.keyboardModel.lastQuestion = self.mainMod.keyboardModel.curQuestion!
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
                println("Compare Neck : faux")
                
                self.mainMod.nbBadAns++
                var wrongNote = neckController.findNote(self.mainMod.keyboardModel.curQuestion!, bad: note)
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
    
    func generateNewStaffSet()
    {
        var prevNote:Note;
        var nxtNote : Note;
        self.mainMod.staffModel.curSet=[Note]()
        self.mainMod.staffModel.indCurNote = 0
        
        prevNote = Note(frette: -1, corde: -1)
        for var i = 0; i < self.mainMod.staffModel.maxSizeSet ; ++i
        {
            nxtNote = self.neckController.randomNoteVisible()
            while(nxtNote.compareTo(prevNote)){
                nxtNote = self.neckController.randomNoteVisible()
            }
            
            prevNote = nxtNote
            self.mainMod.staffModel.curSet.append(nxtNote);
            println("Question = C\(self.mainMod.staffModel.curSet[i].corde), F\(self.mainMod.staffModel.curSet[i].frette)")
        }
        
        self.staffController.putNotesOnStaff(self.mainMod.staffModel.curSet)
    }
    
    func newStaffQuestion()
    {
        
        if(self.mainMod.curMode == false)
        {
            self.mainMod.staffModel.indCurNote++
            
            if(self.mainMod.staffModel.indCurNote == self.mainMod.staffModel.maxSizeSet || self.mainMod.staffModel.curSet.count == 0)
            {
                self.generateNewStaffSet()
            }
            
            self.cond.playNote(self.mainMod.staffModel.curSet[self.mainMod.staffModel.indCurNote])
            self.staffView?.drawRectStaff(self.mainMod.staffModel.indCurNote, color: 0)
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
