//
//  Router.swift
//  MVVM
//
//  Created by Nikita Beglov on 02.07.2024.
//

import UIKit

final class Router: RouterProtocol {
    
    func modalPresent(from: UIViewController, filmId: Int) {
        let detailViewController = DetailsViewController(viewModel: DetailsViewModel(filmId: filmId))
        from.present(detailViewController, animated: true)
    }
}
