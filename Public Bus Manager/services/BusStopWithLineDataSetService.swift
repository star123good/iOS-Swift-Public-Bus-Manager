//
//  BusStopWithLineDataSetService.swift
//  Public Bus Manager
//
//  Created by Boss on 2020/1/8.
//  Copyright © 2020 Boss. All rights reserved.
//

import Foundation
import CoreLocation


class BusStopWithLineDataSetService {
    static let instance = BusStopWithLineDataSetService()
    
    public var busStopLineList: [BusStopLineModel]
    public var allBusStopList: [BusStopWithLineModel]
    public var availableBusStopList: [BusStopWithLineModel]
    let availableHalfCount = 10
    let M_PI = 3.141592654
    
    init() {
        busStopLineList = [BusStopLineModel]()
        allBusStopList = [BusStopWithLineModel]()
        availableBusStopList = [BusStopWithLineModel]()
        loadDataFromJson("PublicBusStopWithLineList")
    }
    
    func getAvailableBusStopList(originPoints: CLLocation, targetPoints: CLLocation) -> [BusStopWithLineModel] {
        
        let orgLat = originPoints.coordinate.latitude,
            orgLng = originPoints.coordinate.longitude,
            tagLat = targetPoints.coordinate.latitude,
            tagLng = targetPoints.coordinate.longitude
        var j = 0,
            dist = 0.0,
            tempDis = 0.0,
            known = Array(repeating: true, count: allBusStopList.count),
            tempBusStop : BusStopWithLineModel!,
            jj = 0
        
        availableBusStopList = []
        
        for _ in 0..<(availableHalfCount-1) {
            j = 0
            tempDis = 100000000.0
            jj = -1
            for busStop in allBusStopList {
                if known[j] {
                    // origin
//                    dist = distance(lat1: orgLat, lon1: orgLng, lat2: busStop.latitude, lon2: busStop.longitude, unit: "K")
                    dist = CLLocation(latitude: orgLat, longitude: orgLng).distance(from: CLLocation(latitude: busStop.latitude, longitude: busStop.longitude))
                    if dist < tempDis {
                        tempBusStop = busStop
                        tempDis = dist
                        jj = j
                    }
                    
                    // target
//                    dist = distance(lat1: tagLat, lon1: tagLng, lat2: busStop.latitude, lon2: busStop.longitude, unit: "K")
                    dist = CLLocation(latitude: tagLat, longitude: tagLng).distance(from: CLLocation(latitude: busStop.latitude, longitude: busStop.longitude))
                    if dist < tempDis {
                        tempBusStop = busStop
                        tempDis = dist
                        jj = j
                    }
                }
                
                j = j + 1
            }
            
            if jj >= 0 {
                availableBusStopList.append(tempBusStop)
                known[jj] = false
            }
        }
        
        // add target as bus stop model
        tempBusStop = BusStopWithLineModel(title: "", description: "", iconFile: "", longitude: tagLng, latitude: tagLat, distance: 0, duration: 0, points: [], lineTitle: "", lineIndex: 0)
        availableBusStopList.append(tempBusStop)
        
        return availableBusStopList
    }
    
    func loadDataFromJson(_ fileResource: String) -> Void {
        guard let fileName = Bundle.main.path(forResource: fileResource, ofType: "json")
            else { return  }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))

        guard
            let data = optionalData,
            let json = try? JSONSerialization.jsonObject(with: data),
            let datas = json as? [[String:AnyObject]]
            else { return  }
        
        for work in datas {
            let title = work["title"] as! String
            let currency = work["currency"] as! String
            let route = work["route"] as! [[Any]]
            self.createBusStopLine(title: title, currency: currency, route: route)
        }
    }
    
    func createBusStopLine(title: String, currency: String, route: [[Any]]){
        var busStopList = [BusStopWithLineModel]()
        var currentBusStop: BusStopWithLineModel
        var index = 0
        
        for work in route {
            currentBusStop = BusStopWithLineModel(title: work[0] as! String, description: work[1] as! String, iconFile: "icons8-traditional-school-bus-30", longitude: work[3] as! Double, latitude: work[2] as! Double,  distance: work[4] as! Int, duration: work[5] as! Int, points: work[6] as! [[Double]], lineTitle: title, lineIndex: index)
            busStopList.append(currentBusStop)
            self.allBusStopList.append(currentBusStop)
            index = index + 1
        }
        
        self.busStopLineList.append(BusStopLineModel(title: title, currency: currency, busStopList: busStopList))
    }
    
    func deg2rad(_ deg:Double) -> Double {
        return deg * M_PI / 180
    }

    func rad2deg(_ rad:Double) -> Double {
        return rad * 180.0 / M_PI
    }

    func distance(lat1:Double, lon1:Double, lat2:Double, lon2:Double, unit:String) -> Double {
        let theta = lon1 - lon2
        var dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta))
        dist = acos(dist)
        dist = rad2deg(dist)
        dist = dist * 60 * 1.1515
        if (unit == "K") {
            dist = dist * 1.609344
        }
        else if (unit == "N") {
            dist = dist * 0.8684
        }
        return dist
    }
    
    func getBearingBetweenTwoPoints1(lat1:Double, lon1:Double, lat2:Double, lon2:Double) -> Double {
        let dLon = lon2 - lon1

        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)

        return radiansBearing
    }
}
