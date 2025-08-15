///|
struct Camera {
  origin : @vec3.Point3
  lower_left_corner : @vec3.Point3
  horizontal : @vec3.Vec3
  vertical : @vec3.Vec3
  u : @vec3.Vec3
  v : @vec3.Vec3
  w : @vec3.Vec3
  lens_radius : Double
}

///|
pub fn Camera::new(
  lookfrom : @vec3.Point3,
  lookat : @vec3.Point3,
  vup : @vec3.Vec3,
  vfov : Double,
  aspect_ratio : Double,
  aperture : Double,
  focus_dist : Double,
) -> Camera {
  let theta = @utils.degrees_to_radians(vfov)
  let h = @math.tan(theta / 2.0)
  let viewport_height = 2.0 * h
  let viewport_width = aspect_ratio * viewport_height
  let w = @vec3.unit_vector(lookfrom - lookat)
  let u = @vec3.unit_vector(vup.cross(w))
  let v = w.cross(u)
  let origin = lookfrom
  let horizontal = u.mul_scalar(viewport_width).mul_scalar(focus_dist)
  let vertical = v.mul_scalar(viewport_height).mul_scalar(focus_dist)
  let lower_left_corner = origin -
    horizontal.div_scalar(2) -
    vertical.div_scalar(2) -
    w.mul_scalar(focus_dist)
  let lens_radius : Double = aperture / 2.0
  return {
    origin,
    lower_left_corner,
    horizontal,
    vertical,
    u,
    v,
    w,
    lens_radius,
  }
}

///|
pub fn Camera::get_ray(self : Camera, s : Double, t : Double) -> @ray.Ray {
  let rd = @vec3.random_in_unit_disk().mul_scalar(self.lens_radius)
  let offset = self.u.mul_scalar(rd.x()) + self.v.mul_scalar(rd.y())
  @ray.Ray::new(
    self.origin + offset,
    self.lower_left_corner +
    self.horizontal.mul_scalar(s) +
    self.vertical.mul_scalar(t) -
    self.origin -
    offset,
  )
}
