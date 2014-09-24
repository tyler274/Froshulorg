require 'csv'

imgnum = 1
CSV.foreach('./froshes.csv', :headers => true) do |row|
  puts row.inspect
  frosh = Frosh.new
  full_name = row['First Name'] + ' ' + row['Last Name']

  frosh.name = full_name
  frosh.last_name = row['Last Name']
  frosh.anagram = row['Anagram']
  (1..7).each do |num|
    key = num.to_s
    if row[key] == 'Dabney'
      frosh.dessert = num
    end
  end

  ('A'..'H').each do |letter|
    if row[letter] == 'Dabney'
      frosh.dinner = letter.ord - 'A'.ord + 1
    end
  end

  frosh.interest_url = 'http://131.215.167.202:2014/assets/' + row['Last Name'].downcase + ', ' + row['First Name'].downcase + '.pdf'

  frosh.image_url = 'noimg.png'#'image_' + imgnum.to_i + '.png'
  imgnum = imgnum + 1

  if row['Gender'] == 'm'
    frosh.male = true
  else
    frosh.male = false
  end

  frosh.save
  puts 'saved'
end
