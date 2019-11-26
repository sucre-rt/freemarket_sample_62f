module MypageHelper

  def card_icon(card)
    if card.brand == "Visa"
      "logo_visa.gif"
    elsif card.brand == "MasterCard"
      "mc_vrt_pos.png"
    elsif card.brand == "JCB"
      "jcb-logomark-img-01.gif"
    elsif card.brand == "American Express"
      "amex-logomark-img-04.gif"
    elsif card.brand == "Diners Club"
      "diners-logomark-img-01.gif"
    elsif card.brand == "Discover"
      "discover-logomark-img.gif"
    else
      ""
    end
  end

end
