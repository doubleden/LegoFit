//
//  ExerciseCellView.swift
//  LegoFit
//
//  Created by Denis Denisov on 13/6/24.
//
import SwiftUI

struct ExerciseCellView: View {
    let title: String
    let onTapAction: () -> Void
    let onSwipeAction: () -> Void
    
    var body: some View {
        Button(title) {
            onTapAction()
        }
        .tint(.white)
        .swipeActions(edge: .leading, allowsFullSwipe:true) {
            Button("Add") {
                onSwipeAction()
            }
            .tint(.main)
        }
    }
}
