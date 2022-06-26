//
//  HomeVC.swift
//  RickAndMorty-GraphQL
//
//  Created by Mert Gökduman on 26.06.2022.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    let viewModel = HomeViewModel()
    
    private lazy var characterTableView: UITableView = {
       let tableView = UITableView()
        tableView.register(CharacterTableViewCell.self,
                           forCellReuseIdentifier: CharacterTableViewCell.identifier)
        tableView.estimatedRowHeight = CharacterTableViewCell.rowHeight
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.bounces = false
        return tableView
    }()
    
    private lazy var filterButton: UIBarButtonItem = {
       let button = UIBarButtonItem()
        button.image = UIImage(named: "filter")?.withRenderingMode(.alwaysTemplate)
        button.tintColor = .lightGray
        button.action = #selector(filterButtonTapped)
        button.target = self
        button.style = .plain
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        characterTableView.delegate = self
        characterTableView.dataSource = self
        setLayout()
        bind()
    }
    
    private func setLayout() {
        
        title = "Rick And Morty"
        view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = filterButton
        self.view.addSubview(characterTableView)
        
        //Characater TableView
        characterTableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left)
            make.right.equalTo(self.view.safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
    
    private func bind() {
        
        HomeViewModel.character.bind { [weak self] _ in
            guard let self = self else { return }
            self.showSpinner(onView: self.view)
            self.viewModel.getCharacterDatas(infiniteScroll: false)
        }
        
        viewModel.characterDatas.bind { _ in
            DispatchQueue.main.async {
                self.characterTableView.reloadData()
                self.removeSpinner()
            }
        }
    }
    
    @objc private func filterButtonTapped() {
        createTransitionAnimation()
        let destinationVC = FilterVC()
        destinationVC.modalPresentationStyle = .overCurrentContext
        self.present(destinationVC, animated: false)
    }
}

//MARK: - UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModel.characterDatas.value.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = characterTableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.identifier,
                                                          for: indexPath) as! CharacterTableViewCell
        cell.character = viewModel.characterDatas.value[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}

//MARK: - UITableViewDelegate
extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        let count = viewModel.characterDatas.value.count
        if indexPath.row == count - 1, count <= viewModel.maxResult {
            viewModel.getCharacterDatas(infiniteScroll: true)
        }
    }
}
