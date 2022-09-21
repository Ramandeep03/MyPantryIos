//
//  AnalyticEvents.swift
//  MyPantry
//
//  Created by Ramandeep Singh on 21/09/22.
//

import Foundation

enum AnalyticEvent: Equatable {
    case homeScreenViewed
    case addScreenViewd
    case updateScreenViewed
case itemAdded(name: String)
case itemUpdated(name: String)
case filterSelected(name: String)
}

enum Parameter: String, Equatable{
    case itemName
    case filterName
}

extension AnalyticEvent{
    var parameters: [Parameter: String]{
        switch self{
        case .homeScreenViewed,
                .addScreenViewd,
                .updateScreenViewed:
            return[:]
        case let .itemAdded(name):
            return [.itemName: name]
        case let .itemUpdated(name):
            return [.itemName: name]
        case let .filterSelected(name):
            return [.itemName: name]
        }
    }
}
