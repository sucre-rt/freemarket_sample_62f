module MypageHelper

  def card_icon(card)
    case card.brand
    when "Visa"
      "logo_visa.gif"
    when "MasterCard"
      "mc_vrt_pos.png"
    when "JCB"
      "jcb-logomark-img-01.gif"
    when "American Express"
      "amex-logomark-img-04.gif"
    when "Diners Club"
      "diners-logomark-img-01.gif"
    when "Discover"
      "discover-logomark-img.gif"
    end
  end

end
