//
//  ContentView.swift
//  Shared
//
//  Created by Rafael Silva on 14/09/21.
//

import SwiftUI

struct ContentView: View {
    var planets = ["Mercurio", "Vênus", "Marte", "Jupter"]
    @ObservedObject var searchControllerProvider = SearchControllerProvider()

    var body: some View {
        NavigationView {
            List{
                ForEach(
                    planets.filter {
                        searchControllerProvider.searchText.isEmpty ||
                        $0.localizedStandardContains(searchControllerProvider.searchText)
                    },
                    id: \.self
                ) { eachPlanet in
                    NavigationLink(
                        destination: PlanetDetail(),
                        label: {
                            Text(eachPlanet)
                        }
                    )
                }
            }
           // .overlay(linkView)
            .navigationTitle("Planets")
            .navigationBarTitleDisplayMode(.inline)
            .overlay(
                ViewControllerResolver { viewController in
                    viewController.navigationItem.searchController = self.searchControllerProvider.searchController
                }
                .frame(width: 0, height: 0)
            )
            .sheet(isPresented: self.$searchControllerProvider.isShowing, content: {
                PlanetDetail()
            })
        }
    }

    private var linkView: some View {
        NavigationLink(
            destination: PlanetDetail(),
            isActive: self.$searchControllerProvider.isShowing,
            label: EmptyView().hidden
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
