//
//  CustomExtensions.swift
//  BookList
//
//  Created by Kishlay Kishore on 29/02/24.
//

import UIKit

extension UIView {
    /**
     Set a shadow on a UIView.
     - parameters:
     - color: Shadow color, defaults to black
     - opacity: Shadow opacity, defaults to 1.0
     - offset: Shadow offset, defaults to zero
     - radius: Shadow radius, defaults to 0
     - viewCornerRadius: If the UIView has a corner radius this must be set to match
     */
    func setShadowWithColor(color: UIColor?, opacity: Float?, offset: CGSize?, radius: CGFloat, viewCornerRadius: CGFloat?) {
        layer.shadowColor = color?.cgColor ?? UIColor.black.cgColor
        layer.shadowOpacity = opacity ?? 1.0
        layer.shadowOffset = offset ?? CGSize.zero
        layer.shadowRadius = radius
        layer.cornerRadius = viewCornerRadius ?? 0
    }
}

extension UIViewController {
    
    public func setNavigationBarImage(for image: UIImage? = nil, color: UIColor = .white) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = image
            appearance.shadowColor = .clear
            appearance.backgroundColor = color
            appearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor(named: "Gray 600") ?? #colorLiteral(red: 0.1153265014, green: 0.228017509, blue: 0.3751957119, alpha: 1)]
            self.navigationController?.navigationBar.standardAppearance = appearance
            if #available(iOS 15, *) {
                self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
            }
        
    }
    
    /// MARK: BackButton
    public func setBackButton(tintColor: UIColor = .white, _ image: UIImage = UIImage(named: "ic_BackSvg")! ) {
        let btn1 = UIButton(type: .custom)
        btn1.setImage(image, for: .normal)
        btn1.imageView?.contentMode = .scaleAspectFit
        btn1.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        btn1.contentHorizontalAlignment = .left
        btn1.setTitleColor(tintColor, for: .normal)
        btn1.addTarget(self, action: #selector(self.backBtnTapAction), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        let negativeSpacer:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -16
        self.navigationItem.leftBarButtonItems = [negativeSpacer, item1]
    }
    
    @objc func backBtnTapAction(){}
    
    /// Function To Setup The Right Button Search
    func setupRightSearchNavItem() {
        let btn1 = UIButton(type: .custom)
        let imgSearch = UIImage(named: "ic_Search")
        btn1.setImage(imgSearch, for: .normal)
        btn1.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
        btn1.imageView?.contentMode = .scaleAspectFit
        btn1.frame = CGRect(x: 0, y: 0, width: 36, height: 36)
        btn1.addTarget(self, action: #selector(self.btnSearchTapAction(sender:)), for: .touchUpInside)
        
        let item1 = UIBarButtonItem(customView: btn1)
        let spacer:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        self.navigationItem.setRightBarButtonItems([spacer,item1], animated: true)
    }
    
    /// These Are The tap functions of the buttons
    /// - Parameter sender: sender type
    @objc func btnSearchTapAction(sender: UIButton){}
}
