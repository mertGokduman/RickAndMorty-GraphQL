//
//  Network.swift
//  RickandMortySample
//
//  Created by Onur Şimşek on 13.06.2022.
//

import Apollo
import Foundation

class Network {
    static let shared = Network()
    
    lazy var apollo = ApolloClient(url: URL(string: "https://rickandmortyapi.com/graphql")!)
}

