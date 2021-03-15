//
//  HomeViewCell.swift
//  MassageRobot
//
//  Created by Augmenta on 02/03/21.
//

import UIKit

class HomeViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblRoutineData: UILabel!
    @IBOutlet weak var lblCreateTime: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblFollowersCount: UILabel!
    
    @IBOutlet weak var imgUserProfile: UIImageView!
    @IBOutlet weak var imgBannarPic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
