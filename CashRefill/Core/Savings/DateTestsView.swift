//
//  DateTestsView.swift
//  CashRefill
//
//  Created by Woturios on 08/07/2022.
//

import SwiftUI

struct Occurrence: Identifiable {
    let id = UUID()
    let start: Date
    let title: String
}

struct Day: Identifiable {
    let id = UUID()
    let title: String
    let occurrences: [Occurrence]
    let date: Date
}

struct EventData {
    let sections: [Day]

    init() {
        // create some events
        let first = Occurrence(start: EventData.constructDate(day: 5, month: 5, year: 2019), title: "First Event")
        let second = Occurrence(start: EventData.constructDate(day: 5, month: 5, year: 2019, hour: 10), title: "Second Event")
        let third = Occurrence(start: EventData.constructDate(day: 5, month: 6, year: 2019), title: "Third Event")
        let fourth = Occurrence(start: EventData.constructDate(day: 2, month: 1, year: 2020), title: "Fourth Event")

        // Create an array of the occurrence objects and then sort them
        // this makes sure that they are in ascending date order
        let events = [third, first, second, fourth].sorted { $0.start < $1.start }

        // create a DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MMMM yyyy"

        // We use the Dictionary(grouping:) function so that all the events are
        // group together, one downside of this is that the Dictionary keys may
        // not be in order that we require, but we can fix that
        let grouped = Dictionary(grouping: events) { (occurrence: Occurrence) -> String in
            dateFormatter.string(from: occurrence.start)
        }

        // We now map over the dictionary and create our Day objects
        // making sure to sort them on the date of the first object in the occurrences array
        // You may want a protection for the date value but it would be
        // unlikely that the occurrences array would be empty (but you never know)
        // Then we want to sort them so that they are in the correct order
        self.sections = grouped.map { day -> Day in
            Day(title: day.key, occurrences: day.value, date: day.value[0].start)
        }.sorted { $0.date < $1.date }
    }

    /// This is a helper function to quickly create dates so that this code will work. You probably don't need this in your code.
    static func constructDate(day: Int, month: Int, year: Int, hour: Int = 0, minute: Int = 0) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone(abbreviation: "GMT")
        dateComponents.hour = hour
        dateComponents.minute = minute

        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let someDateTime = userCalendar.date(from: dateComponents)
        return someDateTime!
    }

}

struct DateTestsView: View {

    // this mocks your data
    let events = EventData()

    var body: some View {
        NavigationView {
            List {
                ForEach(events.sections) { section in
                    Section(header:
                                Text(section.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(10)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                    
                    ) {
                        ForEach(section.occurrences) { occurrence in
                            NavigationLink(destination: OccurrenceDetail(occurrence: occurrence)) {
                                OccurrenceRow(occurrence: occurrence)
                                    .font(.headline)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationBarTitle(Text("Events"))
        }
    }
}

// These are sample views so that the code will work
struct OccurrenceDetail: View {
    let occurrence: Occurrence

    var body: some View {
        Text(occurrence.title)
    }
}

struct OccurrenceRow: View {
    let occurrence: Occurrence

    var body: some View {
        Text(occurrence.title)
    }
}

struct DateTestsView_Previews: PreviewProvider {
    static var previews: some View {
        DateTestsView()
    }
}
