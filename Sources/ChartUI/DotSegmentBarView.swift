// FoxTerm | DotSegmentBarView.swift
// Copyright (c) 2025-2026 foxterm.app
// Created by foxterm@foxmail.com

import SwiftUI

public struct DotSegmentBarView: View {
    let data: [DotColorValue]

    // 强制使用纯整数物理像素/点，不做任何浮点数平摊
    let dotWidth: CGFloat
    let dotSpacing: CGFloat
    let barHeight: CGFloat

    public init(data: [DotColorValue], dotWidth: CGFloat = 4.0, dotSpacing: CGFloat = 2.0, barHeight: CGFloat = 12.0) {
        self.data = data
        self.dotWidth = dotWidth
        self.dotSpacing = dotSpacing
        self.barHeight = barHeight
    }

    public var body: some View {
        Canvas { context, size in
            let totalWidth = size.width
            let step = dotWidth + dotSpacing
            guard totalWidth >= dotWidth, step > 0 else { return }

            // 向下取整：只画能完美放下的点，决不凑数
            let count = max(Int(floor((totalWidth + dotSpacing) / step)), 1)
            let colors = computeColors(for: count)

            for i in 0 ..< count {
                // 坐标永远是 0, 6, 12, 18... 绝对物理对齐，零抗锯齿模糊
                let x = CGFloat(i) * step
                let rect = CGRect(x: x, y: 0, width: dotWidth, height: barHeight)
                let path = Path(roundedRect: rect, cornerRadius: dotWidth / 2)

                context.fill(path, with: .color(colors[i]))
            }
        }
        .frame(height: barHeight)
    }

    private func computeColors(for totalCount: Int) -> [Color] {
        let totalValue = data.reduce(0) { $0 + $1.value }
        guard totalValue > 0 else {
            return Array(repeating: Color.primary.opacity(0.12), count: totalCount)
        }

        struct AllocatedItem {
            let color: Color
            var baseCount: Int
            let remainder: Double
        }

        var items: [AllocatedItem] = data.map { item in
            let exactCount = (item.value / totalValue) * Double(totalCount)
            let base = Int(floor(exactCount))
            let rem = exactCount - Double(base)
            return AllocatedItem(color: item.color, baseCount: base, remainder: rem)
        }

        let currentAllocated = items.reduce(0) { $0 + $1.baseCount }
        let unallocated = totalCount - currentAllocated

        if unallocated > 0 {
            let sortedIndices = items.indices.sorted { items[$0].remainder > items[$1].remainder }
            for i in 0 ..< min(unallocated, sortedIndices.count) {
                items[sortedIndices[i]].baseCount += 1
            }
        }

        var colors: [Color] = []
        for item in items {
            colors.append(contentsOf: Array(repeating: item.color, count: item.baseCount))
        }

        if colors.count < totalCount {
            colors.append(contentsOf: Array(repeating: Color.primary.opacity(0.12), count: totalCount - colors.count))
        }

        return colors
    }
}
