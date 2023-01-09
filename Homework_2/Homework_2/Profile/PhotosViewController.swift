//
//  File.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 31.08.2022.
//

import UIKit
import iOSIntPackage
class PhotosViewController: UIViewController{
    
   // private lazy var imageFasade = ImagePublisherFacade()

    private lazy var layout: UICollectionViewFlowLayout = {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         layout.minimumLineSpacing = 8
         layout.minimumInteritemSpacing = 4
         layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
         return layout
     }()
 
     private lazy var collectionView: UICollectionView = {
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCell")
         collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
         collectionView.dataSource = self
         collectionView.delegate = self
         collectionView.translatesAutoresizingMaskIntoConstraints = false
         return collectionView
     }()
    
    private let imageSource: [String] = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40"]
    
    private lazy var imageProcessor = ImageProcessor()
    private var imagesArray: [UIImage] = []
    private var imagesArrayWhithFilter: [UIImage] = []
    
    
    // добавляем фильтр на массив картинок и преобразуем String в UIImage
    private func createImagesArrayWithFilter()  {
        print("Подождите минутку, идет обработка фотографий")
        
        let start = DispatchTime.now()
        
        for i in 0...(imageSource.count - 1)  {
            //var imageWithFilter = UIImage()
            //imageProcessor.processImage(sourceImage: UIImage(named: imageSource[i])! , filter: .chrome) { imageWithFilter = $0 ?? UIImage(named: "1")! }
            imagesArray.append(UIImage(named: imageSource[i])!)
        }
        
        imageProcessor.processImagesOnThread(sourceImages: imagesArray, filter: .chrome, qos: .utility) { [weak self] images in
            DispatchQueue.main.async {
                self?.imagesArrayWhithFilter = images.map { image in
                    UIImage(cgImage: image!)
                }
                let end = DispatchTime.now()
                let time = end.uptimeNanoseconds - start.uptimeNanoseconds
                let timeInterval = Double(time) / 1_000_000_000
                self?.collectionView.reloadData()
                print("Время обработки: \(timeInterval)")
            }
        }
        //qos: .default Время обработки: 5.345231386
        //qos: .background Время обработки: 6.586953502
        //qos: .userInitiated Время обработки: 6.301778812
        //qos: .utility Время обработки: 5.6970868
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Photo Gallery"
        self.navigationController?.navigationBar.isHidden = false
        self.setupConstraints()
        self.createImagesArrayWithFilter()
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.imageFasade.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = true
        //self.imageFasade.removeSubscription(for: self)
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
   
    private func setupConstraints(){
        self.view.addSubview(collectionView)
        self.view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
   
}
extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesArrayWhithFilter.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        // модель без фильтра
        //let viewModel = PhotosCollectionViewCell.ViewModel(image: UIImage(named: imageSource[indexPath.row]))
        // модель с применением фильтра
        let viewModel = PhotosCollectionViewCell.ViewModel(image: imagesArrayWhithFilter[indexPath.row])
        
        cell.setup(with: viewModel)
        cell.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let numberOfItemsOfLine = 3.0
        let inSets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? .zero
        
        let width = collectionView.bounds.width - numberOfItemsOfLine * interItemSpacing - inSets.left - inSets.right
        let itemWidth = floor (width / numberOfItemsOfLine)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ShowViewController()
        let viewModel = ShowViewController.ViewModel(image: imagesArray[indexPath.row])
        vc.setup(with: viewModel)
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true)
    }
}
//extension PhotosViewController: ImageLibrarySubscriber{
//    func receive(images: [UIImage]) {
//
//        imagesArrayWithFilter = images
//        collectionView.reloadData()
//        //print("-----")
//    }
//}
