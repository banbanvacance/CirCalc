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
    
    //ボタンのタイトルの数字を表示部に表示する。
    @IBAction func buttonNumber(_ sender: UIButton) {
        let title = sender.title(for:UIControlState.normal)!
        if(nearNumber(num:output.text!) != "0" && getPre(num:output.text!) != ")"){
            output.text = output.text! + title
        }
    }
    
    //小数点を表示部に表示する。
    @IBAction func buttonPoint(_ sender: UIButton) {
        if(isInPoint(num: nearNumber(num: output.text!)) == false){
            output.text = output.text! + "."
        }
    }
    @IBAction func buttonShisoku(_ sender: AnyObject) {
        let title = sender.title(for:UIControlState.normal)!
        let pre = getPre(num:output.text!)
        if(isInSignal(num: pre) == false){
            output.text = output.text! + title
        }
    }
    
    //カッコを入力する。
    @IBAction func buttonKakko(_ sender: UIButton) {
        let bool = kakkoToji(num: output.text!).0
        let i = kakkoToji(num: output.text!).1
        let pre = getPre(num:output.text!)
        let shiki = (output.text! as NSString).substring(from:output.text!.characters.count - i)
        if(isInSignal(num: pre) == true || pre == ""){
            if(bool == true){
                output.text = output.text! + "("
            }
        }else if(isInSignal(num: shiki) == true && isInSignal(num: pre) == false){
            if(bool == false){
                output.text = output.text! + ")"
            }
        }
    }
    
    //表示部の文字を全てクリアする
    @IBAction func crearNum(_ sender: AnyObject) {
        output.text = ""
    }
    
    //表示部の文字を１文字削除
    @IBAction func deleteNum(_ sender: AnyObject) {
        var str:String = output.text!
        if(str.characters.count > 0){
            str  = (str as NSString).substring(to:str.characters.count-1)
        }
        output.text = str
    }
    
    @IBAction func equal(_ sender: UIButton) {
        let str:String = output.text!
        if(suushikiCheck(num: str)){
            let expression = NSExpression(format: str)
            let out = expression.expressionValue(with: nil, context: nil) as! Double
            let textout: String! = output.text! + "=" + String(out)
            output.text! = String(out)
            //LINE連携仕掛り中
            let ngalert = UIAlertController(title: "LINE送信", message: "LINEに送信しますか？", preferredStyle:  UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "はい", style: .default) {
                action in NSLog("OK！")
                let allowedCharacterSet = NSMutableCharacterSet.alphanumeric()
                allowedCharacterSet.addCharacters(in:"-._~")
                let encodeMessage: String! = (textout as NSString).addingPercentEncoding(withAllowedCharacters: allowedCharacterSet as CharacterSet)!
                let messageURL: NSURL! = NSURL( string: "line://msg/text/" + encodeMessage )
                
                if (UIApplication.shared.canOpenURL(messageURL as URL)) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(messageURL  as URL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(messageURL  as URL)
                    }
                }
            }
            let cancelAction = UIAlertAction(title: "いいえ", style: .cancel) {
                action in NSLog("Cancel！")
            }
            ngalert.addAction(okAction)
            ngalert.addAction(cancelAction)
            present(ngalert, animated: true, completion: nil)
        }
    }
    
    //数式が正しいかチェックする。正しくない場合、アラートを表示。
    func suushikiCheck(num:String) -> Bool{
        var bool:Bool = true
        let str:String = output.text!
        let ngalert = UIAlertController(title: "数式不正エラー", message: "数式を正しく入れてください", preferredStyle:  UIAlertControllerStyle.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style:UIAlertActionStyle.default, handler:{
            (action: UIAlertAction!) -> Void in
        })
        ngalert.addAction(defaultAction)
        
        if(kakkoToji(num: str).0 == false || isInSignal(num: getPre(num: str)) == true){
            present(ngalert, animated: true, completion: nil)
            bool = false
        }
        return bool
    }
    
    
    
    //直前に入力されている文字を取得する。
    func getPre(num:String) -> String{
        let index:Int = num.characters.count
        var pre = ""
        if(index > 0){
            pre = (num as NSString).substring(from: index - 1)
        }
        return pre
    }
    
    //直前に入力されている数字の固まりを取得する。
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
        return String(nnum)
    }
    
    //引数の文字が四則演算かどうかを判定する。
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
    
    func isInPoint(num:String) -> Bool {
        var bool = false
        for index in num.characters.reversed() {
            if(index == "."){
                bool = true
                break
            }
        }
        return bool
    }
    
    //カッコが閉じられているかチェック、する。
    func kakkoToji(num:String) -> (Bool,Int) {
        var bool = true
        var i = 0
        for index in num.characters.reversed() {
            if(index == "(" ){
                bool = false
                break
            }else if(index == ")"){
                bool = true
                break
            }
            i = i + 1
        }
        return (bool,i)
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

