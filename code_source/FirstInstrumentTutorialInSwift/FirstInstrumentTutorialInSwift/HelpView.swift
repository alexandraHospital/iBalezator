//
//  HelpView.swift
//  iBalezator
//
//  Created by m2sar on 20/04/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit

class HelpView: UIImageView, UITextViewDelegate {

    private let help = UIImageView()
    var controller: HelpController?
    
    var text: UITextView
    var close: UIButton
    let PADDING = 10.0 as CGFloat
    let BUTTON_WIDTH = 65.0 as CGFloat
    let BUTTON_HEIGHT = 45.0 as CGFloat
    
    
    override init (frame : CGRect)
    {
        let ecran = UIScreen.mainScreen()
        
        if (ecran.bounds.width == 480) {
            //4s
             //10 : les 10 pixels de marges autour de l'écran
            self.text = UITextView(frame: CGRectMake(PADDING, PADDING, ecran.bounds.width - PADDING * 2, ecran.bounds.height - PADDING * 2))
            self.close = UIButton(frame: CGRectMake((ecran.bounds.width - BUTTON_WIDTH)  / 2, ecran.bounds.height - PADDING - BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT))
        }
        else {
            //10 : les 10 pixels de marges autour de l'écran
            self.text = UITextView(frame: CGRectMake(PADDING, PADDING,ecran.bounds.width - PADDING * 2, ecran.bounds.height - PADDING * 2))
            self.close = UIButton(frame: CGRectMake((ecran.bounds.width - BUTTON_WIDTH)  / 2, ecran.bounds.height - PADDING - BUTTON_HEIGHT, BUTTON_WIDTH, BUTTON_HEIGHT))
        }
        
        super.init(frame: frame)
        
        //Bouton pour fermer l'aide
        self.close.setTitle("Fermer", forState: .Normal)
        self.close.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.close.backgroundColor = UIColor.grayColor()
        self.userInteractionEnabled = true
        self.close.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)

        //Texte d'aide
        self.text.delegate = self
        self.text.textAlignment = NSTextAlignment.Justified
        self.text.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sagittis tempus elit. Ut non nisi purus. Aenean sit amet nisl eu tellus finibus facilisis. Nunc vehicula elit velit, sit amet pharetra orci viverra sed. Maecenas venenatis ante nec neque hendrerit euismod. Nunc vulputate molestie lectus, sit amet varius nibh pharetra quis. In dictum, lorem in ultrices volutpat, lacus elit ultrices arcu, a molestie lectus purus ac eros. Suspendisse ornare vehicula fringilla. Sed vel interdum orci, a malesuada velit. Quisque vitae metus eu velit volutpat lacinia."
        
        self.addSubview(self.text)
        self.addSubview(self.close)
    }

    
    func pressed(sender: UIButton!){
        println("pressed")
        self.controller?.superController?.closeHelp()
    }
            
            
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}



