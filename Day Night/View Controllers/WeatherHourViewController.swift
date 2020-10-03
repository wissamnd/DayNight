//
//  WeatherHourViewController.swift
//  Day Night
//
//  Created by Wissam Noureddine on 29/7/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherHourViewController: UIViewController, UITableViewDataSource, ModelWeatherByHourDelegate ,UITableViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet var tableView: UITableView!
    var model : Model = Model()
    var weatherList : [WeatherByHour] = [WeatherByHour]()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        model.weatherByHourDelegate = self
        
        // request location authorization
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        // if previously user has allowed the location permission, then request location
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways){
            locationManager.requestLocation()
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard tableView.indexPathForSelectedRow != nil else {return}
        let selectedWeather = weatherList[tableView.indexPathForSelectedRow!.row]
        let detailVC = segue.destination as! DetailWeatherByHourViewController
        detailVC.weather = selectedWeather
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            model.fetch96HoursWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // might be that user didn't enable location service on the device
        // or there might be no GPS signal inside a building
        
        // might be a good idea to show an alert to user to ask them to walk to a place with GPS signal
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.WEATHER_BY_HOUR_CELL_REUSABLE_ID, for: indexPath) as! WeatherByHourTableViewCell
        // Configure the cell with the data
        cell.setCell(self.weatherList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func WeatherFetched(_ weatherList: [WeatherByHour]) {
        self.weatherList = weatherList
        tableView.reloadData()
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
