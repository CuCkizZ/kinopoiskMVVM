//
//  DetailsViewModelProtocol.swift
//  MVVM
//
//  Created by Nikita Beglov on 03.07.2024.
//

import Foundation

protocol DetailsViewModelProtocol {
    var filmDescription: FullInfo? { get }
    var isLoading: Observable<Bool> { get set }
    var onDataLoaded: (() -> Void)? { get set }
    func getfilmDescription()
}
