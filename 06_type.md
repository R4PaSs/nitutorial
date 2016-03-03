# Nullable and Adaptive Typing

One of the specific feature of Nit the management of the `null` value and how the static types of expressions and variable are computed.

Unlike most other language, the `null` value is statically controlled, therefore it cannot occurs randomly.

To accept `null`, the static type must be extended with the `nullable` keyword.

~~~nit
var a: Int = 10            # OK
var b: nullable Int = 1)   # OK
var c: nullable Int = null # OK
var d: Int = null # NOT OK
#            ^
# Type Error: expected `Int`, got `null`.
~~~

The static type system controls that `null` does not propagate to unwanted places.
Therefore, it is required to test the value of expressions that might be null.

To control the correction of programs, the static type system of Nit features *adaptive typing*.
Adaptive typing is used to track the static types of variables and expressions.
With adaptive typing, the static type of variables might changes according to:

* its assignments
* its comparisons to null (with `==` and `!=`)
* its type checks (with `isa` seen bellow)
* the control flow of the program (`if`, `while`, `break`, `and`, etc.)

~~~nit
# Double a number; if null is given 0 is returned.
fun double(value: nullable Int): Int
do
	# Here, `value` is a `nullable Int`
	if value == null then return 0
	# Here, `value` is a `Int`. It's *adaptive typing*!
	return value * 2
end
~~~

Adaptive typing correctly handle independent assignments.

~~~nit
fun triple(value: nullable Int): Int
do
	# Here `value` is a `nullable Int`
	if value == null then
		# Here `value` is `null`
		value = 0
		# Here `value` is `Int`
	end # In the implicit and empty else, `value` is `Int`
	# Here `value` is Int
	return value * 3
end
~~~


The `isa` keyword can be used to test the dynamic type of an expression.
If the expression is a variable, then its static type can be adapted.

~~~
fun what_it_is(value: nullable Object)
do
	# `value` is a `nullable Object` that is the most general type is the type hierarchy of Nit.
	if value == null then
		print "It's null!"
		return
	end
	# Now, `value` is a `Object` that is the root of the class hierarchy.
	if value isa Int then
		# Now `value` is a `Int`.
		# No need to cast, the static type is already adapted.
		print "It's the integer {value}, the one that follows {value-1}."
		# Because `value` is an `Int`, `value-1` is accepted
	else if value isa String then
		print "It's the string {value}, made of {value.length} charcters."
	else
		print "Whathever it is, I do not care."
	end
end
~~~

Adaptive typing correctly handle loops

~~~nit
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
print deep_first(one) # 1
var range = [1..5]
print deep_first(range) # still 1
var ranges = [range, [3..8]]
print deep_first(ranges) # again 1
~~~


## Mission