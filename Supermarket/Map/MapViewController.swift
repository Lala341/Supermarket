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
    var usermanager = UserCoreDataManager();
    fileprivate let locationManager: CLLocationManager =  CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    var primer: Bool = false
    var iniciadoTimer = false
    var user_id : String! = ""
    var timer: DispatchSourceTimer?

    @IBOutlet weak var connect: UILabel!
    var connection: Bool = true
    
    public func cone(){
        if(connection){
            self.connect.isHidden = true
        }else{
            self.connect.isHidden = false
        }
            
    }
    
    private func startTimer() {
        let queue = DispatchQueue(label: "com.firm.app.timer", attributes: .concurrent)

        timer?.cancel()        // cancel previous timer if any

        timer = DispatchSource.makeTimerSource(queue: queue)

        timer?.schedule(deadline: .now(), repeating: .seconds(5), leeway: .milliseconds(20))

        // or, in Swift 3:
        //
        // timer?.scheduleRepeating(deadline: .now(), interval: .seconds(5), leeway: .seconds(1))

        timer?.setEventHandler { [weak self] in // `[weak self]` only needed if you reference `self` in this closure and you want to prevent strong reference cycle
            self!.sendLocalization()
        }

        timer?.resume()
    }

    private func stopTimer() {
        timer?.cancel()
        timer = nil
    }
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
        cone()
        if(iniciadoTimer==false){
            let users: [User] = usermanager.fetchUsers(container: manager.getContainer())
            if(users.count>0){
                user_id = users[0].id
            }
            print("iniciadoTimer")
            iniciadoTimer = true
            startTimer()
        }
        // Do any additional setup after loading the view.
    }
    func sendLocalization(){
        
    print("json")
        let loc_current = locationManager.location
        let url = URL(string: "http://ec2-18-212-16-222.compute-1.amazonaws.com:8086/location")!
        let json: [String: Any] = [
            "lon":loc_current!.coordinate.longitude,
            "lat":loc_current!.coordinate.latitude,
            "user_id": user_id!
            
        ]
        print(json)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: json)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                
                
                return
            }
            print("Send u")
        
    })
        task.resume()
    }
    
    
    func loadData(){
        var stor: [StoreRequest] = []
        let url = URL(string: "http://ec2-18-212-16-222.compute-1.amazonaws.com:8084/analytics/question3")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("error: \(error)")
            } else {
               
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                   let dataf = dataString.data(using: .utf8)!
                    do {
                        if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [String:[String: Any]]
                        {
                            var i = 1;
                            var annnotations: [StoreAnnotation] = []
                            
                           var annotation = StoreAnnotation(
                                title : "Te",
                                subtitle : "gato",
                                thirdAttribut: StoreRequest(name: "Te", address: "Te", photo: "Te", id: Int(1), users: Int(0)), coordinate : CLLocationCoordinate2D(latitude: 4.5972017, longitude: -74.0887572))
                            annotation.title = "Te"
                            annotation.subtitle = "gato"
                            annotation.coordinate = CLLocationCoordinate2D(latitude: 4.5972017, longitude: -74.0887572)
                            while( i < 7){
                                
                                annotation = StoreAnnotation(
                                    title : (jsonArray["\(i)"]!["name"]! as? String)!,
                                    subtitle : (jsonArray["\(i)"]!["address"]! as? String)!,
                                    thirdAttribut:
                                    StoreRequest(name: (jsonArray["\(i)"]!["name"]! as? String)!, address: (jsonArray["\(i)"]!["address"]! as? String)!, photo: (jsonArray["\(i)"]!["logo_img"]! as? String)!, id: ((jsonArray["\(i)"]!["id"]! as! Int)), users:  ((jsonArray["\(i)"]!["current_users"]! as! Int))), coordinate : CLLocationCoordinate2D(latitude: (jsonArray["\(i)"]!["loc_lat"]! as? Double)!, longitude: (jsonArray["\(i)"]!["loc_lon"]! as? Double)!))
                                annotation.title = jsonArray["\(i)"]!["name"]! as? String
                                annotation.subtitle = jsonArray["\(i)"]!["address"]! as? String
                                annotation.coordinate = CLLocationCoordinate2D(latitude: jsonArray["\(i)"]!["loc_lat"]! as! Double, longitude: jsonArray["\(i)"]!["loc_lon"]! as! Double)
                               
                                
                                i = i + 1;
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
    var ima = "marker"
    let annot: StoreAnnotation = annotation as! StoreAnnotation
    if(annot.getThirdAttribut.users!>=40){
        ima = "marker-red"
    }
    print(ima)
    let pinImage = UIImage(named: ima)
           let size = CGSize(width: 65, height: 65)
           UIGraphicsBeginImageContext(size)
           pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
           let resizedImage = UIGraphicsGetImageFromCurrentImageContext()

    annotationView?.image = resizedImage
    

        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        leftIconView.image = UIImage(named: "store")
        annotationView?.leftCalloutAccessoryView = leftIconView
    
   let rightButton = UIButton(type: .contactAdd)
    annotationView?.rightCalloutAccessoryView = rightButton

    
        return annotationView
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let storeAnnotation = view.annotation as? StoreAnnotation{
           
          
            
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
