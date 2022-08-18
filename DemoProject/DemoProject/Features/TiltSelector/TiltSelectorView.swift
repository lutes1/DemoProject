//
//  TiltSelectorView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import SwiftUI

struct TiltSelectorView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HeaderView(title: "Tilt")
            Spacer()
        }
        .padding()
    }
}



struct TiltSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        TiltSelectorView()
    }
}
