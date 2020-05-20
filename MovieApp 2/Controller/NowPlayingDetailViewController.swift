//
//  NowPlayingDetailViewController.swift
//  MovieApp 2
//
//  Created by Pooja kumbhar on 20/05/20.
//  Copyright © 2020 Pooja kumbhar. All rights reserved.
//

import UIKit

class NowPlayingDetailViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    var imgUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if imgUrl == ""{
            self.backgroundImageView.image = UIImage(named: "placeholder")
        }else{
         loadImage(imgUrl)
        }
    }
    
    func loadImage(_ url: String){
        let url = URL(string: url)
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                       if let image = UIImage(data: data) {
                           DispatchQueue.main.async {
                            self.backgroundImageView.image = image
                           }
                       }
                   }
               }
    }

}
