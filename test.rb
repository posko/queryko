class A
  class << self
    attr_accessor :value
  end
  self.value = 1

  def self.inherited(subclass)
    puts "#{subclass.value} #{subclass}"
    if self.value == 1
      puts "Inside"
    end
  end
end

class B < A
  # self.value = 1
end

class C < B
end

class D < C
end

puts D.value
