//
//  CharacterTableViewCell.swift
//  TheRickSanchezUniverse
//
//  Created by Ahmed MAbdelfattah on 30/05/2024.
//

import UIKit
import SwiftUI

class CharacterTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CharacterTableViewCell"
    
    private var hostingController: UIHostingController<AsyncImageView>?
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private lazy var speciesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        return label
    }()
    
    private lazy var characterInforStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, speciesLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var containterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [characterInforStackView])
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(containterStackView)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 0.6
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    var character: CharacterRepresentation? {
        didSet {
            updateUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        contentView.addSubview(containerView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hostingController?.view.removeFromSuperview()
        hostingController = nil
        nameLabel.text = nil
        speciesLabel.text = nil
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            containterStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            containterStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 16),
            containterStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 16),
            containterStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
        ])
    }
    
    private func updateUI() {
        guard let character = character else { return }
        nameLabel.text = character.name
        speciesLabel.text = character.species
        
        let asyncImageView = AsyncImageView(imageURL: character.image)
        let hostingController = UIHostingController(rootView: asyncImageView)
        self.hostingController = hostingController
        
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.heightAnchor.constraint(equalToConstant: 70),
            hostingController.view.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        
        hostingController.view.layer.cornerRadius = 10
        hostingController.view.layer.masksToBounds = true
        hostingController.view.backgroundColor = .clear
        
        containterStackView.insertArrangedSubview(hostingController.view, at: 0)
    }
}
