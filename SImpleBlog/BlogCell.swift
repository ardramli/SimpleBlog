//
//  BlogCell.swift
//  SImpleBlog
//
//  Created by ardMac on 27/04/2017.
//  Copyright © 2017 ardMac. All rights reserved.
//

import UIKit

class BlogCell: UITableViewCell {
    
    static let cellIdentifier = "BlogCell"
    static let cellNib = UINib(nibName: BlogCell.cellIdentifier, bundle: Bundle.main)
    

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
