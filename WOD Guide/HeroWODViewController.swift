//
//  HeroWODViewController.swift
//  WOD Guide
//
//  Created by William Mahoney on 11/29/15.
//  Copyright © 2015 William Mahoney. All rights reserved.
//

import UIKit
import Foundation

class HeroWODViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {

    var wodList = [HeroWOD]()
    var FilteredWodList = [HeroWOD]()
    var Keyword = ""
    var searchController : UISearchController?
    
    @IBAction func backButton(sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for wodData in HeroWODs().library {
            let wod = HeroWOD(dictionary: wodData)
            wodList.append(wod)
        }
        
//        var headerView:UIView = UIView(frame: CGRectMake(0, 0, view.size.width, tableView.size.wid))
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = UIColor.green
        button.setTitle("Test Button", for: .normal)
//        button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
//        headerView.addSubview(button)
//        self.view.addSubview(button)

        
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
        
        searchController?.searchBar.scopeButtonTitles = ["All", "AMRAP", "For Time", "For Load"]
        searchController?.searchBar.delegate = self
        searchController?.searchBar.tintColor = UIColor.black
        
//        searchController?.searchBar.showsSearchResultsButton = true
//        http://stackoverflow.com/questions/20791577/adding-uibutton-to-uitableview-section-header

        self.filterByScope()
        
//        if searchController?.active == true {
//            
//        }
        
        

    }
    


    
    func filterByScope(){
        let scope = searchController!.searchBar.scopeButtonTitles![searchController!.searchBar.selectedScopeButtonIndex]
        let scopeString: String = scope
        self.FilteredWodList = self.wodList.filter({ (wod: HeroWOD) -> Bool in
            if scopeString == "All" {
                return true
            }
            
            if let _=wod.description?.lowercased().range(of: scopeString.lowercased()) {
                return true
            }
            return false
        })
    }
    
    func filterByName(){
        self.FilteredWodList = self.FilteredWodList.filter({ (wod: HeroWOD) -> Bool in
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as UITableViewCell
        let wod = self.FilteredWodList[indexPath.row]
        
        if let wodName = wod.name {
            cell.textLabel?.text = wodName
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showHeroDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHeroDetail" {
            let controller = segue.destination as? HeroWODDetailView
            if let indexPath = self.tableView.indexPathForSelectedRow
                
            {
                
                
                let wod = FilteredWodList[indexPath.row]
                controller?.heroWODImage = wod.image ?? ""
                controller?.nameText = wod.name ?? ""
                controller?.descriptionText = wod.description ?? ""
                controller?.exerciseText = wod.exercise ?? ""
                controller?.aboutText = wod.about ?? ""
            }
            
            
            
            
        }     
    }
}
