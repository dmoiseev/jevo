function leak()
	for i=1:100000
		f = eval(:(function() produce() end))
		t = Task(f)
		consume(t)

		t.exception = null
		try
		  yieldto(t)
		end
	end
	gc()
end
