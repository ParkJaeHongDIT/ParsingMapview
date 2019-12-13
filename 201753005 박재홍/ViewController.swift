//
//  ViewController.swift
//  201753005 박재홍
//
//  Created by dit02 on 2019. 12. 13..
//  Copyright © 2019년 DIT. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, XMLParserDelegate, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    // 데이터를 받을 배열
    var annotation: data?
    var annotations: Array = [data]()
    
     // 파싱 데이터를 저장할 자료구조
    var item: [String:String] = [:]
    var items: [[String:String]] = []
    
     // 현재의 tag 저장
    var currentElement = ""
    
    var name: String?
    var lat: String?
    var lng: String?
    var dLat: Double?
    var dLng: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.mapView.showsUserLocation = true
        
        // Pasing 시작
        if let path = Bundle.main.url(forResource: "Add", withExtension: "xml"){
            if let myParser = XMLParser(contentsOf: path) {
                myParser.delegate = self
                
                if myParser.parse() {
                    print("파싱 성공!")
                    for item in items {
                        
                    }
                } else {
                    print("파싱 실패")
                }
            } else {
                print("file load error")
            }
        } else {
            print("not file")
        }
        
        mapView.delegate = self
        
        //시작 지도 설정
        zoomToRegion()
        
        //xml파일에 있는 정보를 선언
        for item in items {
            
            lat = item["lat"]
            lng = item["lng"]
            name = item["title"]
            
            // 형변환
            dLat = Double(lat!)
            dLng = Double(lng!)
            
            //파싱한 위도 경도를 받아서 지도에 핀을 꼽음
            annotation = data(coordinate: CLLocationCoordinate2D(latitude: dLat!, longitude: dLng!), title: name!)
            annotations.append(annotation!)
        }
        mapView.addAnnotations(annotations)
        
        
        
    }
    
    func zoomToRegion() {
        //시작할때 지도 위치와 확대 정보
        let location = CLLocationCoordinate2D(latitude: 35.164437, longitude: 129.064962)
        let span = MKCoordinateSpan(latitudeDelta: 0.015, longitudeDelta: 0.015)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    // XMLParser delegate Method
    // XML 파서가 시작 태그를 만나면 호출
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
    }
    
    // XML 파서가 종료 태그를 만나면 호출
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            items.append(item)
            print(item)
        }
    }
    
    // 현재 태그에 담겨있는 문자열 전달
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        // white char(공백) 제거
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        //print(data)
        if !data.isEmpty {
            item[currentElement] = data
        }
        
    }
    
}

