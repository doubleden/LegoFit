//
//  MyWorkoutsDitaisView.swift
//  LegoFit
//
//  Created by Denis Denisov on 2/6/24.
//

import SwiftUI

struct MyWorkoutsDetailsView: View {
    let workout: Workout
    
    var body: some View {
        
        List(workout.exercises, id: \.id) { workout in
            VStack(alignment: .leading) {
                Text(workout.name)
                Text(workout.set.formatted())
                Text(workout.rep.formatted())
                Text(workout.weight.formatted())
            }
        }
        
    }
}

//import SwiftData
//#Preview {
//    struct MyWorkoutsDetailsView_Previews: PreviewProvider {
//        static var previews: some View {
//            let config = ModelConfiguration(isStoredInMemoryOnly: true)
//            let container = try! ModelContainer(for: Workout.self, Exercise.self, configurations: config)
//            
//            let exercise = Exercise(category: "legs", name: "Жим ног", definition: "Описание", photo: "image.png", set: 3, rep: 12, weight: 100)
//            let workout = Workout(name: "Тренировка ног", exercises: [exercise])
//            
//            container.mainContext.insert(exercise)
//            container.mainContext.insert(workout)
//            
//            return MyWorkoutsDetailsView(workout: workout)
//                .modelContainer(container)
//        }
//    }
//}
