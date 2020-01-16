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
    
    
    func updateBasicViews(distance: String, duration: String, option: Int, top: String, bottom: String) {
        print("bus line walking table cell")
        
        walkingButton.backgroundColor = .clear
        walkingButton.layer.cornerRadius = 15
        walkingButton.layer.borderWidth = 1
        walkingButton.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.4980392157, blue: 0.8470588235, alpha: 1)
        
        walkingPositionLabel.text = top
        walkingDistanceLabel.text = distance + " (" + duration + ")"
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
    
    func updateViews(transit: BusLineStepModel, option: Int, top: String, bottom: String){
        updateBasicViews(distance: transit.distance, duration: transit.duration, option: option, top: top, bottom: bottom)
    }
    
    func updateViews(busLine: BusLineModel, option: Int, top: String, bottom: String){
        updateBasicViews(distance: busLine.distance, duration: busLine.duration, option: option, top: top, bottom: bottom)
    }
}

class BusLineTransitTableViewCell: UITableViewCell {
    
    @IBOutlet var transitButton: UIButton!
    @IBOutlet var transitTopLabel: UILabel!
    @IBOutlet var transitButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet var transitBusStopListTableView: UITableView!
    
    private var busStopList: [BusStopWithLineModel]!
    
    
    func updateViews(transit: BusLineStepModel, busStopList: [BusStopWithLineModel]){
        print("bus line transit table cell")
        
        self.busStopList = busStopList
        
        transitBusStopListTableView.dataSource = self
        transitBusStopListTableView.delegate = self
        
        transitButton.setTitle(transit.transitLineName, for: .normal)
        transitButton.layer.cornerRadius = 5
        
        transitTopLabel.text = transit.instructions
        
//        transitBottomLabel.text = "Bus Stops: \(transit.transitLineStops ?? 1) (" + transit.duration + ")"
        
//        let imageWidth = transitButton.imageView!.frame.width
        let textWidth = (transitButton.titleLabel!.text! as NSString).size(withAttributes:[NSAttributedString.Key.font:transitButton.titleLabel!.font!]).width
        let width = textWidth + 30
        transitButtonWidthConstraint.constant = width
    }
}

extension BusLineTransitTableViewCell: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busStopList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let busStop = busStopList[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "busLineTransitBusStopListTableCell") as? BusLineTransitBusStopListTableViewCell {
            cell.updateViews(title: busStop.description, duration: String(format:"%d mins", busStop.duration))
            return cell
        }
        return BusLineTransitBusStopListTableViewCell()
    }
}


class BusLineTransitBusStopListTableViewCell: UITableViewCell {
    
    @IBOutlet var butStopTitleLabel: UILabel!
    @IBOutlet var busStopDurationLabel: UILabel!
    
    func updateViews(title: String, duration: String) {
        butStopTitleLabel.text = title
        busStopDurationLabel.text = duration
    }
}
