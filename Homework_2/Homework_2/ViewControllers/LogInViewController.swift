//
//  LogInViewController.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 15.08.2022.
//

import UIKit
import RealmSwift

class LogInViewController: UIViewController {
    
    var loginDelegate: LoginViewControllerDelegate?
    
    var authModel = AuthUser()
    let realm = try! Realm()
    
    let queue = DispatchQueue(label: "hackPassQueue", qos: .userInteractive)
    
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
        logIn.placeholder = "email".localized
        logIn.textColor = .black
        logIn.text = ""
        logIn.keyboardType = .emailAddress
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
        pass.placeholder = "password".localized
        pass.textColor = .black
        pass.text = ""
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
    
    private lazy var logInButton: CustomButton = {
        let customButton = CustomButton(title: "sign_in".localized,
                                        textColor: .white,
                                        backgroundColorButton: UIColor(named: "AccentColor")!,
                                        clipsToBoundsOfButton: true,
                                        cornerRadius: 10,
                                        shadowOpacity: 0,
                                        shadowOffset: .zero,
                                        translatesAutoresizingMask: false)
        customButton.addTarget = {self.buttonPressed()}
        return customButton
    }()
    
//    private lazy var crackPasswordButton: CustomButton = {
//        let customButton = CustomButton(title: "Подобрать пароль",
//                                        textColor: .white,
//                                        backgroundColorButton: UIColor(named: "AccentColor")!,
//                                        clipsToBoundsOfButton: true,
//                                        cornerRadius: 10,
//                                        shadowOpacity: 0,
//                                        shadowOffset: .zero,
//                                        translatesAutoresizingMask: false)
//        customButton.addTarget = {self.crackButtonPressed()}
//        return customButton
//    }()
    
    private lazy var signUpButton: CustomButton = {
        let customButton = CustomButton(title: "sign_up".localized,
                                        textColor: .white,
                                        backgroundColorButton: UIColor(named: "AccentColor")!,
                                        clipsToBoundsOfButton: true,
                                        cornerRadius: 10,
                                        shadowOpacity: 0,
                                        shadowOffset: .zero,
                                        translatesAutoresizingMask: false)
        customButton.addTarget = {self.signUpButtonPressed()}
        return customButton
    }()
    
    private lazy var stackButton: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .medium)
        ai.startAnimating()
        ai.color = .gray
        ai.hidesWhenStopped = true
        ai.isHidden = true
        ai.translatesAutoresizingMaskIntoConstraints = false
        return ai
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.title = "Профиль"
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.logInImageView)
        self.scrollView.addSubview(self.stackView)
        //self.scrollView.addSubview(self.logInButton)
        self.scrollView.addSubview(self.stackButton)
        self.view.backgroundColor = .white
        self.stackView.addArrangedSubview(logInTextField)
        self.stackView.addArrangedSubview(passTextField)
        self.stackButton.addArrangedSubview(logInButton)
        self.stackButton.addArrangedSubview(signUpButton)
        self.view.addSubview(activityIndicator)
        self.setupView()
        self.setupGesture()
        self.navigationController?.navigationBar.isHidden = true
        self.checkAuthUser()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.logInTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.didShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.didHideKeyboard(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
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
            
            self.stackButton.topAnchor.constraint(equalTo: self.stackView.bottomAnchor, constant: 16),
            self.stackButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            self.stackButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            self.stackButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.stackButton.heightAnchor.constraint(equalToConstant: 108),
            
            self.activityIndicator.leadingAnchor.constraint(equalTo: stackButton.leadingAnchor, constant: 26),
            self.activityIndicator.centerYAnchor.constraint(equalTo: stackView.centerYAnchor, constant: 26)
      
        ])
    }
    
    private func saveRealm(login: String, password: String){
        try! realm.write({
            authModel.login = login
            authModel.password = password
            realm.add(authModel)
        })
    }
    //проверка, если пользователь уже был залогинен, создаем юзера и заходим
    private func checkAuthUser(){
        let lastAuthUser = realm.objects(AuthUser.self).last
        let user = UserDefaults.standard.string(forKey: "authKey")
        if lastAuthUser != nil && lastAuthUser?.login == user {
            let checkerService = CheckerService()
            checkerService.checkCredentials(email: lastAuthUser!.login, password: lastAuthUser!.password) { result in
                switch result {
                case .success(let user):
                    let vc = ProfileViewController(user: user)
                    self.navigationController?.pushViewController(vc, animated: true)
                    print("auto_login".localized)
                case .failure(_):
                    print("login_error".localized)
                    let alarm = UIAlertController(title: "login_error".localized, message: "enter_login_and_password".localized, preferredStyle: .alert)
                    let alarmAction = UIAlertAction(title: "close".localized, style: .default)
                                            alarm.addAction(alarmAction)
                                            self.present(alarm, animated: true)
                }
            }
        }
        else {
            print("sign_in_or_sign_up".localized)
        }
       
    }
    
    @objc private func buttonPressed(){
        
        if (!logInTextField.text!.isEmpty && !passTextField.text!.isEmpty) {
            let checkerService = CheckerService()
            checkerService.checkCredentials(email: logInTextField.text!, password: passTextField.text!) { result in
                switch result{
                case .success(let user):
                    let vc = ProfileViewController(user: user)
                    self.navigationController?.pushViewController(vc, animated: true)
                    //сохраняем пользователя в базу рилм
                    self.saveRealm(login: self.logInTextField.text!, password: self.passTextField.text!)
                    UserDefaults.standard.set(self.logInTextField.text!, forKey: "authKey")
                case .failure(let error):
                    print("login_error".localized, error.localizedDescription)
                    let alarm = UIAlertController(title: "login_error".localized, message: error.localizedDescription, preferredStyle: .alert)
                    let alarmAction = UIAlertAction(title: "close".localized, style: .default)
                                            alarm.addAction(alarmAction)
                                            self.present(alarm, animated: true)
                }
            }
        }
    }
    
    @objc private func signUpButtonPressed(){
        
        if (!logInTextField.text!.isEmpty && !passTextField.text!.isEmpty) {
            let checkerService = CheckerService()
            checkerService.signUp(email: logInTextField.text!, password: passTextField.text!) { result in
                switch result{
                case .success(let user):
                    let vc = ProfileViewController(user: user)
                    self.navigationController?.pushViewController(vc, animated: true)
                    //сохраняем пользователя в базу рилм
                    self.saveRealm(login: self.logInTextField.text!, password: self.passTextField.text!)
                    UserDefaults.standard.set(self.logInTextField.text!, forKey: "authKey")
                case .failure(let error):
                    print("registration_error".localized, error.localizedDescription)
                    let alarm = UIAlertController(title: "registration_error".localized, message: error.localizedDescription, preferredStyle: .alert)
                    let alarmAction = UIAlertAction(title: "close".localized, style: .default)
                                            alarm.addAction(alarmAction)
                                            self.present(alarm, animated: true)
                }
                
            }
        }
    }

//            let debugUser = User(userName: "Кот пират", password: passTextField.text!, avatar: UIImage(named: "cat5")!, login: logInTextField.text!, status: "Продвинутый")
//            let releaseUser = User(userName: "Кот боец", password: passTextField.text!, avatar: UIImage(named: "cat6")!, login: logInTextField.text!, status: "Местный")
            
                
#if DEBUG
//            if (loginDelegate?.check(login: debugUser.login, password: debugUser.password)) == true {
//                let vc = ProfileViewController(user: debugUser)
//                self.navigationController?.pushViewController(vc, animated: true)
                
//            }  else { let alert = UIAlertController(title: "Неверный логин или пароль", message: "", preferredStyle: .actionSheet)
//                let cancelButton = UIAlertAction(title: "Ввести заново", style: .cancel) {_ in
//                    print("")
//                }
//                alert.addAction(cancelButton)
//                self.present(alert, animated: true)
//            }
#else
//            if (loginDelegate?.check(login: releaseUser.login, password: releaseUser.password)) == true {
//                let vc = ProfileViewController(user: releaseUser)
//                self.navigationController?.pushViewController(vc, animated: true)
//
//            }  else { let alert = UIAlertController(title: "Неверный логин или пароль", message: "", preferredStyle: .actionSheet)
//                let cancelButton = UIAlertAction(title: "Ввести заново", style: .cancel) {_ in
//                    print("")
//                }
//                alert.addAction(cancelButton)
//                self.present(alert, animated: true)
//            }
#endif
//
//
//        } else {
//            let alert = UIAlertController(title: "Введите логин и пароль", message: "", preferredStyle: .actionSheet)
//            let cancelButton = UIAlertAction(title: "Ввести заново", style: .cancel) {_ in
//                print("")
//            }
//            alert.addAction(cancelButton)
//            self.present(alert, animated: true)
//        }
//#if DEBUG
            //let debugUser = User(userName: "Test Cat", password: "123", avatar: UIImage(named: "cat4")!, login: "user", status: "Test")
            //let currentUserService = TestUserService(user: debugUser)
    //#else
            //let releaseUser = User(userName: "Coder Cat", password: "1234", avatar: UIImage(named: "cat2")!, login: "admin", status: "Эксперт")
            //let currentUserService = CurrentUserService(user: releaseUser)
    //#endif
//            let currentUser = currentUserService.entryLogin(login: user.login, password: user.password)
               // if currentUser == nil {
    //}
    
    
    
    /*@objc private func crackButtonPressed(){
        if self.passTextField.text != nil && self.passTextField.text!.count <= 3{
            var password = ""
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            self.passTextField.placeholder = ""
            self.passTextField.text = ""
            
            queue.async {
                password = self.bruteForce()
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.isHidden = true
                    self.passTextField.isSecureTextEntry = false
                    self.passTextField.text = password
                }
            }
        } else {
            let alert = UIAlertController(title: "Пароль слишком сложный", message: "", preferredStyle: .actionSheet)
            let cancelButton = UIAlertAction(title: "Закрыть", style: .cancel) {_ in
                print("")
            }
            alert.addAction(cancelButton)
            self.present(alert, animated: true)

        }
        
    }
    
    private func passwordGenerate() -> String{
        let len = 3
        let pswdChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        let rndPswd = String((0..<len).compactMap{ _ in pswdChars.randomElement() })
        print("New password: " + rndPswd)
        return rndPswd
    }
    
    private func bruteForce() -> String {
        
        let bruteForcePassword = BruteForce().bruteForce(passwordToUnlock: passwordGenerate())
        return bruteForcePassword
    }*/
    
    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didShowKeyboard(_ notification: Notification){
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRect = keyboardFrame.cgRectValue
            let keyboardHight = keyboardRect.height
            let loginButtonBottomPointY = self.logInButton.frame.origin.y + 50
            let keyboardOriginY = self.view.frame.height - keyboardHight
            let offset = keyboardOriginY <= loginButtonBottomPointY ? loginButtonBottomPointY - keyboardOriginY + 25 : 0

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
extension String{
    var localized: String{
        NSLocalizedString(self, comment: "")
    }
}
