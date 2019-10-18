//
//  cardsDataModel.swift
//  TinderStack
//
//  Created by Osama Naeem on 16/03/2019.
//  Copyright © 2019 NexThings. All rights reserved.
//

import UIKit
struct CardsDataModel {
    
    var bgColor: UIColor
    var text : String
    var image : UIImage
      
    init(bgColor: UIColor, text: String, image: UIImage) {
        self.bgColor = bgColor
        self.text = text
        self.image = image
    
    }
}


