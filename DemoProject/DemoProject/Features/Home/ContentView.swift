//
//  ContentView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.07.2022.
//

import SwiftUI

struct ContentView: View {
    private let imageLink = "https://pngimg.com/uploads/earth/earth_PNG21.png"
    @State private var page: Page? = nil
    @State private var showloadingIndicator = false
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            HeaderView(viewModel: .init(title: "Art"))
            Spacer()
                
            if let canvasViewModel = viewModel.canvasViewModel {
                CanvasView(viewModel: canvasViewModel)
                    .padding()
            }
            
            if showloadingIndicator {
                ProgressView()
            }
            
            Spacer()

            if viewModel.canvasViewModel != nil {
                HStack {
                    Spacer()
                    HStack {
                        Button("Tilt") { page = .tilt }
                        Button("Background") { page = .background }
                        Button("Size") { page = .size }
                    }
                    .buttonStyle(.borderedProminent)
                    .fontWeight(.bold)
                    Spacer()
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
        .padding()
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        showloadingIndicator = true
        
        DispatchQueue.global().async {
            defer {
                DispatchQueue.main.async {
                    showloadingIndicator = false
                }
            }
            
            guard let url = URL(string: imageLink) else { return }
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                withAnimation {
                    self.viewModel.canvasViewModel = CanvasViewModel(image: image)
                }
            }
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init())
    }
}
