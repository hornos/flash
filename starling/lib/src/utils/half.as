package utils {
  public function half(n:int):int {
    return n >> 1;
  }

  public function color(v:Array):uint {
    return v[0] << 16 | v[1] << 8 | v[2];
  }
}
