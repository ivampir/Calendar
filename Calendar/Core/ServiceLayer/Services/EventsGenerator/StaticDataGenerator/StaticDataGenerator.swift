//
//  StaticDataGenerator.swift
//  Calendar
//
//  Created by Vitaliy Ampilogov on 3/19/17.
//  Copyright © 2017 v.ampilogov. All rights reserved.
//

import Foundation

protocol IStaticDataGenerator {
    func generateEvents(for date: Date) -> [Event]
}

private struct Constants {
    typealias Hours = UInt32
    static let maxDuration: Hours = 5
    static let maxStartTime: Hours = 20
    static let maxEventsPerDay: UInt32 = 5
}

class StaticDataGenerator: IStaticDataGenerator {
    
    private let staticData = StaticData()
    fileprivate let timeZoneOffset: TimeInterval = TimeInterval(NSTimeZone.system.secondsFromGMT())
    
    private func generateEventTitle() -> String {
        return staticData.activities.randomElement
    }
    
    private func generateLocation() -> String {
        return staticData.cities.randomElement
    }
    
    private func generateDuration() -> TimeInterval {
        return TimeInterval.hour * Double(arc4random_uniform(Constants.maxDuration) + 1)
    }
    
    private func generateStartDate(for date: Date) -> Date {
        let startTime = TimeInterval.hour * Double(arc4random_uniform(Constants.maxStartTime) + 1)
        return date.addingTimeInterval(startTime)
    }
    
    func generateEvents(for dayDate: Date) -> [Event] {
        
        var events = [Event]()
        let numberOfEvents = arc4random_uniform(Constants.maxEventsPerDay)
        var lastDate = generateStartDate(for: dayDate)
        for _ in 0...numberOfEvents {
            let event = Event(identifier: UUID().uuidString,
                              title: generateEventTitle(),
                              location: generateLocation(),
                              startDate: lastDate,
                              duration: generateDuration())
            
            // Generate events just for current day
            if lastDate.timeIntervalSince1970 < dayDate.timeIntervalSince1970 + TimeInterval.day {
                events.append(event)
            } else {
                break
            }
            
            lastDate = event.startDate.addingTimeInterval(event.duration)
        }
        
        return events
    }
}
