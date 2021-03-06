//
//  UITableViewCell.swift
//  Apprtc
//
//  Created by Mahabali on 9/5/15.
//  Copyright (c) 2015 Mahabali. All rights reserved.
//

import UIKit



protocol RTCRoomTextInputViewCellDelegate{
    func shouldJoinRoom (room:NSString,textInputCell:RTCRoomTextInputViewCell)
}


class RTCRoomTextInputViewCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var textField:UITextField?
    @IBOutlet weak var textFieldBorderView:UIView?
    @IBOutlet weak var joinButton:UIButton?
    @IBOutlet weak var errorLabel:UILabel?
    @IBOutlet weak var errorLabelHeightConstraint:NSLayoutConstraint?
    var delegate:RTCRoomTextInputViewCellDelegate?
    
    override func awakeFromNib() {
        self.errorLabelHeightConstraint?.constant=0.0
        self.textField?.delegate=self
        self.textField?.becomeFirstResponder()
        self.joinButton?.backgroundColor=UIColor(white: 100/255, alpha: 1.0)
        self.joinButton?.enabled=true
        self.joinButton?.layer.cornerRadius=3.0
        
    }
    
    @IBAction func touchButtonPressed (sender:UIButton){
        if self.delegate?.shouldJoinRoom(self.textField!.text!, textInputCell: self) != nil{
            NSLog("Delegate was implemented");
        }
    }
    //Mark - UITextFieldDelegate Methods
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let isBackspace = string.isEmpty && range.length == 1
        var text:NSString = NSString(format: "%@%@", textField.text!,string)
        if (isBackspace && text.length>1){
            text=text.substringWithRange(NSMakeRange(0, text.length-2))
        }
        if (text.length>5){
            UIView.animateWithDuration(3.0, animations: { () -> Void in
                self.errorLabelHeightConstraint?.constant=0.0
                self.textFieldBorderView?.backgroundColor=UIColor(red: 66.0/2555.0, green: 133.0/255.0, blue: 244.0/255.0, alpha: 1.0)
                self.joinButton?.enabled=true
                self.layoutIfNeeded()
            })
            
        }
        else{
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.errorLabelHeightConstraint?.constant=0.0
                self.textFieldBorderView?.backgroundColor=UIColor(red: 66.0/2555.0, green: 133.0/255.0, blue: 244.0/255.0, alpha: 1.0)
                self.joinButton?.enabled=true
                self.layoutIfNeeded()
            })
        }
        
        return true
    }
    
    
}
