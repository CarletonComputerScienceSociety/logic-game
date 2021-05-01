extends Node

var x = []


func andOp(list_1, list_2):	
	
	x = []
	
	for i in range(len(list_1)):
		x.append(list_1[i] && list_2[i])
	return x

func orOp(list_1, list_2):
	
	x = []
	
	for i in range(len(list_1)):
		x.append(list_1[i] || list_2[i])
	return x


func notOp(list_1):
	
	x = []
	
	for i in range(len(list_1)):
		x.append(!list_1[i])
	return x

func impOp(list_1, list_2):
	
	list_1 = notOp(list_1)
	
	return orOp(list_1, list_2)



func xorOp(list_1, list_2):
	
	return notOp(andOp(impOp(list_1, list_2), impOp(list_2, list_1)))

func dmpOp(list_1, list_2):
	
	return andOp(impOp(list_1, list_2), impOp(list_2, list_1))
