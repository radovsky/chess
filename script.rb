b = Board.new
b.move([6, 5], [5, 5])
b.move([1, 4], [2, 4])
b.move([2, 4], [3, 4])
b.move([6, 6], [5, 6])
b.move([5, 6], [4, 6])
b.move([0, 3], [4, 7])

b.grid.each do |line|
  p line
end


#totally checkmate
# [6, 5] - [5,5]
# [1, 4] - [3, 4]
# [6, 6] - [4, 6]
# [0, 3] - [4, 7]
# f2, f3
# e7, e5
# g2, g4
# d8, h4
