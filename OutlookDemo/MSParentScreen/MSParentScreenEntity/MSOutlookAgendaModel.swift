//
//  MSOutlookAgendaModel.swift
//  OutlookDemo
//
//  Created by Banerjee, Subhodip on 28/02/18.
//  Copyright © 2018 Subhodip Banerjee. All rights reserved.
//
/**
 `MSOutlookAgendaModel` which contains the entities, which are the basic model objects used by the Interactor.
 - This Entity contains all the models for `AgendaView`.
 */
import Foundation
import CoreLocation
/**
 `AgendaDatabaseConfig` is the main backbone for making the `Agenda`.
 • `EveryDayAgenda`:-
 -  `let date: Date` - date of the Agenda.
 -  `agendaEvents: [EveryDayAgendaEvents]` - array of everyday agenda.
 
 • `EveryDayAgendaEvents`:-
 -  `title: String` - title of the Agenda.
 -  `date: Date` - date of the Agenda.
 -  `startTime: Date` - start time of the Agenda.
 -  `meetingPeople: [MeetingPepole]` - array of meeting pepole participants.
 -  `allDayEvent: Bool` - is the event occurs everyday.
 
 • `MeetingPepole`:-
 -  `firstName: String` - first Name of the meeting pepole participant.
 -  `lastName: String` - last Name of the meeting pepole participant.
 -  `backgroundColor: String` - background color for meeting participants.
 -  `combinedName: String` - combined Name of the meeting pepole participant. e.g. Ryan Gigs -> "RG"
 */
struct AgendaDatabaseConfig{
    
    struct EveryDayAgenda{
        let date: Date
        let agendaEvents: [EveryDayAgendaEvents]
    }
    
    struct EveryDayAgendaEvents: Decodable{
        let title: String
        var date: Date
        let startTime: Date
        let meetingPeople: [MeetingPepole]
        let allDayEvent: Bool
    }
    
    struct MeetingPepole: Decodable{
        let firstName: String
        let lastName: String
        let backgroundColor: String
        let combinedName: String
    }
    
}
/**
 `ScrollDirection` defines `AgendaView` table scrolling dirction.
 */
public enum ScrollDirection {
    case up
    case down
    case none
}
