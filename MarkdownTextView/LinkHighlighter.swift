//
//  LinkHighlighter.swift
//  MarkdownTextView
//
//  Created by Indragie on 4/29/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

import UIKit

/**
*  Highlights URLs.
*/
public final class LinkHighlighter: HighlighterType {
    private var detector: NSDataDetector!
    
    public init() throws {
        var errorPtr: NSError! = NSError(domain: "Migrator", code: 0, userInfo: nil)
        var error: NSError?
        do {
            let detector = try NSDataDetector(types: NSTextCheckingType.Link.rawValue)
            self.detector = detector
        } catch let error1 as NSError {
            error = error1
            if (true) {
                errorPtr = error
            }
            throw errorPtr
        }
    }
    
    // MARK: HighlighterType
    
    public func highlightAttributedString(attributedString: NSMutableAttributedString) {
        enumerateMatches(detector, string: attributedString.string) {
            if let URL = $0.URL {
                let linkAttributes = [
                    NSLinkAttributeName: URL
                ]
                attributedString.addAttributes(linkAttributes, range: $0.range)
            }
        }
    }
}
