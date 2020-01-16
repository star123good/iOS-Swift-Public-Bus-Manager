//
//  BusLineStepModel.swift
//  Public Bus Manager
//
//  Created by Boss on 2020/1/8.
//  Copyright © 2020 Boss. All rights reserved.
//

import Foundation
import GoogleMaps


class BusLineStepModel {
    
    public var distance: String!
    public var distanceValue: Int!
    public var duration: String!
    public var durationValue: Int!
    public var endLocation: CLLocation!
    public var startLocation: CLLocation!
    public var instructions: String!
    public var polyline: GMSPolyline!
    public var arrivalStop: String?
    public var arrivalStopLocation: CLLocation?
    public var arrivalTime: String?
    public var departureStop: String?
    public var departureStopLocation: CLLocation?
    public var departureTime: String?
    public var travelMode: String!
    public var transitLineName: String?
    public var transitLineNumber: Int?
    public var transitLineStops: Int?
    
    init(step: [String:AnyObject]){
        let dist = step["distance"] as! [String:AnyObject]
        distance = dist["text"] as? String
        distanceValue = dist["value"] as? Int
        
        let durate = step["duration"] as! [String:AnyObject]
        duration = durate["text"] as? String
        durationValue = durate["value"] as? Int
        
        let end = step["end_location"] as! [String:Double]
        endLocation = CLLocation(latitude: end["lat"]!, longitude: end["lng"]!)
        
        let start = step["start_location"] as! [String:Double]
        startLocation = CLLocation(latitude: start["lat"]!, longitude: start["lng"]!)
        
        instructions = step["html_instructions"] as? String
        instructions = instructions.htmlString
        
        let points = step["polyline"] as! [String:String]
        let path = GMSPath.init(fromEncodedPath: (points["points"])!)
        polyline = GMSPolyline(path: path)
        
        travelMode = step["travel_mode"] as? String
        
        let transit = step["transit_details"] as? [String:AnyObject]
        
        if transit != nil {
            var arrival = transit!["arrival_stop"] as! [String:AnyObject]
            arrivalStop = arrival["name"] as? String
            let arrivalLoc = arrival["location"] as! [String:Double]
            arrivalStopLocation = CLLocation(latitude: arrivalLoc["lat"]!, longitude: arrivalLoc["lng"]!)
            arrival = transit!["arrival_time"] as! [String:AnyObject]
            arrivalTime = arrival["text"] as? String
            
            var departure = transit!["departure_stop"] as! [String:AnyObject]
            departureStop = departure["name"] as? String
            let departureLoc = departure["location"] as! [String:Double]
            departureStopLocation = CLLocation(latitude: departureLoc["lat"]!, longitude: departureLoc["lng"]!)
            departure = transit!["departure_time"] as! [String:AnyObject]
            departureTime = departure["text"] as? String
            
            let line = transit!["line"] as! [String:AnyObject]
            
            transitLineName = line["name"] as? String
            transitLineNumber = line["short_name"] as? Int
            transitLineStops = transit!["num_stops"] as? Int
        }
    }
    
    init(customize: [String:AnyObject]) {
        travelMode = TravelModeType.TRANSIT.rawValue
        transitLineName = customize["title"] as? String
        transitLineStops = customize["stops"] as? Int
        distance = customize["distance"] as? String
        distanceValue = customize["distanceValue"] as? Int
        duration = customize["duration"] as? String
        durationValue = customize["durationValue"] as? Int
        instructions = customize["instructions"] as? String
        arrivalStop = customize["arrivalStop"] as? String
        departureStop = customize["departureStop"] as? String
    }
}


class BusLineModel {
    
    public var path: GMSPath!
    public var polyline: GMSPolyline!
    public var bounds: GMSCoordinateBounds!
    public var fareCurrency: String!
    public var fareCurrencyValue: Double!
    public var arrivalTime: String!
    public var arrivalTimeValue: Int!
    public var departureTime: String!
    public var departureTimeValue: Int!
    public var distance: String!
    public var distanceValue: Int!
    public var duration: String!
    public var durationValue: Int!
    public var endAddress: String!
    public var endLocation: CLLocation!
    public var startAddress: String!
    public var startLocation: CLLocation!
    public var transits: [BusLineStepModel]!
    
    init(route: [String:AnyObject]){
        let routeBounds = route["bounds"] as! [String:AnyObject]
        let northeastBounds = routeBounds["northeast"] as! [String:Double]
        let southwestBounds = routeBounds["southwest"] as! [String:Double]
        bounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: northeastBounds["lat"]!, longitude: northeastBounds["lng"]!), coordinate: CLLocationCoordinate2D(latitude: southwestBounds["lat"]!, longitude: southwestBounds["lng"]!))
        
        let fare = route["fare"] as? [String:AnyObject]
        if fare != nil {
            fareCurrency = fare?["text"] as? String
            fareCurrencyValue = fare?["value"] as? Double
        }
        
        let legsTotal = route["legs"] as! [[String:AnyObject]]
        let legs = legsTotal.first!
        
        let arrival = legs["arrival_time"] as? [String:AnyObject]
        if arrival != nil{
            arrivalTime = arrival?["text"] as? String
            arrivalTimeValue = arrival?["value"] as? Int
        }
        
        let departure = legs["departure_time"] as? [String:AnyObject]
        if departure != nil {
            departureTime = departure?["text"] as? String
            departureTimeValue = departure?["value"] as? Int
        }
        
        let dist = legs["distance"] as! [String:AnyObject]
        distance = dist["text"] as? String
        distanceValue = dist["value"] as? Int
        
        let durate = legs["duration"] as! [String:AnyObject]
        duration = durate["text"] as? String
        durationValue = durate["value"] as? Int
        
        endAddress = legs["end_address"] as? String
        let end = legs["end_location"] as! [String:Double]
        endLocation = CLLocation(latitude: end["lat"]!, longitude: end["lng"]!)
        
        startAddress = legs["start_address"] as? String
        let start = legs["start_location"] as! [String:Double]
        startLocation = CLLocation(latitude: start["lat"]!, longitude: start["lng"]!)
        
        let steps = legs["steps"] as! [[String:AnyObject]]
        
        transits = []
        for step in steps {
            transits.append(BusLineStepModel(step: step))
        }
        
        let routeOverviewPolyline = route["overview_polyline"] as! [String:String]
        let points = routeOverviewPolyline["points"]
        
        path = GMSPath.init(fromEncodedPath: points!)
        polyline = GMSPolyline(path: path)
    }
    
    init(customize: [String:AnyObject]) {
        duration = customize["duration"] as? String
        durationValue = customize["durationValue"] as? Int
        distance = customize["distance"] as? String
        distanceValue = customize["distanceValue"] as? Int
        
        let step = customize["step"] as! [String:AnyObject]
        transits = []
        transits.append(BusLineStepModel(customize: step))
        
        fareCurrency = customize["currency"] as? String
        arrivalTime = customize["arrival"] as? String
        startAddress = customize["startAddress"] as? String
        endAddress = customize["endAddress"] as? String
        
        startLocation = customize["startLocation"] as? CLLocation
        endLocation = customize["endLocation"] as? CLLocation
        
        var customPath = customize["path"] as! [[Double]]
        let tempPath = GMSMutablePath()
        var northeastLat = 100000.0,
            northeastLng = 100000.0,
            southeastLat = -100000.0,
            southeastLng = -100000.0
        if startLocation != nil {
            customPath.insert([startLocation.coordinate.latitude, startLocation.coordinate.longitude], at: 0)
        }
        if endLocation != nil {
            customPath.append([endLocation.coordinate.latitude, endLocation.coordinate.longitude])
        }
        for temp in customPath {
            tempPath.add(CLLocationCoordinate2D(latitude: temp[0], longitude: temp[1]))
            northeastLat = min(northeastLat, temp[0])
            northeastLng = min(northeastLng, temp[1])
            southeastLat = max(southeastLat, temp[0])
            southeastLng = max(southeastLng, temp[1])
        }
        polyline = GMSPolyline(path: tempPath)
        bounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: northeastLat, longitude: northeastLng), coordinate: CLLocationCoordinate2D(latitude: southeastLat, longitude: southeastLng))
    }
    
    init(customizeWalking: [String:AnyObject]) {
        duration = customizeWalking["duration"] as? String
        durationValue = customizeWalking["durationValue"] as? Int
        distance = customizeWalking["distance"] as? String
        distanceValue = customizeWalking["distanceValue"] as? Int
        
        transits = []
        
        fareCurrency = "0 USD"
        arrivalTime = customizeWalking["arrival"] as? String
        startAddress = customizeWalking["startAddress"] as? String
        endAddress = customizeWalking["endAddress"] as? String
    }
}


extension String {
    var htmlAttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return nil
        }
    }
    var htmlString: String {
        return htmlAttributedString?.string ?? ""
    }
}
