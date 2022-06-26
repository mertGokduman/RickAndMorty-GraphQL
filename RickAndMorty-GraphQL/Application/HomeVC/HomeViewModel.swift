//
//  HomeViewModel.swift
//  RickAndMorty-GraphQL
//
//  Created by Mert Gökduman on 26.06.2022.
//

import Foundation

final class HomeViewModel {
    
    private var page: Int = 1
    var maxResult: Int = 0
    var maxPage: Int = 0
    
    static var character: ObservableObject<String> = ObservableObject("")
    var characterDatas: ObservableObject<[CharacterQuery.Data.Character.Result]> = ObservableObject([])
    
    func getCharacterDatas(infiniteScroll: Bool) {
        
        if infiniteScroll {
            page += 1
        } else {
            page = 1
            characterDatas.value.removeAll()
        }
        
        Network.shared.apollo.fetch(query: CharacterQuery(page: page,
                                                          charaterName: HomeViewModel.character.value)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success(characterResult):
                guard let results = characterResult.data?.characters?.results,
                      let count = characterResult.data?.characters?.info?.count,
                        let pages = characterResult.data?.characters?.info?.pages else { return }
                self.maxResult = count
                self.maxPage = pages
                self.characterDatas.value.append(contentsOf: results.compactMap { $0 })
            case .failure( _):
                print("Error yedim")
            }
        }
    }
}
