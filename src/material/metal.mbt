///|
struct Metal {
  albedo : @color.Color
  fuzz : Double
}

///|
pub fn Metal::new(a : @color.Color, f : Double) -> Metal {
  { albedo: a, fuzz: f }
}

///|
pub impl Material for Metal with scatter(
  self : Metal,
  r_in : @ray.Ray,
  normal : @vec3.Vec3,
  hit_point : @vec3.Point3,
) -> (@color.Color, @ray.Ray)? {
  let reflected = @vec3.reflect(@vec3.unit_vector(r_in.direction()), normal)
  let scattered = @ray.Ray::new(
    hit_point,
    reflected + @vec3.random_vec3_in_unit_sphare().mul_scalar(self.fuzz),
  )
  let attenuation = self.albedo
  if @vec3.dot(scattered.direction(), normal) > 0 {
    Some((attenuation, scattered))
  } else {
    None
  }
}
