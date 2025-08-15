///|
struct Camera {
  origin : @vec3.Point3
  lower_left_corner : @vec3.Point3
  horizontal : @vec3.Vec3
  vertical : @vec3.Vec3
}

///|
pub fn Camera::new(
  lookfrom : @vec3.Point3,
  lookat : @vec3.Point3,
  vup : @vec3.Vec3,
  vfov : Double,
  aspect_ratio : Double,
) -> Camera {
  let theta = @utils.degrees_to_radians(vfov)
  let h = @math.tan(theta / 2.0)
  let viewport_height = 2.0 * h
  let viewport_width = aspect_ratio * viewport_height
  let w = @vec3.unit_vector(lookfrom - lookat)
  let u = @vec3.unit_vector(vup.cross(w))
  let v = w.cross(u)
  let origin = lookfrom
  let horizontal = u.mul_scalar(viewport_width)
  let vertical = v.mul_scalar(viewport_height)
  let lower_left_corner = origin -
    horizontal.div_scalar(2) -
    vertical.div_scalar(2) -
    w
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
