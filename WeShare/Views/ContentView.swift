//
//  ContentView.swift
//  WeShare
//
//  Created by Fátima González on 16/04/23.
//

import SwiftUI

struct ContentView: View {
    @State var showImagePicker: Bool = false
    @StateObject var imageData = ImageData()
    
    var body: some View {
        NavigationView
        {
            ZStack
            {
                RadialGradient(stops: [
                    .init(color: Color(red: 0.64, green: 0.09, blue: 1), location: 0.3),
                                .init(color: .white, location: 0.3)
                            ], center: .top, startRadius: 200, endRadius: 490)
                                .ignoresSafeArea()
                
                VStack
                {
                    if imageData.imageNote.isEmpty
                    {
                        Text("Try adding a photo!")
                            .italic()
                            .foregroundColor(.gray)
                    }
                    
                    else
                    {
                        HomeView()
                    }
                }
                .navigationTitle("WeShare")
                
                .toolbarBackground(Color.white, for: .navigationBar)
                .toolbarColorScheme(.light, for: .navigationBar)
                
                .sheet(isPresented: $showImagePicker)
                {
                    ImagePicker(sourceType: .photoLibrary)
                    {
                        image in
                        imageData.addNote(image: image, title: "Edit me!", desc: "")
                        print("\(image.scale)")
                    }
                }
                    
                .toolbar
                {
                    ToolbarItem(placement: .navigationBarTrailing)
                    {
                        Button
                        {
                            showImagePicker.toggle()
                        } label:
                        {
                            Label("Image", systemImage: "plus")
                                .foregroundColor(.yellow)
                                .fontWeight(.bold)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing)
                    {
                        Button
                        {
                            withAnimation
                            {
                                imageData.resetUserData()
                            }
                        } label:
                        {
                            Label("Image", systemImage: "trash")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .environmentObject(imageData)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
