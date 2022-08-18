//
//  SizeSelectorView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import SwiftUI

struct SizeSelectorView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            HeaderView(title: "Size")
            Spacer()
            CanvasView(viewModel: CanvasViewModel(
                image: viewModel.image!,
                tilt: viewModel.metadata.tilt,
                backgroundColor: viewModel.metadata.backgroundColor,
                size: viewModel.metadata.size
            ))
            Spacer()
        }
        .padding()
    }
}

struct SizeSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SizeSelectorView()
            .environmentObject(Self.createViewModel())
    }
    
    private static func createViewModel() -> ContentViewModel {
        let viewModel = ContentViewModel()
        viewModel.image = loadDummyImage()
        return viewModel
    }
    
    private static func loadDummyImage() -> UIImage {
        let url = "https://pngimg.com/uploads/earth/earth_PNG21.png"
        return UIImage(data: (try? Data(contentsOf: URL(string: url)!))!)!
    }
}
