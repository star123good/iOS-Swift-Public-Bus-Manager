//
//  BusStopListTableViewCell.swift
//  Public Bus Manager
//
//  Created by Boss on 2019/12/30.
//  Copyright © 2019 Boss. All rights reserved.
//

import UIKit


class BusStopListTableViewCell: UITableViewCell {
    
    @IBOutlet var durationTimeLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var busLineButton: UIButton!
    @IBOutlet var currencyAndStationsLabel: UILabel!
    @IBOutlet var arrivalTimeAndAddressLabel: UILabel!
    @IBOutlet var busLineButtonWidthConstraint: NSLayoutConstraint!
    
    func updateViews(busLine: BusLineModel){
        durationTimeLabel.text = busLine.duration
        distanceLabel.text = busLine.distance
        var lineName = ""
        var stationNumber = 0
        for transit in busLine.transits {
            if transit.travelMode == TravelModeType.TRANSIT.rawValue {
                lineName = transit.transitLineName!
                stationNumber = transit.transitLineStops!
            }
        }
        if stationNumber > 0 {
            busLineButton.setTitle(lineName, for: .normal)
            currencyAndStationsLabel.text = busLine.fareCurrency + " Bus Stops:\(stationNumber)"
            arrivalTimeAndAddressLabel.text = busLine.arrivalTime + " " + busLine.endAddress
        }
        else {
            busLineButton.setTitle("Walking", for: .normal)
            busLineButton.setImage(UIImage(named: "icon-man-walk"), for: .normal)
            currencyAndStationsLabel.isHidden = true
            arrivalTimeAndAddressLabel.text = busLine.endAddress
        }
        busLineButton.backgroundColor = .clear
        busLineButton.layer.cornerRadius = 10
        busLineButton.layer.borderWidth = 2
        busLineButton.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.4980392157, blue: 0.8470588235, alpha: 1)
        let imageWidth = busLineButton.imageView!.frame.width
        let textWidth = (busLineButton.titleLabel!.text! as NSString).size(withAttributes:[NSAttributedString.Key.font:busLineButton.titleLabel!.font!]).width
        let width = textWidth + imageWidth + 30
        //30 - the sum of your insets from left and right
        busLineButtonWidthConstraint.constant = width
        self.layoutIfNeeded()
    }
}


class TaxiTableViewCell: UITableViewCell{
    
    @IBOutlet var taxiAlertLabel: UILabel!
    @IBOutlet var taxiPriceLabel: UILabel!
    @IBOutlet var taxiRemainTimeLabel: UILabel!
    @IBOutlet var taxiTakeButton: UIButton!
    
    func updateViews(){
        //
    }
}


class AddressTableViewCell: UITableViewCell {
    
    @IBOutlet var addressTitleLabel: UILabel!
    @IBOutlet var addressDetailLabel: UILabel!
    
    func updateViews(address: AddressNode){
        addressTitleLabel.text = address.mainText
        addressDetailLabel.text = address.secondaryText
    }
}
