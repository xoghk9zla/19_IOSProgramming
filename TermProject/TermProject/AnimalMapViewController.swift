//
//  AnimalMapViewController.swift
//  TermProject
//
//  Created by KPUGAME on 2019. 6. 1..
//  Copyright © 2019년 KPUGAME. All rights reserved.
//

import UIKit
import MapKit

class AnimalMapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var posts = NSMutableArray()
    
    let regionRadius:CLLocationDistance = 5000
    
    func centerMapOnLocation(location: CLLocation){
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    var happenplaces : [HappenPlace] = []
    
    func loadInitialData(){
        for post in posts{
            let kind = (post as AnyObject).value(forKey: "kindCd") as! NSString as String
            let addr = (post as AnyObject).value(forKey: "happenPlace") as! NSString as String
            let geoCoder = CLGeocoder()
           
            geoCoder.geocodeAddressString(addr, completionHandler: {(placemarks, error) -> Void in
                if let placemark = placemarks?.first {
                    let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate

                    let happenplace = HappenPlace(title: kind, locationName: addr, coordinate: CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude))
                    self.happenplaces.append(happenplace)
                    self.mapView.addAnnotations(self.happenplaces)
                    
                }
            })
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControl: UIControl){
        let location = view.annotation as! HappenPlace
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        guard let annotation = annotation as? HappenPlace else {return nil}
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else{
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 37.4908791, longitude: 126.7270392)
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        loadInitialData()
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
