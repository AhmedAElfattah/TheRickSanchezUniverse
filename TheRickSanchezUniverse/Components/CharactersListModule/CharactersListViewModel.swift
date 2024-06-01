//
//  CharactersListViewModel.swift
//  TheRickSanchezUniverse
//
//  Created by Ahmed MAbdelfattah on 30/05/2024.
//

import Foundation




class CharactersListViewModel {
    
    private(set) var charactersListAppState: CharactersListAppState = .initial {
        didSet {
            DispatchQueue.main.async { [self] in
                stateDidUpdate?(self.charactersListAppState)
            }
        }
    }
    
    private var networkManager: NetworkManagerDictatable!
    private (set) var url: String = "https://rickandmortyapi.com/api/character"
    
    var stateDidUpdate: ((CharactersListAppState) -> Void)?
    
    private var currentPage = 1
    private var charactersList: [CharacterRepresentation] = []
    private var isLoading = false
    
    init(charactersListAppState: CharactersListAppState, networkManager: NetworkManagerDictatable!, stateDidUpdate: ((CharactersListAppState) -> Void)?) {
        self.charactersListAppState = charactersListAppState
        self.networkManager = networkManager
        self.stateDidUpdate = stateDidUpdate
    }
    
    func getCharactersList(with url: String = "https://rickandmortyapi.com/api/character") {
        guard !isLoading else { return }
        
        self.charactersListAppState = .loading
        fetchCharacters(with: url, page: 1)
    }
    
    func fetchMoreCharacters() {
        guard !isLoading else { return }
        
        currentPage += 1
        fetchCharacters(with: url, page: currentPage)
    }
    
    private func fetchCharacters(with url: String, page: Int) {
        isLoading = true
        networkManager.fetchCharacters(url: url, page: page, status: nil) { [weak self] networkResponse in
            guard let self = self else { return }
            self.isLoading = false
            switch networkResponse {
            case let .success(characters):
                let characterRepresentationList = characters.compactMap { CharacterRepresentation(from: $0) }
                if page == 1 {
                    self.charactersList = characterRepresentationList
                } else {
                    self.charactersList.append(contentsOf: characterRepresentationList)
                }
                self.charactersListAppState = .success(charactersList: self.charactersList)
            case let .failure(error):
                print("Error", error)
                self.charactersListAppState = .failure
            }
        }
    }
}


