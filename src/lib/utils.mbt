let rng: @random.Rand = @random.Rand::new()

///|
pub fn degrees_to_radians(degrees : Double) -> Double {
  return degrees * @math.PI / 180
}

///|
pub fn random_double() -> Double {
  rng.double()
}

///|
pub fn random_double_in_range(min : Double, max : Double) -> Double {
  return min + (max - min) * random_double()
}

///|
pub fn clamp(x: Double, min: Double, max: Double) -> Double {
    if (x < min) {
        min
    } else if (x > max) {
        max
    } else {
        x
    }
}
