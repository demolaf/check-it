//
//  UserRecentRepositoriesTableViewCell.swift
//  check_it
//
//  Created by Ademola Fadumo on 02/01/2024.
//

import UIKit

class UserRecentRepositoriesTableViewCell: UITableViewCell {
    static let reuseId = "UserRecentRepositoriesTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeSubviews()
    }
    
    private func initializeSubviews() {}
    
    required init(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        applyConstraints()
    }
    
    private func applyConstraints() {}
    
    override func prepareForReuse() {}
}
