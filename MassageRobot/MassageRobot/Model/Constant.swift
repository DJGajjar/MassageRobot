//
//  Constant.swift
//  Geoscout
//
//  Created by Augmenta on 19/07/20.
//  Copyright © 2020 Augmenta. All rights reserved.
//

import Foundation
import UIKit

let SHARED_APPDELEGATE = AppDelegate().sharedAppDelegate()

// MARK: - NSUSERDEFAULT KEY Name
let ISSHOWLANDINGPAGE = "isShowLanding"
let USERTYPE = "UserType"


// MARK: - Response Parameter
let POSTREQ = "POST"
let GETREQ = "GET"
let PUTREQ = "PUT"
let GetOkValue = "ok"

// MARK:- Screen size
//let screenSize = UIScreen.main.bounds
//let screenWidth = screenSize.width
//let screenHeight = screenSize.height

let ISLOGIN = "isLogin"
let ISHOMEPAGE = "isHomePage"
let USERID = "userID"
let QueAns = "queans"
let ISANSUPLOAD = "IsAnsUpload"

public var strBaseAPI = ""

// MARK:- API Listing
struct ApiUrls {

    static let baseURL = "https://massage-robotics-website.uc.r.appspot.com"
    
    static let SignUpsubUrl = "/wt?tablename=Userdata&row="
    static let loginsubUrl = "/rd?query='Select u.*, p.thumbnail from Userdata as u left join Userprofile as p on u.userid = p.userid Where"
}

struct TextfieldPlaceholderString {
    
    static let string = TextfieldPlaceholderString()
    
    let provideBDay = "DD"
    let provideBMonth = "MM"
    let provideBYear = "YYYY"
    
    let provideFriendName = "Name of your friend"
}

// MARK: - Api manager class object
//let APIManagerObj = APIManager.sharedInstance()

extension UIColor {
    @nonobjc class var whiteCity: UIColor {
        return UIColor(white: 245.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var btnBGColor: UIColor {
        return UIColor(red: 18.0 / 255.0, green: 162.0 / 255.0, blue: 190.0 / 255.0, alpha: 1.0)
    }
    @nonobjc class var btnSelectColor: UIColor {
        return UIColor(red: 128.0 / 255.0, green: 194.0 / 255.0, blue: 213.0 / 255.0, alpha: 1.0)
    }
}

