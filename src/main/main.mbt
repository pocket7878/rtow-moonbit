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
  println("P3\n\{image_width} \{image_height}\n255")
  let viewport_height = 2.0
  let viewport_width = aspect_ratio * viewport_height
  let focal_length = 1.0
  let origin = @lib.Point3::new(0.0, 0.0, 0.0)
  let horizontal = @lib.Vec3::new(viewport_width, 0.0, 0.0)
  let vertical = @lib.Vec3::new(0.0, viewport_height, 0.0)
  let lower_left_corner = origin -
    horizontal.div_scalar(2.0) -
    vertical.div_scalar(2.0) -
    @lib.Vec3::new(0.0, 0.0, focal_length)

    let world = @lib.HittableList::new()
    world.add(@lib.Sphere::new(@lib.Point3::new(0,0,-1), 0.5))
    world.add(@lib.Sphere::new(@lib.Point3::new(0,-100.5,-1), 100))
  for j = image_height - 1; j >= 0; j = j - 1 {
    for i = 0; i < image_width; i = i + 1 {
      let u = i.to_double() / (image_width - 1).to_double()
      let v = j.to_double() / (image_height - 1).to_double()
      let ray = @lib.Ray::new(
        origin,
        lower_left_corner +
        horizontal.mul_scalar(u) +
        vertical.mul_scalar(v) -
        origin,
      )
      let c = ray_color(ray, world)
      @lib.write_color(c)
    }
  }
}
