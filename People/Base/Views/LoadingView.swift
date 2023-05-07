//
//  LoadingView.swift
//  People
//
//  Created by Ifeanyi Onuoha on 02/05/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
            
            ProgressView()
                .padding(.horizontal, 80)
                .padding(.vertical, 50)
                .background(Theme.onBackground)
                .cornerRadius(20)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
