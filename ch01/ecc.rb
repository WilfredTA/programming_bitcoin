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

class FieldOperationError < StandardError
  attr_accessor :fieldElements, :operation
  def initialize(fieldElements, operation)
    self.fieldElements = fieldElements
    self.operation = operation
    msg = "#{operation} cannot be performed on #{fieldElements}"
    super(msg)
  end
end