//
//  CustomTableViewCell.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 23.08.2022.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    struct ViewModel{
        let author: String
        let image: UIImage?
        let description: String
        let likes: Int
        let views: Int
    }
    
    private lazy var authorLable: UILabel = {
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
    
    private lazy var descriptionLable: UILabel = {
        let description = UILabel()
        description.textColor = .systemGray
        description.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        description.numberOfLines = 0
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    private lazy var likesLable: UILabel = {
        let likesLable = UILabel()
        likesLable.textColor = .black
        likesLable.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        likesLable.translatesAutoresizingMaskIntoConstraints = false
        return likesLable
    }()
    
    private lazy var viewsLable: UILabel = {
        let viewsLable = UILabel()
        viewsLable.textColor = .black
        viewsLable.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        viewsLable.translatesAutoresizingMaskIntoConstraints = false
        return viewsLable
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with viewmodel: ViewModel){
        self.authorLable.text = viewmodel.author
        self.postImageView.image = viewmodel.image
        self.descriptionLable.text = viewmodel.description
        self.likesLable.text = "Likes: \(viewmodel.likes)"
        self.viewsLable.text = "Views: \(viewmodel.views)"
    }
    
    private func setupView(){
        self.addSubview(self.authorLable)
        self.addSubview(self.postImageView)
        self.addSubview(self.descriptionLable)
        self.addSubview(self.likesLable)
        self.addSubview(self.viewsLable)
        
        NSLayoutConstraint.activate([
            self.authorLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.authorLable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.authorLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.postImageView.topAnchor.constraint(equalTo: self.authorLable.bottomAnchor, constant: 12),
            self.postImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.postImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.postImageView.heightAnchor.constraint(equalTo: self.widthAnchor),
     
            self.descriptionLable.topAnchor.constraint(equalTo: self.postImageView.bottomAnchor, constant: 16),
            self.descriptionLable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.descriptionLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            self.likesLable.topAnchor.constraint(equalTo: self.descriptionLable.bottomAnchor, constant: 16),
            self.likesLable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.likesLable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        
            self.viewsLable.topAnchor.constraint(equalTo: self.descriptionLable.bottomAnchor, constant: 16),
            self.viewsLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.viewsLable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    

   

}
