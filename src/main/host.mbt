///|
trait HostInterface {
  begin(self : Self, w : Int, h : Int) -> Unit
  pixel(
    self : Self,
    x : Int,
    y : Int,
    c : @color.Color,
    samples_per_pixel : Int,
  ) -> Unit
}

///|
#cfg(any(target="js", target="wasm-gc"))
struct WebCanvasHost {
  mut height : Int
}

///|
#cfg(any(target="js", target="wasm-gc"))
fn WebCanvasHost::new() -> WebCanvasHost {
  return { height: -1 }
}

///|
#cfg(any(target="js", target="wasm-gc"))
impl HostInterface for WebCanvasHost with begin(
  self : WebCanvasHost,
  _w : Int,
  h : Int,
) -> Unit {
  self.height = h
}

///|
#cfg(any(target="js", target="wasm-gc"))
impl HostInterface for WebCanvasHost with pixel(
  self : WebCanvasHost,
  x : Int,
  y : Int,
  c : @color.Color,
  samples_per_pixel : Int,
) -> Unit {
  let y_out = self.height - 1 - y
  @color.write_color_to_canvas(x, y_out, c, samples_per_pixel)
}

///|
#cfg(any(target="native", target="llvm"))
struct PPMImageHost {}

///|
#cfg(any(target="native", target="llvm"))
fn PPMImageHost::new() -> PPMImageHost {
  return PPMImageHost::{  }
}

///|
#cfg(any(target="native", target="llvm"))
impl HostInterface for PPMImageHost with begin(
  self : PPMImageHost,
  w : Int,
  h : Int,
) -> Unit {
  println("P3\n\{w} \{h}\n255")
}

///|
#cfg(any(target="native", target="llvm"))
impl HostInterface for PPMImageHost with pixel(
  self : PPMImageHost,
  _x : Int,
  _y : Int,
  c : @color.Color,
  samples_per_pixel : Int,
) -> Unit {
  @color.write_color(c, samples_per_pixel)
}

///|
#cfg(any(target="js", target="wasm-gc"))
typealias WebCanvasHost as Host

///|
#cfg(not(any(target="js", target="wasm-gc")))
typealias PPMImageHost as Host
