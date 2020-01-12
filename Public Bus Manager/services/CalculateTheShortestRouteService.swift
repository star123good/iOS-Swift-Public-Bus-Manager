//
//  CalculateTheShortestRouteService.swift
//  Public Bus Manager
//
//  Created by Boss on 2020/1/8.
//  Copyright © 2020 Boss. All rights reserved.
//

import Foundation
import CoreLocation


class CalculateTheShortestRouteService {
    private var busLineService: BusStopWithLineDataSetService
    private var busLineDict = [String:BusStopLineModel]()
    private var availableBusStopList: [BusStopWithLineModel]
    private var distanceMatrix: [[String:AnyObject]]
    private var distances: [[String]]
    private var distancesValue = [[Int]]()
    private var durations = [[String]]()
    private var durationsValue = [[Int]]()
    public var selectedBusLine: BusStopLineModel!
    public var selectedStartBusStopIndex: Int!
    public var selectedEndBusStopIndex: Int!
    public var selectedShortest: Bool
    public var shortestDuration: Int
    public var shortestWalkingDistance: Int
    public var shortestTransitDistance: Int
    public var shortestTransitDuration: Int
    public var customize = [String:AnyObject]()
    public var startAddress: String
    public var endAddress: String
    
    
    init(busLineService: BusStopWithLineDataSetService, rows: [[String:AnyObject]], startAddress: String, endAddress: String) {
        self.busLineService = busLineService
        for busLine in busLineService.busStopLineList {
            busLineDict[busLine.title] = busLine
        }
        
        self.availableBusStopList = busLineService.availableBusStopList
        self.distanceMatrix = rows
        self.distances = Array(repeating: Array(repeating: "", count: availableBusStopList.count), count: rows.count)
        self.distancesValue = Array(repeating: Array(repeating: -1, count: availableBusStopList.count), count: rows.count)
        self.durations = Array(repeating: Array(repeating: "", count: availableBusStopList.count), count: rows.count)
        self.durationsValue = Array(repeating: Array(repeating: -1, count: availableBusStopList.count), count: rows.count)
        
        var elements: [[String: AnyObject]]
        var distance: [String:AnyObject]
        var duration: [String:AnyObject]
        
        for (i, row) in rows.enumerated() {
            elements = row["elements"] as! [[String: AnyObject]]
            
            for (j, element) in elements.enumerated() {
                if element["status"] as! String == "OK" {
                    distance = element["distance"] as! [String:AnyObject]
                    duration = element["duration"] as! [String:AnyObject]
                    
                    self.distances[i][j] = distance["text"] as! String
                    self.distancesValue[i][j] = distance["value"] as! Int
                    self.durations[i][j] = duration["text"] as! String
                    self.durationsValue[i][j] = duration["value"] as! Int
                }
            }
        }
        
        self.selectedShortest = false
        self.shortestDuration = 0
        self.shortestWalkingDistance = 0
        self.shortestTransitDistance = 0
        self.shortestTransitDuration = 0
        self.startAddress = startAddress
        self.endAddress = endAddress
    }
    
    func calcDuration(start: BusStopWithLineModel, end: BusStopWithLineModel) -> Int {
        if start.lineTitle == end.lineTitle {
            // same line
            let currentLine = busLineDict[start.lineTitle]
            var duration = 0
            if start.lineIndex == end.lineIndex {
                return 0
            }
            else if start.lineIndex < end.lineIndex {
                for i in start.lineIndex...(end.lineIndex-1) {
                    duration = duration + (currentLine?.busStopList[i].duration)!
                }
                return duration
            }
            else if start.lineIndex > end.lineIndex {
                for i in end.lineIndex...(start.lineIndex-1) {
                    duration = duration + (currentLine?.busStopList[i].duration)!
                }
                return duration
            }
        }
        return -1
    }
    
    func calcShortestDuration() {
        var orgToSt = 0,
            stToEn = 0,
            enToTag = 0,
            tempDuration = 0
        shortestDuration = 1000000
        selectedShortest = false
        
        if durationsValue.count == 2 {
            for i in 0...(durationsValue[0].count-1) {
                for j in 0...(durationsValue[1].count-1) {
                    if durationsValue[0][i] > -1 && durationsValue[1][j] > -1 {
                        // duration
                        orgToSt = durationsValue[0][i]
                        enToTag = durationsValue[1][j]
                        stToEn = calcDuration(start: availableBusStopList[i], end: availableBusStopList[j])

                        if stToEn > 0 {
                            tempDuration = orgToSt + stToEn + enToTag
                            if tempDuration < shortestDuration {
                                // refresh
                                shortestDuration = tempDuration
                                selectedBusLine = busLineDict[availableBusStopList[i].lineTitle]
                                selectedStartBusStopIndex = availableBusStopList[i].lineIndex
                                selectedEndBusStopIndex = availableBusStopList[j].lineIndex
                                selectedShortest = true
                                shortestWalkingDistance = distancesValue[0][i] + distancesValue[1][j]
                                shortestTransitDuration = stToEn
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getCustomizeByBusLineModel() -> [String:AnyObject] {
        var lines = [String:AnyObject]()
        
        var path = [[Double]]()
        var st = 0,
            en = 0,
            cnt = 0,
            tmp : BusStopWithLineModel
        if selectedShortest {
            st = min(selectedStartBusStopIndex, selectedEndBusStopIndex)
            en = max(selectedStartBusStopIndex, selectedEndBusStopIndex)
            cnt = en - st
            for i in st..<en {
                tmp = selectedBusLine.busStopList[i]
                path.append(contentsOf: tmp.points)
            }
            
            lines["startLocation"] = CLLocation(latitude: selectedBusLine.busStopList[st].latitude, longitude: selectedBusLine.busStopList[st].longitude)
            lines["endLocation"] = CLLocation(latitude: selectedBusLine.busStopList[en].latitude, longitude: selectedBusLine.busStopList[en].longitude)
        }
        lines["path"] = path as AnyObject
        
        lines["duration"] = String(format:"%d mins", shortestDuration / 60) as AnyObject
        lines["durationValue"] = shortestDuration as AnyObject
        lines["distance"] = String(format:"%d m", shortestWalkingDistance) as AnyObject
        lines["distanceValue"] = shortestWalkingDistance as AnyObject
        
        var step = [String:AnyObject]()
        if (selectedBusLine != nil) {
            step["title"] = selectedBusLine.title as AnyObject
            step["instructions"] = selectedBusLine.busStopList[selectedStartBusStopIndex].description as AnyObject
            step["departureStop"] = selectedBusLine.busStopList[selectedStartBusStopIndex].description as AnyObject
            step["arrivalStop"] = selectedBusLine.busStopList[selectedEndBusStopIndex].description as AnyObject
        }
        else {
            step["title"] = "" as AnyObject
            step["instructions"] = "" as AnyObject
            step["departureStop"] = "" as AnyObject
            step["arrivalStop"] = "" as AnyObject
        }
        step["stops"] = cnt as AnyObject
        step["duration"] = String(format:"%d mins", shortestTransitDuration / 60) as AnyObject
        step["durationValue"] = shortestTransitDuration as AnyObject
        step["distance"] = String(format:"%d m", shortestTransitDistance) as AnyObject
        step["distanceValue"] = shortestTransitDistance as AnyObject
        lines["step"] = step as AnyObject
        
        if (selectedBusLine != nil) {
            lines["currency"] = selectedBusLine.currency as AnyObject
        }
        else {
            lines["currency"] = "" as AnyObject
        }
        
        let currentTime = (Date().timeIntervalSince1970).rounded() + Double(shortestDuration)
        let df = DateFormatter()
        df.dateFormat = "hh:mm"
        let arrivalDate = Date(timeIntervalSince1970: TimeInterval(currentTime))
        lines["arrival"] = df.string(from: arrivalDate) as AnyObject
        
        lines["startAddress"] = startAddress as AnyObject
        lines["endAddress"] = endAddress as AnyObject
        
        self.customize = lines
        return self.customize
    }
}
