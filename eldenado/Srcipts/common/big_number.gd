extends Reference

class_name BigNumber

var mantissa:float = 0.0
var exponent:int = 1

const postfixes_dict = {
    "0": "",
    "1": "k",
    "2": "m",
    "3": "b",
    "4": "t",
    "5": "a0",
    "6": "a1",
    "7": "a2",
    "8": "a3",
    "9": "a4",
    "10": "a5",
    "11": "a6",
    "12": "a7",
    "13": "a8",
    "14": "a9",
    "15": "b0",
    "16": "b1",
    "17": "b2",
    "18": "b3",
    "19": "b4",
    "20": "b5",
    "21": "b6",
    "22": "b7",
    "23": "b8",
    "24": "b9",
    "25": "c0",
    "26": "c1",
    "27": "c2",
    "28": "c3",
    "29": "c4",
    "30": "c5",
    "31": "c6",
    "32": "c7",
    "33": "c8",
    "34": "c9",
    "35": "d0",
    "36": "d1",
    "37": "d2",
    "38": "d3",
    "39": "d4",
    "40": "d5",
    "41": "d6",
    "42": "d7",
    "43": "d8",
    "44": "d9",
    "45": "e0",
    "46": "e1",
    "47": "e2",
    "48": "e3",
    "49": "e4",
    "50": "e5",
    "51": "e6",
    "52": "e7",
    "53": "e8",
    "54": "e9",
    "55": "f0",
    "56": "f1",
    "57": "f2"
}
const alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

const MAX_MANTISSA = 1209600

"""
m:
"""
func _init(m,e=0):
  if typeof(m) == TYPE_STRING:
    var scientific = m.split("e")
    mantissa = float(scientific[0])
    if scientific.size() > 1:
      exponent = int(scientific[1])
    else:
      exponent = 0
  elif typeof(m) == TYPE_OBJECT:
    mantissa = m.mantissa
    exponent = m.exponent
  else:
    size_check(m)
    mantissa = m
    exponent = e
  calculate(self)

func size_check(m):
  if m > MAX_MANTISSA:
    printerr("BIG ERROR: MANTISSA TOO LARGE, PLEASE USE EXPONENT OR SCIENTIFIC NOTATION")

func type_check(n):
  if typeof(n) == TYPE_INT or typeof(n) == TYPE_REAL:
    return {"mantissa":float(n), "exponent":0}
  elif typeof(n) == TYPE_STRING:
    return {"mantissa":float(n.split("e")[0]), "exponent":int(n.split("e")[1])}
  else:
    return n

func plus(n):
  n = type_check(n)
  size_check(n.mantissa)
  var exp_diff = n.exponent - exponent
  var scaled_mantissa = n.mantissa * pow(10, exp_diff)
  mantissa += scaled_mantissa
  calculate(self)
  return self

func minus(n):
  n = type_check(n)
  size_check(n.mantissa)
  var exp_diff = n.exponent - exponent
  var scaled_mantissa = n.mantissa * pow(10, exp_diff)
  mantissa -= scaled_mantissa
  calculate(self)
  return self

func multiply(n):
  n = type_check(n)
  size_check(n.mantissa)
  var new_exponent = n.exponent + exponent
  var new_mantissa = n.mantissa * mantissa
  while new_mantissa >= 10.0:
    new_mantissa /= 10.0
    new_exponent += 1
  mantissa = new_mantissa
  exponent = new_exponent
  calculate(self)
  return self

func divide(n):
  n = type_check(n)
  size_check(n.mantissa)
  if n.mantissa == 0:
    printerr("BIG ERROR: DIVIDE BY ZERO")
    return self

  var new_exponent = exponent - n.exponent
  var new_mantissa = mantissa / n.mantissa
  while new_mantissa < 1.0 and new_mantissa > 0.0:
    new_mantissa *= 10.0
    new_exponent -= 1
  mantissa = new_mantissa
  exponent = new_exponent
  calculate(self)
  return self

func power(n:int):
  if n < 0:
    printerr("BIG ERROR: NEGATIVE EXPONENTS NOT SUPPORTED!")
    mantissa = 1.0
    exponent = 0
    return self
  if n == 0:
    mantissa = 1.0
    exponent = 0
    return self

  var y_mantissa = 1
  var y_exponent = 0

  while n > 1:
    if n % 2 == 0: #n is even
      exponent = exponent + exponent
      mantissa = mantissa * mantissa
      n = n / 2
    else:
      y_mantissa = mantissa * y_mantissa
      y_exponent = exponent + y_exponent
      exponent = exponent + exponent
      mantissa = mantissa * mantissa
      n = (n-1) / 2

  exponent = y_exponent + exponent
  mantissa = y_mantissa * mantissa
  calculate(self)
  return self

func square():
  if exponent % 2 == 0:
    mantissa = sqrt(mantissa)
    exponent = exponent/2
  else:
    mantissa = sqrt(mantissa*10)
    exponent = (exponent-1)/2
  calculate(self)
  return self

func calculate(big):
  if big.mantissa >= 10.0 or big.mantissa < 1.0:
    var diff = int(floor(log10(big.mantissa)))
    var div = pow(10.0, diff)
    if div > 0.0:
      big.mantissa /= div
      big.exponent += diff
  while big.exponent < 0:
    big.mantissa *= 0.1
    big.exponent += 1
  while big.mantissa >= 10.0:
    big.mantissa *= 0.1
    big.exponent += 1
  if big.mantissa == 0.0:
    big.exponent = 0
  pass

func isEqualTo(n):
  n = type_check(n)
  calculate(n)
  return n.mantissa == mantissa and n.exponent == exponent

func isLargerThan(n):
  n = type_check(n)
  calculate(n)

  if mantissa == 0.0:
    return false

  if exponent > n.exponent:
    return true
  elif exponent == n.exponent:
    if mantissa > n.mantissa:
      return true
    else:
      return false
  else:
    return false

func isLargerThanOrEqualTo(n):
  n = type_check(n)
  calculate(n)
  if isEqualTo(n):
    return true
  if isLargerThan(n):
    return true
  return false

func isLessThan(n):
  n = type_check(n)
  calculate(n)

  if mantissa == 0.0 and n.mantissa > 0.0:
    return true

  if exponent < n.exponent:
    return true
  elif exponent == n.exponent:
    if mantissa < n.mantissa:
      return true
    else:
      return false
  else:
    return false

func isLessThanOrEqualTo(n):
  n = type_check(n)
  calculate(n)
  if isEqualTo(n):
    return true
  if isLessThan(n):
    return true
  return false

static func min(m, n):
  if m.isLessThan(n):
    return m
  else:
    return n

static func max(m, n):
  if m.isLargerThan(n):
    return m
  else:
    return n

func roundDown():
  if exponent == 0:
    mantissa = floor(mantissa)
  elif exponent == 1:
    mantissa = stepify(mantissa, 0.1)
  elif exponent == 2:
    mantissa = stepify(mantissa, 0.01)
  elif exponent == 3:
    mantissa = stepify(mantissa, 0.001)
  else:
    mantissa = stepify(mantissa, 0.0001)
  return self

func log10(x):
  return log(x) * 0.4342944819032518

func toString():
  if exponent < 10:
    return str(mantissa * pow(10, exponent))
  else:
    return toScientific()

func toScientific():
  return str(mantissa) + "e" + str(exponent)

func toFloat():
  return stepify(float(str(mantissa) + "e" + str(exponent)),0.01)

func toAA(noDecimalsOnSmallValues=false):
  var target = floor(exponent/3)
  var hundreds = 1
  for i in range(exponent % 3):
    hundreds *= 10

  var prefix = mantissa * hundreds
  var postfix = ""

  var units = [0,0]
  var m = 0
  var u = 1

    #this is quite slow for very big numbers, but we save the result for next similar target
  if not postfixes_dict.has(str(target)):
    print("UNIT " + str(target) + " NOT FOUND IN TABLE - GENERATING IT INSTEAD")
    while (m < target-5):
      m += 1
      units[u] += 1
      if units[u] == alphabet.size():
        var found = false
        for i in range(units.size()-1,-1,-1):
          if not found and units[i] < alphabet.size()-1:
            units[i] += 1
            found = true
        units[u] = 0
        if not found:
          units.append(0)
          u += 1
          for i in range(units.size()):
            units[i] = 0

    for i in range(units.size()):
      postfix = postfix + str(alphabet[units[i]])
    postfixes_dict[str(target)] = postfix
  else:
    postfix = postfixes_dict[str(target)]

  var result = ""
  var split = str(prefix).split(".")
  if noDecimalsOnSmallValues and target == 0:
    result = split[0]
  else:
    if split[0].length() == 3:
      result = str("%1.2f" % prefix).substr(0,3)
    else:
      result = str("%1.2f" % prefix).substr(0,4)

  return result + postfix
