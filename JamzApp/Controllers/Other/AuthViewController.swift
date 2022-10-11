//
//  AuthViewController.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 10/11/22.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate  {

    private let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: config)
        return webView
    }()
    
    public var completionHandler: ((Bool) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        view.addSubview(webView)
        guard let url = AuthManager.shared.signInURL else {
            return
        }
        webView.load(URLRequest(url: url))
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
   
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }
        //exchange the code for access token
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code" })?.value
        else {
            return
        }
        
        webView.isHidden = true
        
        print("Code: \(code)")
        AuthManager.shared.exchangeCodeForToken(code: code) { [weak self] success in DispatchQueue.main.async {
            let mainAppTabBarVC = TabBarViewController()
            mainAppTabBarVC.modalPresentationStyle = .fullScreen
            self?.present(mainAppTabBarVC, animated: true)
           // self?.navigationController?.pop
        //    popToRootViewController(animated: true)
//            self?.performSegue(withIdentifier: "loggedinsegue", sender: nil)
            self?.completionHandler?(success)
        }
            
        }
    }
    
}

