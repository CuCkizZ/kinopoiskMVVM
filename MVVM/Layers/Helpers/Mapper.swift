//
//  Mapper.swift
//  MVVM
//
//  Created by Nikita Beglov on 09.07.2024.
//

import Foundation

final class Mapper {
    
    func mapping (_ model: Preview) -> FullInfo {
        let nameRu = model.nameRu
        let nameOriginal = model.nameOriginal
        let posterUrl = model.posterURL
        let ratingKinopoisk = model.ratingKinopoisk
        let ratingImdb = model.ratingImdb
        let year = model.year
        let filmLength = model.filmLength
        let description = model.description
        
        return .init(nameRu: nameRu ?? "na name",
                     nameOriginal: nameOriginal ?? "N/A",
                     posterUrl: URL(string: posterUrl ?? ""),
                     ratingKinopoisk: ratingKinopoisk ?? 0.0,
                     ratingImdb: ratingImdb ?? 0.0,
                     year: year ?? 2000,
                     filmLength: filmLength ?? 120,
                     description: description ?? "")
    }
}
