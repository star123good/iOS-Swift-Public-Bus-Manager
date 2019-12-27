//
//  BusStopModel.swift
//  Public Bus Manager
//
//  Created by Boss on 2019/12/26.
//  Copyright © 2019 Boss. All rights reserved.
//

import Foundation

struct BusStopModel {
    public var title : String!
    public var description : String!
    public var imageFile : String!
    public var iconFile : String!
    public var locationName : String!
    public var discipline : String!
    public var longitude : Double!
    public var latitude : Double!

    init(title: String, description: String, imageFile: String, iconFile: String, locationName: String, discipline: String, longitude: Double, latitude: Double) {
        self.title = title
        self.description = description
        self.imageFile = imageFile
        self.iconFile = iconFile
        self.locationName = locationName
        self.discipline = discipline
        self.longitude = longitude
        self.latitude = latitude
    }
    
    func getArtWork() -> Artwork? {
        guard let artwork = Artwork(
            title: self.title,
            locationName: self.locationName,
            discipline: self.discipline,
            longitude: self.longitude,
            latitude: self.latitude
            ) else { return nil }
        return artwork
    }
}
