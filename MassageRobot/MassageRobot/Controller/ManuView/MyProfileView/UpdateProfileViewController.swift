//
//  UpdateProfileViewController.swift
//  MassageRobot
//
//  Created by Augmenta on 10/03/21.
//

import UIKit
import SDWebImage

class UpdateProfileViewController: UIViewController, UITextFieldDelegate{
        
    @IBOutlet weak var btnSelectImage: UIButton!
    
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtEthniciy: UITextField!
    @IBOutlet weak var txtPreferredUnits: UITextField!
    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var txtFeet: UITextField!
    @IBOutlet weak var txtMarriedSingle: UITextField!
    @IBOutlet weak var txtChildren: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtIncome: UITextField!
    @IBOutlet weak var txtOccupation: UITextField!
    @IBOutlet weak var txtSelfEmployeed: UITextField!
    @IBOutlet weak var txtLanguage: UITextField!
    @IBOutlet var txtAddress: UITextField!
    
    @IBOutlet weak var imgRoutine: UIImageView!
    
    @IBOutlet var viewBack: UIView!
    
    var picker: UIPickerView!
    
    var isAgeSelect: Bool = false
    var isGenderSelect: Bool = false
    
    var arrMyProfileStoreData = [[String: Any]]()
    
    var arrAge = [String]()
    var arrWeight = [String]()
    
    let arrGender:[(Id: String, Gender: String)] = [("1","Male"),("2","Female")]
    
    let arrEthniciy = ["Indian","American","African","japanese","Chinese","Korean"]
    let arrPreferredUnits:[(Id: String, Unit: String)] = [("1","Metric"),("2","Imperial")]

    let arrFeet = ["53","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","72","74","76"]
    let arrMarried:[(Id: String, Status: String)] = [("1","Single"),("2","Married")]
    let arrChildren = ["0","1","2","3","4","5"]
    
    let arrIncome = ["50000","100000","150000","200000",]
    let arrOccupation = ["Accounting","Airlines/Aviation","Civil Engineering","Animation","Apparel & Fashion ","Architecture & Planning","Arts & CraftsAutomotive","Banking","Biotechnology","Broadcast Media","Business Supplies & Equipment","Information Technology","Insurance","International Affairs","International Trade & Development","Internet","Investment Banking","Investment Management"]
    
    let arrSelfEmployeed:[(Id: String, Value: String)] = [("1","Yes"),("2","No")]
    let arrLanguage:[(Id: String, Language: String)] = [("1","English"),("2","Hindi")]
    
    let arrCountry:[(Id: String, Name: String)] = [
        ("1", "Afghanistan"),
        ("2", "Albania"),
        ("3", "Algeria"),
        ("4", "Andorra"),
        ("5", "Angola"),
        ("6", "Anguilla"),
        ("7", "Antigua &amp; Barbuda"),
        ("8", "Argentina"),
        ("9", "Armenia"),
        ("10", "Aruba"),
        ("11", "Australia"),
        ("12", "Austria"),
        ("13", "Azerbaijan"),
        ("14", "Bahamas"),
        ("15", "Bahrain"),
        ("16", "Bangladesh"),
        ("17", "Barbados"),
        ("18", "Belarus"),
        ("19", "Belgium"),
        ("20", "Belize"),
        ("21", "Benin"),
        ("22", "Bermuda"),
        ("23", "Bhutan"),
        ("24", "Bolivia"),
        ("25", "Bosnia & Herzegovina"),
        ("26", "Botswana"),
        ("27", "Brazil"),
        ("28", "British Virgin Islands"),
        ("29", "Brunei"),
        ("30", "Bulgaria"),
        ("31", "Burkina Faso"),
        ("32", "Burundi"),
        ("34", "Cambodia"),
        ("35", "Cameroon"),
        ("36", "Cape Verde"),
        ("37", "Cayman Islands"),
        ("38", " Chad"),
        ("39", "Chile"),
        ("40", "China"),
        ("41", "Colombia"),
        ("42", "Congo"),
        ("43", "Cook Islands"),
        ("44", "Costa Rica"),
        ("45", "Cote D Ivoire"),
        ("46", "Croatia"),
        ("47", "Cruise Ship"),
        ("48", "Cuba"),
        ("49", "Cyprus"),
        ("50", "Czech Republic"),
        ("51", "Denmark"),
        ("52", "Djibouti"),
        ("53", "Dominica"),
        ("54", "Dominican Republic"),
        ("55", "Ecuador"),
        ("56", "Egypt"),
        ("57", "El Salvador"),
        ("58", "Equatorial Guinea"),
        ("59", "Estonia"),
        ("50", "Ethiopia"),
        ("51", "Falkland Islands"),
        ("52", "Faroe Islands"),
        ("53", "Fiji"),
        ("54", "Finland"),
        ("55", "France"),
        ("56", "French Polynesia"),
        ("57", "French West Indies"),
        ("58", "Gabon"),
        ("59", "Gambia"),
        ("60", "Georgia"),
        ("61", "Germany"),
        ("62", "Ghana"),
        ("63", "Gibraltar"),
        ("64", "Greece"),
        ("65", "Greenland"),
        ("66", "Grenada"),
        ("67", "Guam"),
        ("68", "Guatemala"),
        ("69", "Guernsey"),
        ("70", "Guinea"),
        ("71", "Guinea Bissau"),
        ("72", "Guyana"),
        ("73", "Haiti"),
        ("74", "Honduras"),
        ("75", " Hong Kong"),
        ("76", "Hungary"),
        ("77", "Iceland"),
        ("78", "India"),
        ("79", "Indonesia"),
        ("80", "Iran"),
        ("81", "Iraq"),
        ("82", "Ireland"),
        ("83", "Isle of Man"),
        ("84", "Israel"),
        ("85", "Italy"),
        ("86", "Jamaica"),
        ("87", "Japan"),
        ("88", "Jersey"),
        ("89", "Jordan"),
        ("90", "Kazakhstan"),
        ("91", "Kenya"),
        ("92", "Kuwait"),
        ("93", "Kyrgyz Republic"),
        ("94", "Laos"),
        ("95", "Latvia"),
        ("96", "Lebanon"),
        ("97", "Lesotho"),
        ("98", "Liberia"),
        ("100", "Libya"),
        ("101", "Liechtenstein"),
        ("102", "Lithuania"),
        ("103", "Luxembourg"),
        ("104", "Macau"),
        ("105", "Macedonia"),
        ("106", "Madagascar"),
        ("107", "Malawi"),
        ("108", "Malaysia"),
        ("109", "Maldives"),
        ("110", "Mali"),
        ("111", "Malta"),
        ("112", "Mauritania"),
        ("113", "Mauritius"),
        ("114", "Mexico"),
        ("115", "Moldova"),
        ("116", "Monaco"),
        ("117", "Mongolia"),
        ("118", "Montenegro"),
        ("119", "Montserrat"),
        ("120", "Morocco"),
        ("121", "Mozambique"),
        ("122", "Namibia"),
        ("123", "Nepal"),
        ("124", "Netherlands"),
        ("125", "Netherlands Antilles"),
        ("126", "New Caledonia"),
        ("127", "New Zealand"),
        ("128", "Nicaragua"),
        ("129", "Niger"),
        ("130", "Nigeria"),
        ("131", "Norway"),
        ("132", "Oman"),
        ("133", "Pakistan"),
        ("134", "Palestine"),
        ("135", "Panama"),
        ("136", "Papua New Guinea"),
        ("137", "Paraguay"),
        ("138", "Peru"),
        ("139", "Philippines"),
        ("140", "Poland"),
        ("141", "Portugal"),
        ("142", "Puerto Rico"),
        ("143", "Qatar"),
        ("144", "Reunion"),
        ("145", "Romania"),
        ("146", "Russia"),
        ("147", "Rwanda"),
        ("148", "Saint Pierre &amp; Miquelon"),
        ("149", "Samoa"),
        ("150", "San Marino"),
        ("151", "Satellite"),
        ("152", "Saudi Arabia"),
        ("153", "Senegal"),
        ("154", "Serbia"),
        ("155", "Seychelles"),
        ("156", "Sierra Leone"),
        ("157", "Singapore"),
        ("158", "Slovakia"),
        ("159", "Slovenia"),
        ("160", "South Africa"),
        ("161", "Spain"),
        ("162", "Sri Lanka"),
        ("163", "St Kitts &amp; Nevis"),
        ("164", "St Lucia"),
        ("165", "St. Lucia"),
        ("166", "Sudan"),
        ("167", "Suriname"),
        ("168", "Swaziland"),
        ("169", "Switzerland"),
        ("170", "Syria"),
        ("171", "Taiwan"),
        ("172", "Tajikistan"),
        ("173", "Tanzania"),
        ("174", "Timor L Este"),
        ("175", "Togo"),
        ("166", "Tonga"),
        ("177", "Trinidad &amp; Tobago"),
        ("178", "Tunisia"),
        ("179", "Turkey"),
        ("180", "Turkmenistan"),
        ("181", "Turks &amp; Caicos"),
        ("182", "Uganda"),
        ("183", "Ukraine"),
        ("184", "United Arab Emirates"),
        ("185", "United Kingdom"),
        ("186", "United States of America"),
        ("187", "Uruguay"),
        ("188", "Uzbekistan"),
        ("189", "Venezuela"),
        ("190", "Vietnam"),
        ("191", "Virgin Islands (US)"),
        ("192", "Yemen"),
        ("193", "Zambia"),
        ("194", "Zimbabwe"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                   
        for ageList in 18...100 {
            arrAge.append(String(ageList))
        }
        
        for weightList in 50...300 {
            arrWeight.append(String(weightList))
        }
        
        txtType.inputView = picker
        txtGender.inputView = picker
        txtEthniciy.inputView = picker
        txtPreferredUnits.inputView = picker
        txtWeight.inputView = picker
        txtFeet.inputView = picker
        txtMarriedSingle.inputView = picker
        txtChildren.inputView = picker
        txtCountry.inputView = picker
        txtIncome.inputView = picker
        txtOccupation.inputView = picker
        txtSelfEmployeed.inputView = picker
        txtLanguage.inputView = picker
        
        picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        txtType.inputView = picker
        txtGender.inputView = picker
        txtEthniciy.inputView = picker
        txtPreferredUnits.inputView = picker
        txtWeight.inputView = picker
        txtFeet.inputView = picker
        txtMarriedSingle.inputView = picker
        txtChildren.inputView = picker
        txtCountry.inputView = picker
        txtIncome.inputView = picker
        txtOccupation.inputView = picker
        txtSelfEmployeed.inputView = picker
        txtLanguage.inputView = picker
        
        txtType.delegate = self
        txtGender.delegate = self
        txtEthniciy.delegate = self
        txtPreferredUnits.delegate = self
        txtWeight.delegate = self
        txtFeet.delegate = self
        txtMarriedSingle.delegate = self
        txtChildren.delegate = self
        txtCountry.delegate = self
        txtIncome.delegate = self
        txtOccupation.delegate = self
        txtSelfEmployeed.delegate = self
        txtLanguage.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewBack.addGestureRecognizer(tap)
        
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
                            
                            txtType.text = profileData.getString(key: "age")
                            txtGender.text = profileData.getString(key: "gender")
                            txtEthniciy.text = profileData.getString(key: "ethnicity")
                            txtPreferredUnits.text = profileData.getString(key: "units")
                            txtWeight.text = profileData.getString(key: "weight")
                            txtFeet.text = profileData.getString(key: "height")
                            txtMarriedSingle.text = profileData.getString(key: "marital")
                            txtChildren.text = profileData.getString(key: "children")
                            txtCountry.text = profileData.getString(key: "country")
                            txtIncome.text = profileData.getString(key: "income")
                            txtOccupation.text = profileData.getString(key: "occupation")
                            txtSelfEmployeed.text = profileData.getString(key: "selfemployeed")
                            txtLanguage.text = profileData.getString(key: "language")
                            txtAddress.text = profileData.getString(key: "address")
                            
                            if profileData.getString(key: "thumbnail") != "" {
                                let urls = URL.init(string: profileData.getString(key: "thumbnail"))
                                imgRoutine.sd_setImage(with: urls , placeholderImage: UIImage(named: "MyProfile"))
                            }else {
                                imgRoutine.image = UIImage(named: "MyProfile")
                            }
                            
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
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        print("tep Gesture Work")
        
        txtType.resignFirstResponder()
        txtGender.resignFirstResponder()
        txtEthniciy.resignFirstResponder()
        txtPreferredUnits.resignFirstResponder()
        txtWeight.resignFirstResponder()
        txtFeet.resignFirstResponder()
        txtMarriedSingle.resignFirstResponder()
        txtChildren.resignFirstResponder()
        txtCountry.resignFirstResponder()
        txtIncome.resignFirstResponder()
        txtOccupation.resignFirstResponder()
        txtSelfEmployeed.resignFirstResponder()
        txtLanguage.resignFirstResponder()
    }
    
    @IBAction func btnSelectImageAction(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()

        let actionSheet = UIAlertController(title: "Take image", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in

            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.delegate = self
                imagePicker.isEditing = true
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                print("Camera Not Available")
                self.showToast(message: "Camera Not Available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photos", style: .default, handler: { (action) in

            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.delegate = self
            imagePicker.isEditing = true
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)

        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        }))

        present(actionSheet, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if txtType.isEditing
        {
            txtType.text = arrAge[textField.tag]
            picker.selectRow(txtType.tag, inComponent: 0, animated: true)
        }
        
        if txtGender.isEditing
        {
            txtGender.text = arrGender[textField.tag].Gender
            picker.selectRow(txtGender.tag, inComponent: 0, animated: true)
        }
        
        if txtEthniciy.isEditing
        {
            txtEthniciy.text = arrEthniciy[textField.tag]
            picker.selectRow(txtEthniciy.tag, inComponent: 0, animated: true)
        }
        
        if txtPreferredUnits.isEditing
        {
            txtPreferredUnits.text = arrPreferredUnits[textField.tag].Unit
            picker.selectRow(txtPreferredUnits.tag, inComponent: 0, animated: true)
        }
        
        if txtWeight.isEditing
        {
            txtWeight.text = arrWeight[textField.tag]
            picker.selectRow(txtWeight.tag, inComponent: 0, animated: true)
        }
        
        if txtFeet.isEditing
        {
            txtFeet.text = arrFeet[textField.tag]
            picker.selectRow(txtFeet.tag, inComponent: 0, animated: true)
        }
        
        if txtMarriedSingle.isEditing
        {
            txtMarriedSingle.text = arrMarried[textField.tag].Status
            picker.selectRow(txtMarriedSingle.tag, inComponent: 0, animated: true)
        }
        
        if txtChildren.isEditing
        {
            txtChildren.text = arrChildren[textField.tag]
            picker.selectRow(txtChildren.tag, inComponent: 0, animated: true)
        }
        
        if txtCountry.isEditing
        {
            txtCountry.text = arrCountry[textField.tag].Name
            picker.selectRow(txtCountry.tag, inComponent: 0, animated: true)
        }
        
        if txtIncome.isEditing
        {
            txtIncome.text = arrIncome[textField.tag]
            picker.selectRow(txtIncome.tag, inComponent: 0, animated: true)
        }
        
        if txtOccupation.isEditing
        {
            txtOccupation.text = arrOccupation[textField.tag]
            picker.selectRow(txtOccupation.tag, inComponent: 0, animated: true)
        }
        
        if txtSelfEmployeed.isEditing
        {
            txtSelfEmployeed.text = arrSelfEmployeed[textField.tag].Value
            picker.selectRow(txtSelfEmployeed.tag, inComponent: 0, animated: true)
        }
        
        if txtLanguage.isEditing
        {
            txtLanguage.text = arrLanguage[textField.tag].Language
            picker.selectRow(txtLanguage.tag, inComponent: 0, animated: true)
        }
        
        if textField == txtType || textField == txtGender || textField == txtEthniciy || textField == txtPreferredUnits || textField == txtWeight || textField == txtFeet || textField == txtMarriedSingle || textField == txtChildren || textField == txtCountry || textField == txtIncome || textField == txtOccupation || textField == txtSelfEmployeed || textField == txtLanguage
        {
            picker.reloadAllComponents()
        }
    }
}

extension UpdateProfileViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if txtType.isEditing {
            return arrAge.count
        }else if txtGender.isEditing {
            return arrGender.count
        }else if txtEthniciy.isEditing {
            return arrEthniciy.count
        }else if txtPreferredUnits.isEditing {
            return arrPreferredUnits.count
        }else if txtWeight.isEditing {
            return arrWeight.count
        }else if txtFeet.isEditing {
            return arrFeet.count
        }else if txtMarriedSingle.isEditing {
            return arrMarried.count
        }else if txtChildren.isEditing {
            return arrChildren.count
        }else if txtCountry.isEditing {
            return arrCountry.count
        }else if txtIncome.isEditing {
            return arrIncome.count
        }else if txtOccupation.isEditing {
            return arrOccupation.count
        }else if txtSelfEmployeed.isEditing {
            return arrSelfEmployeed.count
        }else if txtLanguage.isEditing {
            return arrLanguage.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if txtType.isEditing {
            return arrAge[row]
        }else if txtGender.isEditing {
            return arrGender[row].Gender
        }else if txtEthniciy.isEditing {
            return arrEthniciy[row]
        }else if txtPreferredUnits.isEditing {
            return arrPreferredUnits[row].Unit
        }else if txtWeight.isEditing {
            return arrWeight[row]
        }else if txtFeet.isEditing {
            return arrFeet[row]
        }else if txtMarriedSingle.isEditing {
            return arrMarried[row].Status
        }else if txtChildren.isEditing {
            return arrChildren[row]
        }else if txtCountry.isEditing {
            return arrCountry[row].Name
        }else if txtIncome.isEditing {
            return arrIncome[row]
        }else if txtOccupation.isEditing {
            return arrOccupation[row]
        }else if txtSelfEmployeed.isEditing {
            return arrSelfEmployeed[row].Value
        }else if txtLanguage.isEditing {
            return arrLanguage[row].Language
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if txtType.isEditing {
            txtType.text = arrAge[row]
            txtType.tag = row
        }else if txtGender.isEditing {
            txtGender.text = arrGender[row].Gender
            txtGender.tag = row
        }else if txtEthniciy.isEditing {
            txtEthniciy.text = arrEthniciy[row]
            txtEthniciy.tag = row
        }else if txtPreferredUnits.isEditing {
            txtPreferredUnits.text = arrPreferredUnits[row].Unit
            txtPreferredUnits.tag = row
        }else if txtWeight.isEditing {
            txtWeight.text = arrWeight[row]
            txtWeight.tag = row
        }else if txtFeet.isEditing {
            txtFeet.text = arrFeet[row]
            txtFeet.tag = row
        }else if txtMarriedSingle.isEditing {
            txtMarriedSingle.text = arrMarried[row].Status
            txtMarriedSingle.tag = row
        }else if txtChildren.isEditing {
            txtChildren.text = arrChildren[row]
            txtChildren.tag = row
        }else if txtCountry.isEditing {
            txtCountry.text = arrCountry[row].Name
            txtCountry.tag = row
        }else if txtIncome.isEditing {
            txtIncome.text = arrIncome[row]
            txtIncome.tag = row
        }else if txtOccupation.isEditing {
            txtOccupation.text = arrOccupation[row]
            txtOccupation.tag = row
        }else if txtSelfEmployeed.isEditing {
            txtSelfEmployeed.text = arrSelfEmployeed[row].Value
            txtSelfEmployeed.tag = row
        }else if txtLanguage.isEditing {
            txtLanguage.text = arrLanguage[row].Language
            txtLanguage.tag = row
        }
    }
}

extension UpdateProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.editedImage.rawValue)] as! UIImage
        let fixedImaage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: image.imageOrientation)
        // fixedImaage.resize(scale: 0.25)
        imgRoutine.contentMode = .scaleAspectFill
        imgRoutine.image = fixedImaage
        btnSelectImage.setImage(nil, for: .normal)
        
        picker.dismiss(animated: true, completion: nil)
    }
}
