import UIKit

//1280 x 704
class StaffView : UIImageView{
    
    //private var controller = StaffController()
    private let staff = UIImageView()
    var controller : StaffController?
    
    let NUMBER_OF_LINE = 5
    //let LINE_WIDTH =
    let LINE_HEIGHT = 1.5 as CGFloat

    let LINE_SPACE = 10 // en comptant l'épaisseur des lignes, donc 7 + 3
    
    //Place de la première ligne
    let LINE_PLACE = 30

    //Place de la dernière ligne
    var LINE_END = 0.0 as CGFloat
    
    //Taille (hauteur) de la note et également de l'espace
    //strict entre deux lignes (sans compter les lignes)
    let NOTE_HEIGHT = 7 as CGFloat
    
    //Largeur de la note
    let NOTE_WIDTH = 11.99 as CGFloat
    
    let PADDING = 20.0 as CGFloat
    
    let PADD_BETW_NOTES = 15.0 as CGFloat
    
    let STEP : CGFloat = 5
    
    var rect : UIView?
    
    override init (frame : CGRect){
        
        super.init(frame: frame)
        self.LINE_END = CGFloat(LINE_PLACE + LINE_SPACE * 4)
        self.drawNewStaff()
    }
    
    func drawNewStaff()
    {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        for( var i = 0; i < NUMBER_OF_LINE; ++i )
        {
            var stfLine = UIView(frame:CGRectMake(PADDING, CGFloat(LINE_PLACE + (LINE_SPACE * i) ), self.frame.width - PADDING*2, LINE_HEIGHT))
            stfLine.backgroundColor = UIColor.blackColor()
            self.addSubview(stfLine)
        }
        
        self.addSubview(staff)
    }
    
    func drawNote(x : CGFloat, y : CGFloat)
    {
        println("\(x),\(y)")
        var imgHN = UIImage(named : "whole_note.png")
        var imgViewHN = UIImageView(frame : CGRectMake(x, y + 2, NOTE_WIDTH, NOTE_HEIGHT))
        imgViewHN.image  = imgHN
        self.drawLineV2(x,y:y)
        self.addSubview(imgViewHN)
    }
    
    func drawLineV2(x : CGFloat, y : CGFloat)
    {
        var nbrLine :CGFloat ;
        var topLine : CGFloat;
        
        //println("y = \(y), le = \(self.LINE_END), ")
        
        if(y > self.LINE_END)
        {
            nbrLine = ((y - CGFloat(self.LINE_END)) / self.STEP)
            nbrLine = CGFloat((Int(nbrLine) + 1) / 2)
            println("nbl = \(nbrLine)");
            
            for (var i = 1; i <= Int(nbrLine);  ++i)
            {
                var stfLine = UIView(frame:CGRectMake(x - 5, CGFloat(Int(LINE_END) + (LINE_SPACE * i)), NOTE_WIDTH + 10, LINE_HEIGHT))
                stfLine.backgroundColor = UIColor.grayColor()
                self.addSubview(stfLine)
            }
        }
        else{/*
            topLine = CGFloat(self.LINE_PLACE) - CGFloat(2 * Int(self.STEP))
            
            nbrLine = ((y - CGFloat(self.LINE_END)) / CGFloat(STEP))
            nbrLine = CGFloat((Int(nbrLine) + 1) / 2)*/
            
        }
        
        //nbrLine =
        //println("nbrLine = \(nbrLine)")
    }
    
    func drawSharp(x : CGFloat, y : CGFloat)
    {
        var imgS = UIImage(named : "sharp.png")
        var imgViewS = UIImageView(frame : CGRectMake(x - self.NOTE_HEIGHT, y, self.NOTE_HEIGHT, self.NOTE_WIDTH))
        imgViewS.image  = imgS
        self.addSubview(imgViewS)
    }
    
    /*  Construit les lignes en plus pour les notes en dessous ou au dessus de la portée
        number : nombre de ligne (1, 2 ou 3)
        position : up ou down (au dessus ou en dessous de la portée)
        notePosition : position de la note sur la portée (en abscisse)
    */
    /*func drawLine(number: Int, position: String, notePosition: CGFloat){
        
        if (position == "down"){
            for (var i = 1; i <= number;  ++i) {
                var stfLine = UIView(frame:CGRectMake(notePosition - 5, CGFloat(Int(LINE_END) + (LINE_SPACE * i)), NOTE_WIDTH + 10, LINE_HEIGHT))
                stfLine.backgroundColor = UIColor.grayColor()
                self.addSubview(stfLine)
            }
        }
        else {
            for (var i = 1; i <= number;  ++i) {
                var stfLine = UIView(frame:CGRectMake(notePosition, CGFloat(LINE_PLACE - (LINE_SPACE * i) ), NOTE_WIDTH + 10, LINE_HEIGHT))
                stfLine.backgroundColor = UIColor.grayColor()
                self.addSubview(stfLine)
            }
        }
    }*/
    
    func drawRectStaff(pos:Int, color : Int)
    {
        var col : UIColor;
        
        switch(color)
        {
            case 0:
                col = UIColor.yellowColor()
            case 1:
                col = UIColor.greenColor()
            case 2:
                col = UIColor.redColor()
            default:
                col = UIColor.grayColor()
        }
        
        self.rect?.removeFromSuperview()
        
        let x = self.getPosLeft(pos)
        let y = CGFloat(5)
        let w = CGFloat(self.NOTE_WIDTH)
        let h = CGFloat(self.getBottomStaff())
        
        let rectFrame = CGRectMake(x,y,w,h)
        self.rect = UIView(frame : rectFrame)
        self.rect?.backgroundColor = col
        self.rect?.alpha = 0.5
        self.addSubview(self.rect!)
    }
    
    func getPosLeft(pos : Int) -> CGFloat{
        var noteLeft = (((Double(self.NOTE_WIDTH) + Double(self.PADD_BETW_NOTES)) * Double(pos)))
        return CGFloat(Double(self.PADDING) + noteLeft)
    }
    
    func getBottomStaff() -> Int{
        return (self.LINE_PLACE + ((4+3) * self.LINE_SPACE));
    }
    
    override func drawRect(rect: CGRect) {
        self.staff.frame = rect
    }
    
    func tapOnStaff(recognizer: UITapGestureRecognizer)
    {
        let pointInView = recognizer.locationInView(self)
        println("x=\(pointInView.x),y=\(pointInView.y)");
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}