//
//  PopUpView.swift
//  Public Bus Manager
//
//  Created by Boss on 2019/12/26.
//  Copyright © 2019 Boss. All rights reserved.
//

import UIKit

class PopUpView: UIView {

    var busStopTitleLabel: UILabel?
    var busStopLocationLabel: UILabel?
    var busStopDescLabel: UILabel?
    var busStopDistanceLabel: UILabel?
    var busStopLocationImageView: UIImageView?
    var busStopDescImageView: UIImageView?
    var busStopDistanceImageView: UIImageView?
    
    var busStopModel: BusStopModel?
    
    func updateViews(busStopModel: BusStopModel){
        self.busStopModel = busStopModel
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        removeAllSubviews()
        
        busStopTitleLabel = UILabel()
        busStopTitleLabel?.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 45)
        busStopTitleLabel?.font = UIFont(name: "Avenir Next", size: 20)
        busStopTitleLabel?.font = UIFont.boldSystemFont(ofSize: (busStopTitleLabel?.font.pointSize)!)
        busStopTitleLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        busStopTitleLabel?.textAlignment = .center
        busStopTitleLabel?.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        busStopTitleLabel?.layer.borderWidth = 1
        busStopTitleLabel?.text = self.busStopModel?.title
        self.addSubview(busStopTitleLabel!)
        
        busStopLocationLabel = UILabel()
        busStopLocationLabel?.frame = CGRect(x: 90, y: 50, width: screenWidth - 130, height: 30)
        busStopLocationLabel?.font = UIFont(name: "Avenir Next", size: 15)
        busStopLocationLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        busStopLocationLabel?.textAlignment = .left
        busStopLocationLabel?.text = self.busStopModel?.locationName
        self.addSubview(busStopLocationLabel!)
        
        busStopDescLabel = UILabel()
        busStopDescLabel?.frame = CGRect(x: 90, y: 80, width: screenWidth - 130, height: 70)
        busStopDescLabel?.font = UIFont(name: "Avenir Next", size: 15)
        busStopDescLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        busStopDescLabel?.textAlignment = .left
        busStopDescLabel?.text = self.busStopModel?.description
        self.addSubview(busStopDescLabel!)
        
        busStopDistanceLabel = UILabel()
        busStopDistanceLabel?.frame = CGRect(x: 90, y: 150, width: 200, height: 30)
        busStopDistanceLabel?.font = UIFont(name: "Avenir Next", size: 15)
        busStopDistanceLabel?.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        busStopDistanceLabel?.textAlignment = .left
        busStopDistanceLabel?.text = self.busStopModel?.discipline
        self.addSubview(busStopDistanceLabel!)
        
        busStopLocationImageView = UIImageView(image: UIImage(named: "icon-position-bule"))
        busStopLocationImageView?.frame = CGRect(x: 41, y: 58, width: 16, height: 21)
        self.addSubview(busStopLocationImageView!)
        
        busStopDescImageView = UIImageView(image: UIImage(named: "icon-info"))
        busStopDescImageView?.frame = CGRect(x: 40, y: 107, width: 18, height: 18)
        self.addSubview(busStopDescImageView!)
        
        busStopDistanceImageView = UIImageView(image: UIImage(named: "icon-man-walk"))
        busStopDistanceImageView?.frame = CGRect(x: 41, y: 156, width: 16, height: 21)
        self.addSubview(busStopDistanceImageView!)
    }

    func removeAllSubviews(){
        for view in self.self.subviews {
            view.removeFromSuperview()
        }
    }
}
