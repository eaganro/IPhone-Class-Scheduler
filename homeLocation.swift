import UIKit
import MapKit


class homeLocation: UIViewController {
    
    @IBOutlet weak var map: MKMapView!
    
    var latitude: Double = 0
    var longitude: Double = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeReturn" {
            
            let nav = segue.destination as! UINavigationController
            let toViewController = nav.topViewController as! ViewController
            
            toViewController.latitude = latitude
            toViewController.longitude = longitude
            toViewController.clear = true
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(homeLocation.longpress(gesrecg:)))
        uilpgr.minimumPressDuration = 2
        map.addGestureRecognizer(uilpgr)
        
    }
    
    func longpress (gesrecg: UIGestureRecognizer) {
        
        let touchPoint = gesrecg.location(in: self.map)
        
        let coordinate = map.convert(touchPoint, toCoordinateFrom: self.map)
        
        latitude = coordinate.latitude
        longitude = coordinate.longitude
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = "New Place"
        annotation.subtitle = "Like to go"
        
        map.addAnnotation(annotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
