struct HittableList {
    objects: Array[&Hittable]
}

pub fn HittableList::new() -> HittableList {
    return {
        objects: []
    }
}

pub fn HittableList::from_one(obj: &Hittable) -> HittableList {
    return {
        objects: [obj]
    }
}

pub fn HittableList::add(self: HittableList, obj: &Hittable) -> Unit {
    self.objects.push(obj)
}

pub fn HittableList::clear(self: HittableList) -> Unit {
    self.objects.clear()
}

pub fn HittableList::hit(self: HittableList, r: Ray, t_min: Double, t_max: Double) -> HitRecord? {
    let mut closest = t_max
    let mut best: HitRecord? = None

    for obj in self.objects {
        match obj.hit(r, t_min, closest) {
            Some(rec) => {
                closest = rec.t
                best = Some(rec)
            }
            None => ()
        }
    }

    return best
}
