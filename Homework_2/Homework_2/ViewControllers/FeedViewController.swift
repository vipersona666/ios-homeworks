//
//  SecondViewController.swift
//  Navigation
//
//  Created by Андрей Байдаченко on 01.08.2022.
//

import UIKit
import StorageService



class FeedViewController: UIViewController {
    
    private lazy var feedModel = FeedModel(delegate: self)
    
    private lazy var button: CustomButton = {
        let customButton = CustomButton(title: "go_to_post".localized,
                                        textColor: .white,
                                        backgroundColorButton: Palette.appButtonBackgroundColor,
                                        clipsToBoundsOfButton: false,
                                        cornerRadius: 12,
                                        shadowOpacity: 0.7,
                                        shadowOffset: CGSize(width: 5, height: 5),
                                        translatesAutoresizingMask: false)
        customButton.addTarget = {self.didTapButton()}
        return customButton
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let customButton = CustomButton(title: "check_word".localized,
                                        textColor: .white,
                                        backgroundColorButton: Palette.appButtonBackgroundColor,
                                        clipsToBoundsOfButton: false,
                                        cornerRadius: 12,
                                        shadowOpacity: 0.7,
                                        shadowOffset: CGSize(width: 5, height: 5),
                                        translatesAutoresizingMask: false)
        customButton.addTarget = {self.checkTapButton()}
        return customButton
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var checkTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.attributedPlaceholder = NSAttributedString(
            string: "enter_word".localized,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText])
        textField.textColor = .white
        textField.text = ""
        textField.backgroundColor = Palette.appButtonBackgroundColor
        textField.font = UIFont.systemFont(ofSize: 16.0)
        textField.layer.cornerRadius = 12
        textField.autocapitalizationType = .none
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.leftViewMode = .always
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "trava1.jpeg") ?? UIImage())
        self.navigationItem.title = "feed".localized
        self.view.addSubview(button)
        self.view.addSubview(checkGuessButton)
        self.view.addSubview(checkTextField)
        self.view.addSubview(infoLabel)
        setupView()
        setupGesture()
    }
    override func viewDidAppear(_ animated: Bool) {
        //self.checkTextField.becomeFirstResponder()
    }
    
    
    private func setupView(){
        NSLayoutConstraint.activate([
            self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            self.button.widthAnchor.constraint(equalToConstant: 200),
            self.button.heightAnchor.constraint(equalToConstant: 50),
            self.infoLabel.topAnchor.constraint(equalTo: self.button.bottomAnchor, constant: 100),
            self.infoLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.infoLabel.widthAnchor.constraint(equalToConstant: 200),
            self.infoLabel.heightAnchor.constraint(equalToConstant: 50),
            self.checkTextField.topAnchor.constraint(equalTo: self.infoLabel.bottomAnchor, constant: 20),
            self.checkTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.checkTextField.widthAnchor.constraint(equalToConstant: 200),
            self.checkTextField.heightAnchor.constraint(equalToConstant: 50),
            self.checkGuessButton.topAnchor.constraint(equalTo: self.checkTextField.bottomAnchor, constant: 20),
            self.checkGuessButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.checkGuessButton.widthAnchor.constraint(equalToConstant: 200),
            self.checkGuessButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    private var timer: Timer?
    
    @objc private func didTapButton() {
        let vc = PostViewController()
        let post = Post(title: "new_post".localized)
        vc.titlePost = post.title
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc private func checkTapButton() {
        
        if (checkTextField.text! == ""){
            let alert = UIAlertController(title: "alert_check_word".localized, message: .none, preferredStyle: .actionSheet)
            let cancelButton = UIAlertAction(title: "enter_word".localized, style: .cancel) {_ in
            }
            alert.addAction(cancelButton)
            self.present(alert, animated: true)
        } else {
            timer = Timer.scheduledTimer(timeInterval: 2.0,
                                             target: self,
                                             selector: #selector(fireTimer),
                                             userInfo: nil,
                                             repeats: false)
        }
    }
    @objc private func fireTimer(){
        
        if (feedModel.check(word: checkTextField.text!)){
            
            infoLabel.text = "right".localized
            infoLabel.backgroundColor = .green
        } else {
            infoLabel.text = "wrong".localized
            infoLabel.backgroundColor = .red
        }
        timer?.invalidate()
        print("Timer fired!")
    }
    
    private func setupGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func hideKeyboard(){
        view.endEditing(true)
        
    }
    
}
extension FeedViewController: FeedModelDelegate{
}
