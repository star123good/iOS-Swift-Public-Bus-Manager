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
    
    public var busLine: BusLineModel!
    public var targetStr: String!
    private var durationTime = 0.0
    private var popUpState = true
    var currentLocation = CLLocation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        busLineTableView.rowHeight = UITableView.automaticDimension
//        busLineTableView.estimatedRowHeight = 125
        busLineTableView.dataSource = self
        busLineTableView.delegate = self
        
        setScreenDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        drawGoogleMapView()
        
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
        var markers = [GMSMarker]()
        var position = busLine.startLocation.coordinate
        var markerView = UIImageView()
        var currentMarker = GMSMarker(position: position)
        currentMarker.title = "My Poisition"
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
        
        googleMapView.animate(with: GMSCameraUpdate.fit(busLine!.bounds, withPadding: 100.0))
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
        
        var lineName = ""
        var stationNumber = 0
        for transit in busLine.transits {
            if transit.travelMode == TravelModeType.TRANSIT.rawValue {
                lineName = transit.transitLineName!
                stationNumber = transit.transitLineStops!
            }
        }
        if stationNumber > 0 {
            busLineButton.setTitle(lineName, for: .normal)
            busLineDescriptionLabel.text = busLine.duration + " walk " + busLine.distance + " " + busLine.fareCurrency + " Bus Stops:\(stationNumber)"
        }
        else {
            busLineButton.setTitle("Walking", for: .normal)
            busLineButton.setImage(UIImage(named: "icon-man-walk"), for: .normal)
            busLineDescriptionLabel.text = busLine.duration + " walk " + busLine.distance
        }
    }
    
    @objc func animateViewUp() {
        let screenSize = UIScreen.main.bounds
        let screenHeight = screenSize.height
        popUpViewHeightConstraint.constant = min(screenHeight, 550)
        popUpButton.setImage(UIImage(named: "button-popdown-point"), for: .normal)
        popUpState = false
        UIView.animate(withDuration: durationTime) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func animateViewDown(){
        popUpViewHeightConstraint.constant = 180
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
}


extension BusStopMapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("transit count")
        print(busLine.transits.count)
        return busLine.transits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indexVal = indexPath.row
        let transit = busLine.transits[indexVal]
        if transit.travelMode == TravelModeType.WALKING.rawValue{
            //
            print("walking table view cell")
            if let cell = tableView.dequeueReusableCell(withIdentifier: "busLineWalkingTableCell") as? BusLineWalkingTableViewCell {
                var optionTransit = 0,
                    topText = "My Position",
                bottomText = targetStr!
                
                if indexVal == 0 {
                    optionTransit = optionTransit + 1
                }
                if indexVal == (busLine.transits.count - 1) {
                    optionTransit = optionTransit + 2
                }
                
                if indexVal > 0 {
                    topText = busLine.transits[indexVal-1].departureStop ?? "TURN"
                }
                if indexVal < (busLine.transits.count - 1) {
                    bottomText = busLine.transits[indexVal+1].arrivalStop ?? "TURN"
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
