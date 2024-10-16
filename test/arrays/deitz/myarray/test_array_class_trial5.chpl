class array1d {
  type t;
  var x1 : t;
  var x2 : t;
  var x3 : t;
  proc indexedby(i : int) ref {
    var result : t;
    select i {
      when 1 do return x1;
      when 2 do return x2;
      when 3 do return x3;
      otherwise writeln("[Out of bounds read]");
    }
    return x1;
  }
}

var aOwn =  new owned array1d(int);
var a : borrowed array1d(int) = aOwn.borrow();

a.indexedby(1) = 3;
a.indexedby(2) = 2;
a.indexedby(3) = 1;
writeln(a.indexedby(1), a.indexedby(2), a.indexedby(3));

class array2d {
  type t;
  var data : unmanaged array1d(t) = new unmanaged array1d(t);

  proc deinit() {
    delete data;
  }

  proc indexedby(i : int, j : int) ref : t {
    return data.indexedby((i - 1) * 2 + j);
  }
}

var a2Own = new owned array2d(int);
var a2 : borrowed array2d(int) = a2Own.borrow();

a2.indexedby(1, 1) = 4;
writeln(a2.indexedby(1, 1));
