//
//  MainViewModelProtocol.swift
//  MVVM
//
//  Created by Nikita Beglov on 26.06.2024.
//

import Foundation
import UIKit

protocol MainViewModelProtocol {
    var searchText: String { get set }
    var isLoading: Observable<Bool> { get set }
    var cellDataSource: Observable<[MainCellModel]> { get }
    func getStart()
    func getFilms()
    func numberOfRowsInSections() -> Int
    func heightForARow() -> CGFloat
    func setFilmName(_ model: MainCellModel) -> String
    func presentDetailVC(_ view: UIViewController, filmId: Int)
}
