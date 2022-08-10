//
//  ProfileHeaderView.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 08.08.2022.
//

import UIKit

class ProfileHeaderView: UIView{
    
    
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 16, y: 16, width: 110, height: 110))
        let imageName = "cat2"
        imageView.image = UIImage(named: imageName)
        imageView.layer.cornerRadius = 55
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 16, y: 159, width: 382, height: 50))
        button.backgroundColor = .blue
        button.tintColor = .white
        button.setTitle("Show status", for: .normal)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowOffset = CGSize(width: 6, height: 6)
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameLable: UILabel = {
        let name = UILabel(frame: CGRect(x: 158, y: 27, width: 98, height: 22))
        name.text = "Coder Cat"
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 18.0)
        return name
    }()
    
    private lazy var infoLable: UILabel = {
        let info = UILabel(frame: CGRect(x: 158, y: 83, width: 154, height: 20))
        info.text = "Waiting for something..."
        info.textColor = .darkGray
        info.font = UIFont.systemFont(ofSize: 14.0)
        return info
    }()
    
    private lazy var textField: UITextField = {
        let text = UITextField(frame: CGRect(x: 158, y: 111, width: 170, height: 40))
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
        return text
    }()
    
    private lazy var statusText = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        self.addSubview(avatarImageView)
        self.addSubview(editButton)
        self.addSubview(nameLable)
        self.addSubview(infoLable)
        self.addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
