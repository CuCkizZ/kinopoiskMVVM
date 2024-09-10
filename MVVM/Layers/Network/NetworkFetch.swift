//
//  NetworkFetch.swift
//  MVVM
//
//  Created by Nikita Beglov on 25.06.2024.
//

import Foundation

final class NetworkFetch: NetworkRouting {
    
    func getPopularFilms(completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = Constants.popularFilms
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [Constants.apiHeader : Constants.apiKey]
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            completion(.success(data))
        }.resume()
    }
    
    func getFilms(_ keyword: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let urlString = Constants.filmRequest + keyword
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [Constants.apiHeader : Constants.apiKey]
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(NetworkError.parseError))
                print(error)
                return
            }
            guard let data = data else { return }
            completion(.success(data))
        }.resume()
    }
    
    func getFilmDescription(filmId: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlString = Constants.filmDescription + "\(filmId)"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [Constants.apiHeader : Constants.apiKey]
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(NetworkError.parseError))
                print(error)
                return
            }
            guard let data = data else { return }
            completion(.success(data))
        }.resume()
    }
}

enum NetworkError: Error {
    case urlError
    case parseError
}
    
private enum Constants {
    static let apiHeader = "X-API-KEY"
    static let apiKey = "48be9be7-345d-4446-8f35-39a4ac9dc3cd"
    static let filmRequest: String = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword="
    static let popularFilms: String = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS"
    static let filmDescription: String = "https://kinopoiskapiunofficial.tech/api/v2.2/films/"
}
