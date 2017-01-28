//
//  MyButton.swift
//  Calc2
//
//  Created by 板東慶一郎 on 2017/01/10.
//  Copyright © 2017年 板東慶一郎. All rights reserved.
//

import Foundation
import UIKit

class MyButton: UIButton {
    
    var myStatus: ButtonStatus!
    enum ButtonStatus {
        case Normal
        case TouchBegan
        case TouchEnded
    }
    
    var start:CGFloat = 0.0 // 開始の角度
    var end :CGFloat = 0.0 // 終了の角度
    var peace :CGFloat = 0.0
    var divnum :Int = 0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        myStatus = .Normal
    }
    
    func setDivideNum(divNum:Int,startNum:Int){
        divnum = divNum
        peace = 2 * CGFloat(M_PI) / CGFloat(divNum)
        start = peace * CGFloat(startNum)
        end = start + peace
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        var tapLocation: CGPoint = CGPoint()
        let touch = touches.first
        tapLocation = touch!.location(in: self)
        print("Touch")
        print(distance(a: CGPoint(x:self.frame.origin.x,y:self.frame.origin.y),b: tapLocation))
        if(distance(a: CGPoint(x:self.frame.origin.x,y:self.frame.origin.y),b: tapLocation) < 200){
            print("In Touch!")
            super.touchesBegan(touches as Set<NSObject> as! Set<UITouch>, with: event)
            self.myStatus = .TouchBegan
            self.setNeedsDisplay()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches as Set<NSObject> as! Set<UITouch>, with: event)
        
        myStatus = .TouchEnded
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        let width = rect.width, height = rect.height
        
                    let color = UIColor(red: 0.081, green: 1.000, blue: 0.421, alpha: 1.000)
            
            // ボタンの形状を定義.
            for i in 0...divnum-1 {
                start = start + peace
                end = end + peace
                let path: UIBezierPath = UIBezierPath();
                path.move(to: CGPoint(x:self.frame.width/2, y:self.frame.height/2))
                path.addArc(withCenter: CGPoint(x:self.frame.width/2, y:self.frame.height/2), radius: 100, startAngle: start, endAngle: end, clockwise: true) // 円弧
            
                let layer = CAShapeLayer()
                layer.fillColor = UIColor.orange.cgColor
                layer.path = path.cgPath
                self.layer.addSublayer(layer)
            }
            
        //} else if myStatus == .TouchBegan {
            // 色の定義.
        
    }
    
    func distance(a:CGPoint, b:CGPoint) -> Double {
        return sqrt(Double(pow(b.x - a.x, 2)) + Double(pow(b.y - a.y, 2)))
    }
}
