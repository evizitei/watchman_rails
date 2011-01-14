class Apparatus
  MAP = {:county=>["E101","E201","E301","E401","E501","E601","E701","E801",
                   "E901","E1001","E1201","E1301","E1401","E1501",
                   "T105","T305","T405","T505","T605","T805","T905","T1005","T1505",
                   "G106","G306","G406","G506","G606","G806","G906","G1006",
                   "S104","S604","H514","CM1","CM2","AIR15",
                   "B107","B207","B307","B807"],
         :city=>[],
         :south_county=>[],
         :ems=>[]}
  class << self 
    def county
      MAP[:county]
    end
  end
end