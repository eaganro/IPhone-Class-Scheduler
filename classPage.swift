import UIKit
import Foundation


class classPage: UIViewController {
    
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var scheduleText: UILabel!
    @IBOutlet weak var leaveTimeText: UILabel!
    
    var index = 0
    
    var homeLat: Double = 0
    var homeLng: Double = 0
    var classLat: Double = 0
    var classLng: Double = 0
    
    var className: String = ""
    var classTimes: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        topText.text = className
        
        var scheduleString: String = "Class Schedule:\n\n"
        scheduleString += "Monday: " + classTimes[0] + "\n"
        scheduleString += "Tuesday: " + classTimes[1] + "\n"
        scheduleString += "Wednesday: " + classTimes[2] + "\n"
        scheduleString += "Thursday: " + classTimes[3] + "\n"
        scheduleString += "Friday: " + classTimes[4] + "\n"
        scheduleText.text = scheduleString
        
        var googleUrl: String = "https://maps.google.com/maps/api/directions/json?origin="
        googleUrl += "\(homeLat)" + "," + "\(homeLng)"
        googleUrl += "&destination=" + "\(classLat)" + "," + "\(classLng)"
        googleUrl += "&mode=walking";
        print(googleUrl)
        
        let myUrl = URL(string: googleUrl)!
        //let request = NSMutableURLRequest(url: myUrl)
        var myHTMLString = ""
        do {
            myHTMLString = try String(contentsOf: myUrl, encoding: .ascii)
            //print("HTML : \(myHTMLString)")
        } catch let error {
            print("Error: \(error)")
        }
        
        myHTMLString = myHTMLString.components(separatedBy: "\"legs\" : [")[1]
        myHTMLString = myHTMLString.components(separatedBy: "\"duration\" : {")[1]
        myHTMLString = myHTMLString.components(separatedBy: "xt\" : \"")[1]
        myHTMLString = myHTMLString.components(separatedBy: " mins")[0]
        print("\n\n\n" + myHTMLString)
        
        var walkingTime = Int(myHTMLString)!
        
        var leaveString: String = "Leave Time:\n\n"

        
        for i in 0...4{
            var hour = 0
            var minutes = 0
            if(classTimes[i] != "None"){
                hour = Int(classTimes[i].components(separatedBy: ":")[0])!
                minutes = Int(classTimes[i].components(separatedBy: ":")[1])!
            }
            
            
            if(minutes - walkingTime < 0){
                if(hour == 1){
                    hour = 12
                }else{
                    hour -= 1
                }
                minutes = 60 + (minutes - walkingTime)
            }else {
                minutes -= walkingTime
            }
            if(i == 0){
                if(classTimes[i] == "None"){
                    leaveString += "Monday: None\n"
                }else{
                    leaveString += "Monday: \(hour):\(minutes)\n"
                }
            } else if(i == 1){
                if(classTimes[i] == "None"){
                    leaveString += "Tuesday: None\n"
                } else{
                    leaveString += "Tuesday: \(hour):\(minutes)\n"
                }
            } else if(i == 2){
                if(classTimes[i] == "None"){
                    leaveString += "Wednesday: None\n"
                }else{
                    leaveString += "Wednesday: \(hour):\(minutes)\n"
                }
            } else if(i == 3){
                if(classTimes[i] == "None"){
                    leaveString += "Thursday: None\n"
                } else{
                    leaveString += "Thursday: \(hour):\(minutes)\n"
                }
            } else if(i == 4){
                if(classTimes[i] == "None"){
                    leaveString += "Friday: None\n"
                } else{
                    leaveString += "Friday: \(hour):\(minutes)\n"
                }
            }
        }
        
        leaveTimeText.text = leaveString

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
