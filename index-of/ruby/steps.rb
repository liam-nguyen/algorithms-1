#!/usr/bin/env ruby

require_relative 'animation'

def build_pi pattern
  pi = Array.new(pattern.length, 0) # Array of zeroes of length |pattern|
  m = 0
  (1...pattern.length).each do |k|
    while m > 0 && pattern[m] != pattern[k]
      m = pi[m - 1]
    end
    if pattern[m] == pattern[k]
      m += 1
    end
    pi[k] = m
  end
  return pi
end

def draw_indexes animation
  index_grid = Grid.new x_margin: 15
  (0..9).each_with_index do |n, i|
    Text.new(animation, n.to_s, x: i, y: 1, color: 'gray40', size: 12, grid: index_grid).draw
  end
  index_grid = Grid.new x_margin: 13
  (10..19).each_with_index do |n, i|
    Text.new(animation, n.to_s, x: i + 10, y: 1, color: 'gray40', size: 12, grid: index_grid).draw
  end
end

def index_of pattern, text

  animation = Animation.new 'steps', 400, 175
  tt = Text.new(animation, text, y: 2).draw
  pt = Text.new(animation, pattern, color: 'gray60', y: 3).draw
  draw_indexes animation
  index_grid = Grid.new x_margin: 15, y_margin: 25
  qt = Text.new(animation, 'q', color: 'purple', bold: true, grid: index_grid, size: 16).draw
  kt = Text.new(animation, 'k', color: 'purple', bold: true, grid: index_grid, size: 16, y: 4).draw
  animation.next

  mismatches = 0

  pi = build_pi pattern
  k = 0
  (0...text.length).each do |q|

    qt.movex(q).draw
    kt.movex(q).draw

    while k > 0 && pattern[k] != text[q]

      Text.new(animation, pattern[k], color: 'red', x: q, y: 3).draw
      animation.frame.delay = 100
      if mismatches == 0
        animation.frame.delay = 150
        animation.write 'first-comparison'
      end
      animation.next
      animation.frame.erase!

      mismatches += 1

      k = pi[k - 1]

      qt.putx(q).draw
      kt.putx(q).draw
      tt.draw
      pt.putx(q - k).draw
      draw_indexes animation
      if k > 0
        Text.new(animation, pattern[0...k], color: 'blue', x: q - k, y: 3).draw
        animation.frame.delay = 100
      else
        animation.frame.delay = 100
      end
      animation.next

    end

    if pattern[k] == text[q]
      Text.new(animation, pattern[k], color: 'green', x: q, y: 3).draw
      animation.next
      if k + 1 == pattern.length
        animation.write
        return q - k 
      end
      k += 1
    end

  end
  return -1
end

def main
  text = readline.strip
  pattern = readline.strip
  puts index_of pattern, text
end

main
