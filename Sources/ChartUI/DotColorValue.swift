// FoxTerm | DotColorValue.swift
// Copyright (c) 2025-2026 foxterm.app
// Created by foxterm@foxmail.com

import SwiftUI

public struct DotColorValue: Identifiable, Hashable {
    public let label: String
    public let color: Color
    public let value: Double

    public var id: String {
        label
    }

    public init(label: String, color: Color, value: Double) {
        self.label = label
        self.color = color
        self.value = value
    }

    public static let empty = [DotColorValue(label: "Empty", color: Color.gray.opacity(0.5), value: 1)]
}
