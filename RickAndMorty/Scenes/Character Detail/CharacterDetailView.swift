//
//  CharacterDetailView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 30.01.2022.
//

import SDWebImageSwiftUI
import SwiftUI

struct CharacterDetailView: View {
    @StateObject var store: CharacterDetailStore
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            BackgroundGradientView()
            
            switch (store.state, store.character) {
            case (.finished, .some(let character)):
                makeContent(for: character)
            case (.initial, _), (.loading, _), (.finished, _):
                ProgressView()
            case (.failed, _):
                Text("😢 Something went wrong")
            }
        }
        .navigationTitle(store.character?.name ?? "Loading...")
        .onFirstAppear(perform: load)
    }
}

// MARK: - UI
private extension CharacterDetailView {
    @ViewBuilder var episodes: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Episodes")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)
                .padding(.leading, 8)
            
            VStack(spacing: 8) {
                ForEach(store.episodes) { episode in
                    CharacterDetailEpisodeView(episode: episode)
                }
            }
        }
    }
    
    @ViewBuilder func makeContent(for character: Character) -> some View {
        ScrollView {
            VStack(spacing: 16) {
                WebImage(url: character.imageUrl)
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(maxWidth: .infinity)
                
                VStack(alignment: .leading, spacing: 16) {
                    makeInfo(for: character)
                    
                    episodes
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 16)
        }
    }
    
    @ViewBuilder func makeInfo(for character: Character) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Info")
                .font(.appSectionTitle)
                .foregroundColor(.appTextSectionTitle)
            
            HStack(alignment: .top) {
                VStack(alignment: .horizontalInfoAlignment, spacing: 8) {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "creditcard")
                        
                        Text(character.name)
                            .alignmentGuide(.horizontalInfoAlignment) { $0[.leading] }
                    }
                    
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "person.fill.questionmark")
                        
                        Text(character.species)
                            .alignmentGuide(.horizontalInfoAlignment) { $0[.leading] }
                    }
                    
                    if !character.type.isEmpty {
                        HStack(alignment: .top, spacing: 8) {
                            Image(systemName: "person.fill.viewfinder")
                            
                            Text(character.type)
                                .alignmentGuide(.horizontalInfoAlignment) { $0[.leading] }
                        }
                    }
                    
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "person.and.arrow.left.and.arrow.right")
                        
                        Text(character.gender)
                            .alignmentGuide(.horizontalInfoAlignment) { $0[.leading] }
                    }
                }
                
                Spacer()
                
                VStack(alignment: .horizontalInfoAlignment, spacing: 8) {
                    HStack(alignment: .top, spacing: 8) {
                        Image(systemName: "globe")
                        
                        Text(character.origin.name)
                            .multilineTextAlignment(.leading)
                            .alignmentGuide(.horizontalInfoAlignment) { $0[.leading] }
                    }
                }
                
                HStack(alignment: .top, spacing: 8) {
                    Image(systemName: "eyes")
                    
                    Text(character.location.name)
                        .multilineTextAlignment(.leading)
                        .alignmentGuide(.horizontalInfoAlignment) { $0[.leading] }
                }
            }
            .font(.appItemDescription)
        }
        .padding(.horizontal, 8)
    }
}

// MARK: - Actions
private extension CharacterDetailView {
    func load() {
        Task {
            await store.load()
        }
    }
}

// MARK: - Previews
struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(
            store: .init(providedData: .entity(.mock))
        )
    }
}