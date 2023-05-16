//
//  NoteDetailView.swift
//  WeShare
//
//  Created by Fátima González on 16/04/23.
//

import SwiftUI

struct NoteDetailView: View
{
    @EnvironmentObject var imageData: ImageData
    @State var note: ImageNote
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedColor = Color.black
    
    var body: some View
    {
        Form
        {
            Section
            {
                HStack
                {
                    Spacer()
                    Image(uiImage: UIImage(data: note.image)!)
                        .resizable()
                        .frame(width: 300, height: 300, alignment: .center)
                    
                    Spacer()
                }
                
                TextField("Write your title!", text: $note.title)
                    .textSelection(.enabled)
                    .onTapGesture
                {
                    note.title = ""
                }
                .font(.title)
                .foregroundColor(Color(red: 0.64, green: 0.09, blue: 1))
                
                ZStack
                {
                    TextEditor(text: $note.description)
                        .textSelection(.enabled)
                        .frame(height: 200)
                    
                    VStack
                    {
                        Spacer()
                        HStack
                        {
                            Spacer()
                            Text("\(note.description.count) / 120")
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                }
                
                HStack
                {
                    Spacer()
                    Button("Confirm changes")
                    {
                        imageData.editNote(id: note.id, title: note.title, description: note.description)
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(Color(red: 0.64, green: 0.09, blue: 1))
                    .fontWeight(.bold)
                    .buttonStyle(.bordered)
                    Spacer()
                }
            }
            
            Section
            {
                VStack
                {
                    HStack
                    {
                        ColorPicker("Select the color to know which one is it:", selection: $selectedColor)
                            .foregroundColor(Color(red: 0.64, green: 0.09, blue: 1))
                            .frame(width: 280, height: 50)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    Spacer()
                    Spacer()
                    
                    HStack
                    {
                        Text("The color is: ")
                        Text(selectedColor.toName() ?? "– None –")
                        
                        ZStack
                        {
                            Circle()
                                .fill(.black)
                                .frame(width: 22, height: 22)
                            Circle()
                                .fill(selectedColor)
                                .frame(width: 20, height: 20)
                        }
                        
                        Spacer()
                    }
                }
            }
        }
    }
}

extension Color
{
    func toName() -> String?
    {
        let uiColor = UIColor(self)

        guard let components = uiColor.cgColor.components, components.count >= 3 else
        {
            return nil
        }

        let redTemp = Float(components[0])
        let greenTemp = Float(components[1])
        let blueTemp = Float(components[2])

        let red = (redTemp * 1000).rounded() / 1000
        let green = (greenTemp * 1000).rounded() / 1000
        let blue = (blueTemp * 1000).rounded() / 1000

        if(red == 1 && green == 1 && blue == 1 && Float(components[3]) == 1)
        {
            return "white"
        }

        if(red == 0 && green == 0 && blue == 0)
        {
            return "black"
        }

        if(red == green && green == blue)
        {
            return "gray"
        }

        switch red
        {
        case 0.6..<1:
                switch green
                {
                    case 0..<0.3:
                        switch blue
                        {
                            case 0..<0.250980:
                                return "red"

                        case 0.250980..<0.501961:
                                return "torch red"

                        case 0.250980..<0.749019:
                                return "pink"

                            case 0.749019..<1:
                                return "pink"

                            case 1:
                                return "fuchsia"

                            default:
                                return nil
                        }

                    case 0.3..<0.501961:
                        if(blue >= 0)
                        {
                            return "orange-red"
                        }
                        else
                        {
                            return nil
                        }

                    case 0.501961..<0.749019:
                        if(green > 0.56 && blue > 0.95)
                        {
                            return "pink"
                        }
                        if(green <= 0.56 && blue > 0.95)
                        {
                            return "purple"
                        }
                        else
                        {
                            return "orange"
                        }

                    case 0.749019..<1:
                        if(red > 0.87 && blue >= 0.7 && blue < 0.87)
                        {
                            return "yellow"
                        }
                        if(red > 0.87 && blue >= 0 && blue < 0.7)
                        {
                            return "peach"
                        }
                        if(red <= 0.87 && blue >= 0.87 && blue <= 1)
                        {
                            return "baby blue"
                        }
                        else
                        {
                            return "green"
                        }

                    case 1:
                        if(blue >= 0)
                        {
                            return "yellow"
                        }
                        else
                        {
                            return nil
                        }

                    default:
                        return nil
                }

            case 0.256..<0.6:
                if(green <= 1 && green > 0.71 && blue >= 0 && blue < 0.8235)
                {
                    return "green"
                }
                if(blue <= 1 && blue > 0.71 && green >= 0 && green < 0.8235)
                {
                    return "blue"
                }
                if(blue <= 1 && blue > 0.71 && green <= 1 && green >= 0.8235)
                {
                    return "blue"
                }
                if(green >= 0 && green <= 0.3922 && blue <= 1 && blue > 0.58)
                {
                    return "dark purple"
                }
                if(green >= 0 && green <= 0.3922 && blue <= 0.58 && blue >= 0)
                {
                    return "dark red"
                }
                else
                {
                    return "black"
                }


            case 0..<0.256:
                if(green <= 1 && green > 0.24 && blue < 0.506)
                {
                    return "green"
                }
            if(green <= 0.749 && blue > 0.2 && blue <= 0.6)
                {
                    return "blue"
                }
                if(green <= 0.5 && blue > 0 && blue <= 1)
                {
                    return "purple"
                }
                if(green >= 0.16 && blue <= 0.2)
                {
                    return "green"
                }
                else
                {
                    return "black"
                }

                default:
                   return nil
        }
    }
}

struct NoteDetailView_Previews: PreviewProvider
{
    static var previews: some View
    {
        let tempImage = UIImage(systemName: "map")?.pngData()
        
        NoteDetailView(note: ImageNote(id: UUID(), image: tempImage!, title: "New note", description: "Text description"))
        
            .environmentObject(ImageData())
    }
}
