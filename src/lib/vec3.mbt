///|
struct Vec3 {
  e : FixedArray[Double]
}

///|
pub fn Vec3::x(self : Vec3) -> Double {
  return self.e[0]
}

///|
pub fn Vec3::y(self : Vec3) -> Double {
  return self.e[1]
}

///|
pub fn Vec3::z(self : Vec3) -> Double {
  return self.e[2]
}

///|
pub impl Default for Vec3 with default() -> Vec3 {
  { e: FixedArray::make(3, 0) }
}

///|
pub fn Vec3::length(self : Vec3) -> Double {
  self.length_squared().sqrt()
}

///|
pub fn Vec3::length_squared(self : Vec3) -> Double {
  self.e[0] * self.e[0] + self.e[1] * self.e[1] + self.e[2] * self.e[2]
}

///|
pub fn Vec3::new(e0 : Double, e1 : Double, e2 : Double) -> Vec3 {
  { e: [e0, e1, e2] }
}

///|
pub impl Show for Vec3 with output(self : Vec3, l : &Logger) {
  l.write_string("\{self.e[0]} \{self.e[1]} \{self.e[2]}")
}

///|
pub impl Neg for Vec3 with op_neg(self : Vec3) -> Vec3 {
  Vec3::new(-self.e[0], -self.e[1], -self.e[2])
}

///|
pub impl Add for Vec3 with op_add(self : Vec3, other : Vec3) -> Vec3 {
  Vec3::new(
    self.e[0] + other.e[0],
    self.e[1] + other.e[1],
    self.e[2] + other.e[2],
  )
}

///|
pub impl Sub for Vec3 with op_sub(self : Vec3, other : Vec3) -> Vec3 {
  Vec3::new(
    self.e[0] - other.e[0],
    self.e[1] - other.e[1],
    self.e[2] - other.e[2],
  )
}

///|
pub impl Mul for Vec3 with op_mul(self : Vec3, other : Vec3) -> Vec3 {
  Vec3::new(
    self.e[0] * other.e[0],
    self.e[1] * other.e[1],
    self.e[2] * other.e[2],
  )
}

///|
pub fn Vec3::mul_scalar(self : Vec3, d : Double) -> Vec3 {
  Vec3::new(self.e[0] * d, self.e[1] * d, self.e[2] * d)
}

///|
pub fn Vec3::div_scalar(self : Vec3, d : Double) -> Vec3 {
  self.mul_scalar(1 / d)
}

///|
pub fn dot(a : Vec3, b : Vec3) -> Double {
  a.e[0] * b.e[0] + a.e[1] * b.e[1] + a.e[2] * b.e[2]
}

///|
pub fn Vec3::cross(self : Vec3, other : Vec3) -> Vec3 {
  Vec3::new(
    self.e[1] * other.e[2] - self.e[2] * other.e[1],
    self.e[2] * other.e[0] - self.e[0] * other.e[2],
    self.e[0] * other.e[1] - self.e[1] * other.e[0],
  )
}

///|
pub fn Vec3::unit_vector(self : Vec3) -> Vec3 {
  self.div_scalar(self.length())
}

///|
pub fn op_get(self : Vec3, key : Int) -> Double {
  return self.e[key]
}

///|
pub typealias Vec3 as Point3

///|
pub typealias Vec3 as Color
