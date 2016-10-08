//
//  ViewController.swift
//  goBiker
//
//  Created by Mike on 08/10/2016.
//  Copyright © 2016 Mike. All rights reserved.
//

import UIKit
import MapKit
import QuartzCore
import Pulsator
import Alamofire
import ObjectMapper


class ViewController: UIViewController , MKMapViewDelegate  {
    // =========================================================================
    // MARK: - Variable Declaration
    @IBOutlet weak var msgBoxTopConstrain: NSLayoutConstraint!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var lblMsgContent: UILabel!
   
    enum dataError: Error {
        case emptyData
        case Unknown
    }
    
    // =========================================================================
    // MARK: - Override function
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
         //Initialize User Profile , Assume device binded and logged In.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.userProfile  = ProfileViewModel(profile: Profile(UUID:"A1233-B1233-C12341", Balance: 122.88))
        
        
        initMap(mapView: mapView, sender: self)
        addAnnotations()
        dropdownHide()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            UIView.animate(withDuration: 2.35, delay: 0.0, usingSpringWithDamping: 5.0, initialSpringVelocity: 1.5,
                           options: .curveEaseIn, animations: {
                            self.dropdownShow()
                            self.view.layoutIfNeeded()
                },completion: {
                    finished in
                    self.callingWebService()
            })
        }
    }
    // =========================================================================
    // MARK: - Data processing
    
    func callingWebService(){
        // http://www.mocky.io/v2/57f921880f0000b6145a7ce3 - invalid format
        // http://www.mocky.io/v2/57f915490f000074135a7ce1 - correct
        Alamofire.request("http://www.mocky.io/v2/57f915490f000074135a7ce1").validate().responseString { response in
            switch response.result {
            case .success:
                self.success(data: response.result.value!)
            case .failure( _):
                self.failure(error: "Domain can't be reached." , retry: true)
            }
        }
    }
    
    func failure(error:String, retry:Bool)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.alertController = UIAlertController(title: "Sorry", message: "\(error)", preferredStyle: .alert)
        var defaultAction = UIAlertAction()
        if(retry){
            defaultAction = UIAlertAction(title: "Try Again", style: .default, handler:  {Void in
                self.callingWebService()
            })
        }else{
            defaultAction = UIAlertAction(title: "Stop", style: .default, handler:  nil)
        }
        
        appDelegate.alertController.addAction(defaultAction)
        
        present(appDelegate.alertController, animated: true, completion: nil)
    }
    
    func success(data:String)
    {
        do {
            _ = try verifyData(names: data)
            self.populateData(data:data)
            self.goPage2()
        } catch dataError.emptyData {
            failure(error:"Invalid data format Received.Please try again later.", retry:false)
        } catch {
            print("i dunno")
        }
    }
    
    func populateData(data :String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Mapping variable
        let response = Mapper<Webservice>().map(JSONString: data)
        
        //Assign into Transaction Object
         appDelegate.transaction  = TransactionViewModel(transaction:
            Transaction(
                TransactionID:          (response?.TransactionID)!,
                Date:                   (response?.Date)!,
                EstimateArrivalTime:    (response?.EstimateArrivalTime)!,
                EstimateDuration:       (response?.EstimateDuration)!,
                Amount :                (response?.Amount)!,
                Currency :              (response?.Currency)!
        ))
        
        //Assign into Biker Object
        appDelegate.biker  = BikeViewModel(Bike:
            Bike(
                Name:                   (response?.Biker.first?.Name)!,
                PlateNumber:            (response?.Biker.first?.PlateNumber)!
        ))
        
    }
    
    func verifyData(names:String) throws -> String {
        let response = Mapper<Webservice>().map(JSONString: names)
        guard let data = response?.TransactionID else {
            throw dataError.emptyData
        }
        return data
    }
    
    // =========================================================================
    // MARK: - Animate
    func goPage2 () {
       performSegue(withIdentifier: "page2", sender: nil)
    }

    
    func dropdownHide() {
        self.msgBoxTopConstrain.constant = -100.0
        
    }
    
    func dropdownShow() {
        self.msgBoxTopConstrain.constant = 0.0
        self.lblMsgContent.text = "Searching Driver , Please be patient . ."
    }

    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){
        //use for unwind from ack to rootview
    }
    
    // =========================================================================
    // MARK: - MapKit
    
    private func addAnnotations() {
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2DMake(50, -100)
        mapView.addAnnotation(point)
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.classForCoder()) else { return nil }
        
        return AnnotationView(annotation: annotation, reuseIdentifier: "PulsatorDemoAnnotation")
    }
    
    func initMap(mapView:MKMapView , sender: MKMapViewDelegate){
        let delta = 5.0
        var region = MKCoordinateRegion()
        region.center.latitude = 50.0
        region.center.longitude = -100.0
        region.span.latitudeDelta = delta
        region.span.longitudeDelta = delta
        mapView.setRegion(region, animated: true)
        mapView.delegate = sender
        
    }
}




class AnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        addPulse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addPulse() {
        let pulsator = Pulsator()
        pulsator.position = center
        pulsator.numPulse = 8
        pulsator.radius = 40
        pulsator.animationDuration = 3
        pulsator.backgroundColor = UIColor(red: 0, green: 0.455, blue: 0.756, alpha: 1).cgColor
        layer.addSublayer(pulsator)
        pulsator.start()
    }
}



