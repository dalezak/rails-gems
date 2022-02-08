class Object
  def to_bool
    !!self
  end
end

class Integer
  def to_bool
    self == 1
  end
end

class String
  def to_bool
    if self == true || self =~ /(true|t|yes|y|1|on)$/i
      true
    elsif self == false || self.blank? || self =~ /(false|f|no|n|0|off)$/i
      false
    else
      false
    end
  end
end

class Symbol
  def to_bool
    self.downcase.to_s =~ /(true|t|yes|y|1|on)$/i
  end
end
