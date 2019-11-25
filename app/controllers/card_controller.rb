class CardController < ApplicationController

  def new
    @years = []    
    Date.today.year.upto(Date.today.year + 10){ |year|
      @years << year
    }
  end

  def create
  end
  
end
