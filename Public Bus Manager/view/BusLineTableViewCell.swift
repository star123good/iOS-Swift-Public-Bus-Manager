//
//  BusLineTableViewCell.swift
//  Public Bus Manager
//
//  Created by Boss on 2019/12/31.
//  Copyright © 2019 Boss. All rights reserved.
//

import UIKit

class BusLineWalkingTableViewCell: UITableViewCell {
    
    @IBOutlet var walkingButton: UIButton!
    @IBOutlet var walkingPositionLabel: UILabel!
    @IBOutlet var walkingDistanceLabel: UILabel!
    @IBOutlet var walkingBusStopLabel: UILabel!
    @IBOutlet var walkingTopUImageView: UIImageView!
    @IBOutlet var walkingBottomUImageView: UIImageView!
    
    func updateViews(transit: BusLineStepModel, option: Int, top: String, bottom: String){
        print("bus line walking table cell")
        
        walkingButton.backgroundColor = .clear
        walkingButton.layer.cornerRadius = 15
        walkingButton.layer.borderWidth = 1
        walkingButton.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.4980392157, blue: 0.8470588235, alpha: 1)
        
        walkingPositionLabel.text = top
        walkingDistanceLabel.text = transit.distance + " (" + transit.duration + ")"
        walkingBusStopLabel.text = bottom
        
        switch option {
        case 0:
            walkingTopUImageView.image = UIImage(named: "cell-a1")
            walkingBottomUImageView.image = UIImage(named: "cell-a2")
            break
        case 1:
            walkingTopUImageView.image = UIImage(named: "cell-a3")
            walkingBottomUImageView.image = UIImage(named: "cell-a2")
            break
        case 2:
            walkingTopUImageView.image = UIImage(named: "cell-a1")
            walkingBottomUImageView.image = UIImage(named: "cell-a4")
            break
        case 3:
            walkingTopUImageView.image = UIImage(named: "cell-a3")
            walkingBottomUImageView.image = UIImage(named: "cell-a4")
            break
        default:
            break
        }
    }
}

class BusLineTransitTableViewCell: UITableViewCell {
    
    @IBOutlet var transitButton: UIButton!
    @IBOutlet var transitTopLabel: UILabel!
    @IBOutlet var transitBottomLabel: UILabel!
    
    func updateViews(transit: BusLineStepModel){
        print("bus line transit table cell")
        
        transitButton.setTitle(transit.transitLineName, for: .normal)
        transitButton.layer.cornerRadius = 5
        
        transitTopLabel.text = transit.instructions
        
        transitBottomLabel.text = "Bus Stops: \(transit.transitLineStops ?? 1) (" + transit.duration + ")"
    }
}
