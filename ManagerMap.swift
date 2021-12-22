import UIKit
import MapKit
import CoreLocation


struct MapManager {
    var mapView : MKMapView!
    let geoCoder = CLGeocoder()
    
    func getLocationByText(mapView :MKMapView, textField:String ,latitudeDelta :Double ,longitude :Double ,Lable :UILabel) {
        
        geoCoder.geocodeAddressString(textField) {
            placeMarks,Error in
            guard let placeMarks = placeMarks?.first, let location = placeMarks.location?.coordinate else {
                return }
            
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude), span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitude))
            
            Lable.text = "\(placeMarks.country ?? "")  \(placeMarks.administrativeArea ?? "")  \(placeMarks.subAdministrativeArea ?? "")"
            
            mapView.setRegion(region, animated: true)
            
        }
    }
    
    func getCenterLocation (mapView :MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
    
    
    func getAddressNow (mapView :MKMapView , action : @escaping ([CLPlacemark]) -> Void){
        let region = getCenterLocation(mapView: mapView)
        geoCoder.reverseGeocodeLocation(region) { (placeMarks, error) in
            action(placeMarks!)
        }
    }
    
    
}
