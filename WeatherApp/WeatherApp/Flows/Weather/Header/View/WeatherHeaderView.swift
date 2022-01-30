//
//  WeatherHeaderView.swift
//  WeatherApp
//
//  Created by Евгений Старшов on 29.01.2022.
//

import UIKit

final class WeatherHeaderView: UIView {
    
    
    // MARK: - Subviews
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 2
        return label
    }()
    
    private(set) lazy var changeDegrees: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Metric / Imperial", for: .normal)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        button.layer.cornerRadius = 16.0
        button.addTarget(self, action: #selector(changeTemperatureButton), for: .touchUpInside)
        return button
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.numberOfLines = 20
        return label
    }()
    
    private enum State {
        case metric
        case fahrenheit
    }
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupLayout()
    }
    
    // MARK: - UI
    
    private func setupLayout() {
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subtitleLabel)
        self.addSubview(self.changeDegrees)
        self.addSubview(self.descriptionLabel)
        
        
        NSLayoutConstraint.activate([
            self.imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            self.imageView.widthAnchor.constraint(equalToConstant: 120.0),
            self.imageView.heightAnchor.constraint(equalToConstant: 120.0),
            
            self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            self.titleLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 16.0),
            self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 12.0),
            self.subtitleLabel.leftAnchor.constraint(equalTo: self.titleLabel.leftAnchor),
            self.subtitleLabel.rightAnchor.constraint(equalTo: self.titleLabel.rightAnchor),
            
            self.changeDegrees.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: 16.0),
            self.changeDegrees.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor),
            self.changeDegrees.widthAnchor.constraint(equalToConstant: 140.0),
            self.changeDegrees.heightAnchor.constraint(equalToConstant: 32.0),
            
            self.descriptionLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 24.0),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.imageView.leftAnchor),
            self.descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5.0),
            
            self.descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    @objc func changeTemperatureButton(sender: UIButton!) {
        print("Button tapped")
        NotificationCenter.default.post(name: .notificationFromTButton, object: nil)
    }
}

