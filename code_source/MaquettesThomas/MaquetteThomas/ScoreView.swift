import UIKit

class ScoreView : UINavigationBar{
    
    private var score :UILabel;
    private var myVc :ViewController
    private var mode : Bool
    
    override init (frame : CGRect )
    {
        self.myVc = ViewController()
        self.score = UILabel(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 30))
        self.mode = false
        super.init(frame: frame)
        self.backgroundColor = UIColor.grayColor()
        
        var curDeg = UIButton()
        curDeg.frame = CGRectMake(0, 0, 50, 50)
        curDeg.backgroundColor = UIColor.greenColor()
        curDeg.setTitle("Mode", forState: UIControlState.Normal)
        curDeg.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        self.addSubview(curDeg)
        
    }
    
    func setMode(curMode : Bool){
        self.mode = curMode
    }
    
    func setmyVc(vc : ViewController){
        self.myVc = vc
    }
    
    func pressed(sender: UIButton!)
    {
        println(self.mode)
        if(self.mode){
            self.myVc.staffNeckMode()
        }else{
            self.myVc.neckKeybMode()
        }
    }
    
    func buttonAction(sender:UIButton!)
    {
        println("Button tapped")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}