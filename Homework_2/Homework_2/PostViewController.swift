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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "blue")!)
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self , action: #selector(didTabItem))
        navigationItem.rightBarButtonItem = barButtonItem
        
    }
    @objc private func didTabItem(){
        let infoVC = InfoViewController()
        infoVC.modalPresentationStyle = .popover
        self.present(infoVC, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
