//
//  MenuViewController.swift
//  MassageRobot
//
//  Created by Sumit Sharma on 11/02/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    let menuItem = ["My Profile","My Preference","Add New Routine","Contact Us","Gallery","Investors","FAQ","Logout","Calibration","Reset"]
    let menuItemIcon = ["MyProfile","MyPreference","AddNewRoutine","ContactUs","Gallery","Investors","FAQ","Logout","CalibrationANdReset","CalibrationANdReset"]
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var table_View: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table_View.alwaysBounceVertical = false
        
    }
    
    override func viewDidLayoutSubviews() {
        table_View.isScrollEnabled = table_View.contentSize.height > table_View.frame.size.height
    }
    
    //MARK:- design
    func designcell(dcell : MenuCellView, index : IndexPath ) {
        dcell.menuItems.text = menuItem[index.item]
        dcell.menuIcons.image = UIImage(named: menuItemIcon[index.item])
    }
}

extension MenuViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuCellView
        
        cell.selectionStyle = .none

        designcell(dcell: cell , index: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexmenuItem = indexPath.item
        
        var isLogin: String = UserDefaults.standard.object(forKey: ISLOGIN) as? String ?? "No"
        
        if isLogin == "Yes" {
            switch indexmenuItem {
            case 0:
                print("Profile")
                let myProfileInfo = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "MyProfileViewController") as! MyProfileViewController
                self.navigationController?.pushViewController(myProfileInfo, animated: true)
                
            case 1:
                print("My prference")
                
                let MyPreference = UIStoryboard(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "MyPreferenceVC") as! MyPreferenceVC
                
                self.navigationController?.pushViewController(MyPreference, animated: true)
                
            case 2:
                print("Add New Routine")
                let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "CreateRoutineViewController") as! CreateRoutineViewController
                vc.strTitleName = "New Routine"
                navigationController?.pushViewController(vc, animated: false)
            case 3:
                print("Contact us")
                
            case 4:
                print("Gallery")
                
            case 5:
                print("Investore")
                
            case 6:
                print("Faq")
                
            case 7:
                print("LogOut")
                UserDefaults.standard.set("No", forKey: ISLOGIN)
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! ViewController
                UIApplication.topViewController()?.navigationController?.pushViewController(vc, animated: true)
            case 8:
                print("Calibration")
                
            default:
                print("Reset")
            }
        }else {
            UserDefaults.standard.set("No", forKey: ISHOMEPAGE)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let lc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController?.pushViewController(lc, animated: false)
        }
    }
}

class MenuCellView : UITableViewCell  {
    
    @IBOutlet weak var menuIcons: UIImageView!
    @IBOutlet weak var menuItems: UILabel!
    
}

