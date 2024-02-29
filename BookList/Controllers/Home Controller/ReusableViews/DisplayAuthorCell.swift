//
//  DisplayAuthorCell.swift
//  BookList
//
//  Created by Kishlay Kishore on 29/02/24.
//

import UIKit
import SDWebImage

class DisplayAuthorCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgAuthor: UIImageView!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblDimensions: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.setBackViewShadow()
            self.imgAuthor.layer.cornerRadius = 16.0
        }
    }
    
    // MARK: - Helper Methods
    func setBackViewShadow() {
        self.shadowView.setShadowWithColor(color: #colorLiteral(red: 0.4862745098, green: 0.4862745098, blue: 0.4862745098, alpha: 0.4422746599), opacity: 1, offset: CGSize(width: -1, height: 2), radius: 3, viewCornerRadius: 16)
    }
    
    func setupData(data:AuthorDataModel?) {
        self.lblAuthorName.text = "Author - \(data?.author ?? "")"
        self.lblDimensions.text = "Dimension - \(data?.width ?? 0) * \(data?.height ?? 0)"
        if let url = URL(string: data?.downloadURL ?? "") {
            imgAuthor.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgAuthor.sd_setImage(with: url,placeholderImage: UIImage(named: "ic_PlaceHolder")) { image, error, cacheType, imageUrl in
                self.imgAuthor.sd_imageIndicator?.stopAnimatingIndicator()
            }
        }
    }

}
