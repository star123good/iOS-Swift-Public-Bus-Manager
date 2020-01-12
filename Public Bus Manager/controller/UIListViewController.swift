//
//  UIListViewController.swift
//  Public Bus Manager
//
//  Created by Boss on 2019/12/29.
//  Copyright © 2019 Boss. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps



extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

        let border = CALayer()

        switch edge {
            case UIRectEdge.top:
                border.frame = CGRect(x: 0, y: 0, width: frame.height, height: thickness)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect(x: 0, y: frame.height - thickness, width: UIScreen.main.bounds.width, height: thickness)
                break
            case UIRectEdge.left:
                border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
                break
            default:
                break
        }

        border.backgroundColor = color.cgColor

        self.addSublayer(border)
    }

}


class UIListViewController: UIViewController {
    
    @IBOutlet weak var sort_view: UIStackView!
    @IBOutlet weak var button_group: UIView!
    @IBOutlet var originLocationText: UITextField!
    @IBOutlet var targetLocationText: UITextField!
    @IBOutlet var busLineTableView: UITableView!
    @IBOutlet var buttonGroupHeightConstraint: NSLayoutConstraint!
    
    let googleApiKey = "AIzaSyAsVN1AHgbMr2n3SYtNZxFiT7e1bz3tP5s"
    let myPositionStr = "My Position"
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var polyline: GMSPolyline?
    var bounds: GMSCoordinateBounds?
    var busLines: [BusLineModel]?
    var drawBusLines: [BusLineModel]?
    var addressList: [AddressNode]?
    var isTableStateAddress = false
    var isSelectedTargetText = true
    var isGoogleApiRunning = false
    var indexFirst: Int!
    var originLocation = ""
    var targetLocation = ""
    var originCLLocation = CLLocation()
    var targetCLLocation = CLLocation()
    var isOriginCheck = false
    var isTargetCheck = false
    var calcService: CalculateTheShortestRouteService!
    var dataService: BusStopWithLineDataSetService!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        busLines = []
        
        checkLocationServices()
        
        busLineTableView.dataSource = self
        busLineTableView.delegate = self
        
        dataService = BusStopWithLineDataSetService()
        
        setScreenDesign()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let busStopMapViewController = segue.destination as? BusStopMapViewController {
            busStopMapViewController.busLines = sender as? [BusLineModel]
            busStopMapViewController.startStr = originLocation
            busStopMapViewController.targetStr = targetLocation
            busStopMapViewController.currentLocation = currentLocation
            busStopMapViewController.indexFirst = indexFirst
            busStopMapViewController.isDrawMoving = true
        }
    }
    
    @IBAction func originLocationActionEditingChanged(_ sender: Any) {
        isSelectedTargetText = false
        isOriginCheck = false
        originCLLocation = CLLocation()
        getGoogleMapAutoComplete(input: originLocationText.text!)
    }
    
    @IBAction func targetLocationActionEditingChanged(_ sender: Any) {
        isSelectedTargetText = true
        isTargetCheck = false
        targetCLLocation = CLLocation()
        getGoogleMapAutoComplete(input: targetLocationText.text!)
    }
    
    @IBAction func originLocationActionTrigged(_ sender: Any) {
        getDistancesFromLocations()
    }
    
    @IBAction func targetLocationActionTrigged(_ sender: Any) {
        getDistancesFromLocations()
    }
    
    @IBAction func switchButtonClicked(_ sender: Any) {
        let temp = originLocationText.text
        originLocationText.text = targetLocationText.text
        targetLocationText.text = temp
        
        let temp1 = originCLLocation
        originCLLocation = targetCLLocation
        targetCLLocation = temp1
        
        let temp2 = isOriginCheck
        isOriginCheck = isTargetCheck
        isTargetCheck = temp2
        
        getDistancesFromLocations()
    }
    
    
    func setScreenDesign() {
        sort_view.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.lightGray, thickness: 0.5)
        
        let shadowSize: CGFloat = 16
        button_group.isHidden = false
        buttonGroupHeightConstraint.constant = 0
        let contactRect = CGRect(x: -shadowSize, y: button_group.frame.size.height - (shadowSize * 0.3), width: button_group.frame.size.width + shadowSize * 2, height: shadowSize)
        button_group.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        button_group.layer.shadowColor = UIColor.lightGray.cgColor
        button_group.layer.shadowOffset = CGSize.zero
        button_group.layer.shadowOpacity = 0.4
        button_group.layer.shadowRadius = 5
    }
    
    func getDistancesFromLocations() {
        originLocation = originLocationText.text ?? ""
        if originLocation == "" || originLocation == myPositionStr {
            originLocationText.text = myPositionStr
            isOriginCheck = true
            originCLLocation = currentLocation
        }
        
        targetLocation = targetLocationText.text ?? ""
        if targetLocation == myPositionStr {
            isTargetCheck = true
            targetCLLocation = currentLocation
        }
        
        if !isOriginCheck {
            getGoogleMapPlaceDetail(address: originLocation, isTarget: false)
        }
        else if !isTargetCheck && targetLocation != "" {
            getGoogleMapPlaceDetail(address: targetLocation, isTarget: true)
        }
        else {
            callGoogleMapDistance()
        }
    }
    
    func callGoogleMapDistance(){
        if originLocation != "" && targetLocation != "" {
            getGoogleMapDistanceWithBusStops(origin: originCLLocation, target: targetCLLocation)
        }
    }
    
    func callGoogleMapDistanceWithBusLine(_ busLine: BusLineModel) {
        let mode = [TravelModeType.WALKING_LOWER.rawValue]
        let origins = [
            "\(originCLLocation.coordinate.latitude),\(originCLLocation.coordinate.longitude)",
            "\(busLine.endLocation.coordinate.latitude),\(busLine.endLocation.coordinate.longitude)"
        ]
        let targets = [
            "\(busLine.startLocation.coordinate.latitude),\(busLine.startLocation.coordinate.longitude)",
            "\(targetCLLocation.coordinate.latitude),\(targetCLLocation.coordinate.longitude)"
        ]
        
        self.drawBusLines = [busLine]
        getGoogleMapDistance(modes: mode, origins: origins, targets: targets)
    }
    
    func getGoogleMapAutoComplete(input: String){
        if self.isGoogleApiRunning {
            return
        }
        self.isGoogleApiRunning = true
        self.addressList = []
        
//        let radius = 20000
        
//        let urlQuery = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(input)&types=geocode&key=\(googleApiKey)"
//        let urlQuery = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(input)&types=geocode&key=\(googleApiKey)&location=\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)&radius=\(radius)"
        let urlQuery = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(input)&key=\(googleApiKey)&components=country:bhs"
        let url = URL(string: urlQuery.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!)
        let request = URLRequest(url: url!)
        
        var predictions = [[String:AnyObject]]()
        
        print("============ google start ============")
        print(url!.absoluteString)
        
        let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
            if(error != nil){
                print("============ google error ============")
            }
            else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    if json["status"] as! String == "OK"
                    {
                        predictions = json["predictions"] as! [[String:AnyObject]]
                    }
                }catch let error as NSError{
                    print(error)
                }
            }
            
            DispatchQueue.main.async {
                for prediction in predictions
                {
                    print("============ google success ============")
                 
                    self.addressList?.append(AddressNode(prediction: prediction))
                }
                
                print("============ google complete ============")
                self.isGoogleApiRunning = false
                //Reload your table here
                self.isTableStateAddress = true
                self.busLineTableView.reloadData()
            }
        }
        dataTask.resume()
    }
    
    func getGoogleMapDistance(modes: [String], origins: [String], targets: [String]){
        if self.isGoogleApiRunning || origins.count != targets.count || origins.count == 0 {
            return
        }
        self.isGoogleApiRunning = true

        let group = DispatchGroup()
        self.indexFirst = 1
        
        for mode in modes {
            
            for (i, origin) in origins.enumerated() {
                let target = targets[i]
        
                let urlQuery = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(target)&mode=\(mode)&key=\(googleApiKey)"
                let url = URL(string: urlQuery.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!)
                let request = URLRequest(url: url!)
                
                var routes = [[String:AnyObject]]()
                
                print("============ google start ============")
                print(url!.absoluteString)
                
                group.enter()
                
                let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
                    if(error != nil){
                        print("============ google error ============")
                    }
                    else{
                        do{
                            let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                            if json["status"] as! String == "OK"
                            {
                                routes = json["routes"] as! [[String:AnyObject]]
                            }
                        }catch let error as NSError{
                            print(error)
                        }
                    }
                    
                    OperationQueue.main.addOperation({
                        DispatchQueue.main.async {
                            for route in routes
                            {
                                print("============ google success ============")
                             
                                self.drawBusLines?.append(BusLineModel(route: route))
                                if i == 0 {
                                    self.indexFirst = self.drawBusLines?.count
                                }
                            }
                            // ****************************************************
                            // tells the group a pending process has been completed
                            group.leave()
                        }
                    })
                }
                dataTask.resume()
            }
        }
        
        group.notify(queue: .main){
            // *****************************************************************************************
            // this will be executed when for each group.enter() call, a group.leave() has been executed
            print("============ google complete ============")
            self.isGoogleApiRunning = false
            DispatchQueue.main.async{
                //Reload your table here
                self.performSegue(withIdentifier: "busStopMapShowIdentifier", sender: self.drawBusLines)
                self.isTableStateAddress = false
                self.busLineTableView.reloadData()
            }
        }
    }
    
    func getGoogleMapDistanceWithBusStops(origin: CLLocation, target: CLLocation){
        if self.isGoogleApiRunning {
            return
        }
        self.isGoogleApiRunning = true
        self.busLines = []
        
        let mode = TravelModeType.WALKING_LOWER.rawValue
        let origins = "\(origin.coordinate.latitude),\(origin.coordinate.longitude)|\(target.coordinate.latitude),\(target.coordinate.longitude)"
        let destinations = self.dataService.getAvailableBusStopList(originPoints: origin, targetPoints: target).map {  String(format:"%f", $0.latitude) + "," + String(format:"%f", $0.longitude) }.joined(separator: "|")
        
        let urlQuery = "https://maps.googleapis.com/maps/api/distancematrix/json?origins=\(origins)&destinations=\(destinations)&mode=\(mode)&key=\(googleApiKey)"
        let url = URL(string: urlQuery.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!)
        let request = URLRequest(url: url!)
            
        var rows = [[String:AnyObject]]()
        
        print("============ google start ============")
        print(url!.absoluteString)
            
        let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
            if(error != nil){
                print("============ google error ============")
            }
            else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    if json["status"] as! String == "OK"
                    {
                        rows = json["rows"] as! [[String:AnyObject]]
                    }
                }catch let error as NSError{
                    print(error)
                }
            }
            
            
            DispatchQueue.main.async {
                print("============ google success ============")
                self.calcService = CalculateTheShortestRouteService(busLineService: self.dataService, rows: rows, startAddress: self.originLocation, endAddress: self.targetLocation)
                self.calcService.calcShortestDuration()
                self.busLines?.append(BusLineModel(customize: self.calcService.getCustomizeByBusLineModel()))
                print("============ google complete ============")
                self.isGoogleApiRunning = false
                //Reload your table here
                self.isTableStateAddress = false
                self.busLineTableView.reloadData()
            }
        }
        dataTask.resume()
    }
    
    func getGoogleMapPlaceDetail(address: String, isTarget: Bool){
        if self.isGoogleApiRunning {
            return
        }
        self.isGoogleApiRunning = true
        self.busLines = []
        
        let urlQuery = "https://maps.googleapis.com/maps/api/geocode/json?address=\(address)&key=\(googleApiKey)"
        let url = URL(string: urlQuery.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!)
        let request = URLRequest(url: url!)
            
        var result = [String:AnyObject]()
        
        print("============ google start ============")
        print(url!.absoluteString)
            
        let dataTask = URLSession.shared.dataTask(with: request){(data, response, error) in
            if(error != nil){
                print("============ google error ============")
            }
            else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    if json["status"] as! String == "OK"
                    {
                        let results = json["results"] as! [[String:AnyObject]]
                        result = results.first!
                    }
                }catch let error as NSError{
                    print(error)
                }
            }
            
            
            DispatchQueue.main.async {
                print("============ google success ============")
                let loc = AddressNode.getGeometry(data: result)
                if isTarget {
                    self.isTargetCheck = true
                    self.targetCLLocation = loc
                }
                else{
                    self.isOriginCheck = true
                    self.originCLLocation = loc
                }
                print("============ google complete ============")
                self.isGoogleApiRunning = false
                self.callGoogleMapDistance()
            }
        }
        dataTask.resume()
    }
    
    func checkLocationServices() {
      if CLLocationManager.locationServicesEnabled() {
        checkLocationAuthorization()
      } else {
        // Show alert letting the user know they have to turn this on.
      }
    }
    
    func checkLocationAuthorization() {
      switch CLLocationManager.authorizationStatus() {
          case .authorizedWhenInUse:
            break
           case .denied: // Show alert telling users how to turn on permissions
           break
          case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
          case .restricted: // Show an alert letting them know what’s up
           break
          case .authorizedAlways:
           break
          default:
            break
        }
    }
}


extension UIListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isTableStateAddress {
            // show addess table view
            return addressList?.count ?? 0
        }
        else{
            // show bus line table view
            if busLines!.count > 0 {
                return busLines!.count + 1
            }
            else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isTableStateAddress {
            // show addess table view
            print("address table view cell")
            if indexPath.row < addressList!.count {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell3") as? AddressTableViewCell {
                    let address = addressList![indexPath.row]
                    cell.updateViews(address: address)
                    return cell
                }
                else {
                    return AddressTableViewCell()
                }
            }
            else{
                return AddressTableViewCell()
            }
        }
        else{
            // show bus line table view
            if indexPath.row < busLines!.count {
                //
                print("bus line table view cell")
                if let cell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell1") as? BusStopListTableViewCell {
                    let busLine = busLines![indexPath.row]
                    cell.updateViews(busLine: busLine)
                    return cell
                }
                else{
                    return BusStopListTableViewCell()
                }
            }
            else{
                //
                print("taxi table view cell")
                if let cell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell2") as? TaxiTableViewCell {
                    cell.updateViews()
                    return cell
                }
                return TaxiTableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isTableStateAddress {
            // show addess table view
            if indexPath.row < addressList!.count {
                let address = addressList![indexPath.row]
                if isSelectedTargetText {
                    targetLocationText.text = address.description
                }
                else{
                    originLocationText.text = address.description
                }
                getDistancesFromLocations()
            }
        }
        else{
            // show bus line table view
            if indexPath.row < busLines!.count {
                let busLine = busLines![indexPath.row]
                callGoogleMapDistanceWithBusLine(busLine)
            }
        }
    }
}


extension UIListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]

        if location.horizontalAccuracy > 0 {
//            locationManager.stopUpdatingLocation()
//            locationManager.delegate = nil

            currentLocation = location
            
            print("list view location moving : Latitude = \(location.coordinate.latitude), Longitude = \(location.coordinate.longitude)")
        }
    }
}
