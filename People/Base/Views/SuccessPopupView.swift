//
//  SuccessPopupView.swift
//  People
//
//  Created by Ifeanyi Onuoha on 03/05/2023.
//

import SwiftUI

struct SuccessPopupView: View {
    var body: some View {
        Symbols.check
            .font(.largeTitle)
            .padding(25)
            .background(.thinMaterial)
            .cornerRadius(10)
            .accessibilityIdentifier("successPopUp")
    }
}

struct SuccessPopupView_Previews: PreviewProvider {
    static var previews: some View {
        SuccessPopupView()
    }
}
