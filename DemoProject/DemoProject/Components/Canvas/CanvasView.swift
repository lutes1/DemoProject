//
//  CanvasView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import SwiftUI

struct CanvasView: View {
    @ObservedObject var viewModel: CanvasViewModel
    
    var body: some View {
        ZStack {
            Image(uiImage: viewModel.image)
                .resizable()
                .scaledToFit()
                .scaleEffect(viewModel.size.ammount)
                .rotationEffect(Angle(degrees: viewModel.tilt))
        }
        .background(Color(viewModel.backgroundColor))
    }
}

struct CanvasView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = CanvasViewModel(
            image: Self.loadDummyImage(),
            tilt: 0.0,
            backgroundColor: .green,
            size: .extraSmall
        )
        
        CanvasView(viewModel: viewModel)
    }
    
    private static func loadDummyImage() -> UIImage {
        let url = "https://pngimg.com/uploads/earth/earth_PNG21.png"
        return UIImage(data: (try? Data(contentsOf: URL(string: url)!))!)!
    }
}
