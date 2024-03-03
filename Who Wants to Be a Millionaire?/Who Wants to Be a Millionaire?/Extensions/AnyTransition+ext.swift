//
//  AnyTransition+ext.swift
//

import SwiftUI

struct BlurTransition: ViewModifier {
    var progress = 0.0
    
    func body(content: Content) -> some View {
        content
            .blur(radius: 50 * progress)
            .grayscale(progress)
            .scaleEffect(CGSize(width: progress + 1, height: progress + 1), anchor: .trailing)
            .offset(x: 500 * progress)
    }
}

extension AnyTransition {
    static let blur: AnyTransition = .modifier(
        active: BlurTransition(progress: 1),
        identity: BlurTransition(progress: 0)
    )
}
