//
//  Grid.swift
//  Mazing
//
//  Created by Jonathan on 7/17/15.
//  Copyright © 2015 Jonathan Underwood. All rights reserved.
//

public class Grid {
    public let rows: Int
    public let columns: Int
    private let grid: [[Cell]]

    public var size: Int {
        get {
            return rows * columns
        }
    }

    public init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        self.grid = Grid.prepareGrid(withRows: rows, columns: columns)
        configureCells()
    }

    public func cellAt(row row: Int, column: Int) -> Cell? {
        if row < 0 || row >= rows { return nil }
        if column < 0 || column >= columns { return nil }

        return grid[row][column]
    }

    public func eachRow(rowResponse: ([Cell]) -> ()) {
        for row in grid {
            rowResponse(row)
        }
    }

    public func eachCell(cellReponse: (Cell) -> ()) {
        for row in grid {
            for cell in row {
                cellReponse(cell)
            }
        }
    }

    private class func prepareGrid(withRows rows: Int, columns: Int) -> [[Cell]] {
        var grid = [[Cell]]()

        for r in 0..<rows {
            var column = [Cell]()
            for c in 0..<columns {
                column.insert(Cell(row: r, column: c), atIndex: c)
            }

            grid.append(column)
        }

        return grid
    }

    private func configureCells() {
        eachCell { cell in
            let row = cell.row
            let column = cell.column

            if let north = self.cellAt(row: row - 1, column: column) { cell.north = north }
            if let south = self.cellAt(row: row + 1, column: column) { cell.south = south }
            if let west = self.cellAt(row: row, column: column - 1) { cell.west = west }
            if let east = self.cellAt(row: row, column: column + 1) { cell.east = east }
        }
    }
}

extension Grid: CustomStringConvertible {
    public var description: String {
        get {

            // Top of Grid
            var output = "+"
            for _ in 1...columns { output += "---+" }
            output += "\n"

            eachRow { row in
                var top = "|"
                var bottom = "+"

                for cell in row {
                    let emptiness = "   " // 3 spaces

                    var eastBoundary = "|"
                    if let eastCell = cell.east {
                        if cell.linked(toCell: eastCell) {
                            eastBoundary = " "
                        }
                    }

                    var southBoundary = "---"
                    if let southCell = cell.south {
                        if cell.linked(toCell: southCell) {
                            southBoundary = emptiness
                        }
                    }

                    top += "\(emptiness)\(eastBoundary)"
                    bottom += "\(southBoundary)+"
                }
                
                output += "\(top)\n"
                output += "\(bottom)\n"
            }
            
            return output
        }
    }
}
