# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name RandomUtilTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://Srcipts/Utils/RandomUtil.gd'

func test_get_attack_power() -> void:
	var dps = 0
	for i in range(0,10):
		var a = RandomUtil.get_attack_power(1,15)
		dps = dps + a
		print(a)
	print("dps->",dps)

#func test_get_random() -> void:
#	for i in range(3):
#		var a = RandomUtil.get_random(3)
#		if a > 0:
#			print("{0}:{1}".format([i,a]))

