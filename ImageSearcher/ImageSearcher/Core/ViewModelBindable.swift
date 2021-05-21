//
//  Bindable.swift
//  ImageSearcher
//
//  Created by 조재흥 on 2021/05/21.
//

import Foundation

protocol ViewModelBindable {
    
    associatedtype ViewModel
    
    var viewModel: ViewModel? { get }
    
    func bind(viewModel: ViewModel)
}
