//
//  CharacterDetailView.swift
//  TheRickSanchezUniverse
//
//  Created by Ahmed MAbdelfattah on 31/05/2024.
//
import SwiftUI
import Combine

struct CharacterProfileView: View {
    var character: CharacterRepresentation
    
    init(character: CharacterRepresentation) {
        self.character = character
    }
    
    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                AsyncImageView(imageURL: character.image)
                    .frame(width: geometry.size.width, height: geometry.size.width)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .padding(.top, 16)
            }
            .frame(height: UIScreen.main.bounds.width)
            
            VStack(alignment: .leading, spacing: 0){
                HStack {
                    Text(character.name)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.leading, 16)
                    
                    Spacer()
                    Text(character.status)
                        .padding(8)
                        .background(Color(red: 32 / 255, green: 206 / 255, blue: 248 / 255))
                        .foregroundColor(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.trailing, 16)
                        .font(.caption)
                }
                
                HStack(spacing: 0) {
                    Text(character.species)
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .padding(.trailing, 8)
                    
                    Text("•")
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    Text(character.gender)
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                }
                .padding(.leading, 16)
                
                HStack(spacing: 0) {
                    Text("Location")
                        .foregroundColor(.black)
                        .padding(.trailing, 8)
                        .font(.system(size: 16))
                    
                    Text(":")
                        .font(.title2)
                        .foregroundColor(.black)
                    
                    Text(character.location)
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .padding(.leading, 8)
                }
                .padding(.leading, 16)
                
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Character Details")
    }
    
}

