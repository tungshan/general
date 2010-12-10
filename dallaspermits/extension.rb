# encoding: utf-8
class String
	#alias_method :old_strip, :strip
	def custom_strip
		self.gsub(/^[\302\240|\s]*|[\302\240|\s]*$/, '').gsub(/(\n)|\s+/,' ') 
	end
end
