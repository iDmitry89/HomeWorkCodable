//
//  InfoViewController.swift
//  DZ-UINavigation
//
//  Created by Dmitry on 08.07.2023.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        
    }

    private func setupConstraints () {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightGray
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)

        let label1 = UILabel()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.text = "About programm."
        label1.textColor = .black
        label1.textAlignment = .center
        label1.font = .boldSystemFont(ofSize: 20)
        label1.numberOfLines = 0
        backgroundView.addSubview(label1)
        
        let label2 = UILabel()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "Author: Смирновъ Дмитрий Викторович"
        label2.textColor = .black
        label2.textAlignment = .center
        // Проверка на приоритетность
        //label2.font = .boldSystemFont(ofSize: 20)
        label2.font = .systemFont(ofSize: 15)
        label2.numberOfLines = 0
        backgroundView.addSubview(label2)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Apple_logo.png")
        imageView.contentMode = .scaleAspectFit
        backgroundView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: backgroundView.centerYAnchor, constant: imageView.bounds.size.height - view.bounds.size.height / 10),
            
            label1.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            label1.trailingAnchor.constraint(equalTo: backgroundView.centerXAnchor, constant: -5),
            label1.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            //label1.heightAnchor.constraint(equalToConstant: 96),
            
            label2.leadingAnchor.constraint(equalTo: label1.trailingAnchor, constant: 10),
            label2.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),
            label2.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
        ])
        
        label1.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label1.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label2.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
    }

}

