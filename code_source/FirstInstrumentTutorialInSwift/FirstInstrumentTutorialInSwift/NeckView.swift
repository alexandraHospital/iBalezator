import UIKit

class NeckView : UIScrollView,UIScrollViewDelegate{
    
    private let imgPendingMarker = UIImage(named : "pending.png")
    private let imgSucceedMarker = UIImage(named : "succeed.png")
    private let imgFailedMarker = UIImage(named : "failed.png")
    
    private let uimgV = UIImageView()
    private let marker = UIImageView()
    private let wrongMarker = UIImageView()
    private let rightMarker = UIImageView()
    var controller : NeckController?
    
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
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.addGestureRecognizer(swipeUp)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.addGestureRecognizer(swipeDown)
        
        
        self.delegate=self
        self.contentSize = uimgV.frame.size
        
        self.addSubview(uimgV)
        self.addSubview(self.marker)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer){
        self.controller?.swipeUp();
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        //self.setContentOffset(CGPointMake(555, 0), animated: true)
        //self.control.closestFret()
        // println("\(control.closestFret(Int(self.contentOffset.x)))")
        self.setContentOffset(CGPointMake(CGFloat(controller!.closestFret(Double(self.contentOffset.x))), 0), animated: true)
        self.controller?.endScroll()
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView!, withVelocity velocity: CGPoint, targetContentOffset: UnsafePointer<CGPoint>){
        println("Release")
        self.setContentOffset(CGPointMake(CGFloat(controller!.closestFret(Double(self.contentOffset.x))), 0), animated: true)
        self.controller?.endScroll()
    }
    
    func tapOnNeck(recognizer: UITapGestureRecognizer)
    {
        let pointInView = recognizer.locationInView(uimgV)
        self.controller!.tapOnNeck(pointInView.x, y : pointInView.y);
        
        //On tire une note aléatoire et on la donne au modèle
        //var randomNote = self.controller!.randomNote(pointInView.x, x2 : pointInView.y)
        //self.controller!.superController?.gameModel.curQuestion = randomNote
        
        //var note = self.controller!.superController?.gameModel.curQuestion // TODO changer ça
        
        //self.addMarker(note!)
        
        println("x : \(pointInView.x) y : \(pointInView.y)")
    }
    
    func markerPending(note: Note)
    {
        self.deleteMarker(self.rightMarker)
        self.putMarker(note, image : self.imgPendingMarker! )
    }
    
    private func putMarker(note : Note, image : UIImage)
    {
        var position = self.controller?.noteToPoint(note)
        marker.image = image
        marker.frame = CGRectMake(position!.1 - (image.size.height/2), position!.0 - (image.size.width/2), image.size.width/2, image.size.height/2)
        
    }
    
    func putWrongMarker(note: Note) {
        var position = self.controller?.noteToPoint(note)
        
        wrongMarker.image = imgFailedMarker;
        wrongMarker.frame = CGRectMake(position!.1 - (imgFailedMarker!.size.height/2), position!.0 - (imgFailedMarker!.size.width/2), imgFailedMarker!.size.width/2, imgFailedMarker!.size.height/2)
        deleteMarker(rightMarker)
        self.addSubview(wrongMarker)
    }
    
    func putRightMarker(note: Note)
    {
        var position = self.controller?.noteToPoint(note)
        rightMarker.image = imgSucceedMarker;
        rightMarker.frame = CGRectMake(position!.1 - (imgSucceedMarker!.size.height/2), position!.0 - (imgSucceedMarker!.size.width/2), imgSucceedMarker!.size.width/2, imgSucceedMarker!.size.height/2)
        self.deleteMarker(wrongMarker)
        self.addSubview(rightMarker)
    }
    
    func deleteMarker(view: UIImageView) {
        view.removeFromSuperview();
    }
}
