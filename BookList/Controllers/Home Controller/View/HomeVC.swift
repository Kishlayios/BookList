//
//  HomeVC.swift
//  BookList
//
//  Created by Kishlay Kishore on 29/02/24.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noDataView: UIView!
    
    // MARK: - Variables
    private var homeViewModel: HomeListViewModel?
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.showsCancelButton = true
        search.delegate = self
        search.placeholder = "Search by author name..."
        return search
    }()
    var isSearchBtnEnabled = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModel()
        self.registerCollectionCells()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "List"
        self.navigationController?.isNavigationBarHidden = false
        setupRightSearchNavItem()
    }
    
    // MARK: - Helper Methods
    func setupViewModel() {
        homeViewModel = HomeListViewModel()
        homeViewModel?.delegate = self
        homeViewModel?.callInitialApis()
    }
    
    func registerCollectionCells() {
        self.collectionView.register(UINib(nibName: "DisplayAuthorCell", bundle: nil), forCellWithReuseIdentifier: "DisplayAuthorCell")
    }
    
    override func btnSearchTapAction(sender: UIButton) {
        UIView.animate(withDuration: 0.3, delay: 0) {
            DispatchQueue.main.async {
                self.navigationItem.rightBarButtonItems = nil
            }
            self.isSearchBtnEnabled = true
            self.searchBar.sizeToFit()
            self.navigationItem.titleView = self.searchBar
            self.searchBar.becomeFirstResponder()
        }
    }
    
}

// MARK: - CollectionView Delegate Methods
extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if homeViewModel?.arrFilteredAuthorList.count ?? 0 > 0 {
            self.noDataView.isHidden = true
        } else {
            self.noDataView.isHidden = false
        }
        return self.homeViewModel?.arrFilteredAuthorList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DisplayAuthorCell", for: indexPath) as! DisplayAuthorCell
        let dictData = self.homeViewModel?.arrFilteredAuthorList[indexPath.row]
        cell.setupData(data: dictData)
        return cell
        
    }
}

// MARK: - CollectionView Datasource Methods
extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (self.homeViewModel?.arrFilteredAuthorList.count ?? 0) - 1 && !isSearchBtnEnabled {
            self.homeViewModel?.pageCount += 1
            self.homeViewModel?.getTheAuthorList()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = self.homeViewModel?.arrFilteredAuthorList[indexPath.row]
        guard let vc = StoryBoard.Main.instantiateViewController(withIdentifier: "BookDetailsVC") as? BookDetailsVC else {return}
        vc.receivedAuthorData = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - CollectionView DelegateFlowLayout Methods
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 32, height: 180)
    }
}

// MARK: - Search Bar Delegate Methods
extension HomeVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        //hideKeyboardWhenTappedAOutsideSearchbar()
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if self.isSearchBtnEnabled {
            self.searchBar.text = ""
            self.searchBar.resignFirstResponder()
            self.homeViewModel?.arrFilteredAuthorList = self.homeViewModel?.arrAuthorList ?? []
            UIView.animate(withDuration: 0.3) {
                self.navigationItem.titleView = nil
                self.isSearchBtnEnabled = false
                self.setupRightSearchNavItem()
                self.reloadCollection()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.homeViewModel?.arrFilteredAuthorList = self.homeViewModel?.arrAuthorList ?? []
        if !searchText.isEmpty {
            self.homeViewModel?.arrFilteredAuthorList = (self.homeViewModel?.arrAuthorList ?? []).filter({($0.author?.lowercased() ?? "").contains(searchText.lowercased())})
        }
        reloadCollection()
    }
}

// MARK: - View Model Methods
extension HomeVC: HomeListVMTrigger {
    
    func reloadCollection() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func reloadOnDataReceive() {
        self.homeViewModel?.arrFilteredAuthorList = self.homeViewModel?.arrAuthorList ?? []
        reloadCollection()
    }
    
}
