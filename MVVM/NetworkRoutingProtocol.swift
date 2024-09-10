//
//  NetworkRoutingProtocol.swift
//  MVVM
//
//  Created by Nikita Beglov on 03.07.2024.
//

import Foundation

protocol NetworkRouting {
    func getPopularFilms(completion: @escaping (Result<Data, Error>) -> Void)
    func getFilms(_ keyword: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
    func getFilmDescription(filmId: Int, completion: @escaping (Result<Data, Error>) -> Void)
}
