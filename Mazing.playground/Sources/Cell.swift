//
//  Cell.swift
//  Mazing
//
//  Created by Jonathan on 7/17/15.
//  Copyright © 2015 Jonathan Underwood. All rights reserved.
//

public class Cell {
    public let row: Int
    public let column: Int

    private var _links = Set<Cell>()
    public var links: Set<Cell> {
        get {
            return _links
        }
    }

    public var north: Cell?
    public var east: Cell?
    public var south: Cell?
    public var west: Cell?

    public var neighbors: [Cell] {
        get {
            var neighbors = [Cell]()

            if let north = north { neighbors.append(north) }
            if let east = south { neighbors.append(east) }
            if let south = south { neighbors.append(south) }
            if let west = south { neighbors.append(west) }

            return neighbors
        }
    }

    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }

    public func link(cell: Cell, bidirectionally: Bool) {
        _links.insert(cell)

        if bidirectionally {
            cell.link(self, bidirectionally: false)
        }
    }

    public func unlink(cell: Cell, bidirectionally: Bool) {
        _links.remove(cell)

        if bidirectionally {
            cell.unlink(self, bidirectionally: false)
        }
    }

    public func linked(toCell cell: Cell) -> Bool {
        if links.indexOf(cell) != nil {
            return true
        } else {
            return false
        }
    }
}

extension Cell: Hashable {
    public var hashValue: Int {
        get {
            return row.hashValue ^ column.hashValue
        }
    }
}

public func ==(lhs: Cell, rhs: Cell) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}

extension Cell: CustomStringConvertible {
    public var description: String {
        get {
            return "\(row), \(column)"
        }
    }
}
