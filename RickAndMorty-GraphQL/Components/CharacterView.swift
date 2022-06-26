//
//  CharacterView.swift
//  RickAndMorty-GraphQL
//
//  Created by Mert Gökduman on 26.06.2022.
//

import Foundation
import UIKit
import SnapKit

protocol CharacterViewDelegate: AnyObject {
    func characterButtonTapped()
}

class CharacterView: UIView {
    
    private lazy var view: UIView = {
       let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var characterButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self,
                         action: #selector(filterButtonTapped),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var lblName: UILabel = {
       let label = UILabel()
        label.contentMode = .left
        label.textColor = .black
        label.font = UIFont(name: "Roboto-Regular", size: 24)
        return label
    }()
    
    private lazy var imgSelection: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "unselected")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var characterName: String?
    private weak var delegate: CharacterViewDelegate?
    private var isSelected: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0,
                                 y: 0,
                                 width: UIScreen.main.bounds.width - 52,
                                 height: 56))
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setLayout() {
        self.addSubview(view)
        view.addSubview(characterButton)
        view.addSubview(lblName)
        view.addSubview(imgSelection)
        
        //Main View
        view.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(56)
        }
        
        //Character button
        characterButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        //Name Label
        lblName.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(16)
            make.left.equalTo(view.snp.left).offset(16)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(24)
        }
        
        //Selection Image
        imgSelection.snp.makeConstraints { make in
            make.centerY.equalTo(lblName.snp.centerY)
            make.right.equalTo(view.snp.right).offset(-16)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
    }
    
    func setUI(characterName: String,
               delegate: CharacterViewDelegate) {
        self.delegate = delegate
        self.characterName = characterName
        lblName.text = characterName
        imgSelection.image = HomeViewModel.character.value == characterName ? UIImage(named: "selected") : UIImage(named: "unselected")
        isSelected = HomeViewModel.character.value == characterName
    }
    
    @objc private func filterButtonTapped() {
        HomeViewModel.character.value = !isSelected ? self.characterName~ : ""
        delegate?.characterButtonTapped()
    }
}

