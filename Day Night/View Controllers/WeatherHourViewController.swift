//
//  WeatherHourViewController.swift
//  Day Night
//
//  Created by Wissam Noureddine on 29/7/20.
//  Copyright © 2020 Wissam Noureddine. All rights reserved.
//

import UIKit

class WeatherHourViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ModelDelegate  {
    
    @IBOutlet var tableView: UITableView!
    var model : Model = Model()
    var weatherList : [Weather] = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        model.delegate = self
        
        model.fetch15DaysWeather(latitude: 20, longitude: 50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.WEATHER_BY_HOUR_CELL_REUSABLE_ID, for: indexPath) as! WeatherByHourTableViewCell
        // Configure the cell with the data
        //cell.setCell(self.weatherList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func WeatherFetched(_ weatherList: [Weather]) {
        self.weatherList = weatherList
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
