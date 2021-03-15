//
//  ViewController.swift
//  MassageRobot
//
//  Created by Rohit Parsana on 01/02/21.
//

import UIKit
import SDWebImage

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
    
    var intPassValue: Int = 0
    
    var strValue: String = "0"
    
//    var arrRoutingList = [String]()
    var arrRoutingList = [[String: Any]]()
    
    var isSortByOpen: Bool = false
    var isLogin: String = UserDefaults.standard.object(forKey: ISLOGIN) as? String ?? "No"
    
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
        
        self.setListingServiceCall()
    }
    
    func setListingServiceCall() {
        
        let url = "https://massage-robotics-website.uc.r.appspot.com/rd?query='Select r.*, u.*, p.thumbnail as userprofile from Routine as r left join Userdata as u on r.userid = u.userid left join Userprofile as p on r.userid = p.userid ORDER BY creation DESC LIMIT 10 OFFSET \(intPassValue)'"
        
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
                        arrRoutingList.append(contentsOf: jsonArray)
//                        arrRoutingList = jsonArray
                        if intPassValue == 0 {
                            intPassValue = intPassValue + jsonArray.count + 1
                        }else {
                            intPassValue = intPassValue + jsonArray.count
                        }
                        
                        tableView.reloadData()
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
        
        if isLogin == "Yes" {
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CreateRoutineViewController") as! CreateRoutineViewController
            vc.strTitleName = "New Routine"
            navigationController?.pushViewController(vc, animated: false)
        }else {
            UserDefaults.standard.set("Yes", forKey: ISHOMEPAGE)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let lc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController?.pushViewController(lc, animated: false)
        }
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
        
        return arrRoutingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! HomeViewCell
                
        cell.selectionStyle = .none
        
        let routingData = arrRoutingList[indexPath.row]
        
        cell.lblTitle.text = routingData.getString(key: "firstname") + " " + routingData.getString(key: "lastname")
        cell.lblLikeCount.text = "(" + routingData.getString(key: "likecount") + ")"
        cell.lblReview.text = "4.55(366)"
        cell.lblCreateTime.text = "1W"
        cell.lblRoutineData.text = routingData.getString(key: "routinename")
        cell.lblFollowersCount.text = "0"
        
        if routingData.getString(key: "userprofile") != "" {
            let urls = URL.init(string: routingData.getString(key: "userprofile"))
            cell.imgBannarPic.sd_setImage(with: urls , placeholderImage: UIImage(named: "DemoCellImg"))
        }else {
            cell.imgBannarPic.image = UIImage(named: "DemoCellImg")
        }
        
        if routingData.getString(key: "thumbnail") != "" {
            let urls = URL.init(string: routingData.getString(key: "thumbnail"))
            cell.imgUserProfile.sd_setImage(with: urls , placeholderImage: UIImage(named: "DemoCellImg"))
        }else {
            cell.imgUserProfile.image = UIImage(named: "DemoCellImg")
        }
        
//        let dateComponentsFormatter = DateComponentsFormatter()
//        dateComponentsFormatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth, .month, .year]
//        dateComponentsFormatter.maximumUnitCount = 1
//        dateComponentsFormatter.unitsStyle = .full
//        dateComponentsFormatter.string(from: Date(), to: Date(timeIntervalSinceNow: 4000000))  // "1 month"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 433
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        let routingData = arrRoutingList[indexPath.row]
        
        if isLogin == "Yes" {
            let sb = UIStoryboard(name: "CreateToutine", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "CreateRoutineViewController") as! CreateRoutineViewController
            vc.strTitleName = "Routine Detail"
            vc.strRoutingID = routingData.getString(key: "routineid")
            navigationController?.pushViewController(vc, animated: false)
        }else {
            UserDefaults.standard.set("Yes", forKey: ISHOMEPAGE)
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let lc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            navigationController?.pushViewController(lc, animated: false)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       let height = scrollView.frame.size.height
       let contentYoffset = scrollView.contentOffset.y
       let distanceFromBottom = scrollView.contentSize.height - contentYoffset
       if distanceFromBottom < height {
           self.setListingServiceCall()
       }
   }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}
