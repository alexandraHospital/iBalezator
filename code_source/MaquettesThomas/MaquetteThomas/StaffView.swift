import UIKit

class StaffView : UIImageView{
    
    private let staff = UIImageView()
    
    override init (frame : CGRect){
        super.init(frame: frame)
        let imgStaff = UIImage(named : "staff.jpg")
        self.image = imgStaff
    }
    
    override func drawRect(rect: CGRect) {
        self.staff.frame = rect
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}