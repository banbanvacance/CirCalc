//
//  ViewController.swift
//  Calc2
//
//  Created by 板東慶一郎 on 2016/12/04.
//  Copyright © 2016年 板東慶一郎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var output: UILabel!
    
    @IBAction func buttonOne(_ sender: UIButton) {
        output.text = output.text! + "1"
        
    }
    @IBAction func buttonTwo(_ sender: AnyObject) {
        output.text = output.text! + "2"
    }
    @IBAction func buttonThree(_ sender: AnyObject) {
        output.text = output.text! + "3"
    }
    @IBAction func buttonFour(_ sender: UIButton) {
        output.text = output.text! + "4"
    }
    @IBAction func buttonFive(_ sender: UIButton) {
        output.text = output.text! + "5"
        
    }
    @IBAction func buttonSix(_ sender: AnyObject) {
        output.text = output.text! + "6"
    }
    @IBAction func buttonSeven(_ sender: AnyObject) {
        output.text = output.text! + "7"
    }
    @IBAction func buttonEight(_ sender: UIButton) {
        output.text = output.text! + "8"
    }
    @IBAction func buttonNine(_ sender: UIButton) {
        output.text = output.text! + "9"
        
    }
    @IBAction func buttonZero(_ sender: AnyObject) {
        if(nearNumber(num:output.text!) != "0"){
            output.text = output.text! + "0"
        }
    }
    @IBAction func buttonZeroZero(_ sender: AnyObject) {
        if(nearNumber(num:output.text!) != "0"){
            output.text = output.text! + "00"
        }
    }
    @IBAction func buttonPoint(_ sender: UIButton) {
        output.text = output.text! + "."
    }
    @IBAction func buttonPlus(_ sender: AnyObject) {
        var pre = getPre(num:output.text!)
        if(isInSignal(num: pre) == false){
            output.text = output.text! + "+"
        }
    }
    @IBAction func buttonMinus(_ sender: AnyObject) {
        var pre = getPre(num:output.text!)
        if(isInSignal(num: pre) == false){
            output.text = output.text! + "-"
        }
    }
    @IBAction func buttonSum(_ sender: UIButton) {
        var pre = getPre(num:output.text!)
        if(isInSignal(num: pre) == false){
            output.text = output.text! + "*"
        }
    }
    @IBAction func buttonDivide(_ sender: UIButton) {
        var pre = getPre(num:output.text!)
        if(isInSignal(num: pre) == false){
            output.text = output.text! + "/"
        }
    }
    @IBAction func buttonKakko(_ sender: UIButton) {
        var bool = true
        var i = 0
        for index in output.text!.characters.reversed() {
            if(index == "(" ){
                bool = false
                break
            }else if(index == ")"){
                bool = true
                break
            }
            i = i + 1
        }
        var pre = getPre(num:output.text!)
        var shiki = (output.text! as NSString).substring(from:output.text!.characters.count - i)
        if(isInSignal(num: pre) == true || pre == ""){
            if(bool == true){
                output.text = output.text! + "("
            }
        }else if(isInSignal(num: shiki) == true && isInSignal(num: pre) == false){
            output.text = output.text! + ")"
        }
    }
    @IBAction func crearNum(_ sender: AnyObject) {
        output.text = ""
    }
    @IBAction func deleteNum(_ sender: AnyObject) {
        var str:String = output.text!
        if(str.characters.count > 0){
            str  = (str as NSString).substring(to:str.characters.count-1)
        }
        output.text = str
    }
    func getPre(num:String) -> String{
        var index:Int = num.characters.count
        var pre = ""
        if(index > 0){
            pre = (num as NSString).substring(from: index - 1)
        }
        return pre
    }
    func nearNumber(num:String) -> String {
        var nnum:String = ""
        var i:Int = 0
        for index in num.characters.reversed() {
            if(index == "+" || index == "-" || index == "*" || index == "/"){
                break
            }else{
                i = i + 1
            }
            nnum = (num as NSString).substring(from:num.characters.count - i)
        }
        print(nnum)
        return String(nnum)
    }
    func isInSignal(num:String) -> Bool {
        var bool = false
        for index in num.characters.reversed() {
            if(index == "+" || index == "-" || index == "*" || index == "/"){
                bool = true
                break
            }
        }
        return bool
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

