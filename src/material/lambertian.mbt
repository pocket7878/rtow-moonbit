///|
struct Lambertian {
  albedo : @color.Color
}

///|
pub fn Lambertian::new(a : @color.Color) -> Lambertian {
  { albedo: a }
}

///|
pub impl Material for Lambertian with scatter(
  self : Lambertian,
  r_in : @ray.Ray,
  normal : @vec3.Vec3,
  hit_point : @vec3.Point3,
  front_face : Bool,
) -> (@color.Color, @ray.Ray)? {
  let scatter_direction = normal + @vec3.random_unit_vector()
  let scattered = @ray.Ray::new(hit_point, scatter_direction)
  let attenuation = self.albedo
  return Some((attenuation, scattered))
}
