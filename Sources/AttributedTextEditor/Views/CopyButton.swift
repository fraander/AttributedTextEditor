//
//  CopyButton.swift
//  AttributedTextEditor
//
//  Created by Frank Anderson on 6/17/25.
//

import SwiftUI

public struct CopyButton: View {
    
    var text: AttributedString
    
    public init(text: AttributedString) {
        self.text = text
    }
    
    public var body: some View {
        Button("Copy", systemImage: "document.on.document", action: copyPlainText)
    }
    
    func copyPlainText() {
        let content = String(text.characters)
        #if os(iOS)
        UIPasteboard.general.string = content
        #elseif os(macOS)
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(content, forType: .string)
        #endif
    }
}
