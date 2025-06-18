import SwiftUI
import UniformTypeIdentifiers

public struct ComposerHeaderView: ToolbarContent {
    @Environment(\.dismiss) var dismiss
    
    var text: AttributedString
    
    var dismissPlacement: ToolbarItemPlacement {
        #if os(iOS)
        .topBarTrailing
        #elseif os(macOS)
        .automatic
        #endif
    }
    
    var copyPlacement: ToolbarItemPlacement {
        #if os(iOS)
        .topBarLeading
        #elseif os(macOS)
        .automatic
        #endif
    }
    
    public var body: some ToolbarContent {
        ToolbarItem(placement: dismissPlacement) {
            Button(role: .confirm) { dismiss() }
        }
        
        ToolbarItem(placement: copyPlacement) {
            Button("Copy", systemImage: "document.on.document", action: copyPlainText)
        }
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
