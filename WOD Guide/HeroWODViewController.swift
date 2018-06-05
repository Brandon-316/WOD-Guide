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
    
    var heightOfHeader = 25
    
    //PopUpView//
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var checkSquatBtn: UIButton!
    @IBOutlet weak var checkCleanBtn: UIButton!
    @IBOutlet weak var checkSnatchBtn: UIButton!
    @IBOutlet weak var checkRunBtn: UIButton!
    @IBOutlet weak var checkKettlebell: UIButton!
    @IBOutlet weak var checkRopeBtn: UIButton!
    @IBOutlet weak var checkJRopeBtn: UIButton!
    @IBOutlet weak var checkRowBtn: UIButton!
    @IBOutlet weak var checkBikeBtn: UIButton!
    @IBOutlet weak var checkDeadliftBtn: UIButton!
    
    @IBAction func checkMark(_ btn: UIButton) {
        let uncheckedBox = UIImage(named: "UncheckedBox.png")
        let checkedBox = UIImage(named: "CheckedBox.png")
        
        if btn.currentImage != checkedBox {
            btn.setImage(checkedBox, for: .normal)
        }else{
            btn.setImage(uncheckedBox, for: .normal)
        }
        setFilteredWodList()
        filterByScope()
        self.tableView.reloadData()
        checkExercises()
    }
    
    @IBAction func backButton(sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneWtPopUpBtn(_ sender: Any) {
        removePopUpView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for wodData in HeroWODs().library {
            let wod = HeroWOD(dictionary: wodData)
            wodList.append(wod)
        }
        


        // Search Bar
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController?.searchBar.autocapitalizationType = .none
        
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = self.searchController
            self.navigationItem.hidesSearchBarWhenScrolling = false
            
        } else {
            self.tableView.tableHeaderView = self.searchController?.searchBar
        }
        //        self.tableView.tableHeaderView = self.searchController?.searchBar
        
        
        self.searchController?.searchResultsUpdater = self
        self.Keyword = ""
        definesPresentationContext = true
        searchController?.dimsBackgroundDuringPresentation = false
        searchController?.hidesNavigationBarDuringPresentation = false

        self.filterByName()
        
        searchController?.searchBar.scopeButtonTitles = ["All", "AMRAP", "For Time", "For Load"]
        searchController?.searchBar.delegate = self
        searchController?.searchBar.tintColor = UIColor.black
        
        self.filterByScope()
        
        setFilteredWodList()
        
    }
    


//Set FilteredWodList//
    func setFilteredWodList() {
        self.FilteredWodList = self.wodList
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
            if self.Keyword.count == 0 {
                return true
            }
            
            if (wod.name?.lowercased().range(of: self.Keyword.lowercased())) != nil {
                return true
            }
            return false
        })
    }
    

    //Filter By Exercise//
    func checkExercises() {
        let checkedBox = UIImage(named: "CheckedBox.png")
        let exercises = [checkSquatBtn, checkRowBtn, checkRunBtn, checkBikeBtn, checkCleanBtn, checkSnatchBtn, checkKettlebell, checkRopeBtn, checkDeadliftBtn, checkJRopeBtn]
        
        for exercise in exercises {
            if exercise?.currentImage == checkedBox {
                filterExercise(exerciseBtn: exercise!)
                }
            }
    }
    
    
    func filterExercise(exerciseBtn: UIButton) {
        var searchString = ""
        
        switch exerciseBtn {
        case _ where exerciseBtn == checkSquatBtn: searchString = "squat"
        case _ where exerciseBtn == checkCleanBtn: searchString = "clean"
        case _ where exerciseBtn == checkSnatchBtn: searchString = "snatch"
        case _ where exerciseBtn == checkRunBtn: searchString = "run"
        case _ where exerciseBtn == checkKettlebell: searchString = "kettlebell"
        case _ where exerciseBtn == checkRopeBtn: searchString = "rope climb"
        case _ where exerciseBtn == checkJRopeBtn: searchString = "double unders"
        case _ where exerciseBtn == checkRowBtn: searchString = "row"
        case _ where exerciseBtn == checkBikeBtn: searchString = "bike"
        case _ where exerciseBtn == checkDeadliftBtn: searchString = "deadlift"
            
        default: searchString = ""
        }
        
        self.FilteredWodList = self.FilteredWodList.filter({ (wod: HeroWOD) -> Bool in
            
            if let _=wod.exercise?.lowercased().range(of: searchString.lowercased()) {
                return true
            }
            return false
        })
        self.tableView.reloadData()
    }
    
    
    
    // Search Bar Function
    func updateSearchResults(for searchController: UISearchController) {
        Keyword = searchController.searchBar.text!
        self.filterByScope()
        self.checkExercises()
        self.filterByName()
        self.tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        Keyword = self.searchController?.searchBar.text ?? ""
        self.filterByScope()
        self.checkExercises()
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
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.frame = CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: heightOfHeader)
        header.backgroundColor = UIColor.purple
        
        let btn = UIButton(type: UIButtonType.custom) as UIButton
        btn.frame = CGRect(x: header.frame.origin.x, y: header.frame.origin.y, width: header.frame.width, height: header.frame.height)
        btn.addTarget(self, action: #selector(HeroWODViewController.addPopUpView), for: .touchUpInside)
        btn.setTitle("Exercise Filters +", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.backgroundColor = UIColor.gray
        btn.isUserInteractionEnabled = true
        
        header.addSubview(btn)

        return header
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(heightOfHeader)
    }
    
    
    @objc func addPopUpView() {
        self.view.addSubview(popUpView)
        popUpView.center = view.center
        
        popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        popUpView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.popUpView.alpha = 1
            self.popUpView.transform = CGAffineTransform.identity
        }
    }
    
    func removePopUpView () {
        UIView.animate(withDuration: 0.3, animations: {
            self.popUpView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.popUpView.alpha = 0
            
        }) { (success:Bool) in
            self.popUpView.removeFromSuperview()
        }
    }
    
    func tappedCheckMark(btn: UIButton) {
        let uncheckedBox = UIImage(named: "UncheckedBox.png")
        let checkedBox = UIImage(named: "CheckedBox.png")
        
        if btn.currentImage == uncheckedBox {
            btn.setImage(checkedBox, for: .normal)
        }else if btn.currentImage == checkedBox {
            btn.setImage(uncheckedBox, for: .normal)
        }        
    }
    
    
}
