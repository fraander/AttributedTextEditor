//import ATProtoKit
//import DesignSystem
import Network
import SwiftUI

public struct ComposerView: View {
    
    public init(
        text: AttributedString = .init(),
        selection: AttributedTextSelection = AttributedTextSelection(),
        presentationDetent: PresentationDetent = .large,
        title: String = "Compose",
        placeholder: String = "What's on your mind?"
    ) {
        self.text = text
        self.selection = selection
        self.presentationDetent = presentationDetent
        self.title = title
        self.placeholder = placeholder
        self.isFocused = false
    }
    
    @State private var text: AttributedString = """
        # Heading 1
        ## Heading 2  
        ### Heading 3

        **Bold text** and *italic text* and __underlined text__ and ~strikethrough~

        Here's some `inline code` and a link to [Google](https://google.com)

        > This is a blockquote
        > Another line

        - Unordered list item
        * Another with asterisk
        + Plus sign item
         - Nested item

        1. Ordered list
        2. Second item
          1. Nested ordered
          2. Another nested

        - [ ] Unchecked checkbox
        - [x] Checked checkbox

        ```swift
        // Code block
        func hello() {
           print("Hello World")
        }
        ```
        """
    @State private var selection = AttributedTextSelection()
    
    @State var presentationDetent: PresentationDetent = .large
    var title: String = "Compose"
    var placeholder: String = "What's on your mind?"
    
    @FocusState var isFocused: Bool
    
    public var body: some View {
        NavigationStack {
            ComposerTextEditorView(text: $text, selection: $selection, placeholder: placeholder)
                .navigationTitle(title)
            #if os(iOS)
                .navigationBarTitleDisplayMode(.inline)
            #endif
                .focused($isFocused)
                .toolbar {
                    ComposerToolbarView(text: $text, selection: $selection, dismissKeyboard: { withAnimation {isFocused = false }})
                    ComposerHeaderView(text: text)
                }
        }
        .presentationDetents([.height(200), .large], selection: $presentationDetent)
        .presentationBackgroundInteraction(.enabled)
    }
}
