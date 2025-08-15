///|
fn ray_color(
  r : @ray.Ray,
  world : @hittable.HittableList,
  depth : Int,
) -> @color.Color {
  if depth <= 0 {
    return @color.Color::new(0, 0, 0)
  }
  match world.hit(r, 0.001, @double.infinity) {
    Some(rec) =>
      match rec.mat.scatter(r, rec.normal, rec.p, rec.front_face) {
        Some((attenuation, scattered)) =>
          return attenuation * ray_color(scattered, world, depth - 1)
        None => return @color.Color::new(0, 0, 0)
      }
    None => {
      let unit_direction : @vec3.Vec3 = @vec3.unit_vector(r.direction())
      let t = 0.5 * (unit_direction.y() + 1.0)
      return @color.Color::new(1.0, 1.0, 1.0).mul_scalar(1.0 - t) +
        @color.Color::new(0.5, 0.7, 1.0).mul_scalar(t)
    }
  }
}

///|
fn main {
  let aspect_ratio : Double = 16.0 / 9.0
  let image_width : Int = 384
  let image_height : Int = (image_width.to_double() / aspect_ratio).to_int()
  let samples_per_pixel : Int = 100
  let max_depth = 50
  println("P3\n\{image_width} \{image_height}\n255")
  let world = @hittable.HittableList::new()
  // Ground
  world.add(
    @sphere.Sphere::new(
      @vec3.Point3::new(0, -100.5, -1),
      100,
      @material.Lambertian::new(@color.Color::new(0.8, 0.8, 0.0)),
    ),
  )
  // Center ball
  world.add(
    @sphere.Sphere::new(
      @vec3.Point3::new(0, 0, -1),
      0.5,
      @material.Lambertian::new(@color.Color::new(0.1, 0.2, 0.5)),
    ),
  )
  // Right ball
  world.add(
    @sphere.Sphere::new(
      @vec3.Point3::new(1, 0, -1),
      0.5,
      @material.Metal::new(@color.Color::new(0.8, 0.6, 0.2), 0.3),
    ),
  )
  world.add(
    @sphere.Sphere::new(
      @vec3.Point3::new(-1, 0, -1),
      0.5,
      @material.Dielectric::new(1.5),
    ),
  )
  world.add(
    @sphere.Sphere::new(
      @vec3.Point3::new(-1, 0, -1),
      -0.45,
      @material.Dielectric::new(1.5),
    ),
  )
  let cam = @camera.Camera::new(
    @vec3.Point3::new(-2, 2, 1),
    @vec3.Point3::new(0, 0, -1),
    @vec3.Vec3::new(0, 1, 0),
    90,
    aspect_ratio,
  )
  for j = image_height - 1; j >= 0; j = j - 1 {
    for i = 0; i < image_width; i = i + 1 {
      let mut pixel_color : @color.Color = @color.Color::new(0, 0, 0)
      for s = 0; s < samples_per_pixel; s = s + 1 {
        let u = (i.to_double() + @utils.random_double()) /
          (image_width - 1).to_double()
        let v = (j.to_double() + @utils.random_double()) /
          (image_height - 1).to_double()
        let r = cam.get_ray(u, v)
        pixel_color += ray_color(r, world, max_depth)
      }
      @color.write_color(pixel_color, samples_per_pixel)
    }
  }
}
