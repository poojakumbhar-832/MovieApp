//
//  NowPlayingCollectionViewCell.swift
//  MovieApp 2
//
//  Created by Pooja kumbhar on 19/05/20.
//  Copyright © 2020 Pooja kumbhar. All rights reserved.
//

import UIKit

class NowPlayingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImgView: UIImageView!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblOverview: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        let bottomBorder = UIView(frame: CGRect(x: 0, y: contentView.frame.size.height - 1, width: contentView.frame.size.width, height: 1))
//        bottomBorder.backgroundColor = UIColor.red
//       contentView.addSubview(bottomBorder)
        
        let topLineView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.bounds.size.width, height: 0.5))
        topLineView.backgroundColor = UIColor.darkGray
           contentView.addSubview(topLineView)
        
           let bottomLineView = UIView(frame: CGRect(x: 0, y: contentView.bounds.size.height, width: contentView.bounds.size.width, height: 0.5))
        bottomLineView.backgroundColor = UIColor.darkGray
           contentView.addSubview(bottomLineView)
    }

}
