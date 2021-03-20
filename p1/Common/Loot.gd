extends Node

var table:Array = [];
var qty:int

func addLoot(item ,weight:int):
		if (!weight || weight == null || weight <= 0):
				weight = 0
		qty = 999999999999;
		var o = {
				"item": item,
				"weight": weight,
				"qty": qty
		}
		table.append(o)

func choose():
		randomize();
		if(table.size() == 0):
				return;
				
		var v : Dictionary;
		var tw = 0;
		
		for i in range(0,table.size()):
				v = table[i]
				if(v.qty > 0):
						tw += v.weight;
		
		var chioce = 0;
		var rndNum = floor( randf() * tw + 1 );
		var weight = 0
		print(rndNum)
		for i in range(0,table.size()):
				v = table[i];
				if(v.qty <= 0):
						continue;
				weight += v.weight;
				if(rndNum <= weight):
						chioce = i;
						break;
		var chosenItem = table[chioce];
		table[chioce].qty = table[chioce].qty - 1
		
		return chosenItem;

func dispose():
		table.empty();
