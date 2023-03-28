//
//  CustomTableViewCell.swift
//  Table View app
//
//  Created by Adlet Zhantassov on 27.03.2023.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"

    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.layer.cornerRadius = contentView.frame.size.width / 2
        return imageView
    }()
    
    lazy var name: UILabel = {
       let label = UILabel()
        label.text = "name"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    lazy var location: UILabel = {
       let label = UILabel()
        label.text = "location"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    lazy var type: UILabel = {
       let label = UILabel()
        label.text = "type"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(foodImageView)
        contentView.addSubview(name)
        contentView.addSubview(location)
        contentView.addSubview(type)
    }
    
    private func setupConstraints() {
        foodImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(contentView.frame.size.width/5)
            make.height.equalTo(contentView.frame.size.height)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalTo(foodImageView.snp.trailing).offset(15)
        }
        
        location.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.leading.equalTo(foodImageView.snp.trailing).offset(15)
        }
        
        type.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalTo(foodImageView.snp.trailing).offset(15)
        }
    }

}
