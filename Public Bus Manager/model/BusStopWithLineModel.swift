//
//  BusStopWithLineModel.swift
//  Public Bus Manager
//
//  Created by Boss on 2020/1/8.
//  Copyright © 2020 Boss. All rights reserved.
//

import Foundation
import GoogleMaps


class BusStopWithLineModel {
    public var title : String!
    public var description : String!
    public var iconFile : String!
    public var longitude : Double!
    public var latitude : Double!
    public var distance : Int!
    public var duration : Int!
    public var points : [[Double]]
    public var path: GMSMutablePath!
    public var polyline: GMSPolyline!
    public var lineTitle: String!
    public var lineIndex: Int!

    init(title: String, description: String, iconFile: String, longitude: Double, latitude: Double, distance: Int, duration: Int, points: [[Double]], lineTitle: String, lineIndex: Int) {
        self.title = title
        self.description = description
        self.iconFile = iconFile
        self.longitude = longitude
        self.latitude = latitude
        self.distance = distance
        self.duration = duration
        self.path = GMSMutablePath()
        self.points = points
        for point in points {
            self.path.add(CLLocationCoordinate2D(latitude: point[0], longitude: point[1]))
        }
        self.polyline = GMSPolyline(path: self.path)
        self.polyline.strokeWidth = 5.0
        self.polyline.strokeColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        self.lineTitle = lineTitle
        self.lineIndex = lineIndex
    }
}


class BusStopLineModel {
    public var busStopList: [BusStopWithLineModel]
    public var title: String
    public var currency: String
    
    init(title: String, currency: String, busStopList: [BusStopWithLineModel]) {
        self.title = title
        self.currency = currency
        self.busStopList = busStopList
    }
}
