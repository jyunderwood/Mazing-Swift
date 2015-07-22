let binaryTreeMaze = Grid(rows: 8, columns: 8)
BinaryTreeMaze.on(binaryTreeMaze)
print("\(binaryTreeMaze)")

var gridView = GridView(cellSize: 20, grid: binaryTreeMaze)
