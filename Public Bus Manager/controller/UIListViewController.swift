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
    
    @IBOutlet weak var currentPosition_lbl: UILabel!
    @IBOutlet weak var sort_view: UIStackView!
    @IBOutlet weak var button_group: UIView!
    @IBOutlet var targetLocationText: UITextField!
    @IBOutlet var busLineTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var polyline: GMSPolyline?
    var bounds: GMSCoordinateBounds?
    var busLines: [BusLineModel]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        busLines = []
        
        checkLocationServices()
        
        busLineTableView.dataSource = self
        busLineTableView.delegate = self
        
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
            busStopMapViewController.busLine = sender as? BusLineModel
            busStopMapViewController.targetStr = targetLocationText.text!
            busStopMapViewController.currentLocation = currentLocation
        }
    }
    
    
    @IBAction func targetLocationActionTrigged(_ sender: Any) {
        if targetLocationText.text! != "" {
            getGoogleMapDistance(modes: [TravelModeType.TRANSIT_LOWER.rawValue, TravelModeType.WALKING_LOWER.rawValue], target: targetLocationText.text!)
        }
    }
    
    
    func setScreenDesign() {
        sort_view.layer.addBorder(edge: UIRectEdge.bottom, color: UIColor.lightGray, thickness: 0.5)
        
        let shadowSize: CGFloat = 16
        let contactRect = CGRect(x: -shadowSize, y: button_group.frame.size.height - (shadowSize * 0.3), width: button_group.frame.size.width + shadowSize * 2, height: shadowSize)
        button_group.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
        button_group.layer.shadowColor = UIColor.lightGray.cgColor
        button_group.layer.shadowOffset = CGSize.zero
        button_group.layer.shadowOpacity = 0.4
        button_group.layer.shadowRadius = 5
    }
    
    
    func getGoogleMapDistance(modes: [String], target: String){
        self.busLines = []

        let group = DispatchGroup()
        
        let origin = "\(currentLocation.coordinate.latitude),\(currentLocation.coordinate.longitude)"
        let destination = "\(target)"
        let googleApiKey = "AIzaSyAsVN1AHgbMr2n3SYtNZxFiT7e1bz3tP5s"
        
        for mode in modes {
        
            let urlQuery = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=\(mode)&key=\(googleApiKey)"
            let url = URL(string: urlQuery.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!)
            let request = URLRequest(url: url!)
            
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
                            let routes = json["routes"] as! [[String:AnyObject]]

                            OperationQueue.main.addOperation({
                                for route in routes
                                {
                                    print("============ google success ============")
                                    
                                    DispatchQueue.main.async {
                                        self.busLines?.append(BusLineModel(route: route))

                                        // ****************************************************
                                        // tells the group a pending process has been completed
                                        group.leave()
                                    }
                                }
                            })
                            
                            
                        }
                    }catch let error as NSError{
                        print(error)
                    }
                }
            }
            dataTask.resume()
        }
        
        group.notify(queue: .main){
            // *****************************************************************************************
            // this will be executed when for each group.enter() call, a group.leave() has been executed
            print("============ google complete ============")
            DispatchQueue.main.async{
                //Reload your table here
                self.busLineTableView.reloadData()
            }
        }
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
        if busLines!.count > 0 {
            return busLines!.count + 1
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < busLines!.count {
            let busLine = busLines![indexPath.row]
            performSegue(withIdentifier: "busStopMapShowIdentifier", sender: busLine)
        }
    }
}

extension UIListViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]

        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil

            currentLocation = location
            
            print("Longitude = \(location.coordinate.longitude), Latitude = \(location.coordinate.latitude)")
        }
    }
}
