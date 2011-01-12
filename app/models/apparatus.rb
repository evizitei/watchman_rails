class Apparatus
  MAP = {:county=>["E101","E201","E301","E401","E501","E601","E701","E801",
                   "E901","E1001","E1201","E1301","E1401","E1501"],
         :city=>[],
         :south_county=>[],
         :ems=>[]}
  class << self 
    def county
      MAP[:county]
    end
  end
end