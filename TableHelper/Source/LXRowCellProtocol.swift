//
//  LXROwProtocol.swift
//  TableHelper
//
//  Created by mac on 2025/2/21.
//

import UIKit

protocol LXCellBaseProtocol {
  func set(item: LXRowModelItemProtocol, indexPath: IndexPath)
}

protocol LXRowCellProtocol: LXCellBaseProtocol where Self: UITableViewCell {
    associatedtype T: LXRowModelItemProtocol
    var item: T? { get set }
    func setItem(_ item: T, indexPath: IndexPath)
}

extension LXRowCellProtocol {
    func set(item: LXRowModelItemProtocol, indexPath: IndexPath) {
        guard let item = item as? Self.T else { return }
        self.item = item
        setItem(item, indexPath: indexPath)
    }
}
