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
    
//    private var authorArray = ["", "Острые козырьки", "Рик и Морти", "Воспитанные волками", "Во все тяжкие (сериал 2008 – 2013) "]
//    private var imageArray = ["cat2","Peaky", "rick", "volf", "Breaking"]
//    private var descriptionArray = ["","Британский сериал о криминальном мире Бирмингема 20-х годов прошлого века, в котором многолюдная семья Шелби стала одной из самых жестоких и влиятельных гангстерских банд послевоенного времени. Фирменным знаком группировки, промышлявшей грабежами и азартными играми, стали зашитые в козырьки лезвия.","В центре сюжета - школьник по имени Морти и его дедушка Рик. Морти - самый обычный мальчик, который ничем не отличается от своих сверстников. А вот его дедуля занимается необычными научными исследованиями и зачастую полностью неадекватен. Он может в любое время дня и ночи схватить внука и отправиться вместе с ним в безумные приключения с помощью построенной из разного хлама летающей тарелки, которая способна перемещаться сквозь межпространственный тоннель. Каждый раз эта парочка оказывается в самых неожиданных местах и самых нелепых ситуациях.","2145 год. Человечество захлебнулось в кровопролитной войне между верующими и атеистами. Некоторое время спустя на планете Kepler-22b в меру удачно приземляется небольшое судно с двумя андроидами, которые называют друг друга Матерью и Отцом. Их миссия — вырастить из привезённых эмбрионов человеческих детёнышей и воспитать их атеистами.","Школьный учитель химии Уолтер Уайт узнаёт, что болен раком лёгких. Учитывая сложное финансовое состояние дел семьи, а также перспективы, Уолтер решает заняться изготовлением метамфетамина. Для этого он привлекает своего бывшего ученика Джесси Пинкмана, когда-то исключённого из школы при активном содействии Уайта. Пинкман сам занимался варкой мета, но накануне, в ходе рейда УБН, он лишился подельника и лаборатории."]
//
//    private var likes = Int.random(in: 500..<900)
//    private var views = Int.random(in: 0..<900)
    
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
        self.navigationItem.title = "Back"
        self.setupConstraints()
    }
 
    private func setupConstraints(){
        self.view.addSubview(self.tableView)
    #if DEBUG
        self.view.backgroundColor = .yellow
        #else
        self.view.backgroundColor = .white
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

