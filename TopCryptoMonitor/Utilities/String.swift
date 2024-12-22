//
//  String.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 22/12/24.
//

import UIKit

extension String {
    func convertToAttributedString() -> NSAttributedString {
        guard let data = data(using: .utf8) else {
            return NSAttributedString()
        }
        
        do {
            let attributedString = try NSMutableAttributedString(data: data,
                                                                  options: [.documentType: NSAttributedString.DocumentType.html,
                                                                            .characterEncoding: String.Encoding.utf8.rawValue],
                                                                  documentAttributes: nil)
            attributedString.addAttribute(.font,
                                          value: UIFont.systemFont(ofSize: 14),
                                          range: NSRange(location: 0, length: attributedString.length))
            return attributedString
        } catch {
            return NSAttributedString()
        }
    }
    
    func htmlToString() -> String { convertToAttributedString().string }
}
