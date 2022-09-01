//
//  ProfileViewController.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 05.08.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var authorArray = ["", "Острые козырьки", "Рик и Морти", "Воспитанные волками", "Во все тяжкие                  (сериал 2008 – 2013) "]
    private var imageArray = ["cat2","Peaky", "rick", "volf", "Breaking"]
    private var descriptionArray = ["","Британский сериал о криминальном мире Бирмингема 20-х годов прошлого века, в котором многолюдная семья Шелби стала одной из самых жестоких и влиятельных гангстерских банд послевоенного времени. Фирменным знаком группировки, промышлявшей грабежами и азартными играми, стали зашитые в козырьки лезвия.","В центре сюжета - школьник по имени Морти и его дедушка Рик. Морти - самый обычный мальчик, который ничем не отличается от своих сверстников. А вот его дедуля занимается необычными научными исследованиями и зачастую полностью неадекватен. Он может в любое время дня и ночи схватить внука и отправиться вместе с ним в безумные приключения с помощью построенной из разного хлама летающей тарелки, которая способна перемещаться сквозь межпространственный тоннель. Каждый раз эта парочка оказывается в самых неожиданных местах и самых нелепых ситуациях.","2145 год. Человечество захлебнулось в кровопролитной войне между верующими и атеистами. Некоторое время спустя на планете Kepler-22b в меру удачно приземляется небольшое судно с двумя андроидами, которые называют друг друга Матерью и Отцом. Их миссия — вырастить из привезённых эмбрионов человеческих детёнышей и воспитать их атеистами.","Школьный учитель химии Уолтер Уайт узнаёт, что болен раком лёгких. Учитывая сложное финансовое состояние дел семьи, а также перспективы, Уолтер решает заняться изготовлением метамфетамина. Для этого он привлекает своего бывшего ученика Джесси Пинкмана, когда-то исключённого из школы при активном содействии Уайта. Пинкман сам занимался варкой мета, но накануне, в ходе рейда УБН, он лишился подельника и лаборатории."]
    
    private var likes = Int.random(in: 500..<900)
    private var views = Int.random(in: 0..<900)
    
//    private lazy var layout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = 12
//        layout.minimumInteritemSpacing = 8
//        return layout
//    }()
//
//    private lazy var collectionView: UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        return collectionView
//    }()
    
    private lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProfileTableHederView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
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
        //self.view.addSubview(self.collectionView)
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
//            self.collectionView.topAnchor.constraint(equalTo: tableView.topAnchor),
//            self.collectionView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
//            self.collectionView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
//            self.collectionView.heightAnchor.constraint(equalTo: tableView.heightAnchor, constant: 100),
//            self.collectionView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileTableHederView else{
                return nil
            }
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
        5
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
            let viewModel = PostTableViewCell.ViewModel(author: authorArray[indexPath.section],
                                                        image: UIImage(named: imageArray[indexPath.section]),
                                                        description: descriptionArray[indexPath.section],
                                                        likes: likes * (indexPath.section + 2),
                                                        views: views * (indexPath.section + 2))
            cell.setup(with: viewModel)
        return cell
            
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let vc = PhotosViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
        
}

//extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
//        cell.clipsToBounds = true
//        cell.layer.cornerRadius = 6
//        cell.backgroundColor = .red
//        return cell
//    }
//
//
//}
