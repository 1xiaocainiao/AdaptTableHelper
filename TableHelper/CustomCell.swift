//
//  CustomCell.swift
//  TableHelper
//
//  Created by mac on 2025/2/24.
//

import UIKit

protocol CustomCellDelegate: NSObjectProtocol {
    func customCell(_ cell: CustomCell)
}

class CustomCell: UITableViewCell {
    weak var delegate: CustomCellDelegate?
    
    var item: CellModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CustomCell: LXRowCellProtocol {
    func setItem(_ item: CellModel, indexPath: IndexPath) {
        textLabel?.text = item.content
    }
}
