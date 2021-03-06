//
//  ContentView.swift
//  Api
//
//  Created by Shereena Sunny on 10/04/22.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
    
        .task {
            await loadData()
        }
        .task {
            DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                emptyData()
            }
        }
    }
    
    func emptyData() {
        results = []
    }
    
func loadData() async {
    guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
        print("Invalid URL")
        return
    }
    
    do {
        let (data, _) = try await URLSession.shared.data(from: url)

        if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
            results = decodedResponse.results
        }
    } catch {
        print("Invalid data")
    }
}

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
