class String
  def capitalize
    case self.size
    when 0 then self
    when 1 then self.upcase
    else self[0].upcase + self[1..-1].downcase
    end
  end

  def downcase
    UnicodeUtils.downcase self
  end

  def upcase
    UnicodeUtils.upcase self
  end
end
