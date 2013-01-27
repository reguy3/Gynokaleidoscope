ArrayList inPlay = new ArrayList();

boolean isSet(Shape op1, Shape op2, Shape op3, boolean petals)
{
  return ((colorIndex(op1.oc)+colorIndex(op2.oc)+colorIndex(op3.oc))%3 == 0)
  && ((op1.TYPE + op2.TYPE + op3.TYPE)%3 == 0)
  && (!petals || ((op1.petals==op2.petals && op2.petals==op3.petals && op1.petals==op3.petals)
  || (op1.petals!=op2.petals && op2.petals!=op3.petals && op1.petals!=op3.petals)));
}

int colorIndex(color c)
{
  for(int i=0;i<colors.length;i++)
    if(colorMatch(colors[i], c))
      return i;
  println(" - nope");
  return -1;
}

boolean colorMatch(color op1, color op2)
{
  return (op1>>16&255) == (op2>>16&255)
  && (op1>>8&255) == (op2>>8&255)
  && (op1&255) == (op2&255);
}

color darken(color c, float s)
{
  s = sqrt(s);
  if(s <= 1) return c;
  //println("D: "+s);
  float r = c >> 16&255;
  float g = c >> 8 &255;
  float b = c &255;
  return color(r/s, g/s, b/s, 255/s);
}

void unitTesting()
{
  println(colorIndex(colors[1]));
  /*
  println(isSet(
    new Hypercycloid(colors[0]),
    new Rose(colors[0]),
    new Hypercycloid(colors[0]),
    false
  ));
  // true */
  /*
  println(isSet(
    new Hypercycloid(colors[0]),
    new Rose(colors[0]),
    new Hypercycloid(colors[1]),
    false
  ));
  // false */
  /*
  println(isSet(
    new Hypercycloid(colors[0]),
    new Rose(colors[1]),
    new Hypercycloid(colors[2]),
    false
  ));
  // true */
  /*
  println(isSet(
    new Rose(colors[0]),
    new Rose(colors[1]),
    new Rose(colors[2]),
    false
  ));
  // true */
  /*
  println(isSet(
    new Rose(colors[0]),
    new Rose(colors[1]),
    new Rose(colors[1]),
    false
  ));
  // false */
  /*
  println(isSet(
    new Rose(colors[0]),
    new Rose(colors[1]),
    new Rose(colors[2]),
    true
  ));
  // true */
  /*
  println(isSet(
    new Rose(colors[0]),
    new Hypercycloid(colors[1]),
    new Rose(colors[2]),
    false
  ));
  // false */
  /*
  println(isSet(
    new Rose(colors[0]),
    new Rose(colors[1]),
    new Rose(colors[2]),
    true
  ));
  // true */
  /*
  println(isSet(
    new Rose(colors[0]),
    new Rose(colors[1]),
    new Rose(colors[2]),
    true
  ));
  // false */
}
