//
//  MapViewController.swift
//  supermarketI
//
//  Created by Laura Isabella Forero Camacho on 29/02/20.
//  Copyright © 2020 Laura Isabella Forero Camacho. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    public var manager: CoreDataManager!
    fileprivate let locationManager: CLLocationManager =  CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    var primer: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate=self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        let center = CLLocationCoordinate2D(latitude:4.6243997, longitude: -74.0678175)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        self.mapView.setRegion(region, animated: true)
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        self.loadData()
        // Do any additional setup after loading the view.
    }
    func loadData(){
      print("1")
        var stor: [StoreRequest] = []
        let url = URL(string: "http://ec2-18-212-16-222.compute-1.amazonaws.com:8084/analytics/question3")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
               
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("data: \(dataString)")
                   let dataf = dataString.data(using: .utf8)!
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String:[String: Any]]
                        {
                           print(jsonArray) // use the json here
                            var i = 1;
                            var annnotations: [StoreAnnotation] = []
                            
                           var annotation = StoreAnnotation(
                                title : "Te",
                                subtitle : "gato",
                                thirdAttribut: StoreRequest(name: "Te", address: "Te", photo: "Te", id: Int(1)), coordinate : CLLocationCoordinate2D(latitude: 4.5972017, longitude: -74.0887572))
                            annotation.title = "Te"
                            annotation.subtitle = "gato"
                            annotation.coordinate = CLLocationCoordinate2D(latitude: 4.5972017, longitude: -74.0887572)
                            while( i < 7){
                                print(jsonArray["\(i)"]!["name"]!)
                                
                                annotation = StoreAnnotation(
                                    title : (jsonArray["\(i)"]!["name"]! as? String)!,
                                    subtitle : (jsonArray["\(i)"]!["address"]! as? String)!,
                                    thirdAttribut:
                                    StoreRequest(name: (jsonArray["\(i)"]!["name"]! as? String)!, address: (jsonArray["\(i)"]!["address"]! as? String)!, photo: (jsonArray["\(i)"]!["logo_img"]! as? String)!, id: ((jsonArray["\(i)"]!["id"]! as! Int))), coordinate : CLLocationCoordinate2D(latitude: (jsonArray["\(i)"]!["loc_lat"]! as? Double)!, longitude: (jsonArray["\(i)"]!["loc_lon"]! as? Double)!))
                                annotation.title = jsonArray["\(i)"]!["name"]! as? String
                                annotation.subtitle = jsonArray["\(i)"]!["address"]! as? String
                                annotation.coordinate = CLLocationCoordinate2D(latitude: jsonArray["\(i)"]!["loc_lat"]! as! Double, longitude: jsonArray["\(i)"]!["loc_lon"]! as! Double)
                               
                                
                                i = i + 1;
                                print(i);
                                annnotations.append(annotation)
                                
                                
                                
                            }
                           DispatchQueue.main.async {
                              
                            for j in annnotations{
                                self.mapView.addAnnotation(j)
                                }
                            }
                            
                            
                            
                        } else {
                            print("bad json")
                        }
                    } catch let error as NSError {
                        print(error)
                    }
                }
            }
        }
        task.resume()
        
    }
   func mapView (_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{


        let identifier = "MyPin"

        if annotation.isKind(of: MKUserLocation.self) {
        return nil
        }

        // Reuse the annotation if possible
        var annotationView:MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        
    }
    
    let pinImage = UIImage(named: "marker")
           let size = CGSize(width: 65, height: 65)
           UIGraphicsBeginImageContext(size)
           pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
           let resizedImage = UIGraphicsGetImageFromCurrentImageContext()

    annotationView?.image = resizedImage
    print( resizedImage!.scale)


        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(named: "store")
        annotationView?.leftCalloutAccessoryView = leftIconView
    
   let rightButton = UIButton(type: .contactAdd)
    annotationView?.rightCalloutAccessoryView = rightButton

    
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let storeAnnotation = view.annotation as? StoreAnnotation{
           
            print("pp"); print(storeAnnotation.getThirdAttribut);
            
            
            let VC = self.storyboard!.instantiateViewController(withIdentifier: "ProductsStoreId") as! ProductsTableView
            
                 
             VC.manager = self.manager
            VC.storeTotal = storeAnnotation.getThirdAttribut
             
             self.present(VC, animated: true, completion: nil)
                                    
                                    self.show(VC, sender: self)
        }

    
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            if(primer == false){
                print("location.coordinate.latitude")
                print(location.coordinate.latitude)
                let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                self.mapView.setRegion(region, animated: true)
                self.primer = true
            }
            
        }
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ProductsTableViewController
        {
            let vc = segue.destination as? ProductsTableViewController
            vc?.manager = manager
        }
        else if segue.destination is ProductsTableView
        {
            let vc = segue.destination as? ProductsTableView
            vc?.manager = manager
        }
         else if segue.destination is ProductsCartTableViewController
         {
             let vc = segue.destination as? ProductsCartTableViewController
             vc?.manager = manager
         }
         else if segue.destination is ProductsCartTableView
         {
             let vc = segue.destination as? ProductsCartTableView
             vc?.manager = manager
         }
        else if segue.destination is NotConection
        {
            let vc = segue.destination as? NotConection
            vc?.manager = manager
        }
        else if segue.destination is MapViewController
        {
            let vc = segue.destination as? MapViewController
            vc?.manager = manager
        }
        
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
class StoreAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?

let thirdAttribut: StoreRequest

init(title: String, subtitle: String, thirdAttribut: StoreRequest, coordinate: CLLocationCoordinate2D) {
    self.thirdAttribut = thirdAttribut
    self.coordinate = coordinate
    self.title = title
    self.subtitle = subtitle
    super.init()
}




var getThirdAttribut: StoreRequest {
    return thirdAttribut
}
}
