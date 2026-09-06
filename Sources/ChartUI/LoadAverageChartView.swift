// FoxTerm | LoadAverageChartView.swift
// Copyright (c) 2025-2026 foxterm.app
// Created by foxterm@foxmail.com

import SwiftUI

/// 纯粹的三层同心渐变环组件 (仅包含环形图)
public struct TripleRingLoadChart: View {
    let load1: Double
    let load5: Double
    let load15: Double
    let physicalCores: Int?

    // 可选自定义参数 (若为 nil，则自动按容器比例自适应)
    var customLineWidth: CGFloat?
    var customSpacing: CGFloat?

    public init(load1: Double, load5: Double, load15: Double, physicalCores: Int?, customLineWidth: CGFloat? = nil, customSpacing: CGFloat? = nil) {
        self.load1 = load1
        self.load5 = load5
        self.load15 = load15
        self.physicalCores = physicalCores
        self.customLineWidth = customLineWidth
        self.customSpacing = customSpacing
    }

    public var body: some View {
        GeometryReader { proxy in
            let diameter = min(proxy.size.width, proxy.size.height)
            let ringWidth = customLineWidth ?? (diameter * 0.085)
            let ringSpacing = customSpacing ?? (diameter * 0.03)

            ZStack {
                // 外环：1分钟 (蓝 ➔ 青)
                SingleLoadRing(
                    value: load1,
                    maxCap: maxCap,
                    diameter: diameter,
                    lineWidth: ringWidth,
                    colors: [
                        Color(red: 0 / 255, green: 122 / 255, blue: 255 / 255),
                        Color(red: 0 / 255, green: 201 / 255, blue: 167 / 255),
                    ]
                )

                // 中环：5分钟 (黄 ➔ 橙)
                SingleLoadRing(
                    value: load5,
                    maxCap: maxCap,
                    diameter: diameter - (ringWidth + ringSpacing) * 2,
                    lineWidth: ringWidth,
                    colors: [
                        Color(red: 255 / 255, green: 204 / 255, blue: 0 / 255),
                        Color(red: 255 / 255, green: 149 / 255, blue: 0 / 255),
                    ]
                )

                // 内环：15分钟 (紫 ➔ 玫红)
                SingleLoadRing(
                    value: load15,
                    maxCap: maxCap,
                    diameter: diameter - (ringWidth + ringSpacing) * 4,
                    lineWidth: ringWidth,
                    colors: [
                        Color(red: 175 / 255, green: 82 / 255, blue: 222 / 255),
                        Color(red: 255 / 255, green: 45 / 255, blue: 85 / 255),
                    ]
                )
            }
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
        }
    }

    private var maxCap: Double {
        Double(max(physicalCores ?? 1, 1)) * 1.5
    }
}

// MARK: - 底层单个渐变圆角环

private struct SingleLoadRing: View {
    let value: Double?
    let maxCap: Double
    let diameter: CGFloat
    let lineWidth: CGFloat
    let colors: [Color]

    private var progress: CGFloat {
        guard let val = value else { return 0.0 }
        return CGFloat(min(max(val / maxCap, 0.0), 1.0))
    }

    var body: some View {
        ZStack {
            // 暗灰底轨
            Circle()
                .stroke(Color.gray.opacity(0.12), style: StrokeStyle(lineWidth: lineWidth))
                .frame(width: diameter, height: diameter)

            // 渐变高亮环 (12点钟起点，顺时针)
            if let value, progress > 0 {
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: colors),
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360 * Double(progress))
                        ),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .frame(width: diameter, height: diameter)
                    .animation(.spring(response: 0.6, dampingFraction: 0.8), value: progress)
            }
        }
    }
}
