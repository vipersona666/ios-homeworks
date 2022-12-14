//
//  InfoViewController.swift
//  Navigation
//
//  Created by Андрей Байдаченко on 02.08.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var buttonInfo: CustomButton = {
//        let buttonInfo = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
//        buttonInfo.backgroundColor = .darkGray
//        buttonInfo.layer.cornerRadius = 12
//        buttonInfo.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
//        buttonInfo.setTitle("Удалить пост", for: .normal)
//        return buttonInfo
        let customButton = CustomButton(title: "Удалить пост", textColor: .white, backgroundColorButton: .darkGray, clipsToBoundsOfButton: false, cornerRadius: 12, shadowOpacity: 0.7, shadowOffset: CGSize(width: 0.5, height: 0.5), translatesAutoresizingMask: false)
        customButton.addTarget = {self.didTapButton()}
        return customButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "green") ?? UIImage())
        self.view.addSubview(buttonInfo)
        setupView()
    }
    
    private func setupView(){
        NSLayoutConstraint.activate([
            self.buttonInfo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.buttonInfo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.buttonInfo.widthAnchor.constraint(equalToConstant: 200),
            self.buttonInfo.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func didTapButton() {
        let alert = UIAlertController(title: "Пост будет удален безвозвратно", message: "Подтвердите", preferredStyle: .actionSheet)
        let trashButton = UIAlertAction(title: "Удалить", style: .destructive) {_ in
            print("Пост удален")
        }
        let cancelButton = UIAlertAction(title: "Отменить удаление", style: .cancel) {_ in
            print("Отмена")
        }
        alert.addAction(trashButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
}
