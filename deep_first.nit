module deep_first

fun deep_first(a: Object): Object
do
	# Here, `a` isa `Object`
        while a isa Collection[Object] do
		# Here, `a` is a `Collection[Object]`
                a = a.first
		# Here, `a` is a `Object` again
        end
        return a 
end

var one = 1
print deep_first(one)
var range = [1..5]
print deep_first(range)
var ranges = [range, [3..8]]
print deep_first(ranges)
var arrays = [[2,3],[3,4]]
print deep_first(arrays)
