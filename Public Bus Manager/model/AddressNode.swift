//
//  AddressNode.swift
//  Public Bus Manager
//
//  Created by Boss on 2020/1/8.
//  Copyright © 2020 Boss. All rights reserved.
//

import Foundation
import CoreLocation



class AddressNode {
    
    public var description: String!
    public var mainText: String!
    public var secondaryText: String!
    public var placeid: String!
    
    
    init(prediction: [String:AnyObject]) {
        description = prediction["description"] as? String ?? ""
        
        let structuredFormatting = prediction["structured_formatting"] as? [String:AnyObject]
        mainText = structuredFormatting?["main_text"] as? String ?? ""
        secondaryText = structuredFormatting?["secondary_text"] as? String ?? ""
        
        placeid = prediction["place_id"] as? String ?? ""
    }
    
    static func getGeometry(data: [String:AnyObject]) -> CLLocation {
        if  let geometry = data["geometry"] as? [String:AnyObject],
            let location = geometry["location"] as? [String:AnyObject],
            let lat = location["lat"] as? Double,
            let lng = location["lng"] as? Double {
            // create CLLocation
            return CLLocation(latitude: lat, longitude: lng)
        }
        return CLLocation()
    }
}
