module CardHelper

  def card_years
    @years = []    
    Date.today.year.upto(Date.today.year + 10){ |year|
      @years << year
    }
    return @years
  end

end
