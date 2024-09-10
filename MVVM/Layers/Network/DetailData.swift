//
//  DetailData.swift
//  MVVM
//
//  Created by Nikita Beglov on 09.07.2024.
//

import Foundation

struct Preview: Codable {
    let kinopoiskID: Int
    let kinopoiskHDID, imdbID, nameRu, nameEn: String?
    let nameOriginal: String?
    let posterURL, posterURLPreview: String?
    let coverURL, logoURL: String?
    let reviewsCount: Int?
    let ratingGoodReview: Double?
    let ratingGoodReviewVoteCount: Int?
    let ratingKinopoisk: Double?
    let ratingKinopoiskVoteCount: Int?
    let ratingImdb: Double?
    let ratingImdbVoteCount: Int?
    let ratingFilmCritics: Double?
    let ratingFilmCriticsVoteCount: Int?
    let ratingAwait: Double?
    let ratingAwaitCount: Int?
    let ratingRFCritics: Double?
    let ratingRFCriticsVoteCount: Int?
    let webURL: String?
    let year, filmLength: Int?
    let slogan, description, shortDescription, editorAnnotation: String?
    let isTicketsAvailable: Bool?
    let productionStatus, type, ratingMPAA, ratingAgeLimits: String?
    let hasImax, has3D: Bool?
    let lastSync: String?
    let countries: [Country]
    let genres: [Genre]
    let startYear, endYear: Int?
    let serial, shortFilm, completed: Bool?
    
    enum CodingKeys: String, CodingKey {
        case kinopoiskID = "kinopoiskId"
        case kinopoiskHDID = "kinopoiskHDId"
        case imdbID = "imdbId"
        case nameRu, nameEn, nameOriginal
        case posterURL = "posterUrl"
        case posterURLPreview = "posterUrlPreview"
        case coverURL = "coverUrl"
        case logoURL = "logoUrl"
        case reviewsCount, ratingGoodReview, ratingGoodReviewVoteCount, ratingKinopoisk, ratingKinopoiskVoteCount, ratingImdb, ratingImdbVoteCount, ratingFilmCritics, ratingFilmCriticsVoteCount, ratingAwait, ratingAwaitCount
        case ratingRFCritics = "ratingRfCritics"
        case ratingRFCriticsVoteCount = "ratingRfCriticsVoteCount"
        case webURL = "webUrl"
        case year, filmLength, slogan, description, shortDescription, editorAnnotation, isTicketsAvailable, productionStatus, type
        case ratingMPAA = "ratingMpaa"
        case ratingAgeLimits, hasImax, has3D, lastSync, countries, genres, startYear, endYear, serial, shortFilm, completed
    }
    
    
    // MARK: - Country
    struct Country: Codable {
        let country: String?
    }
    
    // MARK: - Genre
    struct Genre: Codable {
        let genre: String?
    }
}
