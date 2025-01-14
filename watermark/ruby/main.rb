#!/usr/bin/env ruby

def volume_of_segment h, s, e
  watermak = [h[s], h[e]].min
  volume = 0
  h[(s+1)..(e-1)].each do |n|
    volume += watermak - n
  end
  return volume
end

def volume_increasing h
  return 0 if h.empty?
  volume = 0
  max = h[0]
  maxi = 0
  h[1..-1].each_with_index do |n, i|
    if n >= max
      volume += volume_of_segment h, maxi, (i + 1)
      max = n
      maxi = (i + 1)
    end
  end
  return volume
end

def volume h
  return 0 if h.empty?
  max = h.max
  maxi = h.find_index max
  first_half = h[0..maxi]
  second_half = h[maxi..-1].reverse
  vfh = volume_increasing(first_half)
  vsh = volume_increasing(second_half)
  return vfh + vsh
end

while true
  h = readline.strip.split(' ').map(&:to_i) rescue break
  puts volume h
end

# puts volume [3, 2, 1, 0, 1, 2, 3] # 9
# puts volume [-3, -2, -1, 0, 1, 2, 3] # 0
# puts volume [3, 2, 1, 0, -1, -2, -3] # 0
# puts volume [0, 1, 0, 1, 0] # 1
# puts volume [0, 1, 0, 2, 0, 3, 1, 2, 1, 3] # 8
# puts volume [0, 1, 0, 2, 0, 3, 1, 2, 1, 3, 0, 0] # 8
# puts volume [0, 0, 0, 1, 0, 5, 0, 3, 0, 0, 6, 0, 0, 4, 0, 0] # 26

