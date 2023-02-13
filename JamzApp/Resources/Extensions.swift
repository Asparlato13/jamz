//
//  Extensions.swift
//  JamzApp
//
//  Created by Adrianna Parlato on 2/13/23.
//


import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    var height: CGFloat {
        return frame.size.height
    }
    var left: CGFloat {
        return frame.origin.x
    }
    var right: CGFloat {
        return left + width
    }
    var top: CGFloat {
        return frame.origin.y
    }
    var bottom: CGFloat {
        return top + height
    }
    
}


extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFomatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()

    static let displayDateFormatter: DateFormatter = {
        let dateFomatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}

extension String {
    static func formattedDate(string: String) -> String {
        guard let date = DateFormatter.dateFormatter.date(from: string) else {
            return string
        }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}

//when user adds/saved album to library it will automatically update the saved album so the user wotn haveto  reload the  app in order to see it
extension Notification.Name {
    static let albumSavedNotificaion = Notification.Name("albumSavedNotificaion")
}



