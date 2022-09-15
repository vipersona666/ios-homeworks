//
//  LogInViewController.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 15.08.2022.
//

import UIKit

class LogInViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
       return scrollView
    }()
    
    private lazy var logInImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        let imageName = "logo"
        imageView.image = UIImage(named: imageName)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logInTextField: UITextField = {
        let logIn = UITextField(frame: .zero)
        logIn.placeholder = "Email of phone"
        logIn.textColor = .black
        logIn.font = UIFont.systemFont(ofSize: 16.0)
        logIn.tintColor = UIColor(named: "AccentColor")
        logIn.autocapitalizationType = .none
        logIn.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: logIn.frame.height))
        logIn.leftViewMode = .always
        logIn.clipsToBounds = true
        logIn.translatesAutoresizingMaskIntoConstraints = false
        return logIn
    }()
    
    private lazy var passTextField: UITextField = {
        let pass = UITextField(frame: .zero)
        pass.placeholder = "Password"
        pass.textColor = .black
        pass.font = UIFont.systemFont(ofSize: 16.0)
        pass.tintColor = UIColor(named: "AccentColor")
        pass.autocapitalizationType = .none
        pass.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: pass.frame.height))
        pass.leftViewMode = .always
        pass.isSecureTextEntry = true
        pass.translatesAutoresizingMaskIntoConstraints = false
        return pass
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.backgroundColor = .systemGray6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(frame: .zero)
        let image = UIImage(named: "blue_pixel")
        button.setBackgroundImage(image, for: .normal)
        //button.titleLabel?.textColor = .white
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Профиль"
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.logInImageView)
        self.scrollView.addSubview(self.stackView)
        self.scrollView.addSubview(self.logInButton)
        self.view.backgroundColor = .white
        self.stackView.addArrangedSubview(logInTextField)
        self.stackView.addArrangedSubview(passTextField)
        self.setupView()
        self.setupGesture()
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        self.logInTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.didHideKeyboard(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    private func setupView(){
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.logInImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 120),
            self.logInImageView.widthAnchor.constraint(equalToConstant: 100),
            self.logInImageView.heightAnchor.constraint(equalToConstant: 100),
            self.logInImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.stackView.topAnchor.constraint(equalTo: self.logInImageView.bottomAnchor, constant: 120),
            self.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackView.heightAnchor.constraint(equalToConstant: 100),
            
            self.logInButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16),
            self.logInButton.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor),
            self.logInButton.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor),
            //self.logInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logInButton.heightAnchor.constraint(equalToConstant: 50),
            self.logInButton.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: 16),
        ])
    }
    
    
    @objc private func buttonPressed(){
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didShowKeyboard(_ notification: Notification){
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHight = keyboardRect.height
            let loginButtonBottomPointY = self.logInButton.frame.origin.y + 80
            let keyboardOriginY = self.view.frame.height - keyboardHight
            let offset = keyboardOriginY <= loginButtonBottomPointY ? loginButtonBottomPointY - keyboardOriginY + 16 : 0
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: offset)
        }
    }
    
    @objc private func didHideKeyboard(_ notification: Notification){
        self.hideKeyboard()
    }
    @objc private func hideKeyboard(){
        self.view.endEditing(true)
        self.scrollView.setContentOffset(.zero, animated: true)
    }
    
    
}
