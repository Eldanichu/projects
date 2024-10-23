extends Control

func _tc_test(times:int = 1):
	var res = []
	for i in range(0,times):
		var s := SimpleLoot.new([
			{"id":1,"name":"potion-0","weight":5},
			{"id":2,"name":"potion-0","weight":5},
			{"id":3,"name":"potion-2**","weight":10},
			{"id":3,"name":"weapon-6******","weight":20},
		]).roll()
		res.append_array(s)
	return res

func _on_tc_10_button_up() -> void:
	var res = _tc_test(10)
	P.new("test-10",P.array_ln(res))


func _on_tc_50_button_up() -> void:
	var res = _tc_test(50)
	P.new("test-50",P.array_ln(res))


func _on_tc_100_button_up() -> void:
	var res = _tc_test(100)
	P.new("test-100",P.array_ln(res))
