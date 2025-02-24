//
//  LXSectionItemProtocol.swift
//  TableHelper
//
//  Created by mac on 2025/2/21.
//

import UIKit

protocol LXSectionModelItemProtocol {
    var rows: [LXRowModelItemProtocol] { get }

    func headerHeight() -> CGFloat
    func estimateHeaderHeight() -> CGFloat
    func headerClass() -> UITableViewHeaderFooterView.Type?
    func headerIdentifier() -> String
    func headerClassName() -> String

    func footerHeight() -> CGFloat
    func estimateFooterHeight() -> CGFloat
    func footerClass() -> UITableViewHeaderFooterView.Type?
    func footerIdentifier() -> String
    func footerClassName() -> String
}

extension LXSectionModelItemProtocol {
    func headerHeight() -> CGFloat {
        UITableView.automaticDimension
    }

    func estimateHeaderHeight() -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func headerClass() -> UITableViewHeaderFooterView.Type? {
        nil
    }
    
    func headerIdentifier() -> String {
        return ""
    }
    
    func headerClassName() -> String {
        return ""
    }

    func footerHeight() -> CGFloat {
        UITableView.automaticDimension
    }
    
    func estimateFooterHeight() -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    func footerClass() -> UITableViewHeaderFooterView.Type? {
        nil
    }
    
    func footerIdentifier() -> String {
        return ""
    }
    
    func footerClassName() -> String {
        return ""
    }
}

extension LXSectionModelItemProtocol {
    var rows: [LXRowModelItemProtocol] {
        get {
            []
        }
    }
}
