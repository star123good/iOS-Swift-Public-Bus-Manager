//
//  BusListViewController.swift
//  Public Bus Manager
//
//  Created by Boss on 2019/12/25.
//  Copyright © 2019 Boss. All rights reserved.
//

import UIKit

class BusListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var busStopListLabel: UILabel!
    @IBOutlet weak var busStopTableView: UITableView!
    @IBOutlet weak var busStopSearchBar: UISearchBar!
    
    var busStopList : [BusStopModel]!
    var filteredData : [BusStopModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        busStopTableView.dataSource = self
        busStopTableView.delegate = self
        
        busStopList = BusStopDataSetService.instance.getBusStopList()
        filteredData = busStopList
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BusStopTableViewCell") as? BusStopTableViewCell {
            let busStop = filteredData[indexPath.row]
            cell.updateViews(busStop: busStop)
            return cell
        }
        else{
            return BusStopTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let busStop = filteredData[indexPath.row]
        performSegue(withIdentifier: "showMapkitFromListSegue", sender: busStop)
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? busStopList : busStopList.filter { (item: BusStopModel) -> Bool in
            // If dataItem matches the searchText, return true to include it
            return item.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        busStopTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let mapkitViewController = segue.destination as? MapkitViewController {
            mapkitViewController.busStopModel = sender as? BusStopModel
        }
    }
    
}
