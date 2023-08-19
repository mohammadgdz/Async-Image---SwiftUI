//
//  ContentView.swift
//  Async Image
//
//  Created by Mohammad on 2023-08-19.
//

import SwiftUI


extension Image {
    func imageModifier () -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
    func iconModifier () -> some View {
        self
            .imageModifier()
            .frame(maxWidth: 128)
            .foregroundColor(.purple)
        .opacity(0.6)
    }
}

struct ContentView: View {
    
    
    private let imageURl = "https://credo.academy/credo-academy@3x.png"
    
    
    
    var body: some View {
        // MARK: - 1.Basic
//        AsyncImage(url: URL(string: imageURl))
        
        //MARK: - 2. Scale
//        AsyncImage(url: URL(string: imageURl), scale: 3.0)
        
        //MARK: - 3. Placeholder
        /*AsyncImage(url: URL(string: imageURl)) { image in
            image.imageModifier()
                
        } placeholder: {
                Image(systemName: "photo.circle.fill").iconModifier()
        }
        .padding(40)*/
        
        //MARK: - 4. Phase
        /*AsyncImage(url: URL(string: imageURl)) { phase in
            // Success : The image successfully loaded
            // Failure : the image failed to load with an error
            // Empty : No image is loaded
            
            if let image = phase.image {
                image.imageModifier()
            } else if phase.error != nil {
                Image(systemName: "ant.circle.fill").iconModifier()
            } else {
                Image(systemName: "photo.circle.fill").iconModifier()
            }
        }
        .padding(40)*/
        
        //MARK: - 4. Animation
        
        AsyncImage(url: URL(string: imageURl), transaction: Transaction(animation: .spring(response: 0.5,dampingFraction: 0.6,blendDuration: 0.25))) { phase in
            switch phase {
            case .success(let image):
                image
                    .imageModifier()
                    .transition(.scale)
            case .failure(_):
                Image(systemName: "ant.circle.fill").iconModifier()
                
            case .empty:
                Image(systemName: "photo.circle.fill").iconModifier()
                
            @unknown default:
                ProgressView()
            }
            
            
        }
        .padding(40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
