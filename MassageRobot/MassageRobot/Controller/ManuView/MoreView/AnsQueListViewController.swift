//
//  AnsQueListViewController.swift
//  MassageRobot
//
//  Created by Augmenta on 16/03/21.
//

import UIKit

class AnsQueListViewController: UIViewController {

    @IBOutlet weak var tblAnsQueList: UITableView!
    
    var dictLocalStore = [String: AnyObject]()
    var queAnsList = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tblAnsQueList.register(UINib(nibName: "AnsQueCell", bundle: nil), forCellReuseIdentifier: "AnsQueCell")
        
        tblAnsQueList.estimatedRowHeight = 80
        tblAnsQueList.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func btnBackToMenuAction(_ sender: UIButton) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    @IBAction func btnUpdateProfileAction(_ sender: UIButton) {
        let myProfileInfo = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
        myProfileInfo.strPath = "AnsList"
        self.navigationController?.pushViewController(myProfileInfo, animated: true)
    }
}

//MARK:- Tableview Delegate Datasource
extension AnsQueListViewController : UITableViewDelegate, UITableViewDataSource {
         
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queAnsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let queAnsCell = tableView.dequeueReusableCell(withIdentifier: "AnsQueCell") as! AnsQueCell
        
        queAnsCell.selectionStyle = .none
        
        let queAndDataList = queAnsList[indexPath.row]
        
        queAnsCell.lblQue.text = queAndDataList.getDictionary(key: "QueAns").getString(key: "Que")
        queAnsCell.lblAns.text = "Answer : " + queAndDataList.getDictionary(key: "QueAns").getString(key: "Ans")
//
//        notiCell.lblTitle.text = notificationList.getString(key: "title")
//        notiCell.lblDescription.text = notificationList.getString(key: "description")
//
//        let fullDate = notificationList.getString(key: "dt_created")
//
//        let strTimeGet = fullDate.components(separatedBy: "-")
//
//        notiCell.lblDateTime.text = strTimeGet[0] + "\n" + strTimeGet[1]
        
        return queAnsCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tblAnsQueList.rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
