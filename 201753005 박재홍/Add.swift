//
//  Add.swift
//  201753005 박재홍
//
//  Created by dit02 on 2019. 12. 13..
//  Copyright © 2019년 DIT. All rights reserved.
//

import Foundation
import MapKit


class data: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
    
    
}
