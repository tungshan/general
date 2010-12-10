class Array
	def merge_sort(&predicate)
		if size <= 1
			self.dup
		else
			halves = split.map{ |half| half.merge_sort(&predicate) }
			merge(*halves, &predicate)
		end
	end

protected
	def split_rec(ls1, ls2, result)
		if ls1.size <= 1
			[result, ls2]
		else
			split_rec(ls1[2..-1], ls2[1..-1], result + [ls2.first])
		end
	end
	
	def split
		split_rec(self, self, [])
	end
	
	def merge(first, second, &predicate)
		if first.empty?
			second.dup
		elsif second.empty?
			first.dup
		elsif predicate.call(first.first, second.first)
			[first.first] + merge(first[1..-1], second, &predicate)
		else
			[second.first] + merge(first, second[1..-1], &predicate)
		end
	end
end

p [1, 5, 6, 4, 3].merge_sort{ |a,b| a <= b }


