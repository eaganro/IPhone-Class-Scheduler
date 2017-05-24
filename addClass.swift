import UIKit

class addClass: UIViewController {
    
    var clear: Bool = false
    
    @IBOutlet weak var className: UITextField!
    
    @IBOutlet weak var monSwitch: UISwitch!
    @IBOutlet weak var tuesSwitch: UISwitch!
    @IBOutlet weak var wedSwitch: UISwitch!
    @IBOutlet weak var thursSwitch: UISwitch!
    @IBOutlet weak var friSwitch: UISwitch!
    
    var switches: [UISwitch] = []
    var switchStatus: [Bool] = []
    
    @IBOutlet weak var monSlider: UISlider!
    @IBOutlet weak var tuesSlider: UISlider!
    @IBOutlet weak var wedSlider: UISlider!
    @IBOutlet weak var thursSlider: UISlider!
    @IBOutlet weak var friSlider: UISlider!
    
    var sliders: [UISlider] = []
    var sliderStatus: [Int] = []
    
    @IBOutlet weak var monText: UILabel!
    @IBOutlet weak var tuesText: UILabel!
    @IBOutlet weak var wedText: UILabel!
    @IBOutlet weak var thursText: UILabel!
    @IBOutlet weak var friText: UILabel!
    
    var labels: [UILabel] = []
    var labelText: [String] = []
    
    var latitude: Double = 0
    var longitude: Double = 0
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool{
        if(identifier == "classList"){
            if((latitude == 0 && longitude == 0) || className.text == ""){
                return false
            }
            return true
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        if segue.identifier == "classList" {
            
            let nav = segue.destination as! UINavigationController
            let toViewController = nav.topViewController as! ViewController
            
            toViewController.newClassName = className.text!
            
            var timeList: [String] = []
            
            for i in 0...4{
                if(switchStatus[i]){
                    timeList.append(labels[i].text!)
                } else {
                    timeList.append("None")
                }
            }
            
            toViewController.newTimes = timeList
            toViewController.newLocation = [latitude, longitude]
        }
        if segue.identifier == "addToMap" {
            for i in 0...4{
                switchStatus[i] = switches[i].isOn
                sliderStatus[i] = Int(sliders[i].value)
                labelText[i] = labels[i].text!
            }
            
            UserDefaults.standard.set(sliderStatus, forKey: "sliderStatus")
            UserDefaults.standard.set(switchStatus, forKey: "switchStatus")
            UserDefaults.standard.set(labelText, forKey: "labelText")
            UserDefaults.standard.set(className.text, forKey: "className")

        }
    }
    
    @IBAction func sliderMoved(_ sender: AnyObject) {
        let slider: UISlider = sender as! UISlider
        
        let roundedValue = Int(slider.value)
        print(roundedValue)
        
        var hour = 8 + Int(roundedValue/4)
        if(hour > 12){
            hour -= 12
        }
        let minn = roundedValue % 4
        let min = minn * 15

        
        let pos = sender.tag
        
        var labelString = "\(hour):"
        if(min == 0){
            labelString += "00"
        }else{
            labelString += "\(min)"
        }
        
        labels[pos!].text = labelString
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if(clear == true){
            switchStatus.removeAll()
            sliderStatus.removeAll()
            labelText.removeAll()
            
            UserDefaults.standard.removeObject(forKey: "sliderStatus")
            UserDefaults.standard.removeObject(forKey: "switchStatus")
            UserDefaults.standard.removeObject(forKey: "labelText")
            UserDefaults.standard.removeObject(forKey: "className")
            
            var i = 0
            while i < 5{
                switchStatus.append(true)
                sliderStatus.append(0)
                labelText.append("Label")
                i += 1
                print("in while")
            }
            print("in here")
        }
        print("out here")
        
        
        switches = [monSwitch, tuesSwitch, wedSwitch, thursSwitch, friSwitch]
        
        sliders = [monSlider, tuesSlider, wedSlider, thursSlider, friSlider]
        
        labels = [monText, tuesText, wedText, thursText, friText]
        
        if(UserDefaults.standard.object(forKey: "sliderStatus") != nil){
            sliderStatus = UserDefaults.standard.object(forKey: "sliderStatus") as! [Int]
        }
        if(UserDefaults.standard.object(forKey: "switchStatus") != nil){
            switchStatus = UserDefaults.standard.object(forKey: "switchStatus") as! [Bool]
            print("dont be here")
        }
        if(UserDefaults.standard.object(forKey: "labelText") != nil){
            labelText = UserDefaults.standard.object(forKey: "labelText") as! [String]
        }
        if(UserDefaults.standard.object(forKey: "className") != nil){
            className.text = UserDefaults.standard.object(forKey: "className") as! String
        }
        
        if(switchStatus.count > 0){
            for i in 0...4{
                switches[i].setOn(switchStatus[i], animated: true)
            }
        }
        if(sliderStatus.count > 0){
            for i in 0...4{
                sliders[i].setValue(Float(sliderStatus[i]), animated: true)
            }
        }
        if(labelText.count > 0){
            for i in 0...4{
                labels[i].text = labelText[i]
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
