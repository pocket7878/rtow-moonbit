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
fn random_scene() -> @hittable.HittableList {
  let world = @hittable.HittableList::new()
  let ground_material = @material.Lambertian::new(
    @color.Color::new(0.5, 0.5, 0.5),
  )
  world.add(
    @sphere.Sphere::new(@vec3.Point3::new(0, -1000, 0), 1000, ground_material),
  )
  for a = -11; a < 11; a = a + 1 {
    for b = -11; b < 11; b = b + 1 {
      let choose_mat = @utils.random_double()
      let center = @vec3.Point3::new(
        a.to_double() + 0.9 * @utils.random_double(),
        0.2,
        b.to_double() + 0.9 * @utils.random_double(),
      )
      if (center - @vec3.Vec3::new(4, 0.2, 0)).length() > 0.9 {
        if choose_mat < 0.8 {
          // diffuse
          let albedo = @color.Color::random() * @color.Color::random()
          let material = @material.Lambertian::new(albedo)
          world.add(@sphere.Sphere::new(center, 0.2, material))
        } else if choose_mat < 0.95 {
          // metal
          let albedo = @color.Color::random_in_range(0.5, 1)
          let fuzz = @utils.random_double_in_range(0, 0.5)
          let material = @material.Metal::new(albedo, fuzz)
          world.add(@sphere.Sphere::new(center, 0.2, material))
        } else {
          // glass
          let material = @material.Dielectric::new(1.5)
          world.add(@sphere.Sphere::new(center, 0.2, material))
        }
      }
    }
  }
  world.add(
    @sphere.Sphere::new(
      @vec3.Point3::new(0, 1, 0),
      1.0,
      @material.Dielectric::new(1.5),
    ),
  )
  world.add(
    @sphere.Sphere::new(
      @vec3.Point3::new(-4, 1, 0),
      1.0,
      @material.Lambertian::new(@color.Color::new(0.4, 0.2, 0.1)),
    ),
  )
  world.add(
    @sphere.Sphere::new(
      @vec3.Point3::new(4, 1, 0),
      1.0,
      @material.Metal::new(@color.Color::new(0.7, 0.6, 0.5), 0.0),
    ),
  )
  world
}

///|
pub fn render(image_width : Int, image_height : Int) -> Unit {
  let aspect_ratio : Double = image_width.to_double() / image_height.to_double()
  let samples_per_pixel : Int = 100
  let max_depth = 50
  let world = random_scene()
  let lookfrom = @vec3.Point3::new(13, 2, 3)
  let lookat = @vec3.Point3::new(0, 0, 0)
  let vup = @vec3.Vec3::new(0, 1, 0)
  let dist_to_focus = 10.0
  let aperture = 0.1
  let cam = @camera.Camera::new(
    lookfrom, lookat, vup, 20, aspect_ratio, aperture, dist_to_focus,
  )
  let host : Host = Host::new()
  host.begin(image_width, image_height)
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
      host.pixel(i, j, pixel_color, samples_per_pixel)
    }
  }
}

///|
fn main {
  let aspect_ratio : Double = 16.0 / 9.0
  let image_width : Int = 384
  let image_height : Int = (image_width.to_double() / aspect_ratio).to_int()
  render(image_width, image_height)
}
