//
//  MainMenuViewController.swift
//  Labb1Swift
//
//  Created by Jesper Stenlund on 2020-02-10.
//  Copyright © 2020 Jesper Stenlund. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let iconImage = UIImageView(
            frame: CGRect(x: 0.0, y: 0.0, width: 200 , height: 200)
        )
        iconImage.image = UIImage(named: "AppIcon_images")
        
        self.view.addSubview(iconImage)
        
        UIView.animate(withDuration: 3, animations:{ () -> Void in
            iconImage.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/3)
        })

    }
}
