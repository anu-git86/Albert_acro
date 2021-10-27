//
//  AcronymsResultsViewModel.swift
//  Acronyms
//
//  Created by Anusha G on 10/27/21.
//

import Foundation

final class AcronymsResultsViewModel {
    
    enum Constants {
        static let errorMessage = "No Results Found"
    }
    
    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<Error> = Observable(nil)
    var searchResults: Observable<[LF]> = Observable([])
    
    func fetchSearchResults(for text: String) {
        APIManager.shared.getAcronymsResults(forText: text) { (result: Result<[APIResponseModel], Error>) in
            switch result {
            case .success(let results):
                if let values = results.first?.lfs {
                    if results.count > 0 {
                        self.searchResults.value = values
                    }
                } else {
                    self.errorMessage.value = Constants.errorMessage
                }
            case .failure(let error):
                self.error.value = error
            }
        }
        
    }
}
