//
//  ProfileViewController.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 05.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let user: User?
    
    init(user: User){
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var postModel = posts
    
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotoCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupConstraints()
    }
 
    private func setupConstraints(){
        self.view.addSubview(self.tableView)
    #if DEBUG
        self.view.backgroundColor = .yellow
        #else
        self.view.backgroundColor = .systemBackground
        #endif
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           
        ])
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileHeaderView else{
                return nil
            }
            headerView.delegate = self
            headerView.setUser(user: user)
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        postModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as? PhotosTableViewCell else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
                    return cell
                }
            
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? PostTableViewCell else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)
                return cell
            }

        let viewModel = PostTableViewCell.ViewModel(author: postModel[indexPath.section].author, image: postModel[indexPath.section].image, description: postModel[indexPath.section].description, likes: postModel[indexPath.section].likes, views: postModel[indexPath.section].views, uniqID: postModel[indexPath.section].id)
        cell.setup(with: viewModel)
        cell.index = indexPath
        return cell
            
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let vc = PhotosViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } 
        
    }
        
}
extension UIColor{
    static func createColor(ligthMode: UIColor, darkMode: UIColor) -> UIColor{
        guard #available(iOS 13.0, *) else { return ligthMode }
        return UIColor { (traitCollection) in
            return traitCollection.userInterfaceStyle == .light ? ligthMode : darkMode
        }
    }
    
}

