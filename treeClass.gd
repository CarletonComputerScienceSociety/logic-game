extends Object
class_name treeNode

var leftNode
var rightNode
var value

func _init(_value):
	value = _value
	leftNode = null
	rightNode = null

func addLeft(newNode):
	leftNode = newNode

func addRight(newNode):
	rightNode = newNode
