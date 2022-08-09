//
//  InfoViewController.swift
//  Navigation
//
//  Created by Андрей Байдаченко on 02.08.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var buttonInfo:UIButton = {
        let buttonInfo = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        buttonInfo.backgroundColor = .darkGray
        buttonInfo.layer.cornerRadius = 12
        buttonInfo.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        buttonInfo.setTitle("Удалить пост", for: .normal)
        return buttonInfo
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "green") ?? UIImage())
        self.view.addSubview(buttonInfo)
        self.buttonInfo.center = self.view.center
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
