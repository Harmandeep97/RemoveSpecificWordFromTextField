//
//  ViewController.swift
//  RemoveSpecificWordFromTextField
//
//  Created by SIERRA on 12/12/18.
//  Copyright © 2018 SIERRA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTextFieldOut: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }

}


extension ViewController: UITextFieldDelegate {
    
    func isBackSpacePressed(str: String) -> Bool{
        
        let  char = str.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        return (isBackSpace == -92) ? true : false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let textRange = Range(range, in: text) {
            var updatedText = text.replacingCharacters(in: textRange,  with: string)
            if isBackSpacePressed(str: string) {
                let data = getString(str: textField.text ?? "")
                if data.0 {
                    let text = updatedText[...(data.1?.lowerBound)!]
                    textField.text = String(text)
                }
                return true
            }else{
                return true
            }
        }else{
            
            return true
        }
    }
    
    func findSign(str: String, arr: [String]) -> [String]{
        
        var arrTemp = arr
        if let range: Range<String.Index> = str.range(of: "@"){
            let cutedFirstHalf = String(str[range.lowerBound...])
            
            if let range: Range<String.Index> = cutedFirstHalf.range(of: " "){
                let anotherstr = cutedFirstHalf[..<range.lowerBound]
                arrTemp.append("\(anotherstr)")
                let strRemaining = cutedFirstHalf[range.lowerBound...]
                return findSign(str: String(strRemaining), arr: arrTemp)
            }else{
                if cutedFirstHalf != "@" {
                    arrTemp.append(cutedFirstHalf)
                }
                return arrTemp
            }
        }else{
            return arrTemp
        }
    }
    
    func getString(str: String) -> (Bool, Range<String.Index>?){
        
        let arrr = findSign(str: str, arr: [])
        if arrr.count > 0 {
            let text = arrr[arrr.count-1]
            if let range: Range<String.Index> = str.range(of: text){
                if str[range.upperBound...] == "" {
                    return (true, range)
                }else{
                    return (false, nil)
                }
            }else{
                return (false, nil)
            }
        }else{
            return (false, nil)
        }
    }

}























