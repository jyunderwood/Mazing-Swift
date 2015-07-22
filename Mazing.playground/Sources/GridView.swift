//
//  GridView.swift
//  Mazing
//
//  Created by Jonathan on 7/17/15.
//  Copyright © 2015 Jonathan Underwood. All rights reserved.
//

import UIKit

public class GridView: UIView {
    var cellSize: CGFloat = 20
    public var grid: Grid?

    public init(cellSize: CGFloat, grid: Grid) {
        self.cellSize = cellSize
        self.grid = grid

        let width = CGFloat(grid.columns) * cellSize
        let height = CGFloat(grid.rows) * cellSize
        let frame = CGRectMake(0, 0, width, height)
        super.init(frame: frame)
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        if let grid = grid {
            grid.eachCell { cell in
                let x1: CGFloat = CGFloat(cell.column) * self.cellSize
                let y1: CGFloat = CGFloat(cell.row) * self.cellSize
                let x2: CGFloat = CGFloat(cell.column + 1) * self.cellSize
                let y2: CGFloat = CGFloat(cell.row + 1) * self.cellSize

                if cell.north == nil {
                    self.drawLine(context, x1, y1, x2, y1)
                }

                if cell.west == nil {
                    self.drawLine(context, x1, y1, x1, y2)
                }

                if let cellEast = cell.east {
                    if cell.linked(toCell: cellEast) == false {
                        self.drawLine(context, x2, y1, x2, y2)
                    }
                } else {
                    self.drawLine(context, x2, y1, x2, y2)
                }

                if let cellSouth = cell.south {
                    if cell.linked(toCell: cellSouth) == false {
                        self.drawLine(context, x1, y2, x2, y2)
                    }
                } else {
                    self.drawLine(context, x1, y2, x2, y2)
                }
            }
        }

        CGContextSetLineWidth(context, 1.0)
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextStrokePath(context)
    }


    private func drawLine(context: CGContext, _ x1: CGFloat, _ y1: CGFloat, _ x2: CGFloat, _ y2: CGFloat) {
        CGContextMoveToPoint(context, x1, y1)
        CGContextAddLineToPoint(context, x2, y2)
    }
}