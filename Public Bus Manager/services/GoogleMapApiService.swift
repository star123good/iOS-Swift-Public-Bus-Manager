//
//  GoogleMapApiService.swift
//  Public Bus Manager
//
//  Created by Boss on 2019/12/27.
//  Copyright © 2019 Boss. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class GoogleMapApiService {
    
    var orginLocation: CLLocation?
    var destinLocation: CLLocation?
    var coordinate = [CLLocationCoordinate2D]()
    var distanceStr = ""
    var distance = 0
    var durationStr = ""
    var duration = 0
    var durationSlow = 0
    
    func getDistance() -> String{
        return distanceStr
    }
    
    func getWalkTime() -> String {
        return durationStr
    }
    
    func getSlowTime() -> String {
        let temp = Double(duration)
        durationSlow = Int(temp * 1.6 / 60.0)
        return "\(durationSlow) mins"
    }
    
    func setCoordinate(coordinate: [CLLocationCoordinate2D]){
        self.coordinate = coordinate
    }
    
    func setDistance(dist: String, value: Int){
        distanceStr = dist
        distance = value
    }
    
    func setDuration(durate: String, value: Int){
        durationStr = durate
        duration = value
    }
}
