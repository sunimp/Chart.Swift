//
//  RsiIndicator.swift
//
//  Created by Sun on 2021/11/29.
//

import UIKit

public class RsiIndicator: ChartIndicator {
    // MARK: Nested Types

    private enum CodingKeys: String, CodingKey {
        case period
        case type
        case configuration
    }

    // MARK: Overridden Properties

    override public var greatestPeriod: Int {
        period
    }

    override public var category: Category {
        .oscillator
    }

    // MARK: Properties

    public let period: Int
    public let configuration: ChartIndicator.LineConfiguration

    // MARK: Lifecycle

    public init(
        id: String,
        index: Int,
        enabled: Bool,
        period: Int,
        onChart: Bool = false,
        single: Bool = true,
        configuration: ChartIndicator.LineConfiguration = .default
    ) {
        self.period = period
        self.configuration = configuration

        super.init(id: id, index: index, enabled: enabled, onChart: onChart, single: single)
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        period = try container.decode(Int.self, forKey: .period)
        configuration = try container.decode(ChartIndicator.LineConfiguration.self, forKey: .configuration)
        try super.init(from: decoder)
    }

    // MARK: Overridden Functions

    override public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(period, forKey: .period)
        try container.encode(configuration, forKey: .configuration)
        try super.encode(to: encoder)
    }

    // MARK: Static Functions

    public static func == (lhs: RsiIndicator, rhs: RsiIndicator) -> Bool {
        lhs.id == rhs.id &&
            lhs.index == rhs.index &&
            lhs.period == rhs.period &&
            lhs.configuration == rhs.configuration
    }
}
