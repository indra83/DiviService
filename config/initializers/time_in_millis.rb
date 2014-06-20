class Time
  def to_millistr
    strftime '%s%3N'
  end

  def self.from_millistr(m)
    at(m.to_i/BigDecimal(1000))
  end
end
