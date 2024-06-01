//
//  MyWorkoutsView.swift
//  LegoFit
//
//  Created by Denis Denisov on 31/5/24.
//

import SwiftUI
import SwiftData

struct MyWorkoutsView: View {
    @Query var workouts: [Workout]
    
    var body: some View {
        NavigationStack {
            List(workouts, id: \.self) { workout in
                Text(workout.name)
                
            }
        }
    }
}

#Preview {
    MyWorkoutsView()
}
