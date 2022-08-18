//
//  ContentView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.07.2022.
//

import SwiftUI

enum Page: Identifiable {
    case tilt
    case background
    case size
    
    var id: Self {
        self
    }
}

class ContentViewModel: ObservableObject {
    @Published var image: UIImage?
    @Published var metadata = ImageMetadata()
}

struct ImageMetadata {
    enum Size: Double {
        case extraSmall = 0.2
        case small = 0.5
        case normal = 1
        case large = 1.2
        case extraLarge = 1.5
    }
    
    var tilt: Double = 0
    var backgroundColor: UIColor = .clear
    var size: Size = .normal
}

struct ContentView: View {
    @State var page: Page? = nil
    @State var displayImageLoader = false
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            HeaderView(title: "Art")
            Spacer()
                
            if let image = viewModel.image {
                CanvasView(
                    viewModel: CanvasViewModel(
                        image: image,
                        tilt: viewModel.metadata.tilt,
                        backgroundColor: viewModel.metadata.backgroundColor)
                )
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

            HStack {
                Button("Clear image") {
                    withAnimation {
                        viewModel.image = nil
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
        .fullScreenCover(item: $page) { page in
            if let page = page {
                switch page {
                case .tilt:
                    TiltSelectorView()
                case .background:
                    BackgroundSelectorView()
                case .size:
                    SizeSelectorView()
                }
            }
        }
        .sheet(isPresented: $displayImageLoader) {
            ImageImportView()
        }
        .padding()
        .environmentObject(viewModel)
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct CanvasViewModel {
    var image: UIImage
    var tilt: Double = 0
    var backgroundColor: UIColor = .clear
    var size: ImageMetadata.Size = .normal
}

// SwiftUI: Reusable toolbar with custom views

// Let's suppose we need to create a toolbar with some
