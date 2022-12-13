//
//  CustomButton.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 01.11.2022.
//

import UIKit

class CustomButton: UIButton {
    let title:String
    let textColor: UIColor
    let backgroundColorButton: UIColor
    let clipsToBoundsOfButton: Bool
    let cornerRadius: CGFloat
    let shadowOpacity: Float
    let shadowOffset: CGSize
    let translatesAutoresizingMask: Bool
    
    
    var addTarget = {}
    
    init(title:String, textColor: UIColor,
         backgroundColorButton: UIColor,
         clipsToBoundsOfButton: Bool,
         cornerRadius: CGFloat,
         shadowOpacity: Float,
         shadowOffset: CGSize,
         translatesAutoresizingMask: Bool) {
        self.title = title
        self.textColor = textColor
        self.backgroundColorButton = backgroundColorButton
        self.clipsToBoundsOfButton = clipsToBoundsOfButton
        self.cornerRadius = cornerRadius
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        self.translatesAutoresizingMask = translatesAutoresizingMask
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        tintColor = textColor
        backgroundColor = backgroundColorButton
        clipsToBounds = clipsToBoundsOfButton
        layer.cornerRadius = cornerRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMask
        addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonPressed(){
        addTarget()
    }
    
}
