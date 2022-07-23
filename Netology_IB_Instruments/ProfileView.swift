//
//  ProfileView.swift
//  Netology_IB_Instruments
//
//  Created by Андрей Байдаченко on 21.07.2022.
//

import UIKit
class ProfileView: UIView{
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var birthdayLable: UILabel!
    
    
    @IBOutlet weak var cityLable: UILabel!
    
    
    @IBOutlet weak var infoTextView: UITextView!
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    private func setup(){
        let view = self.loadViewFromXib()
        self.addSubview(view)
        view.frame = self.bounds
        
    }
    private func loadViewFromXib() -> UIView{
        guard let view = Bundle.main.loadNibNamed("ProfileView", owner: self)?.first as? UIView
        else{
           return UIView()
       }
        return view
    }
}
