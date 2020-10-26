//
//  Extentions.swift
//  SmartyHome
//
//  Created by Ahmed MAHOUCHI on 10/25/20.
//

import Foundation
extension Date {
    func toString(dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
extension String {
    
    var isEmptyOrNull: Bool {
        if self.isEmpty || self.count == 0 {
            return true
        } else {
            return false
        }
    }
    
}
