//
//  HeaderView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import SwiftUI

struct HeaderView: View {
    @Environment(\.presentationMode) var presentationMode
    var title: String
    var body: some View {
        ZStack {
            HStack {
                Button("Close") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Spacer()
            }
            
            Text(title)
                .font(.title.bold())
        }
        .buttonStyle(.bordered)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(title: "_test title_")
    }
}
