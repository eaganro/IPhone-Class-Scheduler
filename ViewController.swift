import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var addClassButton: UIButton!
    @IBOutlet weak var selectLocationButton: UIButton!
    @IBOutlet weak var classList: UITableView!
    
    var classArray: [String] = []
    var locationArray: [[Double]] = [[]]
    var timeArray: [[String]] = [[]]
    
    var newClassName: String = ""
    var newTimes: [String] = []
    var newLocation: [Double] = []
    
    var latitude: Double = 0
    var longitude: Double = 0
    var clear = false;
    var selectedRow = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return classArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = classArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.row
        performSegue(withIdentifier: "classPage", sender: nil)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool{
        if(identifier == "addClass"){
            if(latitude == 0 && longitude == 0){
                return false
            }
            return true
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addClass" {
            
            let toViewController = segue.destination as! addClass
            
            toViewController.clear = true
        }
        if segue.identifier == "setHome" {
            
            
        }
        if segue.identifier == "classPage" {
            let nextVC = segue.destination as! classPage
            nextVC.index = selectedRow
            nextVC.classTimes = timeArray[selectedRow+1]
            nextVC.homeLat = latitude
            nextVC.homeLng = longitude
            nextVC.classLat = locationArray[selectedRow+1][0]
            nextVC.classLng = locationArray[selectedRow+1][1]
            nextVC.className = classArray[selectedRow]
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let itemsObject = UserDefaults.standard.object(forKey: "classArray")
        
        
        if let tempItems = itemsObject as? [String] {
            classArray = tempItems
        }
        
        classList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            classArray.remove(at: indexPath.row)
            locationArray.remove(at: indexPath.row)
            timeArray.remove(at: indexPath.row)
            
            classList.reloadData()
            
            UserDefaults.standard.set(classArray, forKey: "classArray")
            UserDefaults.standard.set(locationArray, forKey: "locationArray")
            UserDefaults.standard.set(timeArray, forKey: "timeArray")

            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(UserDefaults.standard.object(forKey: "classArray") != nil){
            classArray = UserDefaults.standard.object(forKey: "classArray") as! [String]
        }
        if(UserDefaults.standard.object(forKey: "timeArray") != nil){
            timeArray = UserDefaults.standard.object(forKey: "timeArray") as! [[String]]
        }
        if(UserDefaults.standard.object(forKey: "locationArray") != nil){
            locationArray = UserDefaults.standard.object(forKey: "locationArray") as! [[Double]]
        }
        if(clear == false && UserDefaults.standard.object(forKey: "homeLat") != nil){
            latitude = UserDefaults.standard.object(forKey: "homeLat") as! Double
            longitude = UserDefaults.standard.object(forKey: "homeLng") as! Double
        }
        
        if(newClassName != ""){
            classArray.append(newClassName)
        }
        if(!newTimes.isEmpty){
            timeArray.append(newTimes)
        }
        if(!newLocation.isEmpty){
            locationArray.append(newLocation)
        }
        
        UserDefaults.standard.set(classArray, forKey: "classArray")
        UserDefaults.standard.set(timeArray, forKey: "timeArray")
        UserDefaults.standard.set(locationArray, forKey: "locationArray")
        UserDefaults.standard.set(latitude, forKey: "homeLat")
        UserDefaults.standard.set(longitude, forKey: "homeLng")

        classList.delegate = self
        classList.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

