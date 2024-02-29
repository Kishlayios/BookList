//
//  HomeVC.swift
//  BookList
//
//  Created by Kishlay Kishore on 29/02/24.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var selectCurrency: UIControl!
    @IBOutlet weak var lblCurrency: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noDataView: UIView!
    
    // MARK: - Variables
    var refreshControl = UIRefreshControl()
    private var homeViewModel: HomeListViewModel?
    
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
    }
    
    // MARK: - Helper Methods
    func setupViewModel() {
        homeViewModel = HomeListViewModel()
        homeViewModel?.delegate = self
        homeViewModel?.callInitials()
    }
    
    func registerCollectionCells() {
        self.collectionView.register(UINib(nibName: "DisplayAuthorCell", bundle: nil), forCellWithReuseIdentifier: "DisplayAuthorCell")
    }

}

// MARK: - CollectionView Delegate Methods
extension HomeVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.homeViewModel?.arrSortedCurrencyKeys.count ?? 0 > 0 {
            self.noDataView.isHidden = true
        } else {
            self.noDataView.isHidden = false
        }
        return self.homeViewModel?.arrSortedCurrencyKeys.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DisplayAuthorCell", for: indexPath) as! DisplayAuthorCell
        let currentKey = self.homeViewModel?.arrSortedCurrencyKeys[indexPath.row] ?? ""
        cell.lblCurrencyName.text = currentKey
        cell.lblCurrencyAmout.text = "\(self.homeViewModel?.convert(amount: Double(self.txtAmount.text ?? "0.0") ?? 0, from: self.selectedCurrency, to: currentKey) ?? 0)"
        return cell
        
    }
}

// MARK: - CollectionView Datasource Methods
extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //code
    }
}

// MARK: - CollectionView DelegateFlowLayout Methods
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 2) - 40, height: 80)
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
        reloadCollection()
    }
    
}
