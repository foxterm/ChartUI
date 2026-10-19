# ChartUI

[English](README.md) | [中文文档](README_CN.md)

FoxTerm APP 专用 SwiftUI 图表组件库，提供点阵分段条、三层负载环、饼图等可视化组件。

> 本库为 [FoxTerm](https://foxterm.app/) APP 专用核心组件，欢迎下载使用：[https://foxterm.app/](https://foxterm.app/)

## 组件

| 组件 | 说明 |
|------|------|
| `DotSegmentBarView` | 点阵分段条图，基于 Canvas 绘制，像素级对齐，适合 CPU/内存使用率展示 |
| `TripleRingLoadChart` | 三层同心渐变环，展示 1/5/15 分钟负载，支持自定义颜色和线宽 |
| `PieChartProgressView` | 环形饼图，基于 Swift Charts `SectorMark` |
| `DotColorValue` | 通用数据模型（标签 + 颜色 + 数值） |

## 环境要求

| 平台 | 最低版本 |
|------|---------|
| iOS  | 17.0    |
| macOS | 14.0   |
| Swift | 5.10   |

## 安装

### Swift Package Manager

```swift
.package(url: "https://github.com/foxterm/ChartUI.git", .upToNextMinor(from: "1.0.0")),
```

```swift
.product(name: "ChartUI", package: "ChartUI"),
```

### CocoaPods

```ruby
pod 'ChartUI', :git => 'https://github.com/foxterm/ChartUI.git'
```

## 使用

### DotSegmentBarView — 点阵分段条

```swift
DotSegmentBarView(data: [
    DotColorValue(label: "User", color: .blue, value: 35),
    DotColorValue(label: "System", color: .orange, value: 15),
    DotColorValue(label: "Idle", color: .gray.opacity(0.3), value: 50),
])
```

### TripleRingLoadChart — 三层负载环

```swift
TripleRingLoadChart(
    load1: 2.5,
    load5: 1.8,
    load15: 1.2,
    physicalCores: 8
)
```

### PieChartProgressView — 环形饼图

```swift
PieChartProgressView(data: [
    DotColorValue(label: "Used", color: .blue, value: 64),
    DotColorValue(label: "Free", color: .gray.opacity(0.3), value: 36),
])
```

## Demo

![Demo](demo/demo.png)

![Demo](demo/cpu.png)

## 许可证

MIT
