//
//  ViewController.swift
//  iPadMultitasking
//
//  Created by Prudhvi Gadiraju on 5/1/19.
//  Copyright © 2019 Prudhvi Gadiraju. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    weak var activeWebView: WKWebView?

    @IBOutlet weak var urlBar: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Multibrowser"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWebView))
        
        let deleteButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeWebView))
        
        navigationItem.rightBarButtonItems = [addButton, deleteButton]
    }

    @objc func addWebView() {
        let webView = WKWebView()
        webView.navigationDelegate = self
        webView.layer.borderColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(webViewTapped))
        recognizer.delegate = self
        webView.addGestureRecognizer(recognizer)
        
        stackView.addArrangedSubview(webView)
        
        webView.load(URLRequest(url: URL(string: "https://www.google.com")!))
        
        select(webView)
        activeWebView = webView
    }
    
    func select(_ webView: WKWebView) {
        for view in stackView.arrangedSubviews {
            view.layer.borderWidth = 0
        }
        
        activeWebView = webView
        webView.layer.borderWidth = 3
        
        navigationItem.title = webView.title
    }
    
    @objc func removeWebView() {
        guard let webView = activeWebView else { return }
        if let index = stackView.arrangedSubviews.firstIndex(of: webView) {
            stackView.removeArrangedSubview(webView)
            webView.removeFromSuperview()
            
            if stackView.arrangedSubviews.count == 0 {
                title = "MultiBrowser"
            } else {
                let newViewIndex = index.advanced(by: -1)
                if let newView = stackView.arrangedSubviews[newViewIndex] as? WKWebView {
                    activeWebView = newView
                    select(newView)
                }
            }
        }
    }
    
    @objc func webViewTapped(tap: UITapGestureRecognizer) {
        if let view = tap.view as? WKWebView {
            select(view)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard textField.hasText else { return true }
        guard let text = textField.text else { return true }
        guard let webView = activeWebView else { return true }
        guard let url = URL(string: text) else { return  true }
        
        webView.load(URLRequest(url: url))
        
        textField.resignFirstResponder()
        return true
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}

