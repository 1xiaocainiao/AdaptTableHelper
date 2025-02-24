//
//  LXRowItemProtocol.swift
//  TableHelper
//
//  Created by mac on 2025/2/21.
//

import UIKit

protocol LXRowModelItemProtocol where Self: AnyObject {
    /// cell类型, 这个有命名空间 比如 Text.UITableViewCell
    func cellClass() -> UITableViewCell.Type
    /// 高度
    func cellHeight() -> CGFloat
    
    func estimateCellHeight() -> CGFloat
    
    func identifier() -> String
    
    func cellClassName() -> String
}

extension LXRowModelItemProtocol {
    func cellClass() -> UITableViewCell.Type {
        UITableViewCell.self
    }
    
    /// 高度
    func cellHeight() -> CGFloat {
        UITableView.automaticDimension
    }
    
    func estimateCellHeight() -> CGFloat {
        return 0
    }
    
    func identifier() -> String {
        String(describing: Self.self)
    }
    
    func cellClassName() -> String {
        String(describing: Self.self)
    }
}

