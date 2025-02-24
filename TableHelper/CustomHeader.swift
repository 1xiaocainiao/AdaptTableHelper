//
//  CustomHeader.swift
//  TableHelper
//
//  Created by mac on 2025/2/24.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.backgroundColor = .green
        
        contentLabel.textColor = .red
        self.contentView.addSubview(contentLabel)
        
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
//        contentLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        contentLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        contentLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: topAnchor),
            contentLabel.leftAnchor.constraint(equalTo: leftAnchor),
            contentLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentLabel.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var item: SectionModel?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension CustomHeader: LXSectionViewProtocol {
    func setItem(_ item: SectionModel, section: Int) {
        contentLabel.text = item.title
    }
}
