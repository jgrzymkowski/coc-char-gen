module ApplicationHelper
  def sym_to_title sym
    sym.to_s.split('_').collect { |t| t.capitalize}.join(' ')
  end
end
