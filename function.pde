float distsq(ten _a, ten _b) {
  float x=_a.x-_b.x, y=_a.y-_b.y;
  return x*x+y*y;
}

float distsq(ten _a, sen _b) {
  float 
    abs = _b.a * _a.x + _b.b * _a.y - _b.c, 
    a = _b.a, b = _b.b;
  return abs*abs/(a*a+b*b);
}

ten cross(sen _a, sen _b) {
  //二線の交点が一つだけある場合それを返す
  float 
    a = _a.a, b = _a.b, c = _a.c, 
    d = _b.a, e = _b.b, f = _b.c, 
    determination = a * e - b * d;
  if (determination == 0) {
    return null;
  } else {
    float x = ( e * c - b * f) / determination;
    float y = (-d * c + a * f) / determination;
    return new ten(x, y, _a, _b);
  }
}

boolean beyond(ten ten1, ten ten2, sen kijun) {
  //ten2がkijunを挟んでten1と反対側にあればtrueを返す
  if (
    ten2.parent[0] == kijun|
    ten2.parent[1] == kijun) {
    return false;
  }
  float hoge = kijun.a * ten1.x + kijun.b * ten1.y - kijun.c ;
  float fuga = kijun.a * ten2.x + kijun.b * ten2.y - kijun.c ;
  if (fuga<0&hoge>0 | fuga>0&hoge<0) {
    return true;
  } else {
    return false;
  }
}