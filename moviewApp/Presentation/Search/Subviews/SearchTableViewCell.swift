//
//  SearchTableViewCell.swift
//  moviewApp
//
//  Created by Jooeun Kim on 2022/12/08.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    static let identifier = String(describing: SearchTableViewCell.self)


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func setupCell(item : ResultMovie){
        
    }
}
