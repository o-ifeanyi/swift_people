//
//  PillView.swift
//  People
//
//  Created by Ifeanyi Onuoha on 30/04/2023.
//

import SwiftUI

struct PillView: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.horizontal, 12)
            .padding(.vertical, 4)
            .background(Theme.accent)
            .cornerRadius(50)
    }
}

struct PillView_Previews: PreviewProvider {
    static var previews: some View {
        PillView(text: "#\(1)")
    }
}
