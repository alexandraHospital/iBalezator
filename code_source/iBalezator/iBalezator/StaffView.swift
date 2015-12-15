import UIKit

//1280 x 704
class StaffView : UIView{
    
    //private var controller = StaffController()
    var controller : StaffController?

    var cle = UIImageView()

    let NUMBER_OF_LINE = 5
    //let LINE_WIDTH =
    let LINE_HEIGHT = 1.5 as CGFloat

    let LINE_SPACE = 10 // en comptant l'épaisseur des lignes, donc 7 + 3
    
    //Place de la première ligne
    let LINE_PLACE = 35
    
    //Place de la dernière ligne
    var LINE_END = 0.0 as CGFloat
    
    //Taille (hauteur) de la note et également de l'espace
    //strict entre deux lignes (sans compter les lignes)
    let NOTE_HEIGHT = 8 as CGFloat
    
    //Largeur de la note
    let NOTE_WIDTH = 13.7 as CGFloat
    
    //Là où commence la portée (abscisse)
    let PADDING = 20.0 as CGFloat
    
    let PADD_BETW_NOTES = 15.0 as CGFloat
    
    let NOTE_PLACE = 60.0 as CGFloat
    
    let COEFF_CLE = 3.7 as CGFloat
    
    let STEP = 5 as CGFloat
    
    let OCTAVA_HEIGHT = 40 as CGFloat
    let OCTAVA_WIDTH = 40 as CGFloat
    var rect : UIView?
    var octava : UILabel?
    private var wrongNote : UIImageView?
    private var wrongSharp : UIImageView?
    private var lastSuppLines = [UIView]()
    
    override init (frame : CGRect){
        
        super.init(frame: frame)
        self.LINE_END = CGFloat(LINE_PLACE + LINE_SPACE * 4)
        self.drawNewStaff()

        var imgCle = UIImage(named : "cle_sol.png")
        cle.image = imgCle
        cle.frame = CGRectMake(CGFloat(LINE_PLACE), CGFloat(LINE_PLACE - LINE_SPACE), imgCle!.size.width/COEFF_CLE, imgCle!.size.height/COEFF_CLE)

 
    }
    
    func drawNewStaff()
    {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.addSubview(cle)
        
        for( var i = 0; i < NUMBER_OF_LINE; ++i )
        {
            var stfLine = UIView(frame:CGRectMake(PADDING, CGFloat(LINE_PLACE + (LINE_SPACE * i) ), self.frame.width - PADDING*2, LINE_HEIGHT))
            stfLine.backgroundColor = UIColor.blackColor()
            self.addSubview(stfLine)
        }
        
    }
      
    func drawQuestionNote(x : CGFloat, y : CGFloat)
    {
        var imgHN = UIImage(named : "whole_note.png")
        var noteIV =  UIImageView(frame : CGRectMake(x + NOTE_PLACE, y + 2, NOTE_WIDTH, NOTE_HEIGHT))
        noteIV.image  = imgHN
        self.drawLineV2(x,y:y, isBad : false)
        self.addSubview(noteIV)
    }
    
    func drawBadNote(x : CGFloat, y : CGFloat)
    {
        var imgHN = UIImage(named : "whole_bad_note.png")
        self.wrongNote =  UIImageView(frame : CGRectMake(x + NOTE_PLACE + (self.PADD_BETW_NOTES*2), y + 2, NOTE_WIDTH, NOTE_HEIGHT))
        self.wrongNote?.image  = imgHN
        self.drawLineV2(x + (self.PADD_BETW_NOTES*2),y:y, isBad : true)
        self.addSubview(self.wrongNote!)
    }
    
    func deleteBadNote(){
        self.wrongNote?.removeFromSuperview()
        self.wrongSharp?.removeFromSuperview()
        
        for(var i = 0; i < self.lastSuppLines.count; ++i){
            self.lastSuppLines[i].removeFromSuperview()
        }
        self.lastSuppLines.removeAll()
    }

    func drawLineV2(x : CGFloat, y : CGFloat, isBad : Bool)
    {
        var nbrLine :CGFloat ;
        var topLine : CGFloat;
        var lstLinesTop = [CGFloat]()
        
        //println("y = \(y), le = \(self.LINE_END), ")
        
        if(y > self.LINE_END)
        {
            nbrLine = ((y - CGFloat(self.LINE_END)) / self.STEP)
            nbrLine = CGFloat((Int(nbrLine) + 1) / 2)
            //println("nbl = \(nbrLine)");
            
            for (var i = 1; i <= Int(nbrLine);  ++i)
            {
                var stfLine = UIView(frame:CGRectMake(x + NOTE_PLACE - 5, CGFloat(Int(LINE_END) + (LINE_SPACE * i)), NOTE_WIDTH + 10, LINE_HEIGHT))
                stfLine.backgroundColor = UIColor.grayColor()
                if(isBad){
                    self.lastSuppLines.append(stfLine)
                }
                self.addSubview(stfLine)
            }
        }
        else{
            
            topLine = CGFloat(self.LINE_PLACE) - CGFloat(2 * Int(self.STEP))
            
            if(y <= topLine)
            {
                nbrLine = abs(((y - CGFloat(topLine)) / CGFloat(STEP)))
                println("\(topLine), \(nbrLine)")
                
                if(nbrLine == 1.0 || nbrLine >= 2.0 ){
                    lstLinesTop.append(topLine)
                }
                
                if(nbrLine == 3.0 || nbrLine >= 4.0 ){
                    lstLinesTop.append(topLine - (self.STEP * 2) )
                }
                
                for (var i = 0; i < lstLinesTop.count;  ++i)
                {
                    var stfLine = UIView(frame:CGRectMake(x + NOTE_PLACE - 5, lstLinesTop[i], NOTE_WIDTH + 10, LINE_HEIGHT))
                    stfLine.backgroundColor = UIColor.grayColor()
                    if(isBad){
                        self.lastSuppLines.append(stfLine)
                    }
                    self.addSubview(stfLine)
                }
            }
        }
    }
    
    func drawBadSharp(x : CGFloat, y : CGFloat)
    {
        var imgS = UIImage(named : "bad_sharp.png")
        self.wrongSharp = UIImageView(frame : CGRectMake(x + NOTE_PLACE + (self.PADD_BETW_NOTES*2)-self.NOTE_WIDTH, y, self.NOTE_HEIGHT, self.NOTE_WIDTH))
        self.wrongSharp?.image  = imgS
        self.addSubview(self.wrongSharp!)
    }
    
    func drawQuestionSharp(x : CGFloat, y : CGFloat)
    {
        var imgS = UIImage(named : "sharp.png")
        var imgViewS = UIImageView(frame : CGRectMake(x + NOTE_PLACE - self.NOTE_WIDTH, y, self.NOTE_HEIGHT, self.NOTE_WIDTH))
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
        
        println("rect\(pos)")
        let rectFrame = CGRectMake(x + NOTE_PLACE, y, w, h)
        self.rect = UIView(frame : rectFrame)
        self.rect?.backgroundColor = col
        self.rect?.alpha = 0.5
        self.addSubview(self.rect!)
    }
    
    func getPosLeft(pos : Int) -> CGFloat{
        var noteLeft = (((Double(self.NOTE_WIDTH) + Double(self.PADD_BETW_NOTES)) * Double(pos)))
        println("\(CGFloat(Double(self.PADDING) + noteLeft))")
        return CGFloat(Double(self.PADDING) + noteLeft)
    }
    
    func getBottomStaff() -> Int{
        return (self.LINE_PLACE + ((4+3) * self.LINE_SPACE));
    }

    
    func drawOctava(x: CGFloat) {
        self.octava = UILabel(frame: CGRectMake(PADDING + (x * (NOTE_WIDTH + PADD_BETW_NOTES) + NOTE_PLACE) , CGFloat(LINE_PLACE) - 45.0 , OCTAVA_HEIGHT, OCTAVA_WIDTH))
        self.octava?.text = "8va"
        self.addSubview(self.octava!)
    }

    
    func maxNotesOnStaff() -> Int {
        let ecran = UIScreen.mainScreen()
        
        if (ecran.bounds.width == 480) {        //4s
            return 12
        }
            
        else if (ecran.bounds.width == 568) {  //5 et 5s
            return 15
        }
            
        else  {                                 //6
            return 19
        }

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}