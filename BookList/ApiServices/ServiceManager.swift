//
//  ServiceManager.swift
//  BookList
//
//  Created by Kishlay Kishore on 29/02/24.
//

import Foundation
import UIKit

class ServiceManager {
    
    // MARK: - Variables
    public static let shared = ServiceManager()
    
    public let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 72, height:72))
        aiv.hidesWhenStopped = true
        aiv.backgroundColor = .lightGray
        aiv.color = .black
        aiv.style = UIActivityIndicatorView.Style.large
        aiv.center = AppDel.window?.center ?? CGPoint(x: 0, y: 50)
        return aiv
    }()
    
    // MARK: - Method To Fetch data From Server
    
    func callGetService(urlStr: String, queryParams: [String: Any] = [:], onSuccess: @escaping((Data) -> Void),onFailure: @escaping((Error) -> Void)) {
        
        activityIndicatorView.startAnimating()
        AppDel.window?.addSubview(activityIndicatorView)
        
        let urlString = "\(Constants.baseUrl)\(urlStr)"
        var param = queryParams
        var components = URLComponents(string: urlString)!
        components.queryItems = param.map { (key, value) in
            URLQueryItem(name: key, value: value as? String)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.cachePolicy = .reloadIgnoringCacheData
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        debugPrint("URL:-",components)
        debugPrint("QueryParam:-",param)
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 5.0
        sessionConfig.timeoutIntervalForResource = 30.0
        sessionConfig.waitsForConnectivity = true
        let session = URLSession(configuration: sessionConfig)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                guard error == nil else {
                    self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.removeFromSuperview()
                    onFailure(error ?? NSError(domain: "", code: 401,userInfo: [NSLocalizedDescriptionKey: "Error"]))
                    return
                }
                let status = httpResponse.statusCode
                if status == 200 {
                    if let data = data {
                        DispatchQueue.main.async {
                            self.activityIndicatorView.stopAnimating()
                            self.activityIndicatorView.removeFromSuperview()
                        }
                        onSuccess(data)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.activityIndicatorView.stopAnimating()
                        self.activityIndicatorView.removeFromSuperview()
                    }
                    onFailure(error ?? NSError(domain: "", code: 401,userInfo: [NSLocalizedDescriptionKey: "Error"]))
                }
            }
        }
        task.resume()
    }
}

// MARK: - Method To handel Failure
extension ServiceManager {
    func executeFailureBlock(title:String = "Error", message:String = Constants.common_error_msg) {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.removeFromSuperview()
            let alert = UIAlertController(title: title, message:message , preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            AppDel.window?.rootViewController?.present(alert,animated: true,completion: nil )
        }
    }
}
