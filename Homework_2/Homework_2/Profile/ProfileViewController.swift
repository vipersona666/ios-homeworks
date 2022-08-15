//
//  ProfileViewController.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 05.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let profileView = ProfileHeaderView(frame: .zero)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    private lazy var pressButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Press", for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 6, height: 6)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Профиль"
        self.view.backgroundColor = .white
        self.view.addSubview(profileHeaderView)
        self.view.addSubview(pressButton)
        self.setupConstraints()
    }
    
    private func setupConstraints(){
        let profileViewConstraint = self.profileViewConstraint()
        let buttonConstraints = self.buttonConstraints()
        NSLayoutConstraint.activate(profileViewConstraint + buttonConstraints)
        
    }
    
    private func profileViewConstraint() -> [NSLayoutConstraint]{
        let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leftConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let rightConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let heigth = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        return [topConstraint, leftConstraint, rightConstraint, heigth]
    }
    
    private func buttonConstraints() -> [NSLayoutConstraint]{
        let bottomConstraint = self.pressButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -90)
        let leftConstraint = self.pressButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let rightConstraint = self.pressButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let heigth = self.pressButton.heightAnchor.constraint(equalToConstant: 50)
        return [bottomConstraint, leftConstraint, rightConstraint, heigth]
    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

}
