//
//  KeyboardView.swift
//  iBalezator
//
//  Created by m2sar on 21/02/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit

class KeyboardView : UIScrollView{
    
    var controller: KeyboardController?
    
    override init (frame : CGRect)
    {
        super.init(frame: frame)
        
        var degs = ["Do","Do#","Ré","Ré#","Mi","Fa","Fa#","Sol","Sol#","La","La#","Si"];
        var curX = 10;
        var curY = 0;
        var offset = 3
        var btnWidth = ((Int(self.frame.width - 10)-(degs.count * offset) ) / degs.count)
 
        for var i = 0; i < degs.count; ++i
        {
            var curDeg = UIButton()
            curDeg.frame = CGRectMake(CGFloat(curX), 10, CGFloat(btnWidth), self.frame.height-20)
            
            curDeg.setTitle(degs[i], forState: UIControlState.Normal)
            curDeg.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
            curDeg.layer.cornerRadius = 5.0;
            self.addSubview(curDeg)
            

            //Si note #, elle sera noire
            //Sinon, elle sera grise
            
            if (degs[i].hasSuffix("#")) {
                curDeg.backgroundColor = UIColor.blackColor()
            }
            
            else {
                curDeg.backgroundColor = UIColor.grayColor()
            }

            curX = curX + btnWidth + offset
        }
        
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.addGestureRecognizer(swipeUp)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.addGestureRecognizer(swipeDown)
        
        
        /*var customSegmentedControl = UISegmentedControl (items: degs)
        customSegmentedControl.frame = CGRectMake(0, 0, self.frame.width, 50)
        customSegmentedControl.selectedSegmentIndex = 1
        customSegmentedControl.tintColor = UIColor.redColor()
        customSegmentedControl.addTarget(self, action: "segmentedValueChanged:", forControlEvents: .ValueChanged)
        self.addSubview(customSegmentedControl)*/
    }
    
    func segmentedValueChanged(sender:UISegmentedControl!)
    {
        println("It Works, Value is ;\(sender.selectedSegmentIndex)")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func buttonToNote(button: UIButton) -> String {
        var note = ""
        
        note = button.titleLabel!.text!
        
        return note
    }
    
    func pressed(sender: UIButton!){
        var note = self.buttonToNote(sender)
        println("note : \(note)")
        
        controller!.superController!.checkKeyboardAnswer(note)
        
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer){
        self.controller?.swipeUp();
    }
    
}
