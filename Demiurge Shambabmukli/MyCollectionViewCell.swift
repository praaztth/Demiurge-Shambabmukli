//
//  MyCollectionViewCell.swift
//  Demiurge Shambabmukli
//
//  Created by tryuruy on 10.09.2024.
//

import Foundation
import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    static let cellName = "MyCollectionViewCell"
    
    let imageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 25
        label.layer.masksToBounds = true
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .center
        
        return stack
    }()
    
    let labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .leading
        
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
        imageLabel.text = nil
    }
    
    func setup() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        
        contentView.addSubview(stack)
        
        stack.addArrangedSubview(imageLabel)
        stack.addArrangedSubview(labelsStack)
        
        labelsStack.addArrangedSubview(titleLabel)
        labelsStack.addArrangedSubview(subtitleLabel)
        
        activateConstraints()
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            stack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            imageLabel.heightAnchor.constraint(equalToConstant: 50),
            imageLabel.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
