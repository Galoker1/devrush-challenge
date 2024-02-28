//
//  DismissBtn.swift
//

import SwiftUI

struct DismissBtn: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
         dismiss()
        } label: {
            Image("x")
                .padding(.trailing, 16)
        }
    }
}

#Preview {
    DismissBtn()
}
