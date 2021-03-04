//
//  ViewController.swift
//  MassageRobot
//
//  Created by Rohit Parsana on 01/02/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btnForYou: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnSortBy: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var viewSort: UIView!
    @IBOutlet weak var viewSortAnimation: UIView!
    
    @IBOutlet weak var constHeightY: NSLayoutConstraint!
    
    @IBOutlet weak var imgAlphabetical: UIImageView!
    @IBOutlet weak var imgNewest: UIImageView!
    @IBOutlet weak var imgOldest: UIImageView!
    
    var isSortByOpen: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        btnForYou.backgroundColor = UIColor.btnBGColor
        btnMenu.backgroundColor = UIColor.clear
        viewSort.backgroundColor = UIColor.clear
        btnAdd.backgroundColor = UIColor.clear
        
        btnForYou.setTitleColor(UIColor.white, for: .normal)
        btnMenu.setImage(UIImage(named: "Sidemenu"), for: .normal)
        btnSortBy.setImage(UIImage(named: "SortIcon"), for: .normal)
        btnAdd.setImage(UIImage(named: "AddIcon"), for: .normal)
        
        imgAlphabetical.isHidden = false
        imgNewest.isHidden = true
        imgOldest.isHidden = true
        
        self.tableView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellReuseIdentifier: "UserListCell")
    }
    
    @IBAction func btnForYouAction(_ sender: UIButton) {
        self.viewSortAnimation.isHidden = true
        
        btnForYou.backgroundColor = UIColor.btnBGColor
        btnMenu.backgroundColor = UIColor.clear
        viewSort.backgroundColor = UIColor.clear
        btnAdd.backgroundColor = UIColor.clear
        
        btnForYou.setTitleColor(UIColor.white, for: .normal)
        btnMenu.setImage(UIImage(named: "Sidemenu"), for: .normal)
        btnSortBy.setImage(UIImage(named: "SortIcon"), for: .normal)
        btnAdd.setImage(UIImage(named: "AddIcon"), for: .normal)
    }
    
    @IBAction func btnSideMenuAction(_ sender: UIButton) {
        self.viewSortAnimation.isHidden = true
        
        btnForYou.backgroundColor = UIColor.clear
        btnMenu.backgroundColor = UIColor.btnBGColor
        viewSort.backgroundColor = UIColor.clear
        btnAdd.backgroundColor = UIColor.clear
        
        btnForYou.setTitleColor(UIColor.black, for: .normal)
        btnMenu.setImage(UIImage(named: "SelectSidemenu"), for: .normal)
        btnSortBy.setImage(UIImage(named: "SortIcon"), for: .normal)
        btnAdd.setImage(UIImage(named: "AddIcon"), for: .normal)
    }
    
    @IBAction func btnSortByAction(_ sender: UIButton) {
        btnForYou.backgroundColor = UIColor.clear
        btnMenu.backgroundColor = UIColor.clear
        viewSort.backgroundColor = UIColor.btnBGColor
        btnAdd.backgroundColor = UIColor.clear
        
        btnForYou.setTitleColor(UIColor.black, for: .normal)
        btnMenu.setImage(UIImage(named: "Sidemenu"), for: .normal)
        btnSortBy.setImage(UIImage(named: "SelectSortIcon"), for: .normal)
        btnAdd.setImage(UIImage(named: "AddIcon"), for: .normal)

        UIView.animate(withDuration: 0.3, animations: {
            self.btnSortBy.transform = CGAffineTransform.identity.rotated(by: 180 * CGFloat(Double.pi))
            self.btnSortBy.transform = CGAffineTransform.identity.rotated(by: -1 * CGFloat(Double.pi))
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.setReturnBack()
        }
        
        self.showNewInfoView()
    }
    
    func setReturnBack() {
        UIView.animate(withDuration: 0.3, animations: {
            self.btnSortBy.transform = CGAffineTransform.identity.rotated(by: +180 * CGFloat(Double.pi))
        })
    }
    
    @IBAction func btnAddAction(_ sender: UIButton) {
        
        self.viewSortAnimation.isHidden = true
        
        btnForYou.backgroundColor = UIColor.clear
        btnMenu.backgroundColor = UIColor.clear
        viewSort.backgroundColor = UIColor.clear
        btnAdd.backgroundColor = UIColor.btnBGColor
        
        btnForYou.setTitleColor(UIColor.black, for: .normal)
        btnMenu.setImage(UIImage(named: "Sidemenu"), for: .normal)
        btnSortBy.setImage(UIImage(named: "SortIcon"), for: .normal)
        btnAdd.setImage(UIImage(named: "SelectAddIcon"), for: .normal)
        
        let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CreateRoutineViewController") as! CreateRoutineViewController
        vc.strTitleName = "New Routine"
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showNewInfoView(){
        self.viewSortAnimation.isHidden = false
        
        if isSortByOpen == false {
            isSortByOpen = true
            UIView.animate(withDuration: 1.0, delay: 0, options: [.curveLinear],
                           animations: {
                            
                            self.constHeightY.constant = 193
                            self.viewSortAnimation.center.y -= UIScreen.main.bounds.height
                            
    //                        if SharedFunctions.sharedInstance().isiPhone6() {
    //                            self.constHeightY.constant = 193
    //                            self.viewSortAnimation.frame = CGRect(x: 0, y: 427, width: 375, height: 193)
    //                        } else if SharedFunctions.sharedInstance().isiPhone6P() {
    //                            self.constHeightY.constant = 193
    //                            self.viewSortAnimation.frame = CGRect(x: 0, y: 427, width: 375, height: 193)
    //                        } else if SharedFunctions.sharedInstance().isiPhoneXs() {
    //                            self.constHeightY.constant = 193
    //                            self.viewSortAnimation.frame = CGRect(x: 0, y: 427, width: 375, height: 193)
    //                        } else if SharedFunctions.sharedInstance().isiPhoneXSMax() {
    //                            self.constHeightY.constant = 193
    //                            self.viewSortAnimation.frame = CGRect(x: 0, y: 427, width: 375, height: 193)
    //                        } else if SharedFunctions.sharedInstance().isiPhone12() {
    //                            self.constHeightY.constant = 193
    //                            self.viewSortAnimation.frame = CGRect(x: 0, y: 427, width: 375, height: 193)
    //                        } else if SharedFunctions.sharedInstance().isiPhone12Mini() {
    //                            self.constHeightY.constant = 193
    //                            self.viewSortAnimation.frame = CGRect(x: 0, y: 427, width: 375, height: 193)
    //                        } else if SharedFunctions.sharedInstance().isiPhone12ProMax() {
    //                            self.constHeightY.constant = 193
    //                            self.viewSortAnimation.frame = CGRect(x: 0, y: 427, width: 375, height: 193)
    //                        }
                            self.viewSortAnimation.layoutIfNeeded()
            }, completion: nil)
        }else {
            isSortByOpen = false
            UIView.animate(withDuration: 1.0, delay: 0, options: [.curveLinear],
                           animations: {
                            self.constHeightY.constant = 193
                            self.viewSortAnimation.center.y += UIScreen.main.bounds.height
                            self.viewSortAnimation.layoutIfNeeded()
            },  completion: nil)
        }
    }
    
    func hideNewInfoView(){
        isSortByOpen = false
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveLinear],
                       animations: {
                        self.constHeightY.constant = 193
                        self.viewSortAnimation.center.y += UIScreen.main.bounds.height
                        self.viewSortAnimation.layoutIfNeeded()
        },  completion: nil)
        
        //self.viewSortAnimation.isHidden = true
    }
    
    @IBAction func btnAlphabeticalAction(_ sender: UIButton) {
        imgAlphabetical.isHidden = false
        imgNewest.isHidden = true
        imgOldest.isHidden = true
        
        self.hideNewInfoView()
    }
    
    @IBAction func btnNewestAction(_ sender: UIButton) {
        imgAlphabetical.isHidden = true
        imgNewest.isHidden = false
        imgOldest.isHidden = true
        
        self.hideNewInfoView()
    }
    
    @IBAction func btnOldestAction(_ sender: UIButton) {
        imgAlphabetical.isHidden = true
        imgNewest.isHidden = true
        imgOldest.isHidden = false
        
        self.hideNewInfoView()
    }
}

extension UIView{
    func animShow(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! HomeViewCell
                
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 433
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "CreateRoutineViewController") as! CreateRoutineViewController
        vc.strTitleName = "Routine Detail"
        navigationController?.pushViewController(vc, animated: false)
    }
    
}

