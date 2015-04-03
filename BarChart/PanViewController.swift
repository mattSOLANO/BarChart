//
//  PanViewController.swift
//  BarChart
//
//  Created by Matt Solano on 3/13/15.
//  Copyright (c) 2015 mattSOLANO. All rights reserved.
//

import UIKit

class PanViewController: UIViewController {
    
    let chartData: [CGFloat] =  [4, 5, 8, 3, 10, 9, 1, 2, 5, 3, 7, 7, 5, 3, 9, 4, 5, 8, 3, 10, 9, 1, 2, 5, 3, 7, 7, 6, 3, 9]

    var hold = false
    var leftPos:CGFloat = 0
    var rightPos:CGFloat = 0
    
    let barWidth: CGFloat = 40,
    barGutter: CGFloat = 8
    var barLeft: CGFloat = 0
    
    @IBOutlet weak var panningView: UIView!
    
    func sayHello() {
        println("hello");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.clipsToBounds = true
        
        var totalBars = CGFloat(chartData.count)
        var chartWidth = totalBars * (barWidth + barGutter)
        panningView.frame = CGRectMake(20, 200, chartWidth, 200)
        panningView.clipsToBounds = true
        
        for (index, i) in enumerate(chartData) {
            var barHeight = i * 20
            var barDuration: CGFloat = (barHeight / 200) + 0.0
            
            var barDelay = ((CGFloat(index) / CGFloat(totalBars)) * 2 ) + 0.3
            
            
            let newBarView = UIButton(frame: CGRectMake(barLeft , 200, barWidth, barHeight))
            newBarView.backgroundColor = UIColor(red: 80/255, green: 67/255, blue: 117/255, alpha: 1)
            newBarView.addTarget(self, action: "sayHello", forControlEvents: UIControlEvents.TouchUpInside)
            
            let barText = UILabel(frame: CGRectMake(0, 0, barWidth, 20))
            barText.text = "\(i)"
            barText.textColor = UIColor(red: 200/255, green: 187/255, blue: 237/255, alpha: 1)
            //barText.backgroundColor = UIColor(red: 70/255, green: 57/255, blue: 107/255, alpha: 1)
            barText.textAlignment = NSTextAlignment.Center
            barText.font = UIFont(name: barText.font.fontName, size: 13)
            barText.alpha = 0
            
            newBarView.addSubview(barText)
            
            panningView.addSubview(newBarView)
            
            UIView.animateWithDuration(NSTimeInterval(0.8),
                delay: NSTimeInterval(barDelay),
                usingSpringWithDamping: 1,
                initialSpringVelocity: 7,
                options: UIViewAnimationOptions.AllowUserInteraction,
                animations: {
                    newBarView.transform = CGAffineTransformMakeTranslation(0, 0 - barHeight)
                }, completion: nil)
            
            UIView.animateWithDuration(NSTimeInterval(1.1),
                delay: NSTimeInterval(barDelay + 0.6) ,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 7,
                options: UIViewAnimationOptions.AllowUserInteraction,
                animations: {
                    barText.alpha = 1
                }, completion: nil)
            
            barLeft = barLeft + barWidth + barGutter
        }
        
    }

    
    
    @IBAction func panAction(sender: UIPanGestureRecognizer) {
        rightPos = sender.view!.frame.maxX
        leftPos = sender.view!.frame.minX
        
        let distanceMoved = sender.translationInView(self.view)
        let velocity = sender.velocityInView(self.view)
        
        var totalBars = CGFloat(chartData.count)
        var chartWidth = totalBars * (barWidth + barGutter)
        
        if ( (distanceMoved.x > 0.0 && leftPos < 10) || (distanceMoved.x < 0.0 && rightPos > self.view.frame.width - 10)){
            sender.view!.center = CGPoint(x: sender.view!.center.x + distanceMoved.x, y: sender.view!.center.y)
            sender.setTranslation(CGPointZero, inView: self.view)
        }
        
        if sender.state == UIGestureRecognizerState.Ended {
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            
            let slideFactor = 0.15 * slideMultiplier
            
            var finalPoint =  sender.view!.center.x + (velocity.x * slideFactor)
            
            if velocity.x < 0 {
                
                finalPoint = max(finalPoint, (-chartWidth / 2) + (self.view.frame.width - 10))
                
            }
            else {
                finalPoint = min(max(finalPoint, 0), (chartWidth / 2) + 20)
            }
            
            
            UIView.animateWithDuration(Double(slideFactor * 2),
                delay: 0,
                options: (
                    UIViewAnimationOptions.CurveEaseOut |
                    UIViewAnimationOptions.AllowUserInteraction |
                    UIViewAnimationOptions.BeginFromCurrentState
                ),
                animations: {sender.view!.center.x = finalPoint },
                completion: nil)
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
