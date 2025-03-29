//
//  RideSummaryView.swift
//  Tekton
//
//  Created by Carlos Mario Muñoz on 28/03/25.
//

import SwiftUI

struct RideSummaryView: View {
    let duration: String
    let distance: String
    let onStore: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Your time was \(duration)")
                .font(.title3)
                .fontWeight(.medium)
            
            Text("Distance: \(distance)")
                .font(.title3)
                .fontWeight(.medium)
            
            HStack(spacing: 24) {
                Button("Store") {
                    onStore()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.orange)
                .cornerRadius(10)
                
                Button("Delete") {
                    onDelete()
                }
                .foregroundColor(.white)
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
            }
        }
        .padding()
        .background(.white.opacity(0.95))
        .cornerRadius(16)
    }
}
