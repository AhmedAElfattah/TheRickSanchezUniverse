//
//  BaseViewController.swift
//  TheRickSanchezUniverse
//
//  Created by Ahmed MAbdelfattah on 30/05/2024.
//

import Foundation
import UIKit


class BaseViewController: UIViewController {
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingIndicator = UIActivityIndicatorView(frame: .init(origin: .zero, size: .init(width: 50, height: 50)))
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.isHidden = true
        return loadingIndicator
    }()
    
    func startLoading() {
        loadingIndicator.isHidden = false
        loadingIndicator.startAnimating()
    }
    
    func stopLoading() {
        loadingIndicator.isHidden = true
        loadingIndicator.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureConstraints()
        startLoading()
    }
    
    private func addSubViews() {
        view.addSubview(loadingIndicator)
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
