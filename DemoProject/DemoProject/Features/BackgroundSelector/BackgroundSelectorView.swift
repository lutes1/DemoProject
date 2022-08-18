//
//  BackgroundSelectorView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import SwiftUI

struct BackgroundSelectorView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HeaderView(title: "Background")
            Spacer()
        }
        .padding()
    }
}


struct BackgroundSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundSelectorView()
    }
}
