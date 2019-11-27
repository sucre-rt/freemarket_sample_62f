module SignupHelper

  def status_bar(status1, status2, status3, status4, status5)
    @status1 = status1
    @status2 = status2
    @status3 = status3
    @status4 = status4
    @status5 = status5
  end

  def birthday_years
    years = []
    Date.today.year.downto(1900){ |year|
      years << year
    }
    return years
  end

  def set_days
    days = []
    for day in 1..31 do
      if day.to_s.length == 1
        days << "0" + "#{day}"
      else
        days << day
      end
    end
    return days
  end
  
end
