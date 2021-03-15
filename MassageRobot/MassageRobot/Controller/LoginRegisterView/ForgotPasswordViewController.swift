//
//  ForgotPasswordViewController.swift
//  MassageRobot
//
//  Created by Augmenta on 05/03/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var txtEmailPhone: UITextField!
    @IBOutlet weak var btnSendLink: UIButton!
    
    @IBOutlet weak var viewLeft: UIView!
    @IBOutlet weak var viewRight: UIView!
    
    @IBOutlet weak var lblNotified: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        viewLeft.dropShadow(color: UIColor.btnBGColor, opacity: 0.6, offSet: CGSize(width: -20, height: 8), radius: 5, scale: true)
        viewRight.dropShadow(color: UIColor.btnBGColor, opacity: 0.6, offSet: CGSize(width: 20, height: 8), radius: 5, scale: true)
        
        txtEmailPhone.delegate = self
    }
    
    @IBAction func btnSendLinkAction(_ sender: UIButton) {
        
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            
    }
}
