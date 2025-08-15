///|
test "Vec3::default() returns zero vector" {
  let v : @vec3.Vec3 = @vec3.Vec3::default()
  assert_eq(v.x(), 0)
  assert_eq(v.y(), 0)
  assert_eq(v.z(), 0)
}

///|
test "Vec3::new() creates vector" {
  let v : @vec3.Vec3 = @vec3.Vec3::new(1, 2, 3)
  assert_eq(v.x(), 1)
  assert_eq(v.y(), 2)
  assert_eq(v.z(), 3)
}

///|
test "Vec3::neg() negate vector" {
  let v : @vec3.Vec3 = @vec3.Vec3::new(1, 2, 3)
  let v = -v
  assert_eq(v.x(), -1)
  assert_eq(v.y(), -2)
  assert_eq(v.z(), -3)
}

///|
test "access by index" {
  let v : @vec3.Vec3 = @vec3.Vec3::new(1, 2, 3)
  assert_eq(v[0], 1)
  assert_eq(v[1], 2)
  assert_eq(v[2], 3)
}

///|
test "add vectors" {
  let a : @vec3.Vec3 = @vec3.Vec3::new(1, 2, 3)
  let b : @vec3.Vec3 = @vec3.Vec3::new(4, 5, 6)
  let c = a + b
  assert_eq(c[0], 5)
  assert_eq(c[1], 7)
  assert_eq(c[2], 9)
}

///|
test "sub vectors" {
  let a : @vec3.Vec3 = @vec3.Vec3::new(9, 8, 7)
  let b : @vec3.Vec3 = @vec3.Vec3::new(2, 4, 6)
  let c = a - b
  assert_eq(c[0], 7)
  assert_eq(c[1], 4)
  assert_eq(c[2], 1)
}

///|
test "multiply by double scalar" {
  let a : @vec3.Vec3 = @vec3.Vec3::new(1, 2, 3)
  let b : Double = 2.0
  let c = a.mul_scalar(b)
  assert_eq(c[0], 2.0)
  assert_eq(c[1], 4.0)
  assert_eq(c[2], 6.0)
}

///|
test "divide by double scalar" {
  let a : @vec3.Vec3 = @vec3.Vec3::new(1, 2, 4)
  let b : Double = 2.0
  let c = a.div_scalar(b)
  assert_eq(c[0], 0.5)
  assert_eq(c[1], 1.0)
  assert_eq(c[2], 2.0)
}
