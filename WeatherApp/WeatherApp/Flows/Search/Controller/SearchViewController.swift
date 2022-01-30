//
//  ViewController.swift
//  WeatherApp
//
//  Created by Евгений Старшов on 29.01.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let cityDecoder = CityDecoder()
    private let cityCareTaker = CityCaretaker()
    
    private var searchView: SearchCityHeaderView {
        return self.view as! SearchCityHeaderView
    }
    
    private var cities: [CityModel] = []
    private var searchResults: [CityModel] = []
    private var savedCities: [CityModel] = []
    
    private struct Constants {
        static let reuseIdentifier = "reuseID"
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchCityHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchResults = cityCareTaker.retrieveCities()
        cityDecoder.getCities { [weak self] cities in
            self?.cities = cities
        }
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(CityCell.self, forCellReuseIdentifier: Constants.reuseIdentifier)
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
        self.searchView.tableView.reloadData()
    }
    
    // MARK: - Private
    
    private func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
    }
    
    private func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
    
    private func requestCity(with query: String) {
        self.throbber(show: true)
        self.searchResults = cities.filter { $0.name == query }
        self.searchView.tableView.isHidden = false
        self.searchView.tableView.reloadData()
        self.searchView.searchBar.resignFirstResponder()
    }
    
    
    
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifier, for: indexPath)
        guard let cell = dequeuedCell as? CityCell else {
            return dequeuedCell
        }
        let city = self.searchResults[indexPath.row]
        let cellModel = CityCellModelFactory.cellModel(from: city)
        cell.configure(with: cellModel)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PickedCity.shared.cityId = searchResults[indexPath.row].id
        tableView.deselectRow(at: indexPath, animated: true)
        savedCities.append(searchResults[indexPath.row])
        cityCareTaker.save(cities: savedCities)
        let weatherDetailViewController = WeatherDetailViewController()
        navigationController?.pushViewController(weatherDetailViewController, animated: true)
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        self.requestCity(with: query)
    }
}
