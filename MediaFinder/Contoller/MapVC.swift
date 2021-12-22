import UIKit
import MapKit
import CoreLocation

protocol AddressDelegate {
    func sendAdress(adress: String)
}

class MapVC: UIViewController {
    
    // MARK: - Outlets.
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var userLocationLabel: UILabel!
    
    // MARK: - Variables.
    
    var delegate: AddressDelegate?
    lazy var geocoder = CLGeocoder()
    var tag = 0
    
    // MARK: - LifeCycle Functions.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Button Functions.
    
    @IBAction func submitBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}


// MARK: - MKMapViewDelegate Extension.

extension MapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.centerCoordinate
        print(center)
        getNameOfLocation(lat: center.latitude, long: center.longitude)
    }
}

// MARK: - MapCenterVC Extension.

extension MapVC {
    
    private func getNameOfLocation(lat:CLLocationDegrees,long:CLLocationDegrees) {
        
        let location = CLLocation(latitude: lat, longitude: long)
        
        // Geocode Location
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
        
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if error != nil {
            userLocationLabel.text = "Unable to Find Address for Location"
            
        } else {
            if let placemarks = placemarks, let placemark = placemarks.first {
                userLocationLabel.text = placemark.compactAddress ?? ""
                delegate?.sendAdress(adress: placemark.compactAddress ?? "N/A")
            } else {
                userLocationLabel.text = "No Matching Addresses Found"
                delegate?.sendAdress(adress: "No Matching Addresses Found")
            }
        }
    }
}

extension CLPlacemark {
    
    var compactAddress: String? {
        if let name = name {
            var result = name
            
            if let street = thoroughfare {
                result += ", \(street)"
            }
            
            if let city = locality {
                result += ", \(city)"
            }
            
            if let country = country {
                result += ", \(country)"
            }
            
            return result
        }
        
        return nil
    }
}




