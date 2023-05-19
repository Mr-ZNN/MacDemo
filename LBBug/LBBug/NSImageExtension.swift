//
//  NSImageExtension.swift
//  LBBug
//
//  Created by 张宁宁 on 19/5/23.
//

import AppKit

extension NSImage {
    static func changeColor(oldImage: NSImage, color: NSColor) -> NSImage? {
        if let newImage: NSImage = oldImage.copy() as? NSImage {
            color.set()
            let imageRect: NSRect = NSRect(x: 0, y: 0, width: oldImage.size.width, height: oldImage.size.height)
            __NSRectFillUsingOperation(imageRect, .sourceAtop)
            newImage.lockFocus()
            return newImage
        } else {
            return nil
        }
    }
}
