import UIKit

class ViewController: UIViewController {
    
    /*let staffNeck : UIView
    let neckKeyb : UIView
    var mode : Int*/
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.neckKeybMode()
    }
    
    func neckKeybMode()
    {
        for view in self.view.subviews
        {
            view.removeFromSuperview()
        }
        
        println("mimi");
        
        let ecran = UIScreen.mainScreen();
        var neckKeyb : UIView;
        
        var hScore = ((ecran.bounds.height * 10.5) / 100)
        var hNeck = ((ecran.bounds.height * 54.5)  / 100)
        var hKeyb = ((ecran.bounds.height * 35)    / 100)
        
        var score = ScoreView(frame: CGRectMake(0, 0, ecran.bounds.width, hScore))
        var neck = NeckView(frame: CGRectMake(0, hScore, ecran.bounds.width, hNeck))
        var keyb = KeybordView(frame: CGRectMake(0, hScore + hNeck, ecran.bounds.width, hKeyb) )
        score.setmyVc(self)
        score.setMode(true)
        
        self.view.addSubview(score)
        self.view.addSubview(neck)
        self.view.addSubview(keyb)
        
    }
    
    func staffNeckMode()
    {
        for view in self.view.subviews
        {
            view.removeFromSuperview()
        }
        
        println("momo")
        
        let ecran = UIScreen.mainScreen()
        var staffNeck : UIView
        /* Portée / Manche */
        var hScore = ((ecran.bounds.height * 10.5) / 100)
        var hStaff = ((ecran.bounds.height * 35) / 100)
        var hNeck = ((ecran.bounds.height * 54.5) / 100)
        
        var score = ScoreView(frame: CGRectMake(0, 0, ecran.bounds.width, hScore))
        var staff = StaffView(frame: CGRectMake(0, hScore, ecran.bounds.width, hStaff))
        var neck = NeckView(frame: CGRectMake(0, hScore + hStaff, ecran.bounds.width, hNeck))
        score.setmyVc(self)
        score.setMode(false)
        
        self.view.addSubview(score)
        self.view.addSubview(staff)
        self.view.addSubview(neck)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}