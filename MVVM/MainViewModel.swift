//
//  MainViewModel.swift
//  MVVM
//
//  Created by Nikita Beglov on 25.06.2024.
//

import UIKit

final class MainViewModel: MainViewModelProtocol {

    private var router: RouterProtocol = Router()
    private var films: [Films]?
    var searchText: String = ""
    var isLoading: Observable<Bool> = Observable(false)
    var cellDataSource: Observable<[MainCellModel]> = Observable(nil)

    func getStart() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        NetworkService.shared.getPopularFilms { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            DispatchQueue.main.async {
                switch result {
                case .success(let films):
                    self.films = films
                    self.mpCellData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func getFilms() {
        if isLoading.value ?? true {
            return
        }
        isLoading.value = true
        NetworkService.shared.getFilms(keyword: searchText) { [weak self] result in
            guard let self = self else { return }
            self.isLoading.value = false
            DispatchQueue.main.async {
                switch result {
                case .success(let films):
                    self.films = films
                    self.mpCellData()
                case .failure(let error):
                    print("\(error)" + warningMessage(error: .parseError))
                }
            }
        }
    }

    func presentDetailVC(_ view: UIViewController, filmId: Int) {
        router.modalPresent(from: view, filmId: filmId)
    }

    func numberOfRowsInSections() -> Int {
        return films?.count ?? 0
    }

    func heightForARow() -> CGFloat {
        150
    }

    private func mpCellData() {
        cellDataSource.value = films?.compactMap({ MainCellModel($0) })
    }

    func setFilmName(_ model: MainCellModel) -> String {
        var text = model.nameRu
        if text.isEmpty {
            text = warningMessage(error: .parseError)
        }
        return text
    }
}
