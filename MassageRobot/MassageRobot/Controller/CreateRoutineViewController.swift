//
//  CreateRoutineViewController.swift
//  MassageRobot
//
//  Created by Rohit Parsana on 04/02/21.
//

import UIKit
import EasyTipView
import TagListView
import IQKeyboardManagerSwift

class CreateRoutineViewController: UIViewController {

    @IBOutlet weak var btnEliteStatusAuthor: UIButton!
    @IBOutlet weak var btnYearMembership: UIButton!
    @IBOutlet weak var btnFeatureRoutine: UIButton!
    @IBOutlet weak var btnTrentSetter: UIButton!
    @IBOutlet weak var btnProffesional: UIButton!
    @IBOutlet weak var btnLight: UIButton!
    @IBOutlet weak var btnMedium: UIButton!
    @IBOutlet weak var btnFirm: UIButton!
    @IBOutlet weak var btnDeep: UIButton!
    @IBOutlet var btnDiseases: [UIButton]!
    @IBOutlet var btnTools: [UIButton]!
    @IBOutlet var btnPath: [UIButton]!
    @IBOutlet weak var txtNewTagName: UITextField!
    @IBOutlet weak var viewTagList: TagListView!
    @IBOutlet weak var lblDescriptionPlaceholder: UILabel!
    @IBOutlet weak var lblNavTitle: UILabel!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var imgRoutine: UIImageView!
    @IBOutlet weak var btnSelectImage: UIButton!
    @IBOutlet weak var btnAddRoutine: UIButton!
    @IBOutlet weak var btnForMe: UIButton!
    @IBOutlet weak var txtRoutineName: UnderlineTextField!
    @IBOutlet weak var viewTapGesture: UIView!
    @IBOutlet weak var viewFullTapGesture: UIView!
    @IBOutlet weak var constHeightPerssure: NSLayoutConstraint!
    @IBOutlet weak var constHeightLinePerssure: NSLayoutConstraint!
    @IBOutlet weak var constHeightSpeed: NSLayoutConstraint!
    @IBOutlet weak var constHeightLineSpeed: NSLayoutConstraint!
    @IBOutlet weak var constHeightTools: NSLayoutConstraint!
    @IBOutlet weak var constHeightLineTools: NSLayoutConstraint!
    @IBOutlet weak var constHeightPath: NSLayoutConstraint!
    @IBOutlet weak var constHeightLinePath: NSLayoutConstraint!
    @IBOutlet weak var constHeightLocation: NSLayoutConstraint!
    @IBOutlet weak var constHeightLineLocation: NSLayoutConstraint!
    
        
    var strTitleName: String!
    
    var tipView: EasyTipView!
    
    let arrCategory = ["Relaxation", "Therapeutic", "Performance"]
    let arrType = ["Cranial Sacral Therapy", "Deep Tissue Massage", "Geriatric Massage", "Prenatal Massage", "Reflexology", "Sports Massage", "Swedish Massage", "Percussion Massage", "Trigger Point Acupressure"]
    let arrUser = ["Audlt", "Athlete", "Geriatric", "Pregnant", "Youth"]
    
    let arrDiseases = ["Anxiety", "Fatiue", "Headache/Migraines", "Inflammation", "Injury", "Insomnia", "Muscle Spasm", "Pain", "Relaxation", "Stress", "Hand", "Tension"]
    
    let arrTools = ["Inline", "Omni", "Percussion", "Point", "Sport"]
    
    let arrPath = ["Circular", "Linear", "Point", "Random"]
    
    var selectedDiseases = [String]()
    var selectedTools = [String]()
    var selectedPaths = [String]()
    
    var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        view.addGestureRecognizer(tapGesture)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewTapGesture.addGestureRecognizer(tap)
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewFullTapGesture.addGestureRecognizer(tap1)
        
        txtNewTagName.delegate = self
        viewTagList.delegate = self
        txtDescription.delegate = self
        
        picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        
        txtUser.inputView = picker
        txtCategory.inputView = picker
        txtType.inputView = picker
        
        txtUser.delegate = self
        txtCategory.delegate = self
        txtType.delegate = self
        
        showToast(message: "Routine created successfully!")
        
        lblNavTitle.text = strTitleName
        
        btnLight.backgroundColor = UIColor.btnSelectColor
        btnMedium.backgroundColor = UIColor.btnBGColor
        btnFirm.backgroundColor = UIColor.btnBGColor
        btnDeep.backgroundColor = UIColor.btnBGColor
        
        if strTitleName == "New Routine" {
            constHeightPerssure.constant = 0.0
            constHeightLinePerssure.constant = 0.0
            constHeightSpeed.constant = 0.0
            constHeightLineSpeed.constant = 0.0
            constHeightTools.constant = 0.0
            constHeightLineTools.constant = 0.0
            constHeightPath.constant = 0.0
            constHeightLinePath.constant = 0.0
            constHeightLocation.constant = 0.0
            constHeightLineLocation.constant = 0.0
            
            imgRoutine.image = UIImage(named: "img_placeholder")
        }else {
            btnSelectImage.isHidden = true
            btnAddRoutine.isHidden = true
        }
    }
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer)
    {
        if tipView != nil
        {
            tipView.dismiss()
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        print("tep Gesture Work")
        txtCategory.resignFirstResponder()
        txtUser.resignFirstResponder()
        txtType.resignFirstResponder()
        
        viewFullTapGesture.isHidden = true
    }
    
    func showToolTip(sender: UIButton, title: String)
    {
        if tipView != nil
        {
            tipView.dismiss()
        }
        
        var preferences = EasyTipView.Preferences()
        preferences.drawing.font = UIFont(name: "SFProText-Regular", size: 13)!
        preferences.drawing.foregroundColor = .white
        preferences.drawing.backgroundColor = #colorLiteral(red: 0.08352854103, green: 0.6347795725, blue: 0.7463413477, alpha: 1)
        preferences.drawing.arrowPosition = EasyTipView.ArrowPosition.top
        
        tipView = EasyTipView(text: title, preferences: preferences)
        tipView.show(forView: sender, withinSuperview: view)
    }
    
    
    @IBAction func btnToast(_ sender: UIButton) {
        showToast(message: "Routine created successfully!")
    }
    
    @IBAction func btnDiseaseAction(_ sender: UIButton) {
        btnDiseases[sender.tag].isSelected = !btnDiseases[sender.tag].isSelected
        if selectedDiseases.contains(arrDiseases[sender.tag])
        {
            selectedDiseases.remove(at: selectedDiseases.lastIndex(of: arrDiseases[sender.tag])!)
        }
        else
        {
            selectedDiseases.append(arrDiseases[sender.tag])
        }
    }
    
    @IBAction func btnToolsAction(_ sender: UIButton) {
        btnTools[sender.tag].isSelected = !btnTools[sender.tag].isSelected
        if selectedTools.contains(arrTools[sender.tag])
        {
            selectedTools.remove(at: selectedTools.lastIndex(of: arrTools[sender.tag])!)
        }
        else
        {
            selectedTools.append(arrTools[sender.tag])
        }
    }
    
    @IBAction func btnPathAction(_ sender: UIButton) {
        btnPath[sender.tag].isSelected = !btnPath[sender.tag].isSelected
        if selectedPaths.contains(arrPath[sender.tag])
        {
            selectedPaths.remove(at: selectedPaths.lastIndex(of: arrPath[sender.tag])!)
        }
        else
        {
            selectedPaths.append(arrPath[sender.tag])
        }
    }
    
    @IBAction func btnProfessionalAction(_ sender: UIButton) {
        
        showToolTip(sender: sender, title: "Professional")
    }
    
    @IBAction func btnTrendSetterAction(_ sender: UIButton) {
        
        showToolTip(sender: sender, title: "Trend Setter")
    }
    
    @IBAction func btnFeatureRoutineAction(_ sender: UIButton) {
        
        showToolTip(sender: sender, title: "Hed a featured routine")
    }
    
    @IBAction func btnYearMembershipAction(_ sender: UIButton) {
        
        showToolTip(sender: sender, title: "3 Year Membership")
    }
    
    @IBAction func btnEliteStatusAuthorAction(_ sender: UIButton) {
        
        showToolTip(sender: sender, title: "Elite Status Author")
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
    
    @IBAction func btnSettingAction(_ sender: UIButton) {
        performSegue(withIdentifier: "settings", sender: nil)
    }
    
    @IBAction func btnForMeAction(_ sender: UIButton) {
        
        btnForMe.isSelected = !btnForMe.isSelected
    }
    
    @IBAction func btnLightAction(_ sender: UIButton) {
        btnLight.backgroundColor = UIColor.btnSelectColor
        btnMedium.backgroundColor = UIColor.btnBGColor
        btnFirm.backgroundColor = UIColor.btnBGColor
        btnDeep.backgroundColor = UIColor.btnBGColor
    }
    
    @IBAction func btnMediumAction(_ sender: UIButton) {
        btnLight.backgroundColor = UIColor.btnBGColor
        btnMedium.backgroundColor = UIColor.btnSelectColor
        btnFirm.backgroundColor = UIColor.btnBGColor
        btnDeep.backgroundColor = UIColor.btnBGColor
    }
    
    @IBAction func btnFirmAction(_ sender: UIButton) {
        btnLight.backgroundColor = UIColor.btnBGColor
        btnMedium.backgroundColor = UIColor.btnBGColor
        btnFirm.backgroundColor = UIColor.btnSelectColor
        btnDeep.backgroundColor = UIColor.btnBGColor
    }
    
    @IBAction func btnDeepAction(_ sender: UIButton) {
        btnLight.backgroundColor = UIColor.btnBGColor
        btnMedium.backgroundColor = UIColor.btnBGColor
        btnFirm.backgroundColor = UIColor.btnBGColor
        btnDeep.backgroundColor = UIColor.btnSelectColor
    }
    
    @IBAction func btnAddRoutineAction(_ sender: UIButton) {
        
        if isValidData()
        {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd HH:mm"
            
            let diseases = selectedDiseases.joined(separator: ",")
            var tags = ""
            for tag in viewTagList.tagViews
            {
                tags += (tag.titleLabel?.text ?? "") + ","
            }
            if tags.count > 0
            {
                tags.removeLast()
            }
//            txtRoutineName.text = "Rohit test routine"
//            txtDescription.text = "This is test routine form ios native."
            
            let url = """
            https://massage-robotics-website.uc.r.appspot.com/wt?tablename=Routine&row=[('\(randomRoutineId())',
            '9ccx8ms5pc0000000000',
            '\(df.string(from: Date()))',
            'public',
            '\(txtRoutineName.text!)',
            '\(txtDescription.text!)',
            '\(df.string(from: Date()))',
            '5',
            '2',
            'best and good',
            '',
            '',
            '\(txtCategory.text!)',
            '\(txtType.text!)',
            '\(txtUser.text!)',
            '\(diseases)',
            '\(tags)')]
            """

//            let url = "https://massage-robotics-website.uc.r.appspot.com/wt?tablename=Routine&row=[('\(randomRoutineId())','9ccx8ms5pc0000000000','\(df.string(from: Date()))','public','\(txtRoutineName.text!)','\(txtDescription.text!)','\(df.string(from: Date()))','5','2','best and good','','','\(txtCategory.text!)','\(diseases)','\(tags)')]"
/* https://massage-robotics-website.uc.r.appspot.com/wt?tablename=Routine&row=[(%27swxmpq9um80000000000%27,
             %279ccx8ms5pc0000000000%27,
             %272021-02-14%2015:19%27,
             %27private%27,
             %2714%20Feb%20routine%27,
             %27test%20routine%27,
             %272021-02-14%2015:19%27,
             %275%27,
             %272%27,
             %27best%20and%20good%27%20,
             %27%27,
             %27%27,
             %27Therapeutic%27,
             %27Prenatal%20Massage%27,
             %27Athlete%27,
             %20%27Fatigue,Inflammation,Insomnia,Stress%27,
             %20%27tag,tag2%27)]
 */
//            let url = "https://massage-robotics-website.uc.r.appspot.com/wt?tablename=Routine&row=[('\(randomRoutineId())','atdpr888898','2021-02-09','public','Rohit test routine','This is test routine form ios native.','2021-02-09','5','2','best and good','Therapeutic','Cranial Sacral Therapy',Pregnant','Anxiety,Inflammation,Insomnia','tag1,tag2')]"
            print(url)
            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            print(encodedUrl)
            callAPI(url: encodedUrl!) { [self] (json, data) in
                print(json)
                if json.getString(key: "Response") == "Success"
                {
                    showToast(message: "Routine created successfully!")
//                    showAlert(message: "Routine created successfully!", options: "OK", completion: nil)
                    txtRoutineName.text = ""
                    txtDescription.text = ""
                    txtCategory.text = ""
                    txtType.text = ""
                    txtUser.text = ""
                    selectedDiseases.removeAll()
                    selectedTools.removeAll()
                    selectedPaths.removeAll()
                    for btn in btnDiseases
                    {
                        btn.isSelected = false
                    }
                    viewTagList.removeAllTags()
                }
//                let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from Routine'"
//                let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                
//                callAPI(url: encodedUrl!) { (json, data) in
//                    print(json)
//                }
            }
        }
    }
    
    func isValidData() -> Bool
    {
        if txtRoutineName.text == ""
        {
            showToast(message: "Please insert title.")
            return false
        }
        else if txtCategory.text == ""
        {
            showToast(message: "Please select category.")
            return false
        }
        else if txtType.text == ""
        {
            showToast(message: "Please select type.")
            return false
        }
        else if txtUser.text == ""
        {
            showToast(message: "Please select user type.")
            return false
        }
        else if selectedDiseases.count == 0
        {
            showToast(message: "Please select details.")
            return false
        }
        else if viewTagList.tagViews.count == 0
        {
            showToast(message: "Please enter tags properly by using enter.")
            return false
        }
        else if txtDescription.text == ""
        {
            showToast(message: "Please insert description.")
            return false
        }
        else if selectedTools.count == 0
        {
            showToast(message: "Please select tools.")
            return false
        }
        else if selectedPaths.count == 0
        {
            showToast(message: "Please select path.")
            return false
        }
        return true
    }
    
    /*
     
     [('24sgbxys4i387ilw7shs','9ccx8ms5pc0000000000','2021-02-09 10:12','private','Ashish Test Routine 1','ionic test routine','2021-02-09 10:12','5','2','best and good' ,'','','Therapeutic','Prenatal Massage','Geriatric', 'Fatigue,Inflammation', 'Tag1,tag2,tah3,tag4')]
     'Fatigue,Inflammation'//check box
     'Therapeutic','Prenatal Massage','Geriatric'//drop down
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CreateRoutineViewController: UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if txtNewTagName == textField && txtNewTagName.text != ""
        {
            viewTagList.addTag(textField.text!)
            textField.text = ""
            if viewTagList.tagViews.count == 0
            {
                textField.placeholder = "Enter a new tag"
            }
            else
            {
                textField.placeholder = "+ tag"
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            
       // IQKeyboardManager.shared.enableAutoToolbar = false

        viewFullTapGesture.isHidden = false
        
        if txtType.isEditing
        {
            txtType.text = arrType[textField.tag]
            picker.selectRow(txtType.tag, inComponent: 0, animated: true)
        }
        else if txtCategory.isEditing
        {
            txtCategory.text = arrCategory[textField.tag]
            picker.selectRow(txtCategory.tag, inComponent: 0, animated: true)
        }
        else if txtUser.isEditing
        {
            txtUser.text = arrUser[textField.tag]
            picker.selectRow(txtUser.tag, inComponent: 0, animated: true)
        }
        
        if textField == txtUser || textField == txtType || textField == txtCategory
        {
            picker.reloadAllComponents()
        }
    }
}

extension CreateRoutineViewController: TagListViewDelegate
{
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        sender.removeTagView(tagView)
        if viewTagList.tagViews.count == 0
        {
            txtNewTagName.placeholder = "Enter a new tag"
        }
        else
        {
            txtNewTagName.placeholder = "+ tag"
        }
    }
}

extension CreateRoutineViewController: UITextViewDelegate
{
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if txtDescription == textView
        {
            lblDescriptionPlaceholder.isHidden = (txtDescription.text + text).count != 0
        }
        return true
    }
}

extension CreateRoutineViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if txtType.isEditing
        {
            return arrType.count
        }
        else if txtCategory.isEditing
        {
            return arrCategory.count
        }
        else if txtUser.isEditing
        {
            return arrUser.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if txtType.isEditing
        {
            return arrType[row]
        }
        else if txtCategory.isEditing
        {
            return arrCategory[row]
        }
        else if txtUser.isEditing
        {
            return arrUser[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if txtType.isEditing
        {
            txtType.text = arrType[row]
            txtType.tag = row
        }
        else if txtCategory.isEditing
        {
            txtCategory.text = arrCategory[row]
            txtCategory.tag = row
        }
        else if txtUser.isEditing
        {
            txtUser.text = arrUser[row]
            txtUser.tag = row
        }
    }
    
}

extension CreateRoutineViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate
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
