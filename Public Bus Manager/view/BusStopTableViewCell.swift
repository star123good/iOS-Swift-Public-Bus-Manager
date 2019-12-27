//
//  BusStopTableViewCell.swift
//  Public Bus Manager
//
//  Created by Boss on 2019/12/26.
//  Copyright © 2019 Boss. All rights reserved.
//

import UIKit

class BusStopTableViewCell: UITableViewCell {

    @IBOutlet weak var busStopImage : UIImageView!
    @IBOutlet weak var busStopTitle : UILabel!
    @IBOutlet weak var busStopDesc : UILabel!
    
    func updateViews(busStop: BusStopModel){
        busStopImage.image = UIImage(named: busStop.iconFile)
        busStopTitle.text = busStop.title
        busStopDesc.text = busStop.description
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
