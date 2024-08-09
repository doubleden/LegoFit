//
//  ActiveWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 27/6/24.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @Bindable var activeWorkoutVM: ActiveWorkoutViewModel
    
    var body: some View {
        Text("Start")
    }
}

#Preview {
    let container = DataController.previewContainer

    return ActiveWorkoutView(activeWorkoutVM: ActiveWorkoutViewModel())
        .modelContainer(container)
}
