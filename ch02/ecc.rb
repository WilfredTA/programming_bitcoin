class FieldElement
  attr_accessor :num, :prime
  def initialize(num, prime)
    if num >= prime || num < 0
      raise Exception.new("Num is not in correct range")
    end
    self.num = num
    self.prime = prime
  end

  def to_s
    return "FieldElement_#{self.prime}(#{self.num})"
  end

  def ==(other)
    if !other
      return false
    end
    return self.num == other.num && self.prime == other.prime
  end

  def !=(other)
    return !self.==(other)
  end

  def +(other)
    operation = lambda { |other|
    (self.num + other.num) % self.prime
  }
    op(other, 'addition', operation)
  end

  def -(other)
    operation = lambda { |other|
    (self.num - other.num) % self.prime
  }
    op(other, 'subtraction', operation)
  end

  def *(other)
    operation = lambda {|other| 
      (self.num * other.num) % self.prime
    }
    op(other, 'multiplication', operation)
  end

  def **(other)
    operation = lambda {|other| 
      (self.num ** other.num) % self.prime
    }

    op(other, 'exponentiation', operation)
  end

  def /(other)
    operation = lambda {|other| 
      ((self.num * inverse(other)) % self.prime)
    }
    op(other, 'division', operation)
  end

  private

  def op(other, name, operation)
    if other.prime != self.prime
      raise FieldOperationError.new([self, other], name)
    end
    new_val = operation.call(other)
    self.class.new(new_val, self.prime)
  end

  def inverse(other)
    other.num ** (other.prime - 2)
  end

end



class Point
  attr_accessor :a, :b, :x, :y
  def initialize(x, y, a, b)
    self.a = a
    self.b = b,
    self.x = x
    self.y = y

    return if x == nil && y == nil
    if self.y ** 2 != self.x ** 3 + a * x + b
      raise PointError.new("#{x} and #{y} are not on the right curve")
  end

  def ==(other)
    self.x == other.x && self.y == other.y &&
    self.a == other.a && self.b == other.b
  end

  def !=(other)
    !self == other
  end

  def +(other)
    # Handle points on different curves
    if self.a != other.a || self.b != other.b
      raise PointError.new("Points are not on the same curve")
    end

    # Handle the identity point being added
    if self.x == nil
      return other
    end
    if other.x == nil
      return self
    end

    # Handle additive inverses
    if self.x == other.x && self.y != other.y
      return self.infinityPoint(self.a, self.b)
    end

    # Handle distinct points on the same curve


    # Handle the equivalent points

  end

  private

  def infinityPoint(a, b)
    self.class.new(nil, nil, a, b)
  end
end

class FieldOperationError < StandardError
  attr_accessor :fieldElements, :operation
  def initialize(fieldElements, operation)
    self.fieldElements = fieldElements
    self.operation = operation
    msg = "#{operation} cannot be performed on #{fieldElements}"
    super(msg)
  end
end

class PointError < StandardError
  def initialize(msg)
    super(msg)
  end

end