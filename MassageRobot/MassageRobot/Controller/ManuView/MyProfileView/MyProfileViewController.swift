//
//  MyProfileViewController.swift
//  MassageRobot
//
//  Created by Augmenta on 09/03/21.
//

import UIKit

class MyProfileViewController: UIViewController {

    @IBOutlet var lblAge: UILabel!
    @IBOutlet var lblGender: UILabel!
    @IBOutlet var lblEthniciy: UILabel!
    @IBOutlet var lblPreferredUnits: UILabel!
    @IBOutlet var lblWeight: UILabel!
    @IBOutlet var lblFeet: UILabel!
    @IBOutlet var lblMarried: UILabel!
    @IBOutlet var lblChildren: UILabel!
    @IBOutlet var lblCountry: UILabel!
    @IBOutlet var lblIncome: UILabel!
    @IBOutlet var lblOccupation: UILabel!
    @IBOutlet var lblSelfEmployeed: UILabel!
    @IBOutlet var lblLanguage: UILabel!
    @IBOutlet var lblAddress: UILabel!
    
    var arrMyProfileData = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.setUserProfileDataService()
    }
    
    func setUserProfileDataService() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        if userID != "" {
            let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from Userprofile where userid='\(userID)''"
            
            print(url)
            
            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            callAPI(url: encodedUrl!) { [self] (json, data1) in
                print(json)
                if json.getString(key: "status") == "false"
                {
                    let string = json.getString(key: "response_message")
                    let data = string.data(using: .utf8)!
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>]
                        {
    //                        arrMyProfileData = jsonArray
                            let profileData = jsonArray[0]
                            
                            lblAge.text = profileData.getString(key: "age")
                            lblGender.text = profileData.getString(key: "gender")
                            lblEthniciy.text = profileData.getString(key: "ethnicity")
                            lblPreferredUnits.text = profileData.getString(key: "units")
                            lblWeight.text = profileData.getString(key: "weight")
                            lblFeet.text = profileData.getString(key: "height")
                            lblMarried.text = profileData.getString(key: "marital")
                            lblChildren.text = profileData.getString(key: "children")
                            lblCountry.text = profileData.getString(key: "country")
                            lblIncome.text = profileData.getString(key: "income")
                            lblOccupation.text = profileData.getString(key: "occupation")
                            lblSelfEmployeed.text = profileData.getString(key: "selfemployeed")
                            lblLanguage.text = profileData.getString(key: "language")
                            lblAddress.text = profileData.getString(key: "address")
                        } else {
                            showToast(message: "Bad Json")
                        }
                    } catch let error as NSError {
                        print(error)
                        showToast(message: error as! String)
                    }
            }
         }
      }
    }
    
    @IBAction func btnUpdateProfileAction(_ sender: UIButton) {
        performSegue(withIdentifier: "UpdateProfileViewController", sender: nil)
    }
    
    @IBAction func btnRunCalibrationAction(_ sender: UIButton) {
        
    }
}
