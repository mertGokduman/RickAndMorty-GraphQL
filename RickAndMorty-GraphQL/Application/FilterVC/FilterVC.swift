//
//  FilterVC.swift
//  RickAndMorty-GraphQL
//
//  Created by Mert Gökduman on 26.06.2022.
//

import UIKit
import SnapKit

class FilterVC: UIViewController {
    
    private lazy var filterView: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var lblTitle: UILabel = {
       let label = UILabel()
        label.contentMode = .left
        label.text = "Filter"
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        return label
    }()
    
    private lazy var lineView: UIView = {
       let line = UIView()
        line.backgroundColor = .darkGray
        return line
    }()
    
    private lazy var characterStack: UIStackView = {
       let stack = UIStackView()
        stack.backgroundColor = .clear
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var characterView: CharacterView = {
       let view = CharacterView()
        view.backgroundColor = .clear
        view.setUI(characterName: "Rick",
                   delegate: self)
        return view
    }()
    
    private lazy var secondCharacterView: CharacterView = {
       let view = CharacterView()
        view.backgroundColor = .clear
        view.setUI(characterName: "Morty",
                   delegate: self)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .black.withAlphaComponent(0.6)
        setLayout()
    }
    
    private func setLayout() {
        
        self.view.addSubview(filterView)
        filterView.addSubview(lblTitle)
        filterView.addSubview(lineView)
        filterView.addSubview(characterStack)
        
        filterView.snp.makeConstraints { make in
            make.center.equalTo(self.view.snp.center)
            make.width.equalTo(self.view.snp.width).offset(-52)
            make.height.greaterThanOrEqualTo(164)
        }
        
        lblTitle.snp.makeConstraints { make in
            make.top.equalTo(filterView.snp.top).offset(16)
            make.left.equalTo(filterView.snp.left).offset(16)
            make.height.equalTo(28)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(lblTitle.snp.bottom).offset(8)
            make.left.equalTo(filterView.snp.left)
            make.right.equalTo(filterView.snp.right)
            make.height.equalTo(0.5)
        }
        
        characterStack.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.left.equalTo(filterView.snp.left)
            make.right.equalTo(filterView.snp.right)
            make.bottom.equalTo(filterView.snp.bottom)
        }
        
        characterStack.addArrangedSubview(characterView)
        characterStack.addArrangedSubview(secondCharacterView)
    }
    
    //Dismiss VC if user tapped anywhere in view except FilterView
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch = touches.first
        if touch?.view != self.filterView {
            self.createTransitionAnimation()
            self.dismiss(animated: false)
        }
    }
}

//MARK: - CharacterViewDelegate
extension FilterVC: CharacterViewDelegate {
    
    func characterButtonTapped() {
        self.createTransitionAnimation()
        self.dismiss(animated: false)
    }
}
