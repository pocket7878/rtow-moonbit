///|
struct Ray {
  orig : @vec3.Point3
  dir : @vec3.Vec3
}

///|
pub impl Default for Ray with default() -> Ray {
  return { orig: @vec3.Point3::default(), dir: @vec3.Vec3::default() }
}

///|
pub fn Ray::new(orig : @vec3.Point3, dir : @vec3.Vec3) -> Ray {
  return { orig, dir }
}

///|
pub fn Ray::origin(self : Ray) -> @vec3.Point3 {
  return self.orig
}

///|
pub fn Ray::direction(self : Ray) -> @vec3.Vec3 {
  return self.dir
}

///|
pub fn Ray::at(self : Ray, t : Double) -> @vec3.Point3 {
  return self.orig + self.dir.mul_scalar(t)
}
