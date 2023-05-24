//
//  LibraryCell.swift
//  Pen Pal
//
//  Created by min joo on 12/4/22.
//

import UIKit

class LibraryCell: UITableViewCell {
    //custom TableCell class which sets label 
    @IBOutlet var quoteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
