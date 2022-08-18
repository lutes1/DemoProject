//
//  ContentView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.07.2022.
//

import SwiftUI

struct ContentView: View {
    @State var page: Page? = nil
    @State var displayImageLoader = false
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            HeaderView(viewModel: .init(title: "Art"))
            Spacer()
                
            if let canvasViewModel = viewModel.canvasViewModel {
                CanvasView(viewModel: canvasViewModel)
                    .padding()
            }
            else {
                Button {
                    displayImageLoader.toggle()
                }
                label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .imageScale(.large)
                        .font(.title)
                }
                .padding()
                .background(Color.accentColor)
                .cornerRadius(5)
            }
            
            Spacer()

            if viewModel.canvasViewModel != nil {
                HStack {
                    Button("Clear image") {
                        withAnimation {
                            viewModel.canvasViewModel = nil
                        }
                    }
                    Spacer()
                    HStack {
                        Button("Tilt") { page = .tilt }
                        Button("Background") { page = .background }
                        Button("Size") { page = .size }
                    }
                    .buttonStyle(.borderedProminent)
                    .fontWeight(.bold)
                }
            }
        }
        .fullScreenCover(item: $page) { page in
            if let page = page, let canvasViewModel = viewModel.canvasViewModel {
                switch page {
                    case .tilt:
                        TiltSelectorView()
                            .environmentObject(canvasViewModel)
                    case .background:
                        BackgroundSelectorView()
                            .environmentObject(canvasViewModel)
                    case .size:
                        SizeSelectorView()
                            .environmentObject(canvasViewModel)
                }
            }
        }
        .sheet(isPresented: $displayImageLoader) {
            ImageImportView { image in
                self.viewModel.canvasViewModel = CanvasViewModel(image: image)
            }
        }
        .padding()
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
