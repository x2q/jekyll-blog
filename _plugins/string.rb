class String
  def xmlschema
    DateTime.strptime(self, '%Y-%m-%d %H:%M:').xmlschema
  end
end
