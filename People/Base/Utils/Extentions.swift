//
//  Extentions.swift
//  People
//
//  Created by Ifeanyi Onuoha on 07/05/2023.
//

import SwiftUI

extension View {
    @ViewBuilder
    func embedNavigation() -> some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                self
            }
        } else {
            NavigationView {
                self
            }
        }
    }
}

