require 'minitest/autorun'
require_relative './ecc.rb'

class EccTest < Minitest::Test
  def test_on_curve
    prime = 223
    a = FieldElement.new(0, prime)
    b = FieldElement.new(7, prime)
    valid_points = [[192, 105], [17,56], [1,193]]
    invalid_points = [[200, 119], [42,99]]
    valid_points.each do |p|
      x = FieldElement.new(p[0], prime)
      y = FieldElement.new(p[1], prime)
      Point.new(x,y,a,b)
    end

    invalid_points.each do |p|
      x = FieldElement.new(p[0], prime)
      y = FieldElement.new(p[1], prime)

      assert_raises PointError do
        Point.new(x,y,a,b)
      end
    end

  end

  def test_mul
    prime = 223
    a = FieldElement.new(0, prime)
    b = FieldElement.new(7, prime)
    x = FieldElement.new(47, prime)
    y = FieldElement.new(71, prime)
    p = Point.new(x,y,a,b)
  #  z = S256Field.new(0x79be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798)

    assert_equal((p * 1), p)
    assert_equal((p * 2),
      Point.new(
        FieldElement.new(36, prime),
        FieldElement.new(111, prime),
        a, b))
  end


end
