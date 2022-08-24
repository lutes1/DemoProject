//
//  HeaderView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import SwiftUI

class HeaderViewModel {
    internal init(title: String, leftButtonTitle: String? = nil, leftButtonAction: (() -> ())? = nil, sizeControlCallback: Binding<Int>? = nil, sizeIndicator: String? = nil, colorControl: UIColor? = nil, tiltIndicator: String? = nil) {
        self.title = title
        self.leftButtonTitle = leftButtonTitle
        self.leftButtonAction = leftButtonAction
        self.sizeControlCallback = sizeControlCallback
        self.sizeIndicator = sizeIndicator
        self.colorControl = colorControl
        self.tiltIndicator = tiltIndicator
    }
   
    var title: String
    var leftButtonTitle: String? = nil
    var leftButtonAction: (() -> ())? = nil
    var sizeControlCallback: Binding<Int>? = nil
    var sizeIndicator: String? = nil
    var colorControl: UIColor? = nil
    var tiltIndicator: String? = nil
}

struct HeaderView: View {
    var viewModel: HeaderViewModel
    var body: some View {
        ZStack {
            HStack {
                if let leftButtonTitle = viewModel.leftButtonTitle {
                    Button(leftButtonTitle) {
                        viewModel.leftButtonAction?()
                    }
                }
                
                if let sizeBinding = viewModel.sizeControlCallback {
                    Stepper("", value: sizeBinding , in: 0...4)
                        .frame(width: 100)
                }
                
                Spacer()
                
                if let colorIndicator = viewModel.colorControl {
                    ColorItemView(color: Color(colorIndicator))
                }
                
                if let sizeIndicator = viewModel.sizeIndicator {
                    Text(sizeIndicator)
                        .font(.title.bold())
                }
                
                if let tiltIndicator = viewModel.tiltIndicator {
                    Text("\(tiltIndicator)°")
                        .font(.title.bold())
                }
            }
            
            if let title = viewModel.title {
                Text(title)
                    .font(.title.bold())
            }
        }
        .buttonStyle(.bordered)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(viewModel: .init(
            title: "_test title_",
            leftButtonTitle: "Save",
            sizeIndicator: "120%",
            colorControl: UIColor.brown)
        )
    }
}
