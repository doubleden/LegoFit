//
//  HistoryWorkoutView.swift
//  LegoFit
//
//  Created by Denis Denisov on 19/7/24.
//

import SwiftUI
import SwiftData

struct HistoryWorkoutView: View {
    @Query(filter: #Predicate<Workout> {
        workout in
        workout.isDone
    },
           sort: \Workout.finishDate,
           order: .reverse) var workouts: [Workout]
    
    private var dates: [Date] {
        Set(workouts.map {
            Calendar.current.startOfDay(for: $0.finishDate)
        }).sorted(by: {$0 > $1})
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(dates, id: \.self) { date in
                        Section(header: Text(date.showDate())) {
                            ForEach(workouts.filter { Calendar.current.isDate($0.finishDate, inSameDayAs: date) }) { workout in
                                NavigationLink(workout.name) {
                                    HistoryWorkoutDetailsView(workout: workout)
                                }
                            }
                            .mainRowStyle()
                        }
                    }
                }
                .mainListStyle()
            }
            .background(MainGradientBackground())
            .navigationTitle("History")
        }
    }
}

#Preview {
    HistoryWorkoutView()
        .modelContainer(DataController.previewContainer)
}
