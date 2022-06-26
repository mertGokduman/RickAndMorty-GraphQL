//
//  API.swift
//  RickandMortySample
//
//  Created by Onur Şimşek on 13.06.2022.
//

import Apollo
import Foundation

public final class CharacterQuery: GraphQLQuery {
    public let operationDefinition: String =
    """
    query Character($page: Int!, $name: String!) {
      characters(page: $page, filter: { name: $name }) {
        __typename
        info {
            __typename
            count
            pages
        }
        results {
          __typename
          id
          name
          image
          location {
            __typename
            name
          }
        }
      }
    }
    """
    
    public let operationName: String = "Character"
    public var page: Int
    public var name: String
    
    internal init(page: Int, charaterName: String) {
        self.page = page
        self.name = charaterName
    }
    
    public var variables: GraphQLMap? {
        return ["page": page, "name": name]
    }
    
    public struct Data: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Query"]
        
        public static let selections: [GraphQLSelection] = [
            GraphQLField("characters", arguments: ["page": GraphQLVariable("page"),  "filter": ["name":GraphQLVariable("name")]], type: .object(Character.selections)),
        ]
        
        public private(set) var resultMap: ResultMap
        
        public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
        }
        
        public init(characters: Character? = nil) {
            self.init(unsafeResultMap: ["__typename": "Query", "characters": characters.flatMap { (value: Character) -> ResultMap in value.resultMap }])
        }
        
        public var characters: Character? {
            get {
                return (resultMap["characters"] as? ResultMap).flatMap { Character(unsafeResultMap: $0) }
            }
            set {
                resultMap.updateValue(newValue?.resultMap, forKey: "characters")
            }
        }
        
        public struct Character: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["Characters"]
            
            public static let selections: [GraphQLSelection] = [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("info", type: .object(Info.selections)),
                GraphQLField("results", type: .list(.object(Result.selections))),
            ]
            
            public private(set) var resultMap: ResultMap
            
            public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
            }
            
            public init(info: Info? = nil, results: [Result?]? = nil) {
                self.init(unsafeResultMap: ["__typename": "Characters", "info": info.flatMap { (value: Info) -> ResultMap in value.resultMap }, "results": results.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }])
            }
            
            public var __typename: String {
                get {
                    return resultMap["__typename"]! as! String
                }
                set {
                    resultMap.updateValue(newValue, forKey: "__typename")
                }
            }
            
            public var info: Info? {
              get {
                return (resultMap["info"] as? ResultMap).flatMap { Info(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "info")
              }
            }
            
            public struct Info: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["Info"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("count", type: .scalar(Int.self)),
                  GraphQLField("pages", type: .scalar(Int.self))
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(pages: Int? = nil, count: Int? = nil) {
                self.init(unsafeResultMap: ["__typename": "Info", "pages": pages, "count": count])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              /// The amount of pages.
              public var pages: Int? {
                get {
                  return resultMap["pages"] as? Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "pages")
                }
              }

              /// The length of the response.
              public var count: Int? {
                get {
                  return resultMap["count"] as? Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "count")
                }
              }
            }
            
            public var results: [Result?]? {
                get {
                    return (resultMap["results"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Result?] in value.map { (value: ResultMap?) -> Result? in value.flatMap { (value: ResultMap) -> Result in Result(unsafeResultMap: value) } } }
                }
                set {
                    resultMap.updateValue(newValue.flatMap { (value: [Result?]) -> [ResultMap?] in value.map { (value: Result?) -> ResultMap? in value.flatMap { (value: Result) -> ResultMap in value.resultMap } } }, forKey: "results")
                }
            }
            
            public struct Result: GraphQLSelectionSet, Identifiable,Equatable {
                public static func == (lhs: CharacterQuery.Data.Character.Result, rhs: CharacterQuery.Data.Character.Result) -> Bool {
                    if lhs.image == rhs.image && lhs.id == rhs.id && lhs.location == rhs.location && lhs.name == rhs.name {
                        return true
                    } else {
                        return false
                    }
                }
                
                public static let possibleTypes: [String] = ["Character"]
                
                public static let selections: [GraphQLSelection] = [
                    GraphQLField("id", type: .scalar(GraphQLID.self)),
                    GraphQLField("name", type: .scalar(String.self)),
                    GraphQLField("location", type: .object(Location.selections)),
                    GraphQLField("image", type: .scalar(String.self)),
                ]
                
                public private(set) var resultMap: ResultMap
                
                public init(unsafeResultMap: ResultMap) {
                    self.resultMap = unsafeResultMap
                }
                
                public init(id: GraphQLID? = nil, name: String? = nil, location: Location? = nil, image: String? = nil) {
                    self.init(unsafeResultMap: ["__typename": "Character", "id": id, "name": name, "location": location.flatMap { (value: Location) -> ResultMap in value.resultMap }, "image": image])
                }
                
                public var __typename: String {
                    get {
                        return resultMap["__typename"]! as! String
                    }
                    set {
                        resultMap.updateValue(newValue, forKey: "__typename")
                    }
                }
                
                /// The id of the character.
                public var id: GraphQLID? {
                    get {
                        return resultMap["id"] as? GraphQLID
                    }
                    set {
                        resultMap.updateValue(newValue, forKey: "id")
                    }
                }
                
                public var name: String? {
                    get {
                        return resultMap["name"] as? String
                    }
                    set {
                        resultMap.updateValue(newValue, forKey: "name")
                    }
                }
                
                public var image: String? {
                    get {
                        return resultMap["image"] as? String
                    }
                    set {
                        resultMap.updateValue(newValue, forKey: "image")
                    }
                }
                
                public var location: [String:String]? {
                    get {
                        return resultMap["location"] as? [String:String]
                    }
                    set {
                        resultMap.updateValue(newValue, forKey: "location")
                    }
                }
                                
                public struct Location: GraphQLSelectionSet {
                    public static let possibleTypes: [String] = ["Location"]
                    
                    public static let selections: [GraphQLSelection] = [
                        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                        GraphQLField("name", type: .scalar(String.self)),
                    ]
                    
                    public private(set) var resultMap: ResultMap
                    
                    public init(unsafeResultMap: ResultMap) {
                        self.resultMap = unsafeResultMap
                    }
                    
                    public init(name: String? = nil) {
                        self.init(unsafeResultMap: ["__typename": "Location", "name": name])
                    }
                    
                    public var __typename: String {
                        get {
                            return resultMap["__typename"]! as! String
                        }
                        set {
                            resultMap.updateValue(newValue, forKey: "__typename")
                        }
                    }
                    
                    public var name: String? {
                        get {
                            return resultMap["name"] as? String
                        }
                        set {
                            resultMap.updateValue(newValue, forKey: "name")
                        }
                    }
                }
            }
        }
    }
}
