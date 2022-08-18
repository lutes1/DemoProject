//
//  SizeSelectorView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import SwiftUI

struct SizeSelectorView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var canvasViewModel: CanvasViewModel
    
    var body: some View {
        VStack {
            HeaderView(
                viewModel: .init(
                    title: "Size",
                    leftButtonTitle: "Done",
                    leftButtonAction: {
                        presentationMode.wrappedValue.dismiss()
                    }
                ),
                leftControls: {
                    Stepper("", value: Binding(
                        get: {
                            canvasViewModel.size.rawValue
                        },
                        set: { value in
                            withAnimation {
                                canvasViewModel.size = .init(rawValue: value)!
                            }
                        }
                    ) , in: 0...4)
                    .frame(width: 100)
                },
                rightControls: {
                    Text(canvasViewModel.size.title)
                        .font(.title.bold())
                }
            )
            
            Spacer()
            CanvasView(viewModel: canvasViewModel)
            
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
    
    private static func createViewModel() -> CanvasViewModel {
        let viewModel = CanvasViewModel(image: loadDummyImage())
        return viewModel
    }
    
    private static func loadDummyImage() -> UIImage {
        let url = "https://pngimg.com/uploads/earth/earth_PNG21.png"
        return UIImage(data: (try? Data(contentsOf: URL(string: url)!))!)!
    }
}

