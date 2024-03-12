//
//  WeatherViewController.swift
//  Clima
//
//  Created by Иван Семенов on 06.03.2024.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    let mainView = WeatherView()
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainView.searchTF.delegate = self   ///делегат
        weatherManager.delegate = self      ///делегат
        locationManager.delegate = self     ///делегат
        
        mainView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        mainView.locationButton.addTarget(self, action: #selector(locationButtonTapped), for: .touchUpInside)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    @objc func locationButtonTapped() {
        ///получаем текущую локацию
        locationManager.requestLocation()
    }
    @objc func searchButtonTapped() {
        ///получаем текст из текстового поля searchTF
        guard let searchText = mainView.searchTF.text else { return }
        mainView.searchTF.endEditing(true)
    }
}

extension WeatherViewController: UITextFieldDelegate {
    ///action кнопки GO на клавиатуре
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        mainView.searchTF.endEditing(true)
        return true
    }
    ///если нажал кнопку не печатая
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Напечатай город"
            return false
        }
    }
    ///очистка текста после нажатия на кнопку
    func textFieldDidEndEditing(_ textField: UITextField) {
        ///Ввод пользователем города
        if let city = mainView.searchTF.text {
            weatherManager.fetchWeather(city: city)
        }
        mainView.searchTF.text = ""
    }
}
extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.mainView.cityLabel.text = weather.cityName
            self.mainView.temperatureLabel.text = "\(weather.tempString)ºC"
            self.mainView.conditionImage.image = UIImage(systemName: weather.conditionName)
        }
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let  location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitide: lat, longitude: lon)
            //36.774       30.718
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
