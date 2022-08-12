//
//  SecondViewController.swift
//  Navigation
//
//  Created by Андрей Байдаченко on 01.08.2022.
//

import UIKit

struct Post{
    var title: String
}

class FeedViewController: UIViewController {
    private lazy var button:UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        button.setTitle("Перейти на пост", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "trava1.jpeg") ?? UIImage())
        self.navigationItem.title = "Лента"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.view.addSubview(button)
        self.button.center = self.view.center
    }
    @objc private func didTapButton() {
        let vc = PostViewController()
        let post = Post(title: "Новый пост")
        vc.titlePost = post.title
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
