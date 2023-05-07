//
//  PersonView.swift
//  People
//
//  Created by Ifeanyi Onuoha on 30/04/2023.
//

import SwiftUI

struct PersonView: View {
    let user: Person
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: user.avatar), content: { image in
                image
                    .resizable()
                    .frame(height: 130)
            }, placeholder: {
                Rectangle()
                    .frame(height: 130)
                    .foregroundColor(Theme.onBackground)
                    .overlay(alignment: .center, content: {
                        ProgressView()
                    })
            })
            
            Group {
                PillView(text: "#\(user.id)")
                
                Text("\(user.firstName) \(user.lastName)")
                    .foregroundColor(Theme.text)
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 5)
        }
        .background(Theme.onBackground)
        .cornerRadius(15)
        .shadow(radius: 2)
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(user: Constants.previewPerson)
    }
}
