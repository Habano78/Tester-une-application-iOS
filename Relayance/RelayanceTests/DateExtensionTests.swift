//
//  DateExtensionTests.swift
//  RelayanceTests
//
//  Created by Perez William on 06/12/2025.
//

import Testing
@testable import Relayance
import Foundation

struct DateExtensionTests {
        
        //MARK: Verifier les transcsiptions string-date; date-string
        @Test func dateFromString() {
                
                //GIVEN
                let date = "2025-12-06"
                //WHEN
                let dateFromString = Date.dateFromString(date)
                
                //THEN
                #expect(dateFromString != nil)
                
        }
        
        @Test
        func stringFromDate() {
               
                //GIVEN
                let dateComponents = DateComponents(year: 2025, month: 12, day: 6)
                let date = Calendar.current.date(from: dateComponents) ?? Date.now
                
                //WHEN
                let stringFromDate = Date.stringFromDate(date)
                
                //THEN
                #expect(stringFromDate == "06-12-2025")
        }
        
        //MARK: Verifier l'extraction de year, month and day
        @Test func getYear() {
                
                //GIVEN
                let dateComponents = DateComponents(year: 2025, month: 12, day: 6)
                let date = Calendar.current.date(from: dateComponents) ?? Date.now
                
                //WHEN
                let year = date.getYear()
                
                //THEN
                #expect(year == 2025)
        }
        
        @Test func getMonth() {
                //GIVEN
                let dataComponents = DateComponents(year: 2025, month: 12, day: 6)
                let date = Calendar.current.date(from: dataComponents) ?? Date.now
                
                //WHEN
                let month = date.getMonth()
                
                //THEN
                #expect(month == 12)
        }
        
        @Test func getDay() {
                //GIVEN
                let dataComponents = DateComponents(year: 2025, month: 12, day: 6)
                let date = Calendar.current.date(from: dataComponents) ?? Date.now
                
                //When
                let day = date.getDay()
                
                //THEN
                #expect(day == 6)
        }
     
}
