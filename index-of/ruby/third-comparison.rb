#!/usr/bin/env ruby

require_relative 'animation'

def bg animation
  index_grid = Grid.new x_margin: 15
  (0..9).each_with_index do |n, i|
    Text.new(animation, n.to_s, x: i, y: 1, color: 'gray40', size: 12, grid: index_grid).draw
  end
  index_grid = Grid.new x_margin: 13
  (10..19).each_with_index do |n, i|
    Text.new(animation, n.to_s, x: i + 10, y: 1, color: 'gray40', size: 12, grid: index_grid).draw
  end

  Text.new(animation, 'ababaababacababacabc', y: 2).draw

end

def qk animation, x
  index_grid = Grid.new x_margin: 15, y_margin: 25
  Text.new(animation, 'q', color: 'purple', bold: true, grid: index_grid, size: 16, x: 11 + x).draw
  Text.new(animation, 'k', color: 'purple', bold: true, grid: index_grid, size: 16, x: 11 + x, y: 5).draw
end

def pi animation, x=0
  index_grid = Grid.new x_margin: 15, y_margin: 25
  (0...8).each { |i|
    Text.new(animation, '00123012'[i], x: x + i, y: 4, color: 'purple', size: 16, bold: true,  grid: index_grid).draw
  }
  Text.new(animation, '(Pi)', x: -0.5, y: 4, color: 'purple', size: 16, bold: true,  grid: index_grid).draw
end

def pat animation, p
  Text.new(animation, 'ababacabc'[0..1], x: 11, y: 3, color: 'blue').draw
  Text.new(animation, 'ababacabc'[2...p], x: 11 + 2, y: 3, color: 'green').draw
  Text.new(animation, 'ababacabc'[[2, p].max ..-1], x: 11 + [2, p].max, y: 3, color: 'gray60').draw
end

def main
  animation = Animation.new 'third-comparison', 400, 190
  
  (1..9).each { |x|
    bg animation
    qk animation, if x <= 2 then 2 else x - 1 end
    pat animation, x
    pi animation, 11
    animation.frame.delay = 100 if x == 0
    animation.frame.delay = 150 if x == 9
    if x < 9
      animation.next
      animation.frame.erase! 
    end
  }

  animation.write
end

main
