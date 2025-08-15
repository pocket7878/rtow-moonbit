///|
struct Sphere {
  center : @vec3.Point3
  radius : Double
  mat : &@material.Material
}

///|
pub fn Sphere::new(
  cen : @vec3.Point3,
  radius : Double,
  m : &@material.Material,
) -> Sphere {
  { center: cen, radius, mat: m }
}

///|
pub impl @hittable.Hittable for Sphere with hit(
  self : Sphere,
  r : @ray.Ray,
  t_min : Double,
  t_max : Double,
) -> @hittable.HitRecord? {
  let oc = r.origin() - self.center
  let a = r.direction().length_squared()
  let half_b = @vec3.dot(oc, r.direction())
  let c = oc.length_squared() - self.radius * self.radius
  let discriminant = half_b * half_b - a * c
  if discriminant > 0.0 {
    let root = discriminant.sqrt()
    let temp = (-half_b - root) / a
    if temp < t_max && temp > t_min {
      let outward_normal = (r.at(temp) - self.center).div_scalar(self.radius)
      let rec : @hittable.HitRecord = {
        t: temp,
        p: r.at(temp),
        normal: (r.at(temp) - self.center).div_scalar(self.radius),
        // temporary value
        front_face: false,
        mat: self.mat,
      }
      // Adjust face normal
      rec.set_face_normal(r, outward_normal)
      return Some(rec)
    }
    let temp = (-half_b + root) / a
    if temp < t_max && temp > t_min {
      let outward_normal = (r.at(temp) - self.center).div_scalar(self.radius)
      let rec : @hittable.HitRecord = {
        t: temp,
        p: r.at(temp),
        normal: (r.at(temp) - self.center).div_scalar(self.radius),
        // temporary value
        front_face: false,
        mat: self.mat,
      }
      // Adjust face normal
      rec.set_face_normal(r, outward_normal)
      return Some(rec)
    }
  }
  return None
}
