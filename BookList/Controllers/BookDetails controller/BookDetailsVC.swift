//
//  BookDetailsVC.swift
//  BookList
//
//  Created by Kishlay Kishore on 29/02/24.
//

import UIKit
import SDWebImage

class BookDetailsVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var imgAuthor: UIImageView!
    
    // MARK: - Variables
    var receivedAuthorData: AuthorDataModel?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTheImage()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "ID - \(receivedAuthorData?.id ?? "")"
        self.navigationController?.isNavigationBarHidden = false
        setBackButton(tintColor: .black)
        setNavigationBarImage(for: UIImage(), color: .white)
    }
    
    override func backBtnTapAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Functions
    private func loadTheImage() {
        if let url = URL(string: receivedAuthorData?.downloadURL ?? "") {
            imgAuthor.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgAuthor.sd_setImage(with: url,placeholderImage: UIImage(named: "ic_PlaceHolder")) { image, error, cacheType, imageUrl in
                self.imgAuthor.sd_imageIndicator?.stopAnimatingIndicator()
            }
        }
    }
    
}
