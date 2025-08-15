///|
pub typealias @vec3.Vec3 as Color

///|
pub fn write_color(pixel_color : Color, samples_per_pixel : Int) -> Unit {
  let mut r = pixel_color.x()
  let mut g = pixel_color.y()
  let mut b = pixel_color.z()

  // 色の合計をサンプルの数で割り、gamma = 2.0のガンマ補正を行う
  let scale = 1.0 / samples_per_pixel.to_double()
  r = (scale * r).sqrt()
  g = (scale * g).sqrt()
  b = (scale * b).sqrt()
  let ir = (256.0 * @utils.clamp(r, 0.0, 0.999)).to_int()
  let ig = (256.0 * @utils.clamp(g, 0.0, 0.999)).to_int()
  let ib = (256.0 * @utils.clamp(b, 0.0, 0.999)).to_int()
  println("\{ir} \{ig} \{ib}")
}
