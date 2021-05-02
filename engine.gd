extends Node

enum Symbol {
	VAR_A,
	VAR_B,
	VAR_C,
	OP_AND,
	OP_OR,
	OP_NOT,
	OP_XOR,
	OP_IMP,
	OP_EQU,
	LEFT_BRACKET,
	RIGHT_BRACKET
}

func _ready():
	print("Test")

func match_brackets(syms):
	var stack = [[]]
	for sym in syms:
		if sym == Symbol.LEFT_BRACKET:
			var new_layer = []
			stack.back().append(new_layer)
			stack.push_back(new_layer)
		elif sym == Symbol.RIGHT_BRACKET:
			stack.pop_back()
		else:
			stack.back().append(sym)
	assert(len(stack) == 1)
	return stack.back()
