//
//  ProfileHeaderView.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 08.08.2022.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView{
    
    weak var delegate: ProfileViewController?
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        let imageName = "cat2"
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = 55
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var editButton: CustomButton = {
//        let button = UIButton(frame: .zero)
//        button.backgroundColor = .blue
//        button.tintColor = .white
//        button.setTitle("Show status", for: .normal)
//        button.layer.cornerRadius = 12
//        //button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOpacity = 0.7
//        button.layer.shadowOffset = CGSize(width: 6, height: 6)
//        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
        let customButton = CustomButton(title: "Show status",
                                        textColor: .white,
                                        backgroundColorButton: .blue,
                                        clipsToBoundsOfButton: false,
                                        cornerRadius: 12,
                                        shadowOpacity: 0.7,
                                        shadowOffset: CGSize(width: 6, height: 6),
                                        translatesAutoresizingMask: false)
        customButton.addTarget = {self.buttonPressed()}
        return customButton
    }()
    
    private lazy var nameLabel: UILabel = {
        let name = UILabel(frame: .zero)
        name.text = "Coder Cat"
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 18.0)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var infoLabel: UILabel = {
        let info = UILabel(frame: .zero)
        info.text = "Waiting for something..."
        info.textColor = .darkGray
        info.font = UIFont.systemFont(ofSize: 14.0)
        info.translatesAutoresizingMaskIntoConstraints = false
        return info
    }()
    
    private lazy var textField: UITextField = {
        let text = UITextField(frame: .zero)
        text.backgroundColor = .white
        text.font = UIFont.systemFont(ofSize: 15)
        text.textColor = .black
        text.placeholder = "set the status"
        text.textAlignment = .center
        text.layer.cornerRadius = 12
        text.layer.borderWidth = 1
        text.layer.borderColor = UIColor.black.cgColor
        text.becomeFirstResponder()
        text.addTarget(self, action: #selector(self.statusTextChanged(_:)), for: .editingChanged)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var statusText = ""
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupView()
        self.setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        //self.backgroundColor = .lightGray
        self.addSubview(avatarImageView)
        self.addSubview(editButton)
        self.addSubview(nameLabel)
        self.addSubview(infoLabel)
        self.addSubview(textField)
        
        NSLayoutConstraint.activate([
            self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 110),
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1),
            
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 28),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            self.infoLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 27),
            self.infoLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 28),
            self.infoLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            self.infoLabel.heightAnchor.constraint(equalToConstant: 20),
            
            self.textField.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 8),
            self.textField.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 28),
            self.textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            self.textField.heightAnchor.constraint(equalToConstant: 40),
            
            self.editButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 8),
            self.editButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.editButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func buttonPressed(){
        infoLabel.text = statusText
        //print(statusText)
        textField.text = ""
        textField.resignFirstResponder()
    }
    
    @objc private func statusTextChanged(_ textField: UITextField){
        statusText = textField.text ?? ""
    }
    
    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard(){
        self.endEditing(true)
        
    }
    
    func setUser(user: User?){
        avatarImageView.image = user?.avatar
        nameLabel.text = user?.userName
        infoLabel.text = user?.status
    }
    
}
