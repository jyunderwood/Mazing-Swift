//
//  BinaryTreeMaze.swift
//  Mazing
//
//  Created by Jonathan on 7/17/15.
//  Copyright © 2015 Jonathan Underwood. All rights reserved.
//

import Foundation

public class BinaryTreeMaze {
    public static func on(grid: Grid) {
        grid.eachCell { cell in
            var neighbors = [Cell]()
            if let northCell = cell.north { neighbors.append(northCell) }
            if let eastCell = cell.east { neighbors.append(eastCell) }

            if neighbors.count != 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(neighbors.count)))
                let neighbor = neighbors[randomIndex]
                cell.link(neighbor, bidirectionally: true)
            }
        }
    }
}
