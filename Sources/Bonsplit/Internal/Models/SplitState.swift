import Combine
import Foundation
import SwiftUI

/// Direction from which a new split animates in
enum SplitAnimationOrigin {
    case fromFirst   // New pane slides in from start (left/top)
    case fromSecond  // New pane slides in from end (right/bottom)
}

/// State for a split node (branch in the split tree)
///
/// Converted from `@Observable` to `ObservableObject + @Published` (Nix build
/// compatibility — see PaneState.swift).
final class SplitState: ObservableObject, Identifiable {
    let id: UUID
    @Published var orientation: SplitOrientation
    @Published var first: SplitNode
    @Published var second: SplitNode
    @Published var dividerPosition: CGFloat  // 0.0 to 1.0

    /// Animation origin for entry animation (nil = no animation needed)
    @Published var animationOrigin: SplitAnimationOrigin?

    init(
        id: UUID = UUID(),
        orientation: SplitOrientation,
        first: SplitNode,
        second: SplitNode,
        dividerPosition: CGFloat = 0.5,
        animationOrigin: SplitAnimationOrigin? = nil
    ) {
        self.id = id
        self.orientation = orientation
        self.first = first
        self.second = second
        self.dividerPosition = dividerPosition
        self.animationOrigin = animationOrigin
    }
}

extension SplitState: Equatable {
    static func == (lhs: SplitState, rhs: SplitState) -> Bool {
        lhs.id == rhs.id
    }
}
