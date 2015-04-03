//
//  ViewController.swift
//  BarChart
//
//  Created by Matt Solano on 3/11/15.
//  Copyright (c) 2015 mattSOLANO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//    let panGestureRecognizer = UIPanGestureRecognizer()
    
    let chartData: [CGFloat] =  [4, 5, 8, 3, 10, 9, 1, 2, 5, 3, 7, 7, 0, 3, 9]
    var barViews: [UIView] = []
    
    
    let barWidth: CGFloat = 40,
        barGutter: CGFloat = 8
    var barLeft: CGFloat = 0
    
    var chartView = UIView()
    
    func sayHello() {
        println("hello");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var totalBars = CGFloat(chartData.count)
        var chartWidth = totalBars * (barWidth + barGutter)
        
        chartView = UIView(frame: CGRect(x: 20, y: 200, width: chartWidth, height: 200))
        chartView.clipsToBounds = true;
        
//        panGestureRecognizer.addTarget(self, action: "panAction")
//        chartView.addGestureRecognizer(panGestureRecognizer)
        
        for (index, i) in enumerate(chartData) {
            var barHeight = i * 20
            var barDuration: CGFloat = (barHeight / 200) + 0.0
            
            var barDelay = ((CGFloat(index) / CGFloat(totalBars)) ) + 0.3
            
            
            let newBarView = UIButton(frame: CGRectMake(barLeft , 200, barWidth, barHeight))
            newBarView.backgroundColor = UIColor(red: 80/255, green: 67/255, blue: 117/255, alpha: 1)
            newBarView.addTarget(self, action: "sayHello", forControlEvents: UIControlEvents.TouchUpInside)
            
            chartView.addSubview(newBarView)
            
            UIView.animateWithDuration(NSTimeInterval(0.8),
                delay: NSTimeInterval(barDelay),
                usingSpringWithDamping: 1,
                initialSpringVelocity: 7,
                options: UIViewAnimationOptions.AllowUserInteraction,
                animations: {
                    newBarView.transform = CGAffineTransformMakeTranslation(0, 0 - barHeight)
                }, completion: nil)
            
            
            barViews.append(newBarView)
            
            barLeft = barLeft + barWidth + barGutter
        }
        
        self.view.addSubview(chartView)

        
    }
    
//    func panAction(imgView:UIPanGestureRecognizer){
//        let distanceMoved = imgView.translationInView(self.view)
//        imgView.view!.center = CGPoint(x: imgView.view!.center.x + distanceMoved.x, y: imgView.view!.center.y + distanceMoved.y)
//        imgView.setTranslation(CGPointZero, inView: self.view)
//    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

