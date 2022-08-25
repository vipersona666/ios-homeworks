//
//  ProfileTableHederView.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 18.08.2022.
//

import UIKit

class ProfileTableHederView: UITableViewHeaderFooterView {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let profileView = ProfileHeaderView(frame: .zero)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        return profileView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView(){
        self.addSubview(profileHeaderView)
        
        NSLayoutConstraint.activate([
            self.profileHeaderView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.profileHeaderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.profileHeaderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }


}
