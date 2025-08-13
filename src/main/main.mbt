///|
fn ray_color(r : @lib.Ray, world : @lib.HittableList) -> @lib.Color {
  match world.hit(r, 0, @double.infinity) {
    Some(rec) =>
      return (rec.normal() + @lib.Color::new(1, 1, 1)).mul_scalar(0.5)
    None => {
      let unit_direction : @lib.Vec3 = r.direction().unit_vector()
      let t = 0.5 * (unit_direction.y() + 1.0)
      return @lib.Color::new(1.0, 1.0, 1.0).mul_scalar(1.0 - t) +
        @lib.Color::new(0.5, 0.7, 1.0).mul_scalar(t)
    }
  }
}

///|
fn main {
  let aspect_ratio : Double = 16.0 / 9.0
  let image_width : Int = 384
  let image_height : Int = (image_width.to_double() / aspect_ratio).to_int()
  let samples_per_pixel : Int = 100
  println("P3\n\{image_width} \{image_height}\n255")
  let world = @lib.HittableList::new()
  world.add(@lib.Sphere::new(@lib.Point3::new(0, 0, -1), 0.5))
  world.add(@lib.Sphere::new(@lib.Point3::new(0, -100.5, -1), 100))
  let cam = @lib.Camera::new()
  for j = image_height - 1; j >= 0; j = j - 1 {
    for i = 0; i < image_width; i = i + 1 {
      let mut pixel_color : @lib.Color = @lib.Color::new(0, 0, 0)
      for s = 0; s < samples_per_pixel; s = s + 1 {
        let u = (i.to_double() + @lib.random_double()) /
          (image_width - 1).to_double()
        let v = (j.to_double() + @lib.random_double()) /
          (image_height - 1).to_double()
        let r = cam.get_ray(u, v)
        pixel_color += ray_color(r, world)
      }
      @lib.write_color(pixel_color, samples_per_pixel)
    }
  }
}
