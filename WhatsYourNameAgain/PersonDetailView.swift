//
//  PersonDetailView.swift
//  WhatsYourNameAgain
//
//  Created by Marcus Benoit on 28.07.24.
//

import SwiftUI
import MapKit
import CoreLocation

struct PersonDetailView: View {
    @Bindable var person: Person
    
    @State private var showEditSheet = false
    
    let locationFetcher = LocationFetcher()
    
    var body: some View {
        ScrollView {
            if let imageData = person.photo, let uiImage = UIImage(data: imageData) {
                
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
            }
            
            Section {
                Text(person.name)
                    .font(.title)
            }
            
            
            
            Section("Facts:") {
                Text(person.factsAboutPerson)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            .padding()
            
            if let startPosition = person.coordinatesOfMeeting {
                let location = MapCameraPosition.region(
                    MKCoordinateRegion(
                        center: CLLocationCoordinate2D(latitude: startPosition.latitude, longitude: startPosition.longitude),
                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                    )
                )
                
                
                Map(initialPosition: location)
            }
        }
        .background(LinearGradient(colors: [.red, .blue], startPoint: .top, endPoint: .bottom))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Edit") {
                showEditSheet.toggle()
            }
        }
        .sheet(isPresented: $showEditSheet, content: {
            EditPersonView(person: person)
        })
    }
}

//#Preview {
//    PersonDetailView()
//}
