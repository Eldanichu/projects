extends Resource
class_name RandomEx


class Rnd:
	var r:RandomNumberGenerator;
	
	func _init():
		r = RandomNumberGenerator.new()
	
	func rand_i_range(vmin:int, vmax:int) -> int:
		r.randomize()
		var value = r.randi_range(vmin,vmax)
		return value
	
	func randomi(range:int = 1) -> int:
		r.randomize()
		var rn = floor(ceil(r.randi())) % (range + 1)
		return rn

	func randomf(rangeP:float = 1.0) -> float:
		r.randomize()
		var rn:String = "%10.2f" % fmod(r.randf() * 100 ,rangeP)
		
		return float(rn)

	func pick(array:Array = []):
		var arr_len = len(array)
		var _array = array
		var i = randomi(arr_len - 1)
		var item = _array[i]
		return item

	func chance(p:int) -> bool:
		var _p = max(0, p - 1)
		var hit = randomi(_p)
		print("{RandomEx} - [chance] value-> {0}".format([hit]))
		return hit == 0
	
	func uid(len:int = 8, number:bool = false) -> String:
		var str = ""
		var _A = "QWERTYUIOPASDFGHJKLZXCVBNM"
		var _a = "qwertyuiopasdfghjklzxcvbnm"
		var _n = "1478523690"
		var strs = [_a,_A]
		if number:
			strs.append(_n)
		var seeds = "".join(strs).split("")
		var seeds_len = len(seeds)
		var _res_str = []
		var char
		var _l = min(len, seeds_len - 1)
		for i in range(_l , 0 , -1):
			var r_index = randomi(seeds_len - 1)
			char = seeds[r_index]
			_res_str.append(char)
		return str.join(_res_str)

static func get_instance() -> Rnd:
	return Rnd.new()

static func exceed(index:int,size:int):
	var i = ((size + index) % size) % size
	return i
