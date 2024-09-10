//
//  MainCellViewModel.swift
//  MVVM
//
//  Created by Nikita Beglov on 25.06.2024.
//

import Foundation

final class MainCellModel {

    let nameRu: String
    let posterImage: URL?
    let filmId: Int

    init(_ film: Films) {
        self.nameRu = film.nameRu ?? film.nameEn ?? ""
        self.posterImage = film.posterUrl.flatMap { URL(string: $0) }
        self.filmId = film.filmId
    }
}
