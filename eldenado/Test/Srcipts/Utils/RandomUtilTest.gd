# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name RandomUtilTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://Srcipts/Utils/RandomUtil.gd'

func test_get_attck_power() -> void:
	var dps = 0
	for i in range(0,10):
		var a = RandomUtil.get_attck_power(1,15)
		dps = dps + a
		print(a)
	print("dps->",dps)
