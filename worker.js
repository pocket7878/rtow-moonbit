self.onmessage = async (e) => {

    let memory;
    const [log, flush] = (() => {
        let buffer = [];
        function flush() {
          if (buffer.length > 0) {
            console.log(new TextDecoder("utf-16").decode(new Uint16Array(buffer).valueOf()));
            buffer = [];
          }
        }
        function log(ch) {
          if (ch == '\n'.charCodeAt(0)) { flush(); }
          else if (ch == '\r'.charCodeAt(0)) { /* noop */ }
          else { buffer.push(ch); }
        }
        return [log, flush]
    })();

    const { width, height, wasmPath } = e.data;
    const rowBuf = new Uint8ClampedArray(width*4);
    let curY = 0;

    function flushRow(y) {
        const copy = rowBuf.slice();
        self.postMessage({ type: "row", y, width, buffer:copy.buffer }, [copy.buffer]);
        self.postMessage({ type: "prog", y, height });
    }

    function put_pixel(x, y, r, g, b) {
      if (x < 0 || y < 0 || x >= width || y >= height) return;
      const i = x*4;
      rowBuf[i] = r & 255;
      rowBuf[i+1] = g & 255;
      rowBuf[i+2] = b & 255;
      rowBuf[i+3] = 255;

      if (x === width - 1) {
        flushRow(y);
        curY++;
      }
    }

    async function loadRenderer() {
        try {
            const resp = await fetch(wasmPath);
            const { instance } = await WebAssembly.instantiateStreaming(resp, {
                env: { put_pixel },
                spectest: {
                    print_char: log
                }
            });

            return instance;
        } catch {
            const bytes = await (await fetch(wasmPath)).arrayBuffer();
          const { instance } = await WebAssembly.instantiate(bytes, { 
            env: { put_pixel },
            spectest: {
                print_char: log
            }
          });
          return instance;
        }
    }

    const inst = await loadRenderer();
    inst.exports.render_to_canvas(width, height);
    self.postMessage({ type: "done" });
};
