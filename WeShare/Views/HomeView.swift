//
//  HomeView.swift
//  WeShare
//
//  Created by Fátima González on 16/04/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var imageData: ImageData
    
    var body: some View
    {
        List
        {
            ForEach(imageData.imageNote)
            {
                note in
                
                NavigationLink(destination: NoteDetailView(note: note))
                {
                    HStack
                    {
                        Image(uiImage: UIImage(data: note.image)!)
                            .resizable()
                            .frame(width: 50, height: 50, alignment: .center)
                        
                        VStack(alignment: .leading)
                        {
                            Text(note.title)
                                .lineLimit(2)
                        }
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(RadialGradient(stops: [
            .init(color: Color(red: 0.64, green: 0.09, blue: 1), location: 0.3),
                        .init(color: .white, location: 0.3)
                    ], center: .top, startRadius: 200, endRadius: 490))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ImageData())
    }
}
