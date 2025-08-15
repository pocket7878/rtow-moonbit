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
pub fn Vec3::random(min : Double, max : Double) -> Vec3 {
  return Vec3::new(
    @utils.random_double_in_range(min, max),
    @utils.random_double_in_range(min, max),
    @utils.random_double_in_range(min, max),
  )
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
pub fn unit_vector(v : Vec3) -> Vec3 {
  v.div_scalar(v.length())
}

///|
pub fn op_get(self : Vec3, key : Int) -> Double {
  return self.e[key]
}

///|
pub fn random_unit_vector() -> Vec3 {
  let a = @utils.random_double_in_range(0, 2 * @math.PI)
  let z = @utils.random_double_in_range(-1, 1)
  let r = (1.0 - z * z).sqrt()
  return Vec3::new(r * @math.cos(a), r * @math.sin(a), z)
}

///|
pub fn random_vec3_in_unit_sphare() -> Vec3 {
  let mut p = Vec3::random(-1, 1)
  while p.length_squared() >= 1 {
    p = Vec3::random(-1, 1)
  } else {
    return p
  }
}

///|
pub fn reflect(v : Vec3, n : Vec3) -> Vec3 {
  v - n.mul_scalar(2 * dot(v, n))
}

///|
pub fn refract(uv : Vec3, n : Vec3, etai_over_etat : Double) -> Vec3 {
  let cos_theta = dot(-uv, n)
  let r_out_parallel = (uv + n.mul_scalar(cos_theta)).mul_scalar(etai_over_etat)
  let r_out_prep = n.mul_scalar(-(1.0 - r_out_parallel.length_squared()).sqrt())
  return r_out_parallel + r_out_prep
}

///|
pub typealias Vec3 as Point3

///|
pub typealias Vec3 as Color
