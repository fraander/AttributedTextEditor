import SwiftUI
import UniformTypeIdentifiers



public struct ComposerHeaderView: ToolbarContent {
    
    var text: AttributedString
    var copyButton: Bool = true
    
    static var dismissPlacement: ToolbarItemPlacement {
        #if os(iOS)
        .topBarTrailing
        #elseif os(macOS)
        .automatic
        #endif
    }
    
    static var copyPlacement: ToolbarItemPlacement {
        #if os(iOS)
        .topBarLeading
        #elseif os(macOS)
        .automatic
        #endif
    }
    
    public var body: some ToolbarContent {
        ToolbarItem(placement: ComposerHeaderView.dismissPlacement) { DismissButton() }
        
        if copyButton {
            ToolbarItem(placement: ComposerHeaderView.copyPlacement) { CopyButton(text: text) }
        }
    }
}
