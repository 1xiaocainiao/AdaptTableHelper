//
//  CellModel.swift
//  TableHelper
//
//  Created by mac on 2025/2/24.
//

import UIKit

class SectionModel: Codable {
    var title: String?
    
    var _testRows: [CellModel]? = []
}

extension SectionModel: LXSectionModelItemProtocol {
    var rows: [LXRowModelItemProtocol] {
        get {
            _testRows ?? []
        }
    }
    
//    func headerHeight() -> CGFloat {
//        return 50
//    }
    
    func estimateHeaderHeight() -> CGFloat {
        return 50
    }
    
    func headerClass() -> UITableViewHeaderFooterView.Type? {
        CustomHeader.self
    }
    
    func headerIdentifier() -> String {
        return String(describing: CustomHeader.self)
    }
    
    func headerClassName() -> String {
        return String(describing: CustomHeader.self)
    }
    
    func footerHeight() -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

class CellModel: Codable {
    var content: String?
}

extension CellModel: LXRowModelItemProtocol {
    func cellClass() -> UITableViewCell.Type {
        CustomCell.self
    }
    
    func cellClassName() -> String {
        return String(describing: CustomCell.self)
    }
    
    func identifier() -> String {
        return String(describing: CustomCell.self)
    }
}
