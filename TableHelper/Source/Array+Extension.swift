//
//  Array+Extension.swift
//  TableHelper
//
//  Created by mac on 2025/2/21.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
