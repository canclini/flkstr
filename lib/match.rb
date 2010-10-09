class Match
  
  def self.initiate(request)
    #find all products matching the request
    companies = request.find_related_tags_for(Company).to_a
    
    #deduct own company
    companies.delete(request.company)
    
    

    #generate a lead for each product
    companies.each do |company| 
      request.leads.create(:company => company, :source => request.company)
    end
  end
  
end


#  criterias: tags, distance or country, budget, language
#  
#  if distance criteria is set to country
#    find all companies with the same country code and matching language
#  else
#    find all companies within the provided distance
#  then
#    find all products with matching tags
#    find all products where budget fits
#    
#    
#    filter mit Gewicht:
#    ALle Produkte welche passende Tags haben werden als Objekte einer Klasse erfasst (Match)
#    
#    jedes objekt hat ein Produkt, die Tags des Produktes, eine Firma,
#    eine dinstanz, ein land, ein budget, eine Sprache und ein Gewicht
#    
#    Das Gewicht kommt folgendermassen zur Geltung
#    100:  alle Tags des Requests kommen im Produkt vor
#          alle Filterkriterien stimmen überein
#      1:  ein Tag passt aber keine Filterkriterien stimmen überein
#      
# Berechnung des Gewichts
#   Anzahl Request Tags (RT)
#   Anzahl Matching Tags (MT)
#   Anzahl Product Tags (PT)
#   Gewicht Tag (WT)
#   Reuqest Budget (RB)
#   Product Budget (PB)
#   Gewicht Budget (WB)
#   Gewicht Sprache (WL)
#   Request Distance (RD)
#   Product Distance (PD)
#   Gewicht Distance (WD)
# 
# Tags:  MT / RT * 100 - (PT -MT) *10
# 
# Budget: 
#   Abweichung Berechnen: Absolutwert der Differenz zwischen product budget und request budget
#     -> (RB - PB).abs
#     umrechnen in prozent: percentBuget = (RB - PB).abs / RB * 100
#     
#     eine Abweichung von 5 % ergibt einen Wert von 100 (budgettolerance)
#     danach pro prozent eine -1
#     dies ergibt einen Wert von 50 bei einer abweichung von 55%
#     somit kann der Wert folgendermassen berechnet werden
#     WB = 100 if percentbudget <= budgettolerance
#     WB = 100 + budgettolerance - percentbudget
# 
# Language:
#   stimmt die Request Langunage (RL) mit der Product Language (PL) überein : 100
#   ansonsten 0
# 
# Distance:
#   unterscheidung zwischen own country und distance in km
#   
#   own country: ist die Firma des Produkts im gleichen Land: 100 ansonsten 0
#   
#   distance to:
#   zuerst für jedes product die dinstant berechnen
#     loop through all products.company.main_address
#       calculate distance between request.company.main_address
#       save it with the object
#       
#   Wert berechung der Distanz
#    Distance < RD: 100
#    danach eine prozentualle Anpassung
#    percentdistance = (PD - RD) / RD * 100
#    
#   falls percentdistance > 100 : Wert = 0
#   ansonsten Wert = 100 - percentdistance
#   
#   Sind die einzelnen Werte berechnet müssen diese noch konsolidiert werden
#   jeder Wert hat nochmal ein eigenes Gewicht wobei das Geicht der Tags zum Beispiel mehr Wert hat als die Distanz
#   
#   WT: 5
#   WB: 3
#   WL: 1
#   WD: 1
#   
#   (3*WT +2*WB +1*WL+1*WD) / 10 = FinalWeight
#   
#   Leads werden nur für Matches erstellt welche ein Gewicht von mehr als 50 haben.
#   
#   Fehlen gewisse Kriterien auf seiten des Produkts werden diese mit einem definierten Wert von 30 gewichtet
#   
#   Eventuell macht es Sinn keine Lead zu erstellen, falls der ein Parameter das Gewicht 0 hat?