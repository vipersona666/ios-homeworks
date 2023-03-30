//
//  ShowViewController.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 01.09.2022.
//

import UIKit

class ShowViewController: UIViewController {

    struct ViewModel{
        let image: UIImage?
    }
    
    private lazy var showImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
    }
    func setup(with viewmodel: ViewModel){
        self.showImageView.image = viewmodel.image
    }
    
    private func setupView(){
        self.view.addSubview(self.showImageView)
        NSLayoutConstraint.activate([
            self.showImageView.topAnchor.constraint(equalTo: view.topAnchor),
            self.showImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.showImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.showImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
   
}
