///|
struct Dielectric {
  ref_idx : Double
}

///|
pub fn Dielectric::new(ri : Double) -> Dielectric {
  { ref_idx: ri }
}

///|
pub impl Material for Dielectric with scatter(
  self : Dielectric,
  r_in : @ray.Ray,
  normal : @vec3.Vec3,
  hit_point : @vec3.Point3,
  front_face : Bool,
) -> (@color.Color, @ray.Ray)? {
  let attenuation = @color.Color::new(1.0, 1.0, 1.0)
  let etai_over_etat : Double = if front_face {
    1.0 / self.ref_idx
  } else {
    self.ref_idx
  }
  let unit_direction = @vec3.unit_vector(r_in.direction())
  let cos_theta = @cmp.minimum(@vec3.dot(-unit_direction, normal), 1.0)
  let sin_theta = (1.0 - cos_theta * cos_theta).sqrt()
  if etai_over_etat * sin_theta > 1.0 {
    let reflected = @vec3.reflect(unit_direction, normal)
    let scattered = @ray.Ray::new(hit_point, reflected)
    return Some((attenuation, scattered))
  }
  let reflect_prob = schlick(cos_theta, etai_over_etat)
  if @utils.random_double() < reflect_prob {
    let reflected = @vec3.reflect(unit_direction, normal)
    let scattered = @ray.Ray::new(hit_point, reflected)
    return Some((attenuation, scattered))
  }
  let refracted = @vec3.refract(unit_direction, normal, etai_over_etat)
  let scattered = @ray.Ray::new(hit_point, refracted)
  Some((attenuation, scattered))
}

///|
fn schlick(cosine : Double, ref_idx : Double) -> Double {
  let mut r0 = (1.0 - ref_idx) / (1.0 + ref_idx)
  r0 = r0 * r0
  return r0 + (1.0 - r0) * @math.pow(1.0 - cosine, 5.0)
}
