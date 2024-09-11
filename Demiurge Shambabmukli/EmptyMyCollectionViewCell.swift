//
//  EmptyMyCollectionViewCell.swift
//  Demiurge Shambabmukli
//
//  Created by tryuruy on 11.09.2024.
//

import UIKit

class EmptyMyCollectionViewCell: UICollectionViewCell {
    static let cellName = "EmptyMyCollectionViewCell"
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .gray
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        
        return label
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    func setup() {
        contentView.backgroundColor = .clear
        contentView.addSubview(stack)
        
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(subtitleLabel)
        
        activateConstraints()
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        ])
    }
}
