//
//  LocalAuthorizationService.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 11.04.2023.
//

import Foundation
import LocalAuthentication
import UIKit

class LocalAuthorizationService: UIViewController{
    
    func authorizeIfPossible(_ authorizationFinished: @escaping (Bool) -> Void){
        let context = LAContext()
        var error: NSError?
        var isBiometria: Bool = false
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
            isBiometria = true
        }
        if isBiometria {
            context.evaluatePolicy(.deviceOwnerAuthentication,
                                   localizedReason: "enter_password_to_log".localized) { [weak self] success, error in
                DispatchQueue.main.async {
                    if let error = error { print(error.localizedDescription) }
                    if success {
                        self?.displaySuccessAlert()
                    } else {
                        self?.displayErrorAlert(error?.localizedDescription ?? "error".localized)
                    }
                }
            }
        } else {
            print(error?.localizedDescription ?? "")
            print("error_biometrical".localized)
        }
    }
    
    private func displaySuccessAlert(){
        let alert = UIAlertController(title: "excellent".localized, message: "authentication".localized, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "ok".localized, style: .default)
          alert.addAction(alertAction)
          present(alert, animated: true)
      }
      
      private func displayErrorAlert(_ error: String){
          let alert = UIAlertController(title: "error".localized, message: error, preferredStyle: .alert)
          let alertAction = UIAlertAction(title: "ok".localized, style: .default)
          alert.addAction(alertAction)
          present(alert, animated: true)
      }
    
}
