struct Sphere {
    center: Point3;
    radius: Double
}

pub fn Sphere::new(cen: Point3, radius: Double) -> Sphere {
    {
        center: cen,
        radius: radius
    }
}

pub impl Default for Sphere with default() -> Sphere {
    {
        center: Point3::default(),
        radius: 0.0
    }
}

pub impl Hittable for Sphere with hit(self: Sphere, r: Ray, t_min: Double, t_max: Double) -> Option[HitRecord] {
  let oc = r.origin() - self.center
  let a = r.direction().length_squared()
  let half_b = dot(oc, r.direction())
  let c = oc.length_squared() - self.radius*self.radius
  let discriminant = half_b*half_b - a*c

  if (discriminant > 0.0) {
      let root = discriminant.sqrt()
      let temp = (-half_b - root) / a
      if (temp < t_max && temp > t_min) {
          let outward_normal = (r.at(temp) - self.center).div_scalar(self.radius)
          let rec: HitRecord = {
              t: temp,
              p: r.at(temp),
              normal: (r.at(temp) - self.center).div_scalar(self.radius),
              // temporary value
              front_face: false
          }
          // Adjust face normal
          rec.set_face_normal(r, outward_normal)
          return Some(rec)
      }

      let temp = (-half_b + root) / a
      if (temp < t_max && temp > t_min) {
          let outward_normal = (r.at(temp) - self.center).div_scalar(self.radius)
          let rec: HitRecord = {
              t: temp,
              p: r.at(temp),
              normal: (r.at(temp) - self.center).div_scalar(self.radius),
              // temporary value
              front_face: false
          }
          // Adjust face normal
          rec.set_face_normal(r, outward_normal)
          return Some(rec)
      }
  }

  return None
}
