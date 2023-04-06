//
//  InfoViewController.swift
//  Navigation
//
//  Created by Андрей Байдаченко on 02.08.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var buttonInfo: CustomButton = {
        let customButton = CustomButton(title: "response_server".localized,
                                        textColor: .white,
                                        backgroundColorButton: Palette.appButtonBackgroundColor,
                                        clipsToBoundsOfButton: false,
                                        cornerRadius: 12, shadowOpacity: 0.7,
                                        shadowOffset: CGSize(width: 0.5, height: 0.5),
                                        translatesAutoresizingMask: false)
        customButton.addTarget = {self.didTapButton()}
        return customButton
    }()

    private lazy var labelInfo: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.backgroundColor = Palette.appButtonBackgroundColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelOrbitalPlanet: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.backgroundColor = Palette.appButtonBackgroundColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "green") ?? UIImage())
        self.view.addSubview(buttonInfo)
        self.view.addSubview(labelInfo)
        self.view.addSubview(labelOrbitalPlanet)
        setupView()
    }
    
    private func setupView(){
        NSLayoutConstraint.activate([
            self.labelInfo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.labelInfo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 240),
            self.labelInfo.heightAnchor.constraint(equalToConstant: 30),
            self.labelOrbitalPlanet.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.labelOrbitalPlanet.topAnchor.constraint(equalTo: labelInfo.bottomAnchor, constant: 30),
            self.labelOrbitalPlanet.heightAnchor.constraint(equalToConstant: 30),
            self.buttonInfo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.buttonInfo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.buttonInfo.widthAnchor.constraint(equalToConstant: 200),
            self.buttonInfo.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didTapButton() {
        NetworkManager.requestTitle(for: "https://jsonplaceholder.typicode.com/todos/6") { title in
            DispatchQueue.main.async {
                self.labelInfo.text = title
            }
        }
        NetworkManager.requestOrbitalPeriod(for: "https://swapi.dev/api/planets/1") { orbitalPeriod in
            DispatchQueue.main.async {
                self.labelOrbitalPlanet.text = "period".localized + (orbitalPeriod ?? "no_data".localized)
            }
        }
        
//        let alert = UIAlertController(title: "Пост будет удален безвозвратно", message: "Подтвердите", preferredStyle: .actionSheet)
//        let trashButton = UIAlertAction(title: "Удалить", style: .destructive) {_ in
//            print("Пост удален")
//        }
//        let cancelButton = UIAlertAction(title: "Отменить удаление", style: .cancel) {_ in
//            print("Отмена")
//        }
//        alert.addAction(trashButton)
//        alert.addAction(cancelButton)
//        self.present(alert, animated: true)
    }
}
