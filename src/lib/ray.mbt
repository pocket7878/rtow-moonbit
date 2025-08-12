struct Ray {
    orig: Point3;
    dir: Vec3;
}

pub impl Default for Ray with default() -> Ray {
    return {
        orig: Point3::default(),
        dir: Vec3::default(),
    }
}

pub fn Ray::new(orig: Point3, dir: Vec3) -> Ray {
    return {
        orig: orig,
        dir: dir,
    }
}

pub fn Ray::origin(self: Ray) -> Point3 {
    return self.orig
}

pub fn Ray::direction(self: Ray) -> Vec3 {
    return self.dir
}

pub fn Ray::at(self: Ray, t: Double) -> Point3 {
    return self.orig + self.dir.mul_scalar(t)
}
