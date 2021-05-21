//
//  TypeKeyDictionary.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/21.
//

import Foundation

struct TypeKeyDictionary<T> {
    
    subscript(key: T.Type) -> T? {
        get {
            return dictionary[ObjectIdentifier(key)]
        }
        set {
            dictionary[ObjectIdentifier(key)] = newValue
        }
    }
    
    //MARK: - Private
    private var dictionary = [ObjectIdentifier: T]()
}
