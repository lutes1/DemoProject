//
//  BackgroundSelectorView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import SwiftUI

struct BackgroundSelectorView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var canvasViewModel: CanvasViewModel
    
    let colors: [Color] = [.clear,.yellow, .green,
                           .black, .red, .blue,
                           .accentColor, .brown, .cyan,
                           .gray, .indigo, .mint,
                           .orange, .purple]
    
    var body: some View {
        VStack {
            HeaderView(
                viewModel:
                        .init(
                            title: "Background",
                            leftButtonTitle: "Done",
                            leftButtonAction: {
                                presentationMode.wrappedValue.dismiss()
                            }),
                rightControls: {
                    ColorItemView(color: Color(canvasViewModel.backgroundColor))
                        .scaleEffect(0.8)
                }
            )
            
            VStack {
                CanvasView(viewModel: canvasViewModel)
                
                Spacer()
                
                Grid {
                    ForEach(colors.chunked(into: 7), id: \.self) { chunk in
                        GridRow {
                            ForEach(chunk, id: \.self) { color in
                                Button {
                                    withAnimation {
                                        canvasViewModel.backgroundColor = UIColor(color)
                                    }
                                }
                                label: {
                                    ColorItemView(color: color)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct BackgroundSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundSelectorView()
            .environmentObject(createViewModel())
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
