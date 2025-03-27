//
//  NomadsTravelApp.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI
import SwiftData

@main
struct NomadsTravelApp: App {
	@AppStorage(Constants.selectedTabKey) var selectedTab: Int = 0
	
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
			Destination.self, Tag.self,
        ])
        
		let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
		WindowGroup {
			TabView(selection: $selectedTab) {
				Tab("All Destinations", systemImage: "airplane", value: 0) {
					AllDestinationsView()
				}
				
				Tab("Tags", systemImage: "tag", value: 1) {
					Text("Tags List Goes Here...")
				}
			}
			.tabViewStyle(.tabBarOnly)
		}
        .modelContainer(sharedModelContainer)
    }
}
