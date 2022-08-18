//
//  TiltSelectorView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import SwiftUI

struct TiltSelectorView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var canvasViewModel: CanvasViewModel
    
    var body: some View {
        VStack {
            HeaderView(
                viewModel:
                        .init(
                            title: "Rotation",
                            leftButtonTitle: "Done",
                            leftButtonAction: {
                                presentationMode.wrappedValue.dismiss()
                            }
                        ),
                rightControls: {
                    Text("\(Int(canvasViewModel.tilt))°")
                        .font(.title.bold())
                }
            )
            
            Spacer()
            
            CanvasView(viewModel: canvasViewModel)
            Spacer()
            Slider(value: $canvasViewModel.tilt, in: 0...359, step: 1)
            Spacer()
        }
        .padding()
    }
}

struct TiltSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        TiltSelectorView()
            .environmentObject(Self.createViewModel())
    }
    
    private static func createViewModel() -> CanvasViewModel {
        let viewModel = CanvasViewModel(image: loadDummyImage())
        return viewModel
    }
    
    private static func loadDummyImage() -> UIImage {
        let url = "https://pngimg.com/uploads/earth/earth_PNG21.png"
        return UIImage(data: (try? Data(contentsOf: URL(string: url)!))!)!
    }
}
