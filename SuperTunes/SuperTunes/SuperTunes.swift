//
//  ViewController.swift
//  SuperTunes
//
//  Created by Max Gabriel on 2024-07-03.
//

import UIKit

class SuperTunes: UIViewController {
    
    var searchResults = [SearchResult]()
    var hasSearched = false

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.contentInset = UIEdgeInsets(top: 51, left: 0, bottom: 0, right: 0)
        let cellNib = UINib(nibName: TableView.CellIdentifiers.ResultCell, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.ResultCell)

        }

    struct TableView {
      struct CellIdentifiers {
        static let ResultCell = "ResultCell"
      }
    }
    

}


// MARK: - Table View Delegate
extension SuperTunes: UITableViewDelegate, UITableViewDataSource {
    func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
      if !hasSearched {
        return 0
      } else if searchResults.count == 0 {
        return 1
      } else {
        return searchResults.count
      }
    }

    func tableView(
      _ tableView: UITableView,
      cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
      let cellIdentifier = TableView.CellIdentifiers.ResultCell
      let cell = tableView.dequeueReusableCell(
        withIdentifier: cellIdentifier,
        for: indexPath) as! ResultCell                  // Change this
      if searchResults.count == 0 {
        cell.nameLabel.text = "(Nothing found)"               // Change this
        cell.artistNameLabel.text = ""                        // Change this
      } else {
        let searchResult = searchResults[indexPath.row]
        cell.nameLabel.text = searchResult.name               // Change this
        cell.artistNameLabel.text = searchResult.artistName   // Change this
      }
      return cell
    }

    
    func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ) {
      tableView.deselectRow(at: indexPath, animated: true)
    }
      
    func tableView(
      _ tableView: UITableView,
      willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
      if searchResults.count == 0 {
        return nil
      } else {
        return indexPath
      }
    }


}

// MARK: - Search Bar Delegate
extension SuperTunes: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchResults = []
        for i in 0...2 {
            let searchResult = SearchResult()
             searchResult.name = String(format: "Fake Result %d for", i)
             searchResult.artistName = searchBar.text!
             searchResults.append(searchResult)
        }
      hasSearched = true
      tableView.reloadData()
    }

}

// MARK: - UIBarPositioningDelegate
extension SuperTunes: UIBarPositioningDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
