//
//  GoogleMapViewController.swift
//  Public Bus Manager
//
//  Created by Boss on 2019/12/28.
//  Copyright © 2019 Boss. All rights reserved.
//

import UIKit
import GoogleMaps

class GoogleMapViewController: UIViewController {

    var mapView : GMSMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func loadView() {
        let camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: 37.334445, longitude: -122.045541), zoom: 13.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        mapView?.settings.scrollGestures = false
//        mapView?.settings.zoomGestures = false
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 37.334445, longitude: -122.045541)
        marker.title = "Sydney"
        marker.snippet = "AU"
        view = mapView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getGoogleMapDistance(mode: "transit")
        getGoogleMapDistance(mode: "walking")
        getGoogleMapDistance(mode: "driving")
    }
    

    func getGoogleMapDistance(mode: String){
        let origin = "37.334445,-122.045541"
        let destination = "37.354445,-122.065541"
        let googleApiKey = "AIzaSyAsVN1AHgbMr2n3SYtNZxFiT7e1bz3tP5s"
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=\(mode)&key=\(googleApiKey)")
        let request = URLRequest(url: url!)
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
                       

                        OperationQueue.main.addOperation({
                            for route in routes
                            {
                                let routeOverviewPolyline = route["overview_polyline"] as! [String:String]
                                let points = routeOverviewPolyline["points"]
                                let path = GMSPath.init(fromEncodedPath: points!)
                                let polyline = GMSPolyline(path: path)
                                polyline.strokeColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                                polyline.strokeWidth = 5
                                let bounds = GMSCoordinateBounds(path: path!)
                                self.mapView!.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 30.0))
                                print("============ google success ============")
                                polyline.map = self.mapView
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
}
