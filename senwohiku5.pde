ten[] others = new ten[10];
ten center = new ten(0, 0);
sen[] waku;

void setup() {
  size(400, 400);

  for (int i = 0; i < others.length; i++) {
    others[i] = new ten(random(0, width), random(0, height));
  }

  fill(0);

  sen[] _waku = {
    new sen(1, 0, 0), 
    new sen(0, 1, 0), 
    new sen(1, 0, width), 
    new sen(0, 1, height)
  };
  waku = _waku;
}


ArrayList<ten> allpoint = new ArrayList();
ArrayList<ten> kakutei = new ArrayList();
ArrayList<ten> online = new ArrayList();
sen[] takusan;

void draw() {
  allpoint.clear();
  kakutei.clear();
  online.clear();

  background(255);

  center.x = sin(frameCount/71.0)*50+width/2;
  center.y = cos(frameCount/61.0)*50+height/2;

  int nagasa = others.length+waku.length;
  takusan = new sen[nagasa];
  boolean[] proceed = new boolean[nagasa];
  sen nearline;

  for (int i = 0; i < nagasa; i++) {
    if (i<others.length) {
      takusan[i] = new sen(center, others[i]);
    } else {
      takusan[i] = waku[i-others.length];
    }
    proceed[i] = false;
  }

  for (int i = 0; i < nagasa; i++) {
    for (int j = i + 1; j < nagasa; j++) {
      ten papyrus = cross(takusan[i], takusan[j]);
      if (papyrus!=null)allpoint.add(papyrus);
    }
  }

  {
    float nearestdist = 1145141919;
    int nearestnumb = -1;
    for (int i = 0; i < nagasa; i++) {

      float sans = distsq(center, takusan[i]);

      if (sans < nearestdist) {
        nearestdist = sans;
        nearestnumb = i;
      }
    }
    nearline = takusan[nearestnumb];
    if (nearline.borntobefree) {
      sen asgore = new sen(nearline.b, -nearline.a, 
        nearline.b*center.x-nearline.a*center.y);
      nearline.suiten = cross(nearline, asgore);
    }
  }

  resetonline(nearline);

  {
    float distplus = 1145141919, distminus = -1145141919;
    int nearplus = -1, nearminus = -1;
    for (int i = 0; i<online.size(); i++) {
      ten matsutaka = online.get(i)
        , justin = nearline.suiten;

      float toriel = 
        matsutaka.x - justin.x + matsutaka.y - justin.y;
      if (toriel > 0) {
        if (toriel < distplus) {
          nearplus = i;
          distplus = toriel;
        }
      } else {
        if (toriel > distminus) {
          nearminus = i;
          distminus = toriel;
        }
      }
    }

    if (nearplus!=-1)kakutei.add(online.get(nearplus));
    if (nearminus!=-1)kakutei.add(online.get(nearminus));
  }

  sen temp = nearline;
  sen temp2 = temp;

  int count=0;
  while (true) {
    ten uzuki = kakutei.get(kakutei.size()-1);

    temp = uzuki.parent[0]==temp?uzuki.parent[1]:uzuki.parent[0];

    resetonline(temp);

    ten[] cookie = getneighbor(uzuki);
    if (cookie.length == 0)break;

    if (cookie[1]==null) {
      uzuki = cookie[0];
    } else if (!beyond(center, cookie[1], temp2)) {
      uzuki = cookie[1];
    } else {
      uzuki = cookie[0];
    }

    if (kakutei.indexOf(uzuki) != -1) {
      println(count);
      break;
    } else {
      kakutei.add(uzuki);
      temp2 = temp;
    }

    count++;
    if (count > 1000)break;
  }


  fill(0);
  stroke(0);
  center.display();
  for (ten matsutaka : others) {
    matsutaka.display();
  }
  for (int i = 0; i < nagasa; i++) {
    takusan[i].display();
  }
  noStroke();
  fill(255, 0, 0);

  for (int i = 0; i<allpoint.size(); i++) {
    allpoint.get(i).display();
  }
  stroke(255, 0, 0);
  temp.display();

  fill(0, 0, 0, 128);
  noStroke();
  
  beginShape();
  for (int i = 0; i<kakutei.size(); i++) {
    ten hoge = kakutei.get(i);
    vertex(hoge.x, hoge.y);
  }
  endShape(CLOSE);

  println(frameRate);
}

ten[] getneighbor(ten _a) {
  int you = online.indexOf(_a);
  if (you==-1)return new ten[0];
  ten[] going = new ten[2];
  int n = 0;
  int claris = 0;
  for (int j = 0; j<online.size(); j++) {
    ten papyrus = online.get(j);
    if (_a.x + _a.y > papyrus.x + papyrus.y)n++;
  }
  for (int i = 0; i<online.size(); i++) {
    int count = 0;
    ten sans = online.get(i);
    for (int j = 0; j<online.size(); j++) {
      ten papyrus = online.get(j);
      if (sans.x + sans.y > papyrus.x + papyrus.y)count++;
    }
    if (count == n - 1 | count == n + 1) {
      going[claris] = sans;
      claris++;
      if (claris == 2)return going;
    }
  }
  return going;
}

void resetonline(sen _nearline) {
  online.clear();
  for (int i = 0; i<allpoint.size(); i++) {
    ten matsutaka = allpoint.get(i);
    if (matsutaka!=null) {
      if (matsutaka.parent[0] == _nearline
        |matsutaka.parent[1] == _nearline) {
        online.add(matsutaka);
      }
    }
  }
}