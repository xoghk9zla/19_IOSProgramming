//
//  Hospital.swift
//  TermProject
//
//  Created by KPUGAME on 2019. 6. 16..
//  Copyright © 2019년 KPUGAME. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Hospital: NSObject, MKAnnotation{
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String?{
        return locationName
    }
    
    func mapItem()->MKMapItem{
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    
}
