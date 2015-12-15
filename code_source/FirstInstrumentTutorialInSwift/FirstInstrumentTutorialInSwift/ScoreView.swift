//
//  ScoreView.swift
//  iBalezator
//
//  Created by m2sar on 21/02/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit

class ScoreView : UINavigationBar{
    
    private let SCORE_TOTAL_WIDTH = CGFloat(200)
    private let SCORE_TOTAL_HEIGHT = CGFloat(200)
    
    private var goodScoreBar:UIView
    private var badScoreBar:UIView
    private var mode : Bool
    
    var controller : ScoreController?
    
    var help: UIButton
    
    override init (frame : CGRect)
    {
        self.goodScoreBar = UIView()
        self.badScoreBar = UIView()
        self.mode = false
        self.help = UIButton()

        
        super.init(frame: frame)
        self.backgroundColor = UIColor.grayColor()
        
        //var changeMode = UIButton()
        //changeMode.frame = CGRectMake(0, 0, 50, 35)
        //changeMode.backgroundColor = UIColor.redColor()
        //changeMode.setTitle("Mode", forState: UIControlState.Normal)
        //changeMode.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        
        var leftOffsetBar = ((self.frame.width - self.SCORE_TOTAL_WIDTH)/2)
        
        self.goodScoreBar.frame = CGRectMake(leftOffsetBar, 3, self.SCORE_TOTAL_WIDTH, 20)
        self.badScoreBar.frame = CGRectMake(leftOffsetBar, 3, 0, 20)

        
        self.goodScoreBar.backgroundColor = UIColor.greenColor()
        self.badScoreBar.backgroundColor = UIColor.redColor()
        
        var imageHelp = UIImage(named : "help.png")
        self.help.setImage(imageHelp, forState: UIControlState.Normal)
        self.help.addTarget(self, action: "helpPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.help.frame = CGRectMake(2, 2, 29, 29)
        
        self.addSubview(self.goodScoreBar)
        self.addSubview(self.badScoreBar)
        self.addSubview(self.help)
        

        
        //self.addSubview(changeMode)
    }
    
    func updateScore(percGood : Double )
    {
        println("percGood : \(percGood)")
        
        var percGoodWidth = ((percGood * Double(self.SCORE_TOTAL_WIDTH)) / 100)
        var percBadWidth = (((100 - percGood) * Double(self.SCORE_TOTAL_WIDTH)) / 100)
        
        println("width : \(percGoodWidth)")
        //self.goodScoreBar.frame = CGRectMake(, 3, 0, self.SCORE_TOTAL_HEIGHT)
        self.goodScoreBar.frame.size.width = CGFloat(percGoodWidth)
        
        self.badScoreBar.frame.origin.x = self.goodScoreBar.frame.origin.x + self.goodScoreBar.frame.size.width
        self.badScoreBar.frame.size.width = CGFloat(percBadWidth)
        
    }

    func pressed(sender: UIButton!)
    {
        self.controller?.changeMode()
    }
    
    func helpPressed(sender: UIButton!)
    {
        println("Help")
        self.controller?.superController?.showHelp()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}