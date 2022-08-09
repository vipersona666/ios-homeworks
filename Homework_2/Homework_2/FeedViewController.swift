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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "trava1.jpeg")!)
        self.navigationItem.title = "Лента"
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.view.addSubview(button)
        self.button.center = self.view.center
        
        
    }
    @objc private func didTapButton() {
        let vc = PostViewController()
        let post = Post(title: "Новый пост")
        vc.titlePost = post.title
        self.navigationController?.pushViewController(vc, animated: true)
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
