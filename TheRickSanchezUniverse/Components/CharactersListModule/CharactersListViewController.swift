//
//  ViewController.swift
//  TheRickSanchezUniverse
//
//  Created by Ahmed MAbdelfattah on 30/05/2024.
//

import UIKit
import SwiftUI
import Combine

class CharactersListViewController: BaseViewController {
    
    private var charactersListAppState: CharactersListAppState = .loading {
        didSet {
            switch charactersListAppState {
            case .initial:
                startLoading()
            case .loading:
                startLoading()
            case .success(let charactersList):
                stopLoading()
                self.allCharacters = charactersList
                self.filteredCharacters = charactersList
                charactersListTableView.reloadData()
            case .failure:
                stopLoading()
            }
        }
    }
    private var viewModel: CharactersListViewModel
    private var allCharacters: [CharacterRepresentation] = []
    private var filteredCharacters: [CharacterRepresentation] = []
    private var cancellables = Set<AnyCancellable>()

    var charactersFilterViewModel: CharacterFilterViewModel
    let hostingController: UIHostingController<CharacterFilterWrapperView>
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Characters"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    
    init(viewModel: CharactersListViewModel, characterFilterViewModel: CharacterFilterViewModel) {
        self.viewModel = viewModel
        self.charactersFilterViewModel = characterFilterViewModel
        self.hostingController =  UIHostingController(rootView: CharacterFilterWrapperView(charactersFilterViewModel: characterFilterViewModel))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private(set) lazy var charactersListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterTableViewCell.self, forCellReuseIdentifier: CharacterTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none // Remove default separators
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        super.startLoading()
        addSubViews()
        configureConstraints()
        configureBinding()
        viewModel.getCharactersList()
    }
    
    // MARK: Private APIs
    
    private func configureBinding() {
        viewModel.stateDidUpdate = { [weak self] newState in
            guard let self = `self` else { return }
            self.charactersListAppState = newState
        }
        
    charactersFilterViewModel.$selectedStatus.sink { [weak self] selectedStatus in
        guard let self = self else { return }
        self.filterCharacters(by: selectedStatus)
        }.store(in: &cancellables)
    }
    
    private func addSubViews() {
        view.addSubview(titleLabel)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        view.addSubview(charactersListTableView)
    }
    
    
    private func configureConstraints() {
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            hostingController.view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            charactersListTableView.topAnchor.constraint(equalTo: hostingController.view.bottomAnchor, constant: 10),
            charactersListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            charactersListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            charactersListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        hostingController.didMove(toParent: self)
    }
    
    private func filterCharacters(by status: String?) {
        
        if let status = status {
            filteredCharacters = allCharacters.filter { $0.status.lowercased() == status.lowercased() }
        } else {
            filteredCharacters = allCharacters
        }
        charactersListTableView.reloadData()
    }
    
    
    
}

extension CharactersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)

            let character = filteredCharacters[indexPath.row]
            let detailView = CharacterProfileView(character: character)
            let hostingController = UIHostingController(rootView: detailView)
            self.navigationController?.pushViewController(hostingController, animated: true)
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            viewModel.fetchMoreCharacters()
        }
    }
}


extension CharactersListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch charactersListAppState {
        case .success:
            let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.reuseIdentifier) as? CharacterTableViewCell
            cell?.character = filteredCharacters[indexPath.row]
                
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 8
    }
}

