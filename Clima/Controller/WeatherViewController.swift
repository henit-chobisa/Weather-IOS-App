//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

class WeatherViewController: UIViewController{
    var player = AVPlayer()
    
    

    @IBOutlet weak var searchfeild: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchbutton: UIButton!
    var weathermanager = WeatherManger()
    let locationmanager = CLLocationManager()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchfeild.delegate = self
        weathermanager.delegate = self
        // Do any additional setup after loading the view.
        locationmanager.delegate = self
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.requestLocation()
       
        
            }

    
    @IBAction func updateLocation(_ sender: UIButton) {
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.requestLocation()

        
    }
    

    
}

//MARK: - TEXTFEILDDELEGATE

extension WeatherViewController : UITextFieldDelegate {
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        print(searchfeild.text!)
        searchfeild.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(searchfeild.text!)
        searchfeild.endEditing(true)
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let city = searchfeild.text{
            weathermanager.fetchweather(cityname: city)
        }
        searchfeild.text = ""
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchfeild.text != ""{
            return true
        }else{
            searchfeild.placeholder = "Type something"
            
            return false
        }
        
        
    }
    func loadVideo(video : String) {

    //this line is important to prevent background music stop
    do {
        try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
    } catch { }

    let path = Bundle.main.path(forResource: video, ofType:"mp4")

    player = AVPlayer(url: NSURL(fileURLWithPath: path!) as URL)
    let playerLayer = AVPlayerLayer(player: player)

    playerLayer.frame = self.view.frame
    playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
    playerLayer.zPosition = -1

    self.view.layer.addSublayer(playerLayer)

        player.seek(to: CMTime.zero)
        player.play()
        
   
        

       
            
        }
        
}

    
    


//MARK: - weathermanagerdelegate


extension WeatherViewController : WeatherManagerDelegate {
    func didupdateweather(weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempreaturestring
            self.cityLabel.text = weather.name
            let p = weather.condition
            self.loadVideo(video: p)
            self.conditionImageView.image = UIImage(systemName: p)
            
        }
        
    }
    func didFailWithError(error: Error) {
        print(error)
    }

}
extension WeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weathermanager.fetchweatherco(latitude: lat, lonngitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
        
    }
    


