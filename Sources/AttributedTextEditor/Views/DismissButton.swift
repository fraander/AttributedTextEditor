//
//  DismissButton.swift
//  AnnotatedTextEditor
//
//  Created by Frank Anderson on 6/17/25.
//

import SwiftUI

public struct DismissButton: View {
    @Environment(\.dismiss) var dismiss

    public var body: some View {
        Button(role: .confirm) { dismiss() }
    }
}
