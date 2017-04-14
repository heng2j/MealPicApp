//
//  ItemSummaryViewController.swift
//  MealPicApp
//
//  Created by Zhongheng Li on 4/14/17.
//  Copyright © 2017 Brendan Lee. All rights reserved.
//

import Foundation
import UIKit


class ItemSummaryViewController: UIViewController{
    
    var takenPhoto:UIImage?
    @IBOutlet weak var imageView: UIImageView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let availableImage = takenPhoto {
            imageView.image = availableImage
        }
        
        
    }
    

}
