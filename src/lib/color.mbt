///|
pub fn write_color(pixel_color : Color, samples_per_pixel: Int) -> Unit {
    let mut r = pixel_color.x()
    let mut g = pixel_color.y()
    let mut b = pixel_color.z()

    let scale = 1.0 / samples_per_pixel.to_double()
    r *= scale
    g *= scale
    b *= scale

    let ir = (256.0 * clamp(r, 0.0, 0.999)).to_int()
    let ig = (256.0 * clamp(g, 0.0, 0.999)).to_int()
    let ib = (256.0 * clamp(b, 0.0, 0.999)).to_int()

    println("\{ir} \{ig} \{ib}")
}
