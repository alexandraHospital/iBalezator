//
//  ScoreView.swift
//  iBalezator
//
//  Created by m2sar on 21/02/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit

class ScoreView : UINavigationBar{
    
    private let SCORE_TOTAL_WIDTH = CGFloat(250)
    private let SCORE_TOTAL_HEIGHT = CGFloat(17)
    
    private var goodScoreBar:UIView
    private var badScoreBar:UIView
    private var mode : Bool
    
    let PERCENT  = 100
    var OFFSET_X = 0 as CGFloat
    let OFFSET_Y = 9 as CGFloat
    
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
        
        
        OFFSET_X = ((self.frame.width - self.SCORE_TOTAL_WIDTH)/2)
        
        self.goodScoreBar.frame = CGRectMake(OFFSET_X, OFFSET_Y, self.SCORE_TOTAL_WIDTH, SCORE_TOTAL_HEIGHT)
        self.badScoreBar.frame = CGRectMake(OFFSET_X, OFFSET_Y, 0, SCORE_TOTAL_HEIGHT)
        
        self.badScoreBar.backgroundColor = UIColor(red: 220/255, green: 0, blue: 0, alpha: 1)

        self.goodScoreBar.backgroundColor = UIColor(red: 51/255, green: 204/255, blue: 51/255, alpha: 1)

        
        var imageHelp = UIImage(named : "help.png")
        self.help.setImage(imageHelp, forState: UIControlState.Normal)
        self.help.addTarget(self, action: "helpPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.help.frame = CGRectMake(10, 2, 29, 29)
        
        
        self.addSubview(self.goodScoreBar)
        self.addSubview(self.badScoreBar)
        self.addSubview(self.help)
    }
    
    func updateScore(percGood : Double )
    {
        println("percGood : \(percGood)")
        
        var percGoodWidth = ((percGood * Double(self.SCORE_TOTAL_WIDTH)) / Double(PERCENT))
        var percBadWidth = (((Double(PERCENT) - percGood) * Double(self.SCORE_TOTAL_WIDTH)) / Double(PERCENT))
        
        println("width : \(percGoodWidth)")
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
        self.controller?.superController?.showHelp()
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}