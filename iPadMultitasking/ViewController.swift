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
        
        stackView.addArrangedSubview(webView)
        
        webView.load(URLRequest(url: URL(string: "https://www.google.com")!))
    }
    
    @objc func removeWebView() {
        
    }

}

