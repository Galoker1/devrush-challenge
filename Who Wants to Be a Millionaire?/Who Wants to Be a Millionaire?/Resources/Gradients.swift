//
//  Colors.swift
//

import SwiftUI

enum Gradients {
    static let red  = LinearGradient(
        colors: [
            Color("lightred"),
            Color("darkred"),
            Color("lightred"),
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let purple  = LinearGradient(
        colors: [
            Color("lavand"),
            Color("purple"),
            Color("lavand"),
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    static let gold  = LinearGradient(
        colors: [
            Color("lightgold"),
            Color("darkgold"),
            Color("lightgold"),
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let blue  = LinearGradient(
        colors: [
            Color("sea"),
            Color("darkblue"),
            Color("sea"),
        ],
        startPoint: .top,
        endPoint: .bottom
    )
    
    static let green  = LinearGradient(
        colors: [
            Color("lightgreen"),
            Color("darkgreen"),
            Color("lightgreen"),
        ],
        startPoint: .top,
        endPoint: .bottom
    )
}



