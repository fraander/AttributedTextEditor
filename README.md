#  AttributedTextEditor

Markdown-annotating version of TextEditor using AttributedString features in iOS/macOS 26. Based on initial implementation of [ComposerUI in IcySky](https://github.com/Dimillian/IcySky/tree/main/Packages/Features/Sources/ComposerUI) by [@Dimillian](https://github.com/Dimillian).

```swift
.package(url: "https://github.com/fraander/AttributedTextEditor.git")
```

## Usage

```swift
import AttributedTextEditor
```

### Drop-in replacement for `TextEditor`, use 
```swift
@State var text = AttributedString()
@State var selection = AttributedTextSelection()

var body: some View {
    ComposerTextEditorView(text: $text, selection: $selection)
}
```

### Standalone view (good for experimentation before implementing in your own project)
```swift
var body: some View {
    ComposerView()
}
```

## Current Implementation

### Challenges / blockers
- [ ] `ComposerToolbarView.swift` buttons don't actually work yet. Working versions that make the selection jump to the end have been found, but that's not good enough.
- [ ] `.link` pattern matches aren't clickable, yet.
    - [ ] Clickable phone numers and email addresses is another goal. In addition to fuzzier link recognition, so `https://www.` isn't always required to make something clickable if not using the Markdown annotation version.
- [ ] The rest of a line for a checked box can't be matched successfully yet, so the rest of the line can't be dimmed, striked through, etc.
- [ ] Copy button cannot yet support copying rich-text version of the string, just plain text.
- [ ] Placeholder placement on MacOS is incorrect and needs to be tuned.

### Other goals
- [ ] Extensibility / user-adjustability in what patterns can be matched and what appearance the matches adopt, so that others can use the spec for their needs, such as the original which was annotating `@mentions` and `www.links.co`
 

### Supported Specification in Editor
I know that this isn't perfect adherence to the Markdown specification. It's been slightly adjusted based on personal preference. Ideally, the project evolves such that many options are available to pick from, and any that aren't available can be addressed by user-created extensions.
* Bold: `*bold*`
* Italic: `_italic_`
* Link: `[link](https://www.github.com/fraander)` (Not clickable, yet)
* Blockquote: `> blockquote`
* Underline: `__underline__`
* Strikethrough: `~strikethrough~`
* Heading 1: `# Heading 1`
* Heading 2: `## Heading 2`
* Heading 3: `### Heading 3`
* Unordered list: `- `, `+ `, `* ` 
* Ordered list: `1. `
* Checkbox: `- [ ]`, `- [x]` (Having trouble adjusting the rest of the line, following `- [x]`)
* Inline code: `[backtick]code[backtick]`
* Code block: ` ```code block``` `

## Screenshot
<table>
  <tr>
    <td>
      <img width="150" alt="Block of markdown sample text with formatting applied." src="https://github.com/user-attachments/assets/30cbddb4-61c7-45ee-b94d-bc9321d121ac">
    </td>
 </table>

