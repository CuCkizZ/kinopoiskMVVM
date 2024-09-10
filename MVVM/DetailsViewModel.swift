//
//  DetailsViewModel.swift
//  MVVM
//
//  Created by Nikita Beglov on 26.06.2024.
//

import UIKit

final class DetailsViewModel: DetailsViewModelProtocol {

    var onDataLoaded: (() -> Void)?
    var isLoading: Observable<Bool> = Observable(false)
    var filmDescription: FullInfo?
    private var filmId: Int

    init(filmId: Int) {
        self.filmId = filmId
        getfilmDescription()
    }

    func getfilmDescription() {
        NetworkService.shared.getFilmDescription(filmId: filmId) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let filmDescription):
                    self.filmDescription = filmDescription
                    self.onDataLoaded?()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
