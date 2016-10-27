//
//  BenchmarkWODViewController.swift
//  WOD Guide
//
//  Created by William Mahoney on 11/29/15.
//  Copyright © 2015 William Mahoney. All rights reserved.
//



import UIKit
import Foundation

class BenchmarkWODViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var WodList = [WOD]()
    var FilteredWodList = [WOD]()
    var Keyword = ""
    var searchController : UISearchController?
    
    @IBAction func backButton(sender: AnyObject) {
    _ = self.navigationController?.popViewController(animated: true)
    }

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for wodData in BenchmarkWODs().library {
            let wod = WOD(dictionary: wodData)
            WodList.append(wod)
        }
        
        // Search Bar
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController?.searchBar.autocapitalizationType = .none
        self.tableView.tableHeaderView = self.searchController?.searchBar
        self.searchController?.searchResultsUpdater = self
        self.Keyword = ""
        definesPresentationContext = true
        searchController?.dimsBackgroundDuringPresentation = false
        searchController?.hidesNavigationBarDuringPresentation = false
        
        self.filterByName()
        
        searchController?.searchBar.scopeButtonTitles = ["All", "Old Girls", "New Girls"]
        searchController?.searchBar.delegate = self
        searchController?.searchBar.tintColor = UIColor.black
        
        self.filterByScope()
    }

    
    
    func filterByScope(){
        let scope = searchController!.searchBar.scopeButtonTitles![searchController!.searchBar.selectedScopeButtonIndex]
        let scopeString: String = scope
        self.FilteredWodList = self.WodList.filter({ (wod: WOD) -> Bool in
            if scopeString == "All" {
                return true
            }
            
            if let _=wod.typeOfGirl?.lowercased().range(of: scopeString.lowercased()) {
                return true
            }
            return false
        })
    }
    
    func filterByName(){
        self.FilteredWodList = self.FilteredWodList.filter({ (wod: WOD) -> Bool in
            if self.Keyword.characters.count == 0 {
                return true
            }
            
            if (wod.name?.lowercased().range(of: self.Keyword.lowercased())) != nil {
                return true
            }
            return false
        })
    }

    
    // Search Bar Function
    
    func updateSearchResults(for searchController: UISearchController) {
        Keyword = searchController.searchBar.text!
        self.filterByScope()
        self.filterByName()
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        Keyword = self.searchController?.searchBar.text ?? ""
        self.filterByScope()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.FilteredWodList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BenchmarkCell", for: indexPath) as UITableViewCell
        let wod = self.FilteredWodList[indexPath.row]
        
        if let wodName = wod.name {
            cell.textLabel?.text = wodName
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showBenchmarkDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        let wod = FilteredWodList[index]
        
        if segue.identifier == "showBenchmarkDetail" {
            let controller = segue.destination as? BenchmarkWODDetailView
            if let indexPath = self.tableView.indexPathForSelectedRow
                
            {
                
                
                let wod = FilteredWodList[indexPath.row]
                controller?.nameText = wod.name ?? ""
                controller?.descriptionText = wod.description ?? ""
                controller?.exerciseText = wod.exercise ?? ""
            }
            
            
            
            
        }
    }
}
