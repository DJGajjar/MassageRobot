//
//  MyPreferenceVC.swift
//  MassageRobot
//
//  Created by Sumit Sharma on 07/02/21.
//

import UIKit

class MyPreferenceVC: UIViewController {
    
    //MARK:- Class Outlet
    @IBOutlet weak var previousandNextView: UIView!
    @IBOutlet weak var progressandCount: UIView!
    @IBOutlet weak var countText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var previewBtn: UIButton!
    @IBOutlet weak var collectionObj: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var topScreen_constrnt: NSLayoutConstraint!
    
    //MARK:- Class Variable
    var currentIndexpath  = IndexPath(row: 0, section: 0)
    var currentIndexVal : Int = 0
    
    var questionaryFile = [[String: Any]]()
    var localQueAndList = [[String: Any]]()
    var staticpickervalue = ["Monthly", "Bi-Weekly", "Weekly", "Daily"]
            
    var dictLocalStore = [String: AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
            
        var myArray = [[String: String]]()
        for i in 0..<10 {

            let dict = ["name": "Item\(i)", "foo": "bar\(i)"]
            myArray.append(dict)
        }
        print("\(myArray)")
        
        var dictionaries = [[String: Int]]()

        // Create a dictionary and add it to the array.
        let dictionary1: [String: Int] = ["cat": 100]
        dictionaries.append(dictionary1)

        // Create another dictionary.
        let dictionary2: [String: Int] = ["dog": 200]
        dictionaries.append(dictionary2)

        // Get value from dictionary in array element 0.
        if let value = dictionaries[0]["cat"] {
            print(value)
        }

        // Get value from dictionary that does not exist.
        if dictionaries[1]["diamond"] != nil {
            // This is not reached.
            print("Not reached")
        }
        
        print(dictionaries)
        
        ViewTop_UPRadius(value: 10, outlet: self.progressandCount )
        ViewBottom_DownRadius(value: 10, outlet: self.previousandNextView )
        
        borderBtn(value: 10, outlet:self.previewBtn )
        borderBtn(value: 10, outlet:self.nextBtn )
        
        let deviceHeight = UIScreen.main.nativeBounds.height
        
        if deviceHeight <= 1334.0{
            self.topScreen_constrnt.constant = 20.0
        }else{
            self.topScreen_constrnt.constant = 62.0
        }
        self.setUserPreferenceQuestionService()
    }
    
    func setUserPreferenceQuestionService() {
        
        let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
        
        if userID != "" {
            let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select * from userpreferencequestion'"
            
            print(url)
            
            let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            callAPI(url: encodedUrl!) { [self] (json, data1) in
                print(json)
                if json.getString(key: "status") == "false"
                {
                    let string = json.getString(key: "response_message")
                    let data = string.data(using: .utf8)!
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [Dictionary<String,Any>] {
                            questionaryFile.append(contentsOf: jsonArray)
                            
                            self.countText.text = "1 / \(questionaryFile.count)"
                            progressBar.progress = Float(Float(1)/Float(questionaryFile.count))
                            
                            collectionObj.reloadData()
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
    
    @IBAction func backToLast(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    //MARK:- priviewNextAction
    @IBAction func priviewNextAction(_ sender: UIButton) {
        
        let currentPlace = Float(currentIndexpath.row)
        let totalPlace = Float(questionaryFile.count)
        
        print("_____________")
        print(currentPlace + 1.0) //set initial valaue
        print(totalPlace)
        
        if self.currentIndexpath.row  == questionaryFile.count - 1 && sender.tag == 1{
            let questionList = questionaryFile[currentIndexpath.row]
            let strAnsQue: String = UserDefaults.standard.object(forKey: QueAns) as? String ?? ""
            
            self.setQueAnsDataStoreIntDict(strQue: questionList.getString(key: "preferencequestion"), strQueID: questionList.getString(key: "questionid"), strAns: strAnsQue)
            
            let userID: String = UserDefaults.standard.object(forKey: USERID) as? String ?? ""
//            "https://massage-robotics-website.uc.r.appspot.com/wt?tablename=userpreference&row=[('\(userID)','\((ansDataList.getString(key: "QueID")))','\((ansDataList.getString(key: "Ans")))')]"
            
            for i in 0..<localQueAndList.count {
                                    
                let ansDataList = localQueAndList[i]
                print(ansDataList.getString(key: "QueID"))
                let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='UPDATE userpreference SET user_preference_answer='\(ansDataList.getDictionary(key: "QueAnd").getString(key: "Ans"))' where questionid='\(ansDataList.getDictionary(key: "QueAnd").getString(key: "QueID"))' and userid='\(userID)''"
                
                print(url)
                
                let encodedUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                
                callAPI(url: encodedUrl!) { [self] (json, data1) in
                    print(json)
                }
            }
            //Service call
        }else{
            if sender.tag == 1 {
                
                let questionList = questionaryFile[currentIndexpath.row]
                let strAnsQue: String = UserDefaults.standard.object(forKey: QueAns) as? String ?? ""
                
                self.setQueAnsDataStoreIntDict(strQue: questionList.getString(key: "preferencequestion"), strQueID: questionList.getString(key: "questionid"), strAns: strAnsQue)
                
                self.currentIndexpath = IndexPath(row: Int(currentPlace) + 1, section: 0)
                print(currentIndexpath.row)
                
                self.countText.text = "\(currentIndexpath.row + 1) / \(questionaryFile.count)"
                progressBar.progress = Float(Float(currentIndexpath.row + 1)/Float(questionaryFile.count))
                                 
                if currentIndexpath.row + 1 == questionaryFile.count {
                    nextBtn.setTitle("Submit", for: .normal)
                }else {
                    nextBtn.setTitle("Next", for: .normal)
                }
            }else if sender.tag == 0{
                
                localQueAndList.remove(at: self.currentIndexpath.row - 1)
                
                if self.currentIndexpath.row !=  0 {
                    self.currentIndexpath = IndexPath(row: Int(currentPlace) - 1, section: 0)
                    print(currentIndexpath.row)
                    
                    self.countText.text = "\(currentIndexpath.row + 1) / \(questionaryFile.count)"
                    progressBar.progress = Float(Float(currentIndexpath.row + 1)/Float(questionaryFile.count))
                    
                    nextBtn.setTitle("Next", for: .normal)
                }
            }
        }
        self.collectionObj.scrollToItem(at: currentIndexpath, at: .left, animated: true)
        
        collectionObj.reloadData()
    }
    
    func setQueAnsDataStoreIntDict(strQue: String, strQueID: String, strAns: String) {
        dictLocalStore["QueAnd"] = ["Que": strQue, "QueID": strQueID, "Ans": strAns] as AnyObject
        localQueAndList.append(dictLocalStore)
    }
}

extension MyPreferenceVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return questionaryFile.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyPreferenceCollectioncell
        let questionList = questionaryFile[indexPath.row]
        cell.questionaryText.text = questionList.getString(key: "preferencequestion")
        self.currentIndexVal = indexPath.row
        print(self.currentIndexVal)
        
        cell.rangeSelectedbutton.tag = indexPath.section
        cell.pickerview.tag = indexPath.section
        cell.currentIndex = indexPath.row
        cell.staticpickervalue = staticpickervalue//[currentIndexpath.row]
        cell.rangeSelectedbutton.setTitle("", for: .normal)
        borderBtn(value: 5, outlet:cell.rangeSelectedbutton )
        borderColor(value: 1.5, outlet: cell.rangeSelectedbutton)
        
        //design only for pickerview
        
        return cell
        
    }
    
    func designview(dcell : MyPreferenceCollectioncell)  {
        
        dcell.pickerview.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return collectionView.frame.size
    }
    
    //[self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.theData.count - 1 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:NO];

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //design
        let transform : CGAffineTransform = CGAffineTransform(scaleX: 1.0, y: 2.0)
        progressBar.transform = transform
        progressBar.layer.cornerRadius = 8
        progressBar.clipsToBounds = true
    }
}

class MyPreferenceCollectioncell : UICollectionViewCell  {
    var staticpickervalue : [String] = []
    var currentIndex: Int!
    
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var rangeSelectedbutton: UIButton!
    @IBOutlet weak var questionaryText: UILabel!
    @IBOutlet weak var viewContainer: UIView!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pickerview.dataSource = self
        pickerview.delegate = self
        
        self.pickerview.isHidden = true
    }
}

extension MyPreferenceCollectioncell{
    
    @IBAction func onClickPickerDisplay(sender : UIButton){
        self.pickerview.isHidden = false
        self.rangeSelectedbutton.setTitle("", for: .normal)
        
        staticpickervalue .removeAll()
        
        if currentIndex == 0 {
            staticpickervalue = ["Monthly", "Bi-Weekly", "Weekly", "Daily"]
        }else if currentIndex == 1 {
            staticpickervalue = ["Upper Body", "Lower Body", "Legs", "Arms"]
        }else if currentIndex == 2 {
            staticpickervalue = ["Good", "Average", "Poor"]
        }else if currentIndex == 3 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 4 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 5 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 6 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 7 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 8 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 9 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 10 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 11 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 12 {
            staticpickervalue = ["Soft", "Hard"]
        }else if currentIndex == 13 {
            staticpickervalue = ["Loud", "Medium", "Low"]
        }else if currentIndex == 14 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 15 {
            staticpickervalue = ["Work", "Pleasure"]
        }else if currentIndex == 16 {
            staticpickervalue = ["Yes", "No"]
        }else if currentIndex == 17 {
            staticpickervalue = ["Minimum", "Midium", "Maximum"]
        }else if currentIndex == 18 {
            staticpickervalue = ["Dressed", "Undressed"]
        }
        pickerview.reloadAllComponents()
    }
}

extension MyPreferenceCollectioncell:UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return staticpickervalue.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return staticpickervalue[row] // dropdown item
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCost = staticpickervalue[row] // selected item
        self.rangeSelectedbutton.setTitle(selectedCost, for: .normal)
        self.rangeSelectedbutton.setTitleColor(.black, for: .normal)
        self.pickerview.isHidden = true
        
        UserDefaults.standard.set("", forKey: QueAns)
        UserDefaults.standard.set(self.rangeSelectedbutton.titleLabel?.text, forKey: QueAns)
    }
}
