extends RefCounted
class_name BS

## Binary Search
## requires sorted array
## @param arr {Array<Dictionary>} sorted Array
## @param target {int} the index you will find out
## @param key {String} sorted index that contains in Dictionary
static func find(arr:Array, target:int, key:String) -> int:
	var low = 0
	var high = arr.size() - 1

	while (low <= high):
		var mid = floori((low + high) / 2);
		var midVal = arr[mid][key];

		if (midVal == target):
			return mid;
		elif midVal < target:
			low = mid + 1;
		else: 
			high = mid - 1;
	return -1
