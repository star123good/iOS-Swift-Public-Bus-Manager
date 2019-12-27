//
//  BusStopDataSetService.swift
//  Public Bus Manager
//
//  Created by Boss on 2019/12/26.
//  Copyright © 2019 Boss. All rights reserved.
//

import Foundation


class BusStopDataSetService {
    static let instance = BusStopDataSetService()
    
    private let busStopList = [
        BusStopModel(title: "First Bus Stop", description: "This is the first bus stop of Junipero Serra Fwy", imageFile: "Map-Marker-Marker-Inside-Chartreuse-icon", iconFile: "icon-position-double", locationName: "Cupertino, CA 95014", discipline: "Sculpture", longitude: -122.045541, latitude: 37.334445),
        BusStopModel(title: "Second Bus Stop", description: "This is the second bus stop of Junipero Serra Fwy", imageFile: "Map-Marker-Marker-Inside-Chartreuse-icon", iconFile: "icon-position-double", locationName: "Cupertino, CA 95014", discipline: "Sculpture", longitude: -122.037237, latitude: 37.334436),
        BusStopModel(title: "Third Bus Stop", description: "This is the third bus stop of Junipero Serra Fwy", imageFile: "Map-Marker-Marker-Inside-Chartreuse-icon", iconFile: "icon-position-double", locationName: "Cupertino, CA 95014", discipline: "Sculpture", longitude: -122.028901, latitude: 37.334530),
        BusStopModel(title: "Forth Bus Stop", description: "This is the forth bus stop of Junipero Serra Fwy", imageFile: "Map-Marker-Marker-Inside-Chartreuse-icon", iconFile: "icon-position-double", locationName: "Cupertino, CA 95051", discipline: "Sculpture", longitude: -122.020668, latitude: 37.333800),
        BusStopModel(title: "Fifth Bus Stop", description: "This is the fifth bus stop of Junipero Serra Fwy", imageFile: "Map-Marker-Marker-Inside-Chartreuse-icon", iconFile: "icon-position-double", locationName: "San Jose, CA 95051", discipline: "Sculpture", longitude: -122.013674, latitude: 37.330340),
        BusStopModel(title: "Sixth Bus Stop", description: "This is the sixth bus stop of Junipero Serra Fwy", imageFile: "Map-Marker-Marker-Inside-Chartreuse-icon", iconFile: "icon-position-double", locationName: "San Jose, CA 95129", discipline: "Sculpture", longitude: -122.009157, latitude: 37.328003)
    ]
    
    func getBusStopList() -> [BusStopModel] {
        return busStopList
//        return loadDataFromJson()
    }
    
    func loadDataFromJson() -> [BusStopModel] {
        var artworks : [BusStopModel] = []
        guard let fileName = Bundle.main.path(forResource: "PublicBusStopList", ofType: "json", inDirectory: "resource")
        else { return artworks }
        print(fileName)
      let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))

      guard
        let data = optionalData,
        // 2
        let json = try? JSONSerialization.jsonObject(with: data),
        // 3
        let dictionary = json as? [String: Any],
        // 4
        let works = dictionary["data"] as? [[Any]]
        else { return artworks }
      // 5
        print(works)
//        let validWorks = works.compactMap { BusStopModel(json: $0) }
//        artworks.append(contentsOf: validWorks)
        
        return artworks
    }
}
