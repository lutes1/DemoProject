//
//  ImageImportView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import SwiftUI

struct ImageImportView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var image: UIImage?
    @State var imageResource = "https://pngimg.com/uploads/earth/earth_PNG21.png"
    @State var showloadingIndicator = false
    @State var isErrorAlertVisible = false
    @State var errorMessage = ""
    var onSubmit: (UIImage) -> ()
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text("Enter your image url below")
                        .font(.title.bold())
                    
                    TextField("add in your png image url...", text: $imageResource)
                        .frame(width: 400, height: 50)
                        .padding(.horizontal)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.accentColor, lineWidth: 2)
                        )
                        .onSubmit {
                            loadImage()
                        }
                }
                Spacer()
            }
            .padding(.top, 100)
            Spacer()
            
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400, alignment: .center)
                    .padding(.horizontal)
            }
            
            if showloadingIndicator {
                ProgressView()
            }
            
            Spacer()
            
            Button("Submit") {
                guard let image = self.image else {
                    isErrorAlertVisible = true
                    errorMessage = "Please provide a valid PNG image link"
                    return
                }
                
                onSubmit(image)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .alert(isPresented: $isErrorAlertVisible) {
            Alert(title: Text(errorMessage))
        }
        .padding()
    }
    
    private func loadImage() {
        showloadingIndicator = true
        
        DispatchQueue.global().async {
            defer {
                DispatchQueue.main.async {
                    showloadingIndicator = false
                }
            }
            
            guard !imageResource.isEmpty else { return }
            guard let url = URL(string: imageResource) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.image = image
                }
            }
        }
    }
}

struct ImageImportView_Previews: PreviewProvider {
    static var previews: some View {
        ImageImportView(onSubmit: { image in })
    }
}
