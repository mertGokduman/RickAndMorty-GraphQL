//
//  String + Extension.swift
//  RickAndMorty-GraphQL
//
//  Created by Mert Gökduman on 26.06.2022.
//

import Foundation
import UIKit

extension String {
    
    //Attributed String For Details Title
    func getAttributeString(for title: String) -> NSMutableAttributedString {
        
        let wholeString: String = title + self
        let attributeString = NSMutableAttributedString(string: wholeString,
                                                        attributes: [
                                                            .font: UIFont(name: "Roboto-Regular", size: 16)!,
                                                            .foregroundColor: UIColor.lightGray
                                                        ])
        let nameAttribute = [.foregroundColor: UIColor.black ] as [NSAttributedString.Key : Any]
        let nameRange = ((wholeString) as NSString).range(of: title)
        attributeString.addAttributes(nameAttribute, range: nameRange)
        return attributeString
    }
}
