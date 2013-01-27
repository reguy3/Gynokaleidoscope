boolean isSet(Shape op1, Shape op2, Shape op3, boolean petals)
{
  println(op1.TYPE);
  println(op2.TYPE);
  println(op3.TYPE);
  return ((colorIndex(op1.c)+colorIndex(op2.c)+colorIndex(op3.c))%3 == 0)
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

void unitTesting()
{  
  // UNIT TESTING
  /*
  println(isSet(
    new Hypercycloid(0,0,0,colors[0]),
    new Rose(0,0,0,colors[0]),
    new Hypercycloid(0,0,0,colors[0]),
    false
  ));
  // true */
  /*
  println(isSet(
    new Hypercycloid(0,0,0,colors[0]),
    new Rose(0,0,0,colors[0]),
    new Hypercycloid(0,0,0,colors[1]),
    false
  ));
  // false */
  /*
  println(isSet(
    new Hypercycloid(0,0,0,colors[0]),
    new Rose(0,0,0,colors[1]),
    new Hypercycloid(0,0,0,colors[2]),
    false
  ));
  // true */
  /*
  println(isSet(
    new Rose(0,0,0,colors[0]),
    new Rose(0,0,0,colors[1]),
    new Rose(0,0,0,colors[2]),
    false
  ));
  // true */
  /*
  println(isSet(
    new Rose(0,0,0,colors[0]),
    new Rose(0,0,0,colors[1]),
    new Rose(0,0,0,colors[1]),
    false
  ));
  // false */
  /*
  println(isSet(
    new Rose(3,0,0,colors[0]),
    new Rose(4,0,0,colors[1]),
    new Rose(5,0,0,colors[2]),
    true
  ));
  // true */
  /*
  println(isSet(
    new Rose(3,0,0,colors[0]),
    new Hypercycloid(5,0,0,colors[1]),
    new Rose(4,0,0,colors[2]),
    false
  ));
  // false */
  /*
  println(isSet(
    new Rose(3,0,0,colors[0]),
    new Rose(3,0,0,colors[1]),
    new Rose(3,0,0,colors[2]),
    true
  ));
  // true */
  /*
  println(isSet(
    new Rose(3,0,0,colors[0]),
    new Rose(4,0,0,colors[1]),
    new Rose(4,0,0,colors[2]),
    true
  ));
  // false */
}
