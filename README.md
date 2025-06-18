#  AttributedTextEditor

Markdown-annotating version of TextEditor using AttributedString features in iOS/macOS 26. Based on initial implementation of [ComposerUI in IcySky](https://github.com/Dimillian/IcySky/tree/main/Packages/Features/Sources/ComposerUI) by [@Dimillian](https://github.com/Dimillian).

## Current Implementation

### Supported Specification
Bold: `*bold*`
Italic: `_italic_`
Link: `[link](https://www.github.com/fraander)` (Not clickable, yet)
Blockquote: `> blockquote`
Underline: `__underline__`
Strikethrough: `~strikethrough~`
Heading 1: `# Heading 1`
Heading 2: `## Heading 2`
Heading 3: `### Heading 3`
Unordered list: `- `, `+ `, `* ` 
Ordered list: `1. `
Checkbox: `- [ ]`, `- [x]` (Having trouble adjusting the rest of the line, following `- [x]`)
Inline code: `\`code\``
Code block: `\`\`\` code block \`\`\``
