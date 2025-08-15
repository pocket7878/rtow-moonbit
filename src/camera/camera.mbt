///|
struct Camera {
  origin : @vec3.Point3
  lower_left_corner : @vec3.Point3
  horizontal : @vec3.Vec3
  vertical : @vec3.Vec3
}

///|
pub fn Camera::new() -> Camera {
  let aspect_ratio = 16.0 / 9.0
  let viewport_height = 2.0
  let viewport_width = aspect_ratio * viewport_height
  let focal_length = 1.0
  let origin = @vec3.Point3::new(0, 0, 0)
  let horizontal = @vec3.Vec3::new(viewport_width, 0.0, 0.0)
  let vertical = @vec3.Vec3::new(0.0, viewport_height, 0.0)
  let lower_left_corner = origin -
    horizontal.div_scalar(2) -
    vertical.div_scalar(2) -
    @vec3.Vec3::new(0, 0, focal_length)
  return { origin, lower_left_corner, horizontal, vertical }
}

///|
pub fn Camera::get_ray(self : Camera, u : Double, v : Double) -> @ray.Ray {
  @ray.Ray::new(
    self.origin,
    self.lower_left_corner +
    self.horizontal.mul_scalar(u) +
    self.vertical.mul_scalar(v) -
    self.origin,
  )
}
