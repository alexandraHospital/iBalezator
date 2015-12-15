import UIKit

class NeckView : UIScrollView,UIScrollViewDelegate{
    
    private let uimgV = UIImageView()
    private let labTmp = UILabel()
    private let control = NeckController()
    
    override init (frame : CGRect)
    {
        super.init(frame: frame)
        
        var imgNeck = UIImage(named : "neck.png")
        
        uimgV.image = imgNeck
        
        if(UIScreen.mainScreen().bounds.width == 480)
        { // 4s
            uimgV.frame = CGRectMake(0, 0, 1650, self.frame.height)
        }else{
            uimgV.frame = CGRectMake(0, 0, (imgNeck!.size.width*self.frame.height)/imgNeck!.size.height, self.frame.height)
        }
            
        var tapRec = UITapGestureRecognizer(target: self, action: "tapOnNeck:");
        tapRec.numberOfTapsRequired = 1;
        tapRec.numberOfTouchesRequired = 1;
        self.addGestureRecognizer(tapRec)
        
        labTmp.frame = CGRectMake(0, 0, 80, 50)
        labTmp.textColor = UIColor.redColor()
        labTmp.backgroundColor = UIColor.whiteColor()
        
        self.delegate=self
        self.contentSize = uimgV.frame.size
        self.addSubview(uimgV)
        self.addSubview(labTmp)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //self.setContentOffset(CGPointMake(555, 0), animated: true)
        //self.control.closestFret()
       // println("\(control.closestFret(Int(self.contentOffset.x)))")
        self.setContentOffset(CGPointMake(CGFloat(control.closestFret(Int(self.contentOffset.x))), 0), animated: true)
    }

    
    func tapOnNeck(recognizer: UITapGestureRecognizer)
    {
        let pointInView = recognizer.locationInView(uimgV)
        println("x=\(pointInView.x),y=\(pointInView.y)");
        
        var pos = control.pointToPosition(pointInView.x, y1: pointInView.y)
        //println("corde = \(pos.0), frette = \(pos.1)")
        
        var note = Note(frette: pos.0, corde: pos.1)
        println("C'est un \(note.getName()) !")
        

       // println("Partie visible : \(self.contentOffset.x) , \(self.contentOffset.x + self.bounds.width) ")
        
        let rand = control.randomNote(self.contentOffset.x, x2: self.contentOffset.x + self.bounds.width);
        labTmp.text = note.getName() + "/" + rand
        labTmp.frame = CGRectMake(self.contentOffset.x, 0, 80, 50)
    }
}
