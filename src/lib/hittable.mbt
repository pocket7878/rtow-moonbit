struct HitRecord {
    p: Point3;
    mut normal: Vec3;
    t: Double;
    mut front_face: Bool;
}

pub fn HitRecord::normal(self: HitRecord) -> Vec3 {
    return self.normal
}

pub fn HitRecord::set_face_normal(self: HitRecord, r: Ray, outward_normal: Vec3) -> Unit {
    self.front_face = dot(r.direction(), outward_normal) < 0
    self.normal = if (self.front_face) {
        outward_normal
    } else {
        -outward_normal
    }
}

pub(open) trait Hittable {
    hit(self: Self, r: Ray, t_min: Double, t_max: Double) -> Option[HitRecord]
}
