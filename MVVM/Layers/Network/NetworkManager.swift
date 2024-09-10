//
//  NetworkService.swift
//  MVVM
//
//  Created by Nikita Beglov on 04.06.2024.
//

import Foundation
import UIKit

final class NetworkService {
    
    static let shared = NetworkService()
    private var mapper = Mapper()
    private let client: NetworkRouting = NetworkFetch()

    func getPopularFilms(completion: @escaping (Result<[Films]?, Error>) -> Void) {
        client.getPopularFilms { result in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = try JSONDecoder().decode(Movies.self, from: data)
                    completion(.success(jsonDecoder.films))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Error parse \(error)")
            }
        }
    }

    func getFilms(keyword: String, completion: @escaping (Result<[Films]?, NetworkError>) -> Void) {
        client.getFilms(keyword) { result in
            switch result {
            case .success(let data):
                do {
                    let jsonDecoder = try JSONDecoder().decode(Movies.self, from: data)
                    completion(.success(jsonDecoder.films))
                } catch {
                    completion(.failure(.parseError))
                }
            case .failure(let error):
                print("Error parse \(error)")
            }
        }
    }

    func getFilmDescription(filmId: Int, completion: @escaping (Result<FullInfo, Error>) -> Void) {
        client.getFilmDescription(filmId: filmId) { result in
            switch result {
            case .success(let data):
                do {
                    let preview = try JSONDecoder().decode(Preview.self, from: data)
                    let fullInfo = self.mapper.mapping(preview)
                    completion(.success(fullInfo))
                } catch {
                    completion(.failure(error))
                    return
                }
            case .failure(let error):
                completion(.failure(error))
                return
            }
        }
    }
}
    
    func downloadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(UIImage(data: data))
        }.resume()
    }

private enum Constants {
    static let apiHeader = "X-API-KEY"
    static let apiKey = "48be9be7-345d-4446-8f35-39a4ac9dc3cd"
    static let popularFilms: String = "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=TOP_100_POPULAR_FILMS"
    static let filmDescription: String = "https://kinopoiskapiunofficial.tech/api/v2.2/films/"
}
