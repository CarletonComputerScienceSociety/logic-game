extends Object
class_name treeNode

var parentNode
var leftNode
var rightNode
var value

func _init(_value):
	value = _value
	parentNode = null
	leftNode = null
	rightNode = null

func addLeft(newNode):
	leftNode = newNode

func addRight(newNode):
	rightNode = newNode
