//
//  WeatherViewController.swift
//  Clima
//
//  Created by Иван Семенов on 06.03.2024.
//

import UIKit

class WeatherViewController: UIViewController {
    let mainView = WeatherView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        
    }


}

