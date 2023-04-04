//
//  PostViewController.swift
//  Navigation
//
//  Created by Андрей Байдаченко on 02.08.2022.
//

import UIKit

class PostViewController: UIViewController {
    var titlePost: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = titlePost
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blue") ?? UIImage())
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self , action: #selector(didTabItem))
        navigationItem.rightBarButtonItem = barButtonItem
        let backButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self , action: #selector(didTabButton))
        navigationItem.leftBarButtonItem = backButtonItem
        
    }
    
    @objc private func didTabItem(){
      
    }
    @objc private func didTabButton(){
        self.navigationController?.popViewController(animated: true)
    }
}
