//
//  ViewController.swift
//  test1
//
//  Created by m2sar on 11/02/2015.
//  Copyright (c) 2015 m2sar. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var maScroll: UIScrollView!
    var imageView: UIImageView!
    
    @IBOutlet weak var deuxieme: UIScrollView!
    
    @IBOutlet weak var labelY: UILabel!
    @IBOutlet weak var labelX: UILabel!
    
    let longueurCorde = 2150
    let miG = 10// mi grave
    let la = 30
    let re = 50
    let sol = 70
    let si = 90
    let miA = 110 //mi aigu
    
    
    var frettes = [Float]()
    
    func F(n : Int) -> Float{
        var exp = Float(n)/Float(12)
        var l = Float(longueurCorde) / powf(Float(2), exp)
        return l
    }
    
    func calculerFrettes(){
        for i in 1...22 {
            frettes.append(Float(longueurCorde) - F(i))
        }
    }
    
    /*func calculerNotes(x: CGFloat, y: CGFloat){
        
        if y < 
        for i in frettes {
            
        }
        
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        let image = UIImage(named: "guitar_neck_right.jpg")!
        imageView = UIImageView(image: image);
        imageView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size:image.size);
        maScroll.addSubview(imageView);
        
        // 2
        maScroll.contentSize = image.size;
        
        // 3
        var doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "scrollViewDoubleTapped:");
        doubleTapRecognizer.numberOfTapsRequired = 1;
        doubleTapRecognizer.numberOfTouchesRequired = 1;
        maScroll.addGestureRecognizer(doubleTapRecognizer);
        
        // 4
        let scrollViewFrame = maScroll.frame
        
        let scaleWidth = scrollViewFrame.size.width / maScroll.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / maScroll.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        maScroll.minimumZoomScale = minScale;
        
        // 5
        maScroll.maximumZoomScale = 1.0
        maScroll.zoomScale = minScale;
        
        // 6
        //centerScrollViewContents()
    }
    
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        // 1
        let pointInView = recognizer.locationInView(imageView)
        
        println("x=\(pointInView.x),y=\(pointInView.y)");
        labelX.text = "x = \(pointInView.x)"
        labelY.text = "y = \(pointInView.y)"
        
        calculerFrettes()
        for element in frettes {
            println("Distance à partir du sillet : \(element)")
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
        // Dispose of any resources that can be recreated.
    }


}

