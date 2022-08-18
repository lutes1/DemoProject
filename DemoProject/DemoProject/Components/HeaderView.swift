//
//  HeaderView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import SwiftUI

class HeaderViewModel {
    internal init(title: String? = nil, leftButtonTitle: String? = nil, leftButtonAction: (() -> ())? = nil, sizeControlCallback: Binding<Int>? = nil, sizeIndicator: String? = nil, colorControl: UIColor? = nil, tiltIndicator: String? = nil) {
        self.title = title
        self.leftButtonTitle = leftButtonTitle
        self.leftButtonAction = leftButtonAction
        self.sizeControlCallback = sizeControlCallback
        self.sizeIndicator = sizeIndicator
        self.colorControl = colorControl
        self.tiltIndicator = tiltIndicator
    }
   
    var title: String? = nil
    var leftButtonTitle: String? = nil
    var leftButtonAction: (() -> ())? = nil
    var sizeControlCallback: Binding<Int>? = nil
    var sizeIndicator: String? = nil
    var colorControl: UIColor? = nil
    var tiltIndicator: String? = nil
}

struct HeaderView<LeftControls: View, RightControls: View>: View {
    internal init(viewModel: HeaderViewModel, leftControls: @escaping () -> LeftControls, rightControls: @escaping () -> RightControls) {
        self.viewModel = viewModel
        self.leftControls = leftControls
        self.rightControls = rightControls
    }
    
    var viewModel: HeaderViewModel
    @ViewBuilder let leftControls: () -> LeftControls
    @ViewBuilder let rightControls: () -> RightControls
    
    var body: some View {
        ZStack {
            HStack {
                if let leftButtonTitle = viewModel.leftButtonTitle {
                    Button(leftButtonTitle) {
                        viewModel.leftButtonAction?()
                    }
                }
                
                leftControls()
                
                Spacer()
                rightControls()
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

extension HeaderView where LeftControls == EmptyView, RightControls == EmptyView {
    init(viewModel: HeaderViewModel) {
        self.init(viewModel: viewModel, leftControls: { EmptyView() }, rightControls: { EmptyView() })
    }
}

extension HeaderView where LeftControls == EmptyView {
    init(viewModel: HeaderViewModel, @ViewBuilder rightControls: @escaping () -> RightControls) {
        self.init(viewModel: viewModel, leftControls: { EmptyView() }, rightControls: rightControls)
    }
}

extension HeaderView where RightControls == EmptyView {
    init(viewModel: HeaderViewModel, @ViewBuilder leftControls: @escaping () -> LeftControls) {
        self.init(viewModel: viewModel, leftControls: leftControls, rightControls: { EmptyView() })
    }
}
