///|
pub(all) struct HitRecord {
  p : @vec3.Point3
  mut normal : @vec3.Vec3
  mat : &@material.Material
  t : Double
  mut front_face : Bool
}

///|
pub fn HitRecord::set_face_normal(
  self : HitRecord,
  r : @ray.Ray,
  outward_normal : @vec3.Vec3,
) -> Unit {
  self.front_face = @vec3.dot(r.direction(), outward_normal) < 0
  self.normal = if self.front_face { outward_normal } else { -outward_normal }
}

///|
pub(open) trait Hittable {
  hit(self : Self, r : @ray.Ray, t_min : Double, t_max : Double) -> HitRecord?
}
