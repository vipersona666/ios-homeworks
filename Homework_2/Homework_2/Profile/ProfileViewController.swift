//
//  ProfileViewController.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 05.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Профиль"
        self.view.backgroundColor = .white
        self.view.addSubview(profileHeaderView)

    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.profileHeaderView.frame = CGRect(x: 0,
                                              y: 100,
                                              width: self.view.bounds.width,
                                              height:self.view.bounds.height )
    }

}
