///|
pub(open) trait Material {
  scatter(
    self : Self,
    r_in : @ray.Ray,
    normal : @vec3.Vec3,
    hit_point : @vec3.Point3,
  ) -> (@color.Color, @ray.Ray)?
}
