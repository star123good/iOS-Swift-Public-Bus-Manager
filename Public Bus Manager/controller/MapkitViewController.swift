//
//  MapkitViewController.swift
//  Public Bus Manager
//
//  Created by Boss on 2019/12/23.
//  Copyright © 2019 Boss. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GoogleMaps
import Alamofire
import SwiftyJSON

class MapkitViewController: UIViewController {

    @IBOutlet weak var mapKitView: MKMapView!
    
    @IBOutlet weak var pullUpView: PopUpView!
    @IBOutlet weak var pullUpViewHeight: NSLayoutConstraint!
    @IBOutlet weak var pullUpBusStopTitleLabel: UILabel!
    @IBOutlet weak var pullUpDistanceLabel: UILabel!
    @IBOutlet weak var pullUpWalkTimeLabel: UILabel!
    @IBOutlet weak var pullUpSlowTimeLabel: UILabel!
    @IBOutlet weak var pullUpBusStopImage: UIImageView!
    @IBOutlet weak var pullUpLocaionLabel: UILabel!
    @IBOutlet weak var pullUpDescriptionLabel: UILabel!
    @IBOutlet weak var pullUpDistanceImage: UIImageView!
    @IBOutlet weak var pullUpWalkTimeImage: UIImageView!
    @IBOutlet weak var pullUpSlowTimeImage: UIImageView!
    
    var regionRadius: CLLocationDistance = 1000
    var initArtwork: Artwork!
    var busStopModel: BusStopModel!
    let locationManager = CLLocationManager()
    var googleMapApiService = GoogleMapApiService()
    var durationTime = 0.0
    var coordinate = [CLLocationCoordinate2D]()
    var currentLocation = CLLocation()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO:Set up the location manager here.
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        // show artwork on map
        mapKitView.delegate = self
        
//        mapKitView.register(ArtworkMarkerView.self,
//                            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//        mapKitView.register(ArtworkView.self,
//                            forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        initArtwork = busStopModel.getArtWork()
        mapKitView.addAnnotation(initArtwork)
        
        
        animateViewDown()
        addSwipe()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationServices()
        
        getGoogleMapDistance()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    
    @IBAction func btnCenterClicked(_ sender: UIButton) {
        guard let currentCoordinate = locationManager.location else { return }
        centerMapOnLocation(location: currentCoordinate)
    }
    
    @IBAction func btnPopUpClicked(_ sender: UIButton) {
        animateViewUp()
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        self.currentLocation = location
        if self.coordinate.count > 0 {
            var minLongitude = self.coordinate[0].longitude
            var maxLongitude = self.coordinate[0].longitude
            var minLatitude = self.coordinate[0].latitude
            var maxLatitude = self.coordinate[0].latitude
            for coord in self.coordinate {
                if coord.longitude > maxLongitude {
                    maxLongitude = coord.longitude
                }
                if coord.longitude < minLongitude {
                    minLongitude = coord.longitude
                }
                if coord.latitude > maxLatitude {
                    maxLatitude = coord.latitude
                }
                if coord.latitude > minLatitude {
                    minLatitude = coord.latitude
                }
            }
            self.regionRadius = max(maxLatitude - minLatitude, maxLatitude - minLatitude) * 637.8137
        }
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapKitView.setRegion(coordinateRegion, animated: true)
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
            mapKitView.showsUserLocation = true
           case .denied: // Show alert telling users how to turn on permissions
           break
          case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            mapKitView.showsUserLocation = true
          case .restricted: // Show an alert letting them know what’s up
           break
          case .authorizedAlways:
           break
          default:
            break
        }
    }
    
    func setupMapView(){
        if let overlay = getMKPolylineFromData() {
            if mapKitView.overlays.count > 0 {
                mapKitView.removeOverlays(mapKitView.overlays)
            }
            mapKitView.addOverlay(overlay)
        }
    }
    
    func getMKPolylineFromData() -> MKPolyline? {
        // service coordinate
        self.googleMapApiService.setCoordinate(coordinate: self.coordinate)
        // return
        return MKPolyline(coordinates: self.coordinate, count: self.coordinate.count)
    }
    
    func getGoogleMapDistance(){
        let origin = "\(self.currentLocation.coordinate.latitude),\(self.currentLocation.coordinate.longitude)"
        let destination = "\(self.initArtwork.coordinate.latitude),\(self.initArtwork.coordinate.longitude)"
        let googleApiKey = "AIzaSyAsVN1AHgbMr2n3SYtNZxFiT7e1bz3tP5s"
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&key=\(googleApiKey)")
        let request = URLRequest(url: url!)
        self.coordinate = [CLLocationCoordinate2D]()
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
                        let routes = json["routes"] as! [[String:AnyObject]]
                        
                        let firstRoute = routes.first
                        let legs = firstRoute?["legs"] as? [[String:Any]]
                        let leg = legs?.first
                        let distance = leg?["distance"] as? [String:Any]
                        let distanceText = distance?["text"] as? String
                        let distanceValue = distance?["value"] as? Int
                        let duration = leg?["duration"] as? [String:Any]
                        let durationText = duration?["text"] as? String
                        let durationValue = duration?["value"] as? Int
                        self.googleMapApiService.setDistance(dist: distanceText!, value: distanceValue!)
                        self.googleMapApiService.setDuration(durate: durationText!, value: durationValue!)

                        OperationQueue.main.addOperation({
                            for route in routes
                            {
                                let routeOverviewPolyline = route["overview_polyline"] as! [String:String]
                                let points = routeOverviewPolyline["points"]
                                let path = GMSPath.init(fromEncodedPath: points!)
//                                    let polyline = GMSPolyline(path: path)
                                print("============ google success ============")
                                for i in 0..<path!.count() {
                                    let coord = path?.coordinate(at: i)
                                self.coordinate.append(CLLocationCoordinate2D(latitude: coord!.latitude, longitude: coord!.longitude))
                                }
                            }
                            // draw map bus line
                            self.setupMapView()
                
                        })
                    }
                }catch let error as NSError{
                    print(error)
                }
            }
        }
        dataTask.resume()
    }
    
    
    func animateViewUp() {
        pullUpBusStopTitleLabel.isHidden = false
        pullUpDistanceLabel.isHidden = false
        pullUpWalkTimeLabel.isHidden = false
        pullUpSlowTimeLabel.isHidden = false
        pullUpLocaionLabel.isHidden = false
        pullUpDescriptionLabel.isHidden = false
        pullUpBusStopImage.isHidden = false
        pullUpDistanceImage.isHidden = false
        pullUpWalkTimeImage.isHidden = false
        pullUpSlowTimeImage.isHidden = false
        pullUpViewUpdateViews()
        pullUpViewHeight.constant = 300
//        pullUpView.updateViews(busStopModel: self.busStopModel)
        UIView.animate(withDuration: durationTime) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func animateViewDown(){
        if(durationTime <= 0.0){
            pullUpBusStopTitleLabel.isHidden = true
            pullUpDistanceLabel.isHidden = true
            pullUpWalkTimeLabel.isHidden = true
            pullUpSlowTimeLabel.isHidden = true
            pullUpLocaionLabel.isHidden = true
            pullUpDescriptionLabel.isHidden = true
            pullUpBusStopImage.isHidden = true
            pullUpDistanceImage.isHidden = true
            pullUpWalkTimeImage.isHidden = true
            pullUpSlowTimeImage.isHidden = true
        }
        pullUpViewHeight.constant = 0
//        pullUpView.removeAllSubviews()
        UIView.animate(withDuration: durationTime) {
            self.view.layoutIfNeeded()
        }
    }
    
    func addSwipe(){
        durationTime = 0.3
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(animateViewDown))
        swipe.direction = .down
        pullUpView.addGestureRecognizer(swipe)
    }
    
    func pullUpViewUpdateViews(){
        pullUpBusStopTitleLabel.text = self.busStopModel.title
        let dist = googleMapApiService.getDistance()
        pullUpDistanceLabel.text = dist
        pullUpWalkTimeLabel.text = googleMapApiService.getWalkTime()
        pullUpSlowTimeLabel.text = googleMapApiService.getSlowTime()
        pullUpBusStopImage.image = UIImage(named: self.busStopModel.imageFile)
        pullUpLocaionLabel.text = self.busStopModel.locationName
        pullUpDescriptionLabel.text = self.busStopModel.description
    }
}


extension MapkitViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Artwork else { return nil }
        
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            view.glyphImage = UIImage(named: "icons8-traditional-school-bus-30")
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
        calloutAccessoryControlTapped control: UIControl) {
          let location = view.annotation as! Artwork
          let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
          location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        renderer.lineWidth = 3
        return renderer
    }
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]

        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil

            print("Longitude = \(location.coordinate.longitude), Latitude = \(location.coordinate.latitude)")

            centerMapOnLocation(location: location)
        }
        
        
        //
//        if let location = locations.last {
//            centerMapOnLocation(location: location)
//        }
        
    }
    
    //Write the didFailWithError method here:
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
