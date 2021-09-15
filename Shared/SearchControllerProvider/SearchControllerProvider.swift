import Foundation
import SwiftUI

class SearchControllerProvider: NSObject, ObservableObject {
    let searchController = UISearchController(searchResultsController: nil)
    @Published var searchText: String = ""
    @Published var isShowing: Bool = false

    override init() {
        super.init()
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
    }
}

extension SearchControllerProvider: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            self.searchText = searchText
        }
    }
}

extension SearchControllerProvider: UISearchControllerDelegate {
    func presentSearchController(_ searchController: UISearchController) {
        isShowing = true
    }
}
