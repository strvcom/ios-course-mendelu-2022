//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Jan Kaltoun on 29.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            CharactersListView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .foregroundColor(.appTextBody)
        .preferredColorScheme(.none)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
