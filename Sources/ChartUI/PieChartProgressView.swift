// FoxTerm | PieChartProgressView.swift
// Copyright (c) 2025-2026 foxterm.app
// Created by foxterm@foxmail.com

import Charts
import SwiftUI

public struct PieChartProgressView: View {
    let portions: [
        DotColorValue
    ]
    public init(portions: [DotColorValue]) {
        self.portions = portions
    }

    public var body: some View {
        Chart(portions) { element in
            SectorMark(
                angle: .value(element.label, element.value),
                innerRadius: .ratio(0.55),
                angularInset: 5
            )
            .cornerRadius(10)
            .foregroundStyle(element.color)
        }
    }
}
