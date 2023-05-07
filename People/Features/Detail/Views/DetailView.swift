//
//  DetailView.swift
//  People
//
//  Created by Ifeanyi Onuoha on 30/04/2023.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var vm = DetailViewModel()
    let userId: Int
    
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            
            if vm.state == .idle {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        AsyncImage(url: URL(string: vm.user?.avatar ?? ""), content: { image in
                            image
                                .resizable()
                                .frame(height: 250)
                        }, placeholder: {
                            Rectangle()
                                .frame(height: 250)
                                .foregroundColor(Theme.onBackground)
                                .overlay(alignment: .center, content: {
                                    ProgressView()
                                })
                        })
                        .cornerRadius(15)
                        
                        
                        if vm.user != nil {
                            Group {
                                personInfo
                                link
                            }
                            .foregroundColor(Theme.text)
                            .padding()
                            .background(Theme.onBackground)
                            .cornerRadius(15)
                        } else {
                            EmptyView()
                        }
                    }
                }
                .padding(.horizontal, 15)
            } else {
                ProgressView()
            }
        }
        .navigationTitle("Details")
        .refreshable {
            Task { await vm.fetchPerson(for: userId) }
        }
        .alert(isPresented: $vm.hasError, error: vm.error, actions: {
            Button("Ok") {
                
            }
            Button("Retry") {
                Task { await vm.fetchPerson(for: userId) }
            }
        })
        .task {
            await vm.fetchPerson(for: userId)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(userId: 1)
    }
}

extension DetailView {
    var personInfo: some View {
        VStack(alignment: .leading, spacing: 10) {
            PillView(text: "#\(userId)")
            
            Text("First Name")
                .font(.headline)
                .fontWeight(.semibold)
            
            Text("\(vm.user!.firstName)")
            
            Divider()
            
            Text("Last Name")
                .font(.headline)
                .fontWeight(.semibold)
            
            Text("\(vm.user!.lastName)")
            
            Divider()
            
            Text("Email")
                .font(.headline)
                .fontWeight(.semibold)
            
            Text("\(vm.user!.email)")
        }
    }
    
    var link: some View {
        Link(destination: URL(string: "https://reqres.in/#support-heading")!, label: {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Support Reqres")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    
                    Text("https://reqres.in/#support-heading")
                }
                
                Spacer()
                
                Symbols.link
            }
        })
    }
}
