//
//  Helpers.swift
//  MVVM
//
//  Created by Nikita Beglov on 30.06.2024.
//

import Foundation

func warningMessage(error: NetworkError) -> String {
    switch error {
    case .urlError:
        return "Неверная ссылка"
    case .parseError:
        return "Ничего не найдено"
    }
}
