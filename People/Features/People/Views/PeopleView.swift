//
//  PeopleView.swift
//  People
//
//  Created by Ifeanyi Onuoha on 28/04/2023.
//

import SwiftUI

struct PeopleView: View {
    @StateObject private var vm = PeopleViewModel()
    @State private var showCreateView: Bool = false
    @State private var showSuccess: Bool = false
    @State private var hasAppeared: Bool = false
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()
            
            if vm.state == .loading {
                ProgressView()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(vm.people, id: \.id) { user in
                            NavigationLink(destination: {
                                DetailView(userId: user.id)
                            }, label: {
                                PersonView(user: user)
                                    .accessibilityIdentifier("person_\(user.id)")
                                    .task {
                                        if vm.hasReachedEnd(of: user) && vm.state != .fetchingMore {
                                            await vm.fetchPeople()
                                        }
                                    }
                            })
                        }
                    }
                    .padding()
                    if vm.state == .fetchingMore {
                        ProgressView("Loading more")
                    }
                }
            }
        }
        
        .navigationTitle("People")
        .toolbar {
            ToolbarItem {
                createButton
            }
        }
        .sheet(isPresented: $showCreateView, content: {
            CreateView {
                withAnimation(.spring().delay(0.3)) {
                    showSuccess.toggle()
                }
            }
        })
        .refreshable {
            await vm.fetchPeople(shouldReset: true)
        }
        .alert(isPresented: $vm.hasError, error: vm.error, actions: {
            Button("Ok") {
                
            }
            Button("Retry") {
                Task { await vm.fetchPeople() }
            }
        })
        .overlay {
            if showSuccess {
                SuccessPopupView()
                    .transition(.scale.combined(with: .opacity))
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
                            withAnimation(.spring()) {
                                showSuccess.toggle()
                            }
                        })
                    }
            }
        }
        .embedNavigation()
        .task {
            if !hasAppeared {
                await vm.fetchPeople()
                hasAppeared = true
            }
        }
    }
}

struct PeopleView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}

extension PeopleView {
    var createButton: some View {
        Button(action: {
            showCreateView.toggle()
        }, label: {
            Symbols.plus
                .font(.title2)
        })
        .disabled(vm.state == .loading)
        .accessibilityIdentifier("createButton")
    }
}
