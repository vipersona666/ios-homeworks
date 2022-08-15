//
//  ProfileHeaderView.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 08.08.2022.
//

import UIKit

class ProfileHeaderView: UIView{
    
    
    
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
    
    private lazy var editButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Show status", for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 6, height: 6)
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var nameLable: UILabel = {
        let name = UILabel(frame: .zero)
        name.text = "Coder Cat"
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 18.0)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var infoLable: UILabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        self.backgroundColor = .lightGray
        self.addSubview(avatarImageView)
        self.addSubview(editButton)
        self.addSubview(nameLable)
        self.addSubview(infoLable)
        self.addSubview(textField)
        
        let avatarImageConstraints = self.avatarImageConstraints()
        let buttonConstraints = self.buttonConstraints()
        let nameLableConstraints = self.nameLableConstraints()
        let infoLableConstraints = self.infoLableConstraints()
        let textFieldConstraints = self.textFieldConstraints()
        NSLayoutConstraint.activate(avatarImageConstraints + buttonConstraints + nameLableConstraints + infoLableConstraints + textFieldConstraints)
    
    }
    
    private func avatarImageConstraints() -> [NSLayoutConstraint]{
        let topConstraint = self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leftConstraint = self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let width = self.avatarImageView.widthAnchor.constraint(equalToConstant: 120)
        let heigth = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1)
        return [topConstraint, leftConstraint, width, heigth]
    }
    
    private func nameLableConstraints() -> [NSLayoutConstraint]{
        let topConstraint = self.nameLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 27)
        let leftConstraint = self.nameLable.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 27.5)
        let heigth = self.nameLable.heightAnchor.constraint(equalToConstant: 30)
        return [topConstraint, leftConstraint, heigth]
    }
    
    private func infoLableConstraints() -> [NSLayoutConstraint]{
        let topConstraint = self.infoLable.topAnchor.constraint(equalTo: self.nameLable.bottomAnchor, constant: 27)
        let leftConstraint = self.infoLable.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 27.5)
        let width = self.infoLable.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        let heigth = self.infoLable.heightAnchor.constraint(equalToConstant: 20)
        return [topConstraint, leftConstraint, heigth, width]
    }
    
    private func textFieldConstraints() -> [NSLayoutConstraint]{
        let topConstraint = self.textField.topAnchor.constraint(equalTo: self.infoLable.bottomAnchor, constant: 8)
        let leftConstraint = self.textField.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 27.5)
        let width = self.textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        let heigth = self.textField.heightAnchor.constraint(equalToConstant: 40)
        return [topConstraint, leftConstraint,  heigth, width]
    }
    
    private func buttonConstraints() -> [NSLayoutConstraint]{
        let topConstraint = self.editButton.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 8)
        let leftConstraint = self.editButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        let rightConstraint = self.editButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        let heigth = self.editButton.heightAnchor.constraint(equalToConstant: 50)
        return [topConstraint, leftConstraint, rightConstraint, heigth]
    }
    
    
    @objc private func buttonPressed(){
        infoLable.text = statusText
        print(statusText)
        textField.text = ""
        textField.resignFirstResponder()
    }
    
    @objc private func statusTextChanged(_ textField: UITextField){
        statusText = textField.text!
        
    }
    
}
