//
//  KeyboardView.swift
//  iBalezator
//
//  Created by m2sar on 21/02/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit

class KeybordView : UIScrollView{
    
    private let control = KeyboardController();
    
    override init (frame : CGRect)
    {
        super.init(frame: frame)
        
        var degs = ["Do","Do#","Ré","Ré#","Mi","Fa","Fa#","Sol","Sol#","La","La#","Si"];
        var offset = 3
        var curX = 5;
        var curY = 0;
        var btnWidth = ((Int(self.frame.width)-(degs.count * offset) ) / degs.count)
        
        
        for var i = 0; i < degs.count; ++i
        {
            var curDeg = UIButton()
            curDeg.frame = CGRectMake(CGFloat(curX), 0, CGFloat(btnWidth), self.frame.height)
            curDeg.backgroundColor = UIColor.greenColor()
            curDeg.setTitle(degs[i], forState: UIControlState.Normal)
            curDeg.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
            self.addSubview(curDeg)
            
            curX = curX + btnWidth + offset
        }
        
        
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
    
    func pressed(sender: UIButton!) {
        var note = control.buttonToNote(sender)
        println("note : \(note)")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
