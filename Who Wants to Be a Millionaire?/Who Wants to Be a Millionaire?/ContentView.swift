//
//  ContentView.swift
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = GameLogic()
    
    var body: some View {
        ZStack {
            if vm.isSplash {
                SplashView()
                    .transition(.blur)
                    .environmentObject(vm)
                   
            } else {
                MenuView()
                    .transition(.slide)
                    .environmentObject(vm)
            }
        }
    }
}

#Preview {
    ContentView()
}
