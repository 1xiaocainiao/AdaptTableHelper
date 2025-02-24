//
//  LXSectionProtocol.swift
//  TableHelper
//
//  Created by mac on 2025/2/21.
//

import UIKit

protocol LXSectionViewBaseProtocol {
    func set(item: LXSectionModelItemProtocol, section: Int)
}

protocol LXSectionViewProtocol: LXSectionViewBaseProtocol where Self: UITableViewHeaderFooterView {
    associatedtype T: LXSectionModelItemProtocol
    
    var item: T? { get set }
    func setItem(_ item: T, section: Int)
}

extension LXSectionViewProtocol {
    func set(item: LXSectionModelItemProtocol, section: Int) {
        guard let item = item as? Self.T else { return }
        self.item = item
        setItem(item, section: section)
    }
}
