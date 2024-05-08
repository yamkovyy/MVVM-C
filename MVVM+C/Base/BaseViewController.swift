//
//  BaseViewController.swift
//  exercise
//
//  Created by viamkovyi on 2024-03-10.
//

import UIKit

typealias ViewController = BaseViewController
class BaseViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
