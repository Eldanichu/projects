extends Node
class_name N

static func I2F(number:int) -> float:
	return number * 1.00000

static func F2I(number:float) -> int:
	return int(number)

static func EQF(n1:float,n2:float) -> bool:
	return is_equal_approx(n1,n2)

static func FZERO(n1:float) -> bool:
	return is_zero_approx(n1)
