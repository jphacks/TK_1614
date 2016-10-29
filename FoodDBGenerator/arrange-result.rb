def to_days(d)
  d = d[0..-11] if d.end_with?('once ripe')

  return 30 * d.match(/(\d+.\d+|\d+)/)[1].to_i if d.end_with?('months')
  return 30 if d.end_with?('month')
  return 7 * d.match(/(\d+.\d+|\d+)/)[1].to_i if d.end_with?('weeks')
  return 7 if d.end_with?('week')
  return d.match(/(\d+.\d+|\d+)/)[1].to_i if d.end_with?('days')
  return 1 if d.end_with?('day')

  raise "Dont match anything #{d}"
end

while line = gets
  jnames, enames, dates = line.chomp.split('&&')

  if dates
    print jnames + '&&' + enames + '&&'

    puts to_days(dates.split('&').map { |date|
      matched = date.match("(.+?)-(.+?)\s(.+)")
      matched ? "#{matched[2].to_i} #{matched[3]}" : date
    }.min { |a, b|
      to_days(a) <=> to_days(b)
    })
  end
end
