//
//  BusStopMapViewController.swift
//  Public Bus Manager
//
//  Created by Boss on 2019/12/30.
//  Copyright © 2019 Boss. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps


class BusStopMapViewController: UIViewController {
    
    @IBOutlet var backNavigateButton: UIButton!
    @IBOutlet var currentPositionButton: UIButton!
    @IBOutlet var popUpButton: UIButton!
    @IBOutlet var googleMapView: GMSMapView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var popUpViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var topBorderView: UIView!
    @IBOutlet var topBorderViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var busLineButton: UIButton!
    @IBOutlet var busLineButtonWidthConstraint: NSLayoutConstraint!
    @IBOutlet var busLineDescriptionLabel: UILabel!
    @IBOutlet var busLinePageController: UIPageControl!
    @IBOutlet var busLineTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    public var busLines: [BusLineModel]!
    private var transitBusLine: BusLineModel!
    private var walkStBusLine: BusLineModel!
    private var walkEnBusLine: BusLineModel!
    public var startStr: String!
    public var targetStr: String!
    public var indexFirst: Int!
    public var isDrawMoving = false
    private var destinationMarker: GMSMarker!
    private var isInBusLine = false
    private var indexInBusLine = 0
    private var durationTime = 0.0
    private var popUpState = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        busLineTableView.rowHeight = UITableView.automaticDimension
//        busLineTableView.estimatedRowHeight = 125
        busLineTableView.dataSource = self
        busLineTableView.delegate = self
        
        if busLines.count == 3 {
            transitBusLine = busLines[0]
            if indexFirst == 2 {
                walkStBusLine = busLines[1]
                walkEnBusLine = busLines[2]
            }
            else {
                walkStBusLine = busLines[2]
                walkEnBusLine = busLines[1]
            }
        }
        
        setScreenDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
        drawGoogleMapViewWithBusLines()
        
        animateViewDown()
        addSwipe()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.setScreenDesign()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.setScreenDesign()
        self.view.layoutIfNeeded()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    
    @IBAction func backNaviagateButtonClicked(_ sender: Any) {
        isDrawMoving = false
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func currentPositionButtonClicked(_ sender: Any) {
        centerMapOnLocation()
    }
    
    @IBAction func popUpShowButtonClicked(_ sender: Any) {
        durationTime = 0.3
        if popUpState {
            animateViewUp()
        }
        else {
            animateViewDown()
        }
    }
    
    
    func centerMapOnLocation() {
        googleMapView.camera = GMSCameraPosition.camera(withLatitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude, zoom: 16)
    }
    
    func drawGoogleMapView() {
        for busLine in busLines {
            var markers = [GMSMarker]()
            var position = busLine.startLocation.coordinate
            var markerView = UIImageView()
            var currentMarker = GMSMarker(position: position)
            currentMarker.title = startStr
            currentMarker.snippet = busLine.startAddress
            markerView = UIImageView(image: UIImage(named: "icon-position-red-big"))
    //        markerView.tintColor = .red
            currentMarker.iconView = markerView
            currentMarker.tracksViewChanges = true
            markers.append(currentMarker)
            
            for transit in busLine.transits {
                let polyline = transit.polyline
                if transit.travelMode == TravelModeType.WALKING.rawValue {
                    polyline?.strokeColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
                    markerView = UIImageView(image: UIImage(named: "icon-position-green-big"))
                }
                else {
                    polyline?.strokeColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
                    markers.last?.iconView = UIImageView(image: UIImage(named: "icons8-traditional-school-bus-30"))
                    markers.last?.title = transit.transitLineName ?? markers.last?.title
                    markers.last?.snippet = transit.departureStop ?? markers.last?.snippet
                    markerView = UIImageView(image: UIImage(named: "icons8-traditional-school-bus-30"))
                }
                polyline?.strokeWidth = 5
                polyline?.map = googleMapView
                
                position = transit.endLocation.coordinate
                currentMarker = GMSMarker(position: position)
                currentMarker.title = transit.transitLineName ?? "TURN"
                currentMarker.snippet = transit.arrivalStop ?? transit.instructions
                
    //            markerView.tintColor = .blue
                currentMarker.iconView = markerView
    //            currentMarker.tracksViewChanges = true
                markers.append(currentMarker)
            }
            
            markers.last?.iconView = UIImageView(image: UIImage(named: "icon-position-bule-big"))
            markers.last?.title = targetStr
            markers.last?.snippet = busLine.endAddress
            
            for marker in markers {
                marker.map = googleMapView
            }
            
            googleMapView.animate(with: GMSCameraUpdate.fit(busLine.bounds, withPadding: 100.0))
        }
    }
        
    func drawGoogleMapViewWithBusLines() {
        var position = walkStBusLine.startLocation.coordinate
        var markerView = UIImageView()
        var currentMarker = GMSMarker(position: position)
        currentMarker.title = startStr
        currentMarker.snippet = walkStBusLine.startAddress
        markerView = UIImageView(image: UIImage(named: "icon-position-red-big"))
        currentMarker.iconView = markerView
        currentMarker.tracksViewChanges = true
        currentMarker.map = googleMapView
        
        position = walkStBusLine.endLocation.coordinate
        currentMarker = GMSMarker(position: position)
        currentMarker.title = transitBusLine.transits.first!.departureStop
        currentMarker.snippet = walkStBusLine.endAddress
        markerView = UIImageView(image: UIImage(named: "icons8-traditional-school-bus-30"))
        currentMarker.iconView = markerView
        currentMarker.tracksViewChanges = true
        currentMarker.map = googleMapView
        
        position = walkEnBusLine.startLocation.coordinate
        currentMarker = GMSMarker(position: position)
        currentMarker.title = transitBusLine.transits.first!.arrivalStop
        currentMarker.snippet = walkEnBusLine.startAddress
        markerView = UIImageView(image: UIImage(named: "icons8-traditional-school-bus-30"))
        currentMarker.iconView = markerView
        currentMarker.tracksViewChanges = true
        currentMarker.map = googleMapView
        
        position = walkEnBusLine.endLocation.coordinate
        currentMarker = GMSMarker(position: position)
        currentMarker.title = targetStr
        currentMarker.snippet = walkEnBusLine.endAddress
        markerView = UIImageView(image: UIImage(named: "icon-position-bule-big"))
        currentMarker.iconView = markerView
        currentMarker.tracksViewChanges = true
        currentMarker.map = googleMapView
        
        
        var polyline = walkStBusLine.polyline
        var totalBounds = GMSCoordinateBounds()
        polyline!.strokeColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        polyline!.strokeWidth = 5
        polyline!.map = googleMapView
        totalBounds = totalBounds.includingBounds(walkStBusLine.bounds)
        
        polyline = walkEnBusLine.polyline
        polyline!.strokeColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        polyline!.strokeWidth = 5
        polyline!.map = googleMapView
        totalBounds = totalBounds.includingBounds(walkEnBusLine.bounds)
        
        polyline = transitBusLine.polyline
        polyline!.strokeColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        polyline!.strokeWidth = 5
        polyline!.map = googleMapView
        totalBounds = totalBounds.includingBounds(transitBusLine.bounds)
        
//        for coordinateIndex in 0 ..< transitBusLine.polyline.path!.count() - 1 {
//            let coord = transitBusLine.polyline.path!.coordinate(at: coordinateIndex)
//            print("\(coord.latitude), \(coord.longitude)")
//        }
        
        
        googleMapView.animate(with: GMSCameraUpdate.fit(totalBounds, withPadding: 100.0))
    }
    
    func setScreenDesign() {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        topBorderViewWidthConstraint.constant = screenWidth
        busLineButton.backgroundColor = .clear
        busLineButton.layer.cornerRadius = 5
        busLineButton.layer.borderWidth = 2
        busLineButton.layer.borderColor = #colorLiteral(red: 0.2549019608, green: 0.4980392157, blue: 0.8470588235, alpha: 1)
        let imageWidth = busLineButton.imageView!.frame.width
        let textWidth = (busLineButton.titleLabel?.text! as! NSString).size(withAttributes:[NSAttributedString.Key.font:busLineButton.titleLabel!.font!]).width
        let width = textWidth + imageWidth + 30
        //24 - the sum of your insets from left and right
        busLineButtonWidthConstraint.constant = width
        
        busLinePageController.isHidden = true
        
        var lineName = "",
            stationNumber = 0,
            totalDuration = 0,
            totalDistance = 0
        for busLine in busLines {
            for transit in busLine.transits {
                if transit.travelMode == TravelModeType.TRANSIT.rawValue {
                    lineName = transit.transitLineName!
                    stationNumber = transit.transitLineStops!
                }
                else {
                    totalDistance = totalDistance + busLine.distanceValue
                }
                totalDuration = totalDuration + busLine.durationValue
            }
        }
        if stationNumber > 0 {
            busLineButton.setTitle(lineName, for: .normal)
            busLineDescriptionLabel.text = transitBusLine.duration + " walk " + transitBusLine.distance + " " +  transitBusLine.fareCurrency + " Bus Stops:\(stationNumber)"
        }
        else {
            busLineButton.setTitle("Walking", for: .normal)
            busLineButton.setImage(UIImage(named: "icon-man-walk"), for: .normal)
            busLineDescriptionLabel.text = "\(totalDuration) mins walk \(totalDistance) m"
        }
    }
    
    @objc func animateViewUp() {
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        popUpViewHeightConstraint.constant = min(screenHeight, 520)
        popUpButton.setImage(UIImage(named: "button-popdown-point"), for: .normal)
        popUpState = false
        UIView.animate(withDuration: durationTime) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func animateViewDown(){
        popUpViewHeightConstraint.constant = 150
        popUpButton.setImage(UIImage(named: "button-popup-point"), for: .normal)
        popUpState = true
        UIView.animate(withDuration: durationTime) {
            self.view.layoutIfNeeded()
        }
    }
    
    func addSwipe(){
        durationTime = 0.3
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(animateViewDown))
        swipeDown.direction = .down
        popUpView.addGestureRecognizer(swipeDown)
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(animateViewUp))
        swipeUp.direction = .up
        popUpView.addGestureRecognizer(swipeUp)
    }
    
    // UpdteLocationCoordinate
    func updateLocationoordinates(coordinates: CLLocationCoordinate2D) {
        let coord = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        let image = UIImage(named:"icon-arrow-green")
        var alpha = 0.0
        let oldIndex = indexInBusLine
        var nextIndex = 0
        isInBusLine = false
        
        for index in 0..<transitBusLine.polyline.path!.count() {
            let points = transitBusLine.polyline.path!.coordinate(at: index)
            let dist = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude).distance(from: CLLocation(latitude: points.latitude, longitude: points.longitude))
            
            if dist < 10 {
                indexInBusLine = Int(index)
                
                if oldIndex < indexInBusLine {
                    nextIndex = indexInBusLine + 1
                }
                else {
                    nextIndex = indexInBusLine - 1
                }
                
                if nextIndex >= 0 && nextIndex < transitBusLine.polyline.path!.count() {
                    let nextPoint = transitBusLine.polyline.path!.coordinate(at: UInt(nextIndex))
                    alpha = BusStopWithLineDataSetService.instance.getBearingBetweenTwoPoints1(lat1: coordinates.latitude, lon1: coordinates.longitude, lat2: nextPoint.latitude, lon2: nextPoint.longitude) - BusStopWithLineDataSetService.instance.M_PI / 2.0
                    isInBusLine = true
                }
                break
            }
        }
        
        if isInBusLine {
            if destinationMarker == nil
            {
                destinationMarker = GMSMarker()
                destinationMarker.position = coord
                destinationMarker.icon = image?.rotate(radians: CGFloat(alpha))
                destinationMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
                destinationMarker.map = googleMapView
                destinationMarker.appearAnimation = .pop
            }
            else
            {
                CATransaction.begin()
                CATransaction.setAnimationDuration(1.0)
                destinationMarker.position = coord
                destinationMarker.icon = image?.rotate(radians: CGFloat(alpha))
                destinationMarker.map = googleMapView
                CATransaction.commit()
            }
        }
        else {
            if destinationMarker != nil
            {
                destinationMarker.position = coord
                destinationMarker.map = nil
            }
        }
    }
}


extension BusStopMapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var totalTransitCount = 0
//        for busLine in busLines {
//            totalTransitCount = totalTransitCount + busLine.transits.count
//        }
        totalTransitCount = 3
        print("transit count")
        print(totalTransitCount)
        return totalTransitCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexVal = indexPath.row
        var currentBusLine = transitBusLine
        switch indexVal {
            case 0:
                currentBusLine = walkStBusLine
                break
            case 1:
                currentBusLine = transitBusLine
                break
            case 2:
                currentBusLine = walkEnBusLine
                break
            default:
                break
        }
        let transit = currentBusLine!.transits[0]
        if indexVal != 1{
            //
            print("walking table view cell")
            if let cell = tableView.dequeueReusableCell(withIdentifier: "busLineWalkingTableCell") as? BusLineWalkingTableViewCell {
                var optionTransit = 0,
                    topText = startStr!,
                    bottomText = targetStr!
                
                if indexVal == 0 {
                    optionTransit = optionTransit + 1
                    bottomText = transitBusLine.transits.first!.departureStop ?? "TURN"
                }
                if indexVal == 2 {
                    optionTransit = optionTransit + 2
                    topText = transitBusLine.transits.first!.arrivalStop ?? "TURN"
                }
                
                cell.updateViews(busLine: currentBusLine!, option: optionTransit, top: topText, bottom: bottomText)
                return cell
            }
            else{
                return BusLineWalkingTableViewCell()
            }
        }
        else{
            //
            print("transit table view cell")
            if let cell = tableView.dequeueReusableCell(withIdentifier: "busLineTransitTableCell") as? BusLineTransitTableViewCell {
                cell.updateViews(transit: transit)
                return cell
            }
            return BusLineTransitTableViewCell()
        }
    }
    
    func tableView_(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var indexVal = indexPath.row
        var currentBusLine = busLines.first
        for busLine in busLines {
            if indexVal < busLine.transits.count {
                currentBusLine = busLine
                break
            }
            else {
                indexVal = indexVal - busLine.transits.count
            }
        }
        let transit = currentBusLine!.transits[indexVal]
        if transit.travelMode == TravelModeType.WALKING.rawValue{
            //
            print("walking table view cell")
            if let cell = tableView.dequeueReusableCell(withIdentifier: "busLineWalkingTableCell") as? BusLineWalkingTableViewCell {
                var optionTransit = 0,
                    topText = startStr!,
                    bottomText = targetStr!
                
                if indexVal == 0 {
                    optionTransit = optionTransit + 1
                }
                if indexVal == (currentBusLine!.transits.count - 1) {
                    optionTransit = optionTransit + 2
                }
                
                if indexVal > 0 {
                    topText = currentBusLine!.transits[indexVal-1].departureStop ?? "TURN"
                }
                if indexVal < (currentBusLine!.transits.count - 1) {
                    bottomText = currentBusLine!.transits[indexVal+1].arrivalStop ?? "TURN"
                }
                
                cell.updateViews(transit: transit, option: optionTransit, top: topText, bottom: bottomText)
                return cell
            }
            else{
                return BusLineWalkingTableViewCell()
            }
        }
        else{
            //
            print("transit table view cell")
            if let cell = tableView.dequeueReusableCell(withIdentifier: "busLineTransitTableCell") as? BusLineTransitTableViewCell {
                cell.updateViews(transit: transit)
                return cell
            }
            return BusLineTransitTableViewCell()
        }
    }
}


extension BusStopMapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]

        if location.horizontalAccuracy > 0 {
            currentLocation = location
            
            if isDrawMoving {
                updateLocationoordinates(coordinates: currentLocation.coordinate)
                print("map view location moving : Latitude = \(location.coordinate.latitude), Longitude = \(location.coordinate.longitude)")
            }
        }
    }
}


extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}
