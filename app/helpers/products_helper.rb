module ProductsHelper

  def size
  end

  def status
    [{name: "新品、未使用"}, {name: "未使用に近い"}, {name: "目立った傷や汚れなし"},{name: "やや傷や汚れあり"}, {name: "傷や汚れあり"}, {name: "全体的に状態が悪い"}]
  end
end
