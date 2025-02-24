//
//  LXTableViewHepler.swift
//  TableHelper
//
//  Created by mac on 2025/2/21.
//

import UIKit

extension LXTableViewHepler {
    enum CLDataMode {
        case section
        case row
    }
}

class LXTableViewHepler: NSObject {
    var sections = [LXSectionModelItemProtocol]()

    var rows = [LXRowModelItemProtocol]()

    private weak var delegate: UITableViewDelegate?

    var mode: CLDataMode = .row
    
    fileprivate var registerCellClassNames: [String] = []
    
    fileprivate weak var listView: UITableView?
    
    /// 点击cell回调
    var didSelectCellCallback: ((IndexPath) -> Void)?
    
    var didSelectHeaderViewCallback: ((Int) -> Void)?
    
    var didSelectFooterViewCallback: ((Int) -> Void)?
    
    var cellForRow: ((UITableViewCell, IndexPath) -> Void)?
    
    var viewForHeader: ((UITableViewHeaderFooterView?, Int) -> Void)?
    
    var viewForFooter: ((UITableViewHeaderFooterView?, Int) -> Void)?
    
    init(listView: UITableView, mode: CLDataMode = .row, delegate: UITableViewDelegate? = nil) {
        self.mode = mode
        self.delegate = delegate
        self.listView = listView
        super.init()
        
        self.listView?.delegate = self
        self.listView?.dataSource = self
    }

    override func forwardingTarget(for aSelector: Selector!) -> Any? {
        if super.responds(to: aSelector) {
            return self
        } else if let delegate, delegate.responds(to: aSelector) {
            return delegate
        }
        return self
    }

    override func responds(to aSelector: Selector!) -> Bool {
        if let delegate {
            return super.responds(to: aSelector) || delegate.responds(to: aSelector)
        }
        return super.responds(to: aSelector)
    }
}

// MARK: - JmoVxia---UITableViewDelegate

extension LXTableViewHepler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate, delegate.responds(to: #selector(tableView(_:didSelectRowAt:))) {
            delegate.tableView?(tableView, didSelectRowAt: indexPath)
        }
        didSelectCellCallback?(indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let delegate, delegate.responds(to: #selector(tableView(_:heightForRowAt:))) {
            delegate.tableView?(tableView, heightForRowAt: indexPath) ?? UITableView.automaticDimension
        } else {
            itemForIndexPath(indexPath)?.cellHeight() ?? .zero
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if let delegate, delegate.responds(to: #selector(tableView(_:estimatedHeightForRowAt:))) {
            delegate.tableView?(tableView, estimatedHeightForRowAt: indexPath) ?? UITableView.automaticDimension
        } else {
            itemForIndexPath(indexPath)?.cellHeight() ?? .zero
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let delegate, delegate.responds(to: #selector(tableView(_:willDisplay:forRowAt:))) {
            delegate.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let delegate, delegate.responds(to: #selector(tableView(_:didEndDisplaying:forRowAt:))) {
            delegate.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let delegate, delegate.responds(to: #selector(tableView(_:heightForHeaderInSection:))) {
            delegate.tableView?(tableView, heightForHeaderInSection: section) ?? UITableView.automaticDimension
        } else {
            sections[safe: section]?.headerHeight() ?? CGFloat.leastNonzeroMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if let delegate, delegate.responds(to: #selector(tableView(_:estimatedHeightForHeaderInSection:))) {
            delegate.tableView?(tableView, estimatedHeightForHeaderInSection: section) ?? UITableView.automaticDimension
        } else {
            sections[safe: section]?.estimateHeaderHeight() ?? CGFloat.leastNonzeroMagnitude
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let delegate, delegate.responds(to: #selector(tableView(_:willDisplayHeaderView:forSection:))) {
            delegate.tableView?(tableView, willDisplayHeaderView: view, forSection: section)
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        if let delegate, delegate.responds(to: #selector(tableView(_:didEndDisplayingHeaderView:forSection:))) {
            delegate.tableView?(tableView, didEndDisplayingHeaderView: view, forSection: section)
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if let delegate, delegate.responds(to: #selector(tableView(_:heightForFooterInSection:))) {
            delegate.tableView?(tableView, heightForFooterInSection: section) ?? UITableView.automaticDimension
        } else {
            sections[safe: section]?.footerHeight() ?? CGFloat.leastNonzeroMagnitude
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        if let delegate, delegate.responds(to: #selector(tableView(_:estimatedHeightForFooterInSection:))) {
            delegate.tableView?(tableView, estimatedHeightForFooterInSection: section) ?? UITableView.automaticDimension
        } else {
            sections[safe: section]?.estimateFooterHeight() ?? CGFloat.leastNonzeroMagnitude
        }
    }

    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let delegate, delegate.responds(to: #selector(tableView(_:willDisplayHeaderView:forSection:))) {
            delegate.tableView?(tableView, willDisplayHeaderView: view, forSection: section)
        }
    }

    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        if let delegate, delegate.responds(to: #selector(tableView(_:didEndDisplayingFooterView:forSection:))) {
            delegate.tableView?(tableView, didEndDisplayingFooterView: view, forSection: section)
        }
    }
}

// MARK: - JmoVxia---UITableViewDataSource

extension LXTableViewHepler: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch mode {
        case .section:
            sections[safe: section]?.rows.count ?? .zero
        case .row:
            rows.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = itemForIndexPath(indexPath) else { return UITableViewCell() }
        
        registerCellClassIfNeed(indexPath, tableView: tableView)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier(), for: indexPath)
        
        self.cellForRow?(cell, indexPath)
        
        (cell as? LXCellBaseProtocol)?.set(item: item, indexPath: indexPath)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        switch mode {
        case .section:
            sections.count
        case .row:
            1
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let item = sections[safe: section] else { return nil }
        if item.headerClass() == nil {
            return nil
        }
        
        registerHeaderOrFooter(item.headerClassName(),
                               identifier: item.headerIdentifier(),
                               headerOrFooter: item.headerClass(),
                               tableView: tableView)
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: item.headerIdentifier())
        view?.tag = section
        view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectHeaderView(_:))))
        view?.isUserInteractionEnabled = true
        (view as? LXSectionViewBaseProtocol)?.set(item: item, section: section)
        
        viewForHeader?(view, section)
        return view
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let item = sections[safe: section] else { return nil }
        if item.footerClass() == nil {
            return nil
        }
        
        registerHeaderOrFooter(item.footerClassName(),
                               identifier: item.footerIdentifier(),
                               headerOrFooter: item.footerClass(),
                               tableView: tableView)
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: item.headerIdentifier())
        view?.tag = section
        view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didSelectFooterView(_:))))
        view?.isUserInteractionEnabled = true
        (view as? LXSectionViewBaseProtocol)?.set(item: item, section: section)
        
        viewForFooter?(view, section)
        return view
    }
}

@objc private extension LXTableViewHepler {
    func didSelectHeaderView(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let view = gestureRecognizer.view as? UITableViewHeaderFooterView else { return }
        didSelectHeaderViewCallback?(view.tag)
    }

    func didSelectFooterView(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let view = gestureRecognizer.view as? UITableViewHeaderFooterView else { return }
        didSelectFooterViewCallback?(view.tag)
    }
}

private extension LXTableViewHepler {
    func itemForIndexPath(_ indexPath: IndexPath) -> LXRowModelItemProtocol? {
        switch mode {
        case .section:
            sections[safe: indexPath.section]?.rows[safe: indexPath.row]
        case .row:
            rows[safe: indexPath.row]
        }
    }
}

private extension LXTableViewHepler {
    func registerCellClassIfNeed(_ indexPath: IndexPath, tableView: UITableView) {
        guard let model = itemForIndexPath(indexPath) else {
            return
        }
        
        let identifier = model.identifier()
        
        if !registerCellClassNames.contains(identifier) {
            registerCellClassNames.append(identifier)
            let cellName = model.cellClassName()
            
            if checkIsNib(nibName: cellName) {
                tableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: identifier)
            } else {
                tableView.register(model.cellClass(), forCellReuseIdentifier: identifier)
            }
        }
    }
    
    func registerHeaderOrFooter(_ name: String,
                                identifier: String,
                                headerOrFooter: UITableViewHeaderFooterView.Type?,
                                tableView: UITableView) {
        
        if headerOrFooter == nil {
            return
        }
        
        if !registerCellClassNames.contains(identifier) {
            registerCellClassNames.append(identifier)
            
            if checkIsNib(nibName: name) {
                tableView.register(UINib(nibName: name, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
            } else {
                tableView.register(headerOrFooter, forHeaderFooterViewReuseIdentifier: identifier)
            }
        }
    }
    
    func checkIsNib(nibName name: String) -> Bool {
        let path = Bundle.main.path(forResource: name, ofType: "nib")
        return path != nil
    }
}
