mass = [0, 1]
i = 0
until mass[-1] > 144
  n = mass[i] + mass[i.next]
  mass.push(n)
  puts mass[i]
  i += 1
end
