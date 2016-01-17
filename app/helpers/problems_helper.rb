module ProblemsHelper
	def max_level
		return Problem.maximum(:level)
	end
end
