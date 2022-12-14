//
//  FeedModel.swift
//  Homework_2
//
//  Created by Андрей Байдаченко on 12.12.2022.
//
protocol FeedModelDelegate: AnyObject{
    
}

class FeedModel {
    //private weak var delegate: FeedModelDelegate?
    let secretWord = "secret"
    
    init(delegate: FeedModelDelegate){
        //self.delegate = delegate
    }

    func check(word: String) -> Bool{
        word == secretWord && word != ""
    }
}
