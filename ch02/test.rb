require 'minitest/autorun'
require_relative './ecc.rb'

class EccTest < Minitest::Test
  def test_ne
    a = FieldElement.new(2, 31)
    b = FieldElement.new(2, 31)
    c = FieldElement.new(15, 31)
    assert_equal a, b
    assert(a != c)
    assert(!(a != b))
  end

  def test_add
    a = FieldElement.new(4, 19)
    b = FieldElement.new(17, 19)
    c = FieldElement.new(6, 20)
    assert_raises FieldOperationError do
      a + c
    end
    assert_equal(a + b, FieldElement.new(2, 19))
    assert_equal(b + a, FieldElement.new(2, 19))
  end

  def test_sub
    a = FieldElement.new(4, 19)
    b = FieldElement.new(17, 19)
    c = FieldElement.new(6, 20)

    assert_equal(a - b, FieldElement.new(6, 19))
    assert_equal(b - a, FieldElement.new(13, 19))
    assert_raises FieldOperationError do
      a - c
    end
  end

  def test_mul
    a = FieldElement.new(4, 19)
    b = FieldElement.new(17, 19)
    c = FieldElement.new(6, 20)

    assert_equal(a*b, FieldElement.new(11, 19))
    assert_equal(b*a, FieldElement.new(11, 19))
    assert_raises FieldOperationError do
      a * c
    end
  end

  def test_pow
    a = FieldElement.new(4, 19)
    b = FieldElement.new(17, 19)
    c = FieldElement.new(6, 20)

    assert_equal(a**b, FieldElement.new(5, 19))
    assert_equal(b**a, FieldElement.new(16, 19))
    assert_raises FieldOperationError do
      a ** c
    end
  end

  def test_div
    a = FieldElement.new(4, 7)
    b = FieldElement.new(3, 7)
    c = FieldElement.new(2, 5)

    assert_equal(a / b, FieldElement.new(6, 7))
    assert_equal(b / a, FieldElement.new(6, 7))
    assert_raises FieldOperationError do
      a / c
    end
  end

end
