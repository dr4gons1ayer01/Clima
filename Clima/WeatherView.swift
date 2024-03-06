//
//  WeatherView.swift
//  Clima
//
//  Created by Иван Семенов on 06.03.2024.
//

import UIKit

class WeatherView: UIView {
    let bgImage = UIImageView(image: UIImage(named: "bg")!)
    
    let geoButton = UIButton(systemName: "paperplane.fill")
    let searchTF = UITextField(placeholder: "Поиск")
    let searchButton = UIButton(systemName: "magnifyingglass")
    
    let conditionImage = UIImageView()
    let temperatureLabel = UILabel(text: "21ºC")
    let cityLabel = UILabel(text: "London")
    
    init() {
        super.init(frame: CGRect())
        setupUI()
    }
    func setupUI() {
        bgImage.contentMode = .scaleAspectFill
        
        conditionImage.image = UIImage(systemName: "sun.max")
        conditionImage.tintColor = .black
        
        temperatureLabel.font = UIFont(name: "Gilroy-Bold", size: 80)
        
        let topStack = UIStackView(arrangedSubviews: [geoButton,
                                                      searchTF,
                                                      searchButton,])
        topStack.axis = .horizontal
        topStack.spacing = 10
        
        let stack = UIStackView(arrangedSubviews: [topStack,
                                                   conditionImage,
                                                   temperatureLabel,
                                                   cityLabel,])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .trailing
        
        addSubview(bgImage)
        addSubview(stack)
        bgImage.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: topAnchor),
            bgImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            bgImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            
//            searchTF.widthAnchor.constraint(equalTo: stack.widthAnchor),
            searchTF.widthAnchor.constraint(equalToConstant: 300),
            
            conditionImage.widthAnchor.constraint(equalToConstant: 120),
            conditionImage.heightAnchor.constraint(equalToConstant: 120),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
        textColor = .black
        font = UIFont(name: "Gilroy-Regular", size: 40)
    }
}
extension UIButton {
    convenience init(systemName: String) {
        self.init(type: .system)
        tintColor = .black
        setImage(UIImage(systemName: systemName), for: .normal)
        widthAnchor.constraint(equalToConstant: 40).isActive = true
        heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
extension UITextField {
    convenience init(placeholder: String) {
        self.init()
        self.placeholder = placeholder
        backgroundColor = .clear
        font = UIFont(name: "Gilroy-Regular", size: 25)
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.cornerRadius = 12

        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0)) // Левый отступ
        leftViewMode = .always
    }
}

import SwiftUI

struct WeatherViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().ignoresSafeArea()
    }
    struct ContainerView: UIViewRepresentable {
        let view = WeatherView()
        
        func makeUIView(context: Context) -> some UIView {
            return view
        }
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
}
