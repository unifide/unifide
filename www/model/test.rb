require 'model.rb'

a = MClass.create(:name => "ClassA")
b = MClass.create(:name => "ClassB")

a.child_klasses << b
a.save

b = MClass.first(:name => "ClassB")
if b.base_klasses.size == 1
  puts "One base class:#{b.base_klasses.first.name}"
else
  puts 'No base class - fail'
end
