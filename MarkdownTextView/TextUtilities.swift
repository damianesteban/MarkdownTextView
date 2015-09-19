//
//  TextUtilities.swift
//  MarkdownTextView
//
//  Created by Indragie on 4/28/15.
//  Copyright (c) 2015 Indragie Karunaratne. All rights reserved.
//

import UIKit

public typealias TextAttributes = [String: AnyObject]

internal func fontWithTraits(traits: UIFontDescriptorSymbolicTraits, font: UIFont) -> UIFont {
    let combinedTraits = UIFontDescriptorSymbolicTraits(rawValue: font.fontDescriptor().symbolicTraits.rawValue | (traits.rawValue & 0xFFFF))
    
    let descriptor = font.fontDescriptor().fontDescriptorWithSymbolicTraits(combinedTraits)
    return UIFont(descriptor: descriptor, size: font.pointSize)
}

internal func regexFromPattern(pattern: String) -> NSRegularExpression {
    var error: NSError?
    do {
        let regex = try NSRegularExpression(pattern: pattern, options: .AnchorsMatchLines)
        return regex
    } catch let error1 as NSError {
        error = error1
        fatalError("Failed to initialize regular expression with pattern \(pattern): \(error)")
    }
}

internal func enumerateMatches(regex: NSRegularExpression, string: String, block: NSTextCheckingResult -> Void) {
    let range = NSRange(location: 0, length: (string as NSString).length)
    regex.enumerateMatchesInString(string, options: [], range: range)
        { (result, _, _) in
            if(result != nil){
                block(result!)
            }
    }
}
