//
//  CharacterTableViewCell.swift
//  RickAndMorty-GraphQL
//
//  Created by Mert Gökduman on 26.06.2022.
//

import UIKit
import SnapKit
//import Apollo
import Kingfisher

class CharacterTableViewCell: UITableViewCell {
    
    static let rowHeight: CGFloat = 265
    static let identifier: String = "CharacterCell"
    
    private lazy var view: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0,
                                         height: 6)
        view.layer.shadowRadius = 6
        
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.cornerRadius = 10
        
        view.layer.masksToBounds = true
        view.clipsToBounds = false
        return view
    }()
    
    private lazy var imgCharacter: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.maskedCorners = [.layerMinXMinYCorner,
                                         .layerMaxXMinYCorner]
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var lblID: UILabel = {
       let label = UILabel()
        label.contentMode = .right
        return label
    }()
    
    private lazy var lblName: UILabel = {
        let label = UILabel()
         label.contentMode = .left
         return label
    }()
    
    private lazy var lblLocation: UILabel = {
        let label = UILabel()
         label.contentMode = .left
         return label
    }()
    
    var character: CharacterQuery.Data.Character.Result? {
        didSet {
            setUI()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setLayouts()
    }
    
    private func setLayouts() {
        
        self.addSubview(view)
        view.addSubview(imgCharacter)
        view.addSubview(lblID)
        view.addSubview(lblName)
        view.addSubview(lblLocation)
        
        //Main View
        view.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(8)
            make.left.equalTo(self.snp.left).offset(24)
            make.right.equalTo(self.snp.right).offset(-24)
            make.bottom.equalTo(self.snp.bottom).offset(-8)
        }
        
        //Character Image View
        imgCharacter.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.height.equalTo(168)
        }
        
        //ID Label
        lblID.snp.makeConstraints { make in
            make.top.equalTo(imgCharacter.snp.bottom).offset(8)
            make.right.equalTo(view.snp.right).offset(-17)
            make.height.equalTo(19)
            make.width.greaterThanOrEqualTo(40)
        }
        
        //Name Label
        lblName.snp.makeConstraints { make in
            make.top.equalTo(lblID.snp.bottom).offset(8)
            make.left.equalTo(view.snp.left).offset(14)
            make.right.equalTo(view.snp.right).offset(-17)
            make.height.greaterThanOrEqualTo(19)
        }
        
        //Location Label
        lblLocation.snp.makeConstraints { make in
            make.top.equalTo(lblName.snp.bottom).offset(8)
            make.left.equalTo(view.snp.left).offset(14)
            make.right.equalTo(view.snp.right).offset(-17)
            make.bottom.equalTo(view.snp.bottom).offset(-16)
        }
    }
    
    private func setUI() {
        guard let character = character else { return }

        lblID.attributedText = character.id~.getAttributeString(for: "#id: ")
        lblName.attributedText = character.name~.getAttributeString(for: "Name: ")
        lblLocation.attributedText = character.location?["name"]~.getAttributeString(for: "Location: ")
        getImage(with: character.image~)
    }
    
    // Get Image with Kingfisher
    private func getImage(with imageURL: String) {
        imgCharacter.kf.setImage(with: URL(string: imageURL),
                                 placeholder: UIImage(named: "empty"))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imgCharacter.image = nil
        lblID.text = nil
        lblName.text = nil
        lblLocation.text = nil
    }
}
