# GdUnit generated TestSuite
#warning-ignore-all:unused_argument
#warning-ignore-all:return_value_discarded
class_name DropItemTest
extends GdUnitTestSuite

# TestSuite generated from
const __source = 'res://DB/DropItem.gd'

var d := preload(__source).new()

func test_drop() -> void:

	print(d.drop("arc"))
