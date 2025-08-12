///|
pub fn write_color(pixel_color : Color) -> Unit {
    let ir = (255.998 * pixel_color.x()).to_int()
    let ig = (255.998 * pixel_color.y()).to_int()
    let ib = (255.998 * pixel_color.z()).to_int()
  println("\{ir} \{ig} \{ib}")
}
