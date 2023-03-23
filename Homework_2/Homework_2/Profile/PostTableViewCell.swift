//
//  CustomTableViewCell.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 23.08.2022.
//

import UIKit
import CoreData


class PostTableViewCell: UITableViewCell {
    
    
    var index: IndexPath?
    let coreDataManager = CoreDataManager.shared

    
    struct ViewModel{
        let author: String
        let image: String
        let description: String
        let likes: Int
        let views: Int
        let uniqID: String
    }
    
    private lazy var authorLabel: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.font = UIFont.boldSystemFont(ofSize: 20.0)
        name.numberOfLines = 2
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let description = UILabel()
        description.textColor = .systemGray
        description.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private lazy var likesLabel: UILabel = {
        let likesLabel = UILabel()
        likesLabel.textColor = .black
        likesLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        return likesLabel
    }()
    
    private lazy var viewsLabel: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.textColor = .black
        viewsLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        return viewsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewmodel: ViewModel) {
        self.authorLabel.text = viewmodel.author
        self.postImageView.image = UIImage(named: viewmodel.image)
        self.descriptionLabel.text = viewmodel.description
        self.likesLabel.text = "Likes: \(viewmodel.likes)"
        self.viewsLabel.text = "Views: \(viewmodel.views)"
       coreDataManager.reloadPosts()
    }
    
    func setupSelectedPost(post: String){
        coreDataManager.reloadPosts()
        if let index = coreDataManager.posts.firstIndex(where: { $0.id == post })  {
            authorLabel.text = coreDataManager.posts[index].title
            postImageView.image = UIImage(named: coreDataManager.posts[index].image!)
            descriptionLabel.text = coreDataManager.posts[index].descriptionPost
            likesLabel.text = "Likes: \(coreDataManager.posts[index].likes)"
            viewsLabel.text = "Views: \(coreDataManager.posts[index].views)"
        }
    }
    
    
    private func setupView(){
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
        self.addSubview(self.authorLabel)
        self.addSubview(self.postImageView)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.likesLabel)
        self.addSubview(self.viewsLabel)
        
        NSLayoutConstraint.activate([
            self.authorLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.authorLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.postImageView.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 12),
            self.postImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.postImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.postImageView.heightAnchor.constraint(equalTo: self.widthAnchor),
     
            self.descriptionLabel.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16),
            self.descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.likesLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.likesLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.likesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        
            self.viewsLabel.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16),
            self.viewsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.viewsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    @objc func doubleTap() {
        let model = posts
           if index != nil {
               if let _ = coreDataManager.posts.firstIndex(where: { $0.id == model[index!.section].id }) {
                   print("Эта запись уже в избранном!")
               } else {
                   print(model[index!.section].author)
                   coreDataManager.createPost (title: model[index!.section].author , descriptionPost: model[index!.section].description, image: model[index!.section].image, likes: Int16(model[index!.section].likes), views: Int16(model[index!.section].views), id: model[index!.section].id)
                   coreDataManager.reloadPosts()
                 
               }
           }
        
       }
}
