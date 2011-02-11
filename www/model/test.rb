require 'model.rb'

a = Klass.create(:name => "ClassA")
b = Klass.create(:name => "ClassB")

a.child_klasses << b
a.save

b = Klass.first(:name => "ClassB")
if b.base_klasses.size == 1
  puts "One base class:#{b.base_klasses.first.name}"
else
  puts 'No base class - fail'
end
