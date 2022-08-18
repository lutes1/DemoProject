//
//  ColorItemView.swift
//  DemoProject
//
//  Created by Petru Lutenco on 18.08.2022.
//

import SwiftUI

struct ColorItemView: View {
    var color: Color
    
    var body: some View {
        if UIColor(color).cgColor.alpha != 0 {
            color
                .frame(width: 50, height: 50)
                .cornerRadius(5)
        } else {
            Image(systemName: "clear")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.red.opacity(0.7))
        }
    }
}

struct ColorItemView_Previews: PreviewProvider {
    static var previews: some View {
        ColorItemView(color: .purple)
    }
}
