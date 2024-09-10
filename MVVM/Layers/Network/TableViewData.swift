//
//  TableViewData.swift
//  MVVM
//
//  Created by Nikita Beglov on 09.07.2024.
//

import Foundation

// MARK: - Preview
struct Movies: Codable {
    let keyword: String?
    let pagesCount, searchFilmsCountResult: Int?
    let films: [Films]
}
    struct Films: Codable {
        let filmId: Int
        let nameRu, nameEn, type, year: String?
        let description, filmLength: String?
        let countries: [Country]
        let genres: [Genre]
        let rating: String?
        let ratingVoteCount: Int
        let posterUrl: String?
        let posterUrlPreview: String?
    }

// MARK: - Country
struct Country: Codable {
    let country: String
}

// MARK: - Genre
struct Genre: Codable {
    let genre: String
}
