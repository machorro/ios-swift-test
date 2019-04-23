//
//  Note.swift
//  TestApp
//
//

import Foundation

struct Note {
    let content: String
    let creationDate: Date
    
    init(content: String) {
        self.content = content
        self.creationDate = Date()
    }
    
    init(content: String, creationDate: Date) {
        self.content = content
        self.creationDate = creationDate
    }
}

extension Note: CustomStringConvertible {
    var description: String {
        return """
        Created: \(creationDate)
        Content: \(content)
        """
    }
}
