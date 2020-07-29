//
//  WeatherDaysViewController.swift
//  Day Night
//
//  Created by Wissam Noureddine on 7/11/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherDaysViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, ModelDelegate,CLLocationManagerDelegate {
    
    // table view outlet
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var dateTodayLabel: UILabel!
    @IBOutlet var tempTodayLabel: UILabel!
    @IBOutlet var precipitationTodayLabel: UILabel!
    @IBOutlet var imageTodayView: UIImageView!
    @IBOutlet var rainChanceImageView: UIImageView!
    @IBOutlet var retryButton: UIButton!
    @IBOutlet var sunsetSunriseLabel: UILabel!
    
    @IBOutlet var header14days: UILabel!
    @IBOutlet var sunriseSunsetIcon: UIImageView!
    @IBOutlet var todayWeatherView: UIView!
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    var model : Model = Model()
    var weatherList : [Weather] = [Weather]()
    var weathertoday : Weather?
    
    var alert : UIAlertController?
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        model.delegate = self
        
        // intializing today's header widget
        tempTodayLabel.text = ""
        dateTodayLabel.text = ""
        precipitationTodayLabel.text = ""
        sunsetSunriseLabel.text = ""
        sunriseSunsetIcon.isHidden = true
        rainChanceImageView.isHidden = true
        todayWeatherView.isHidden = true
        header14days.isHidden = true
        
        // request location authorization
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        // if previously user has allowed the location permission, then request location
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
            locationManager.requestLocation()
        }
        
        self.alert = UIAlertController(title: "Location Access", message: "Please enable location access from the device Settings.", preferredStyle: .alert)
        self.alert?.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.alert?.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default){
            (_) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        })
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIGestureRecognizer {
            guard self.weathertoday != nil else {return}
            let detailVC = segue.destination as! DetailViewController
            detailVC.weather = self.weathertoday
        }else{
            guard tableView.indexPathForSelectedRow != nil else {return}
            let selectedWeather = weatherList[tableView.indexPathForSelectedRow!.row]
            let detailVC = segue.destination as! DetailViewController
            detailVC.weather = selectedWeather
        }
        
        
    }
    @IBAction func retryButtonAction(_ sender: Any) {
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
            locationManager.requestLocation()
            retryButton.isHidden = true
        }else if (CLLocationManager.authorizationStatus() == .denied){
            DispatchQueue.main.async {
                self.present(self.alert!, animated: true, completion: nil);
            }
        }else if (CLLocationManager.authorizationStatus() == .notDetermined){
            locationManager.requestWhenInUseAuthorization()
            retryButton.isHidden = true
        }
    }
    
    
    // MARK: Location Manager Code
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == .authorizedWhenInUse || status == .authorizedAlways){
            manager.requestLocation()
        }else if (status == .denied){
            DispatchQueue.main.async {
                self.retryButton.isHidden = false
                self.present(self.alert!, animated: true, completion: nil);
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // might be that user didn't enable location service on the device
        // or there might be no GPS signal inside a building
        
        // might be a good idea to show an alert to user to ask them to walk to a place with GPS signal
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            model.fetch15DaysWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            self.loadingIndicator.startAnimating()
        }
    }
    
    // MARK: Table View Code
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.WEATHER_BY_DAY_CELL_REUSABLE_ID, for: indexPath) as! WeatherByDayTableViewCell
        // Configure the cell with the data
        cell.setCell(self.weatherList[indexPath.row])
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func WeatherFetched(_ weatherList: [Weather]) {
        self.weathertoday = weatherList[0]
        guard let weathertoday = self.weathertoday else {
            return
        }
        self.weatherList =  Array(weatherList.dropFirst())
        tempTodayLabel.text = String(weathertoday.feelsLikeTemp.maxTemp.rounded()) + Constants.TEMP_UNIT
        let df = DateFormatter()
        df.dateFormat = "EEE, MMM d"
        dateTodayLabel.text = df.string(from: weathertoday.date)
        
        
        // precipition label and icon
        let precipitationPercentage = Int(weathertoday.precipitation_probability.percentage)
        if precipitationPercentage == 0 {
            precipitationTodayLabel.text = String(precipitationPercentage) + "%"
            rainChanceImageView.isHidden = false
        }
        
        imageTodayView.image = weathertoday.weather_code.getWeatherIcon()!
        self.loadingIndicator.stopAnimating()
        

        if let sunriseSunset = Greeting.getSunriseSunsetText(weather: weathertoday) {
            sunsetSunriseLabel.text = sunriseSunset.timeUntil
            sunriseSunsetIcon.image = UIImage(systemName: sunriseSunset.systemIcon)
            sunriseSunsetIcon.isHidden = false
        }else{
            dateTodayLabel.textColor = .white
            tempTodayLabel.textColor = .white
            precipitationTodayLabel.textColor = .white
            rainChanceImageView.tintColor = .white
            todayWeatherView.backgroundColor = .darkGray
            imageTodayView.image = weathertoday.weather_code.getWeatherIconNight()!
        }
        todayWeatherView.isHidden = false
        header14days.isHidden = false
        tableView.reloadData();
    }
    
    
}
