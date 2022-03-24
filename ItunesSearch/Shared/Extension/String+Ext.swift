//
//  String+Ext.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import Foundation

// MARK: - Date
extension String {
    
    func formatDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.Date.serviceDateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")        
        guard let date = dateFormatter.date(from: self) else { return nil }
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = Constants.Date.appDateFormat
        return dateFormatter.string(from: date)
    }
}

// MARK: - HTML
extension String {
    
    func htmlToString() -> String? {
        guard let data = self.data(using: .utf8) else { return nil }
        return try? NSAttributedString(data: data,
                                       options: [.documentType: NSAttributedString.DocumentType.html],
                                       documentAttributes: nil).string
    }
}
