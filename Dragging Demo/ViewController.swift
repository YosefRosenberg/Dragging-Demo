//
//  ViewController.swift
//  Dragging Demo
//
//  Created by Yosef Rosenberg on 4/28/16.
//  Copyright © 2016 Yosef Rosenberg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Sets the label called "Drag me!" and places it in the middle
        let label = UILabel(frame: CGRectMake(self.view.bounds.width / 2 - 100, self.view.bounds.height / 2 - 50, 200, 100))
       
        label.text = "Drag me!"
        
        label.textAlignment = NSTextAlignment.Center
        
        self.view.addSubview(label)
        
        // The colon passes on information otherwise it doesn't
        let gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
        
        label.addGestureRecognizer(gesture)
        
        label.userInteractionEnabled = true
    }
    
    func wasDragged(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translationInView(self.view)
        
        let label = gesture.view!
        
        label.center = CGPoint(x: self.view.bounds.width / 2 + translation.x, y: self.view.bounds.height / 2 + translation.y)
        
        let xFromCenter = label.center.x - self.view.bounds.width / 2
        
        // Allows the label to be at 1 in teh center but get smaller as it moves from center, the min and 1 limit it from being bigger than 1.
        let scale = min(100 / abs(xFromCenter), 1)
        
        // 1 corresponds to about 60 degrees
        var rotation = CGAffineTransformMakeRotation(xFromCenter / 200)
        
        // 1 corresponds to origional size so this is just slightly smaller
        var stretch = CGAffineTransformScale(rotation, scale, scale)
        
        label.transform = stretch
        

        
        //This piece of code allows the label to return to center when you release your finger
        if gesture.state == UIGestureRecognizerState.Ended {
            
            if label.center.x < 100 {
                
                print("Not Chosen")
                
            } else if label.center.x > self.view.bounds.width - 100 {
                
                print ("Chosen")
            }
            
            //Sets our label to how it was originally
            rotation = CGAffineTransformMakeRotation(0)
            
            stretch = CGAffineTransformScale(rotation, 1, 1)
            
            label.transform = stretch
            
            label.center = CGPoint(x: self.view.bounds.width / 2, y: self.view.bounds.height / 2)
            
        }
        
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

