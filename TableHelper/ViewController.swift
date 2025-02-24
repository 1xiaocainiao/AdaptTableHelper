//
//  ViewController.swift
//  TableHelper
//
//  Created by mac on 2025/2/21.
//

import UIKit

class ViewController: UIViewController {
    lazy var helper: LXTableViewHepler = {
        let helper = LXTableViewHepler(listView: list)
        return helper
    }()
    
    lazy var list: UITableView = {
        let table = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        table.backgroundColor = .clear
        table.estimatedRowHeight = 0
        table.estimatedSectionFooterHeight = 0
        table.estimatedSectionHeaderHeight = 0
        table.separatorStyle = .none
        if #available(iOS 15, *) {
            table.sectionHeaderTopPadding = 0
        }
        
        table.contentInsetAdjustmentBehavior = .never
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(list)
        
        list.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        helper.cellForRow = { [weak self] cell, indexPath in
            if let cell = cell as? CustomCell {
                cell.delegate = self
            }
        }
        
//        helper.mode = .row
//        testOnlyRow()
        
        helper.mode = .section
        testSectionAndRow()
        // Do any additional setup after loading the view.
    }
    
    func testOnlyRow() {
        var dataRows = [CellModel]()
        for index in 0...10 {
            let model = CellModel()
            model.content = "第\(index)行"
            dataRows.append(model)
        }
        
        helper.rows = dataRows
        list.reloadData()
    }
    
    func testSectionAndRow() {
        var dataSections = [SectionModel]()
        
        for index in 0...3 {
            let section = SectionModel()
            section.title = "第\(index)组"
            
            section._testRows = []
            
            for index in 0...10 {
                let model = CellModel()
                model.content = "第\(index)行"
                section._testRows?.append(model)
            }
            
            dataSections.append(section)
        }
        
        helper.sections = dataSections
        list.reloadData()
    }
    
}

/// 外部需要控制时使用,否则只需要在model里面设置好
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}

// MARK: - CustomCellDelegate
extension ViewController: CustomCellDelegate {
    func customCell(_ cell: CustomCell) {
        
    }
}
