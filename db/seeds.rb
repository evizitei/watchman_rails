# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

  org_ids = ["EV2067", "DA0812", "TB6670", "JB1941", "DB3177", "BC7457", "ND2603", "SD9594", "LE5863", "RF4314", "JF4697", 
  "BH8076", "JH4910", "JH0598", "DJ7630", "JJ4703", "MJ1054", "PK3072", "SK8374", "RK2901", "AL1426", "SM3940", "DM3996", 
  "JN1804", "GN7697", "BO5331", "JP9216", "JP7386", "JP2840", "MR8087", "RR1420", "SS2421", "PS8287", "AT3048", "WU8813", 
  "DV7349", "BW7080", "DA8307", "MC0576", "TK0323", "KM8233", "DM3482", "RN7990", "MN7674", "JO7814", "TR0592", "VM6825", 
  "ZD6077", "MF1311", "NB5283", "JH6908", "KK6809", "GL6627", "AM0901", "WM5907", "ZM3550", "MM1945", "SM7143", "JR4675", 
  "TS9024", "WT9726", "DT3756", "BZ9592", "MZ2990", "WC8610", "JH9938", "HM3046", "CM9582", "EM3395", "SM9460", "LM1060", 
  "BM7894", "CR7514", "AS7377", "JT1647", "HW7631", "JB4409", "SB8715", "GB6557", "JB5202", "NB3822", "KB8348", "AB7411", 
  "JC5957", "SD1480", "ME9208", "ME4051", "JE6455", "BH1233", "WH4701", "LH9579", "AH3236", "NH6930", "MS7125", "BJ4749", 
  "ML0740", "CM4490", "PM8750", "JN1212", "GO5206", "MP3492", "TP8295", "TP7641", "JR9476", "DR8884", "BR6679", "KS2564", 
  "SS8021", "BS4536", "CW6379", "FW7767", "SW6319", "JW2136", "GY8320", "KA5252", "DA2999", "SA2616", "DB9963", "BB0886", 
  "EC2029", "ZD3717", "KH9958", "SK1580", "SL8372", "TN7336", "DR3694", "DR5583", "TR8280", "DS1606", "CS1780", "AS9550", 
  "KS2721", "NB2159", "TB4589", "CC6798", "CS3682", "MS3966", "RY8161", "RA0824", "MA9424", "DA7199", "DB4855", "DB9762", 
  "MG0874", "WG8070", "JG1776", "JL6972", "LL0455", "JL1867", "RM3183", "MM1811", "AR4823", "AR2470", "DS4269", "JS8417", 
  "JS6579", "TS0606", "AS3309", "AS4583", "JW7922", "MW0771", "AW5481", "KA8588", "TB1480", "MC1389", "BC1518", "WH4280", 
  "JJ5164", "JK2056", "JB7527", "PK3101", "BK4046", "GM7747", "CM6339", "BR3856", "SS3239", "MS4649", "JV8044", "AB3140", 
  "RB0779", "CB4520", "AN1491", "DD4511", "CG2651", "SH5710", "MH1551", "CH6723", "JH6205", "MI8329", "TJ6435", "BK6018", 
  "NO6006", "EP1861", "SR1592", "MR3311", "SS4757", "DT3188", "JT0908", "GW1737", "TW1638", "RY9755", "IB9338", "DD0025", 
  "CD4486", "BM2968", "KN9479", "TO1321", "MS9423", "JV7894", "JV0650", "TW0692", "CW7086", "DB9719", "CI3764", "CL6823", 
  "TM9737", "CM1641", "JS0626", "JV7073", "FY9741", "NB7386", "RC0735", "MC8739", "DC4970", "AE1682", "MG5336", "JG3342", 
  "GJ4253", "CK5410", "GO9280", "RR6014", "PS0882", "RS3227", "CS9681", "KW1107", "BD6851", "SD8018", "DH4267", "PH4301", 
  "NJ4734", "JL2380", "AP4110", "LP1727", "MP4133", "TR3840", "NS1255", "MT1548", "JT6335", "BW1235", "EW2429", "PF0000", 
  "RA8091", "PB9740", "MB2926", "GB5093", "JC1446", "QC1997", "BC1261", "BD9668", "KD1476", "RF0593", "KG6983", "SG3764", 
  "JG4186", "LH0001", "JH1411", "DH8913", "KH7596", "DJ3175", "JJ2108", "JK0000", "DL2305", "CL9369", "RL0077", "GM3607", 
  "SO4942", "MP0634", "GR0041", "SS5761", "SS4652", "VS5281", "JS7070", "BS2795", "MS1425", "JT8289", "WT9012", "LT7097", 
  "DW1808", "JW7069", "LW5124", "BW2460", "TA6262", "LB4522", "SB2011", "KB5238", "MB8672", "PB2971", "TB7762", "DB3179", 
  "DB3469", "DB7839", "PB0072", "CB2780", "JB8557", "AA9824", "AB7469", "RB9261", "MB6347", "AB7404", "MC7908", "BC7732", 
  "DC1733", "DR7402", "TC9033", "EC2413", "TC5993", "LC1384", "KC7085", "CD3955", "CD4062", "VD6313", "SD4177", "JD0257", 
  "MD2270", "TD6372", "CD0754", "MF7402", "DG7077", "DG0926", "CG0947", "JG3426", "DG0445", "PG7081", "MG0742", "KG7609", 
  "LH3662", "SH5841", "KH2216", "MH1690", "SB1687", "EH6593", "CH8525", "DH6321", "RH5206", "SH1670", "JH2279", "GJ4755", 
  "JJ1287", "MJ4436", "EJ7580", "WJ3375", "BJ1210", "MJ9363", "DK8920", "MK1170", "KB0988", "TK3780", "MK6577", "TK5413", 
  "KK7324", "EK7021", "RK0638", "SL6992", "EL3036", "ML8325", "RL7896", "JL5861", "PL7368", "ML1421", "CM6314", "MM5742", 
  "MM9187", "JM0024", "CM1506", "DM2588", "LM2348", "MM8036", "MM9375", "RM7483", "SM1104", "AM2494", "SM9358", "CM0374", 
  "DM5581", "BN5717", "TN4586", "BN9572", "GO4782", "DO5204", "JP2714", "TP1197", "LP5940", "ER0310", "CR1746", "JR4149", 
  "SR0112", "TR2811", "RS7920", "BS6874", "NS0696", "JS0261", "CS4352", "DS3762", "JS0345", "TS5415", "MS6243", "TS3624", 
  "GS7420", "SS2097", "JS0035", "BS3539", "RS7023", "KS7247", "HS6113", "SS1941", "SS7384", "MS9110", "DS7581", "DS0835", 
  "JS3570", "DT4962", "BT6511", "MT0802", "JT9233", "SV7613", "CV4905", "EV7294", "SV9318", "TW0905", "RW8585", "BW0682", 
  "DW8461", "MW7739", "CW3343", "SW2293", "KW0838", "SW1096", "JW6086", "LY6374", "RY8012", "NK7852", "DR8927", "TB0594", 
  "JB9982", "CH8828", "CH4238", "EK4051", "SL1396", "JM0524", "DP7284", "JS2945", "DS3263", "JS2991", "BS8840", "AS7757", 
  "MM7672", "BP4447", "JP1442", "RS2366", "JV2580", "BW5401", "BZ9573"]
  
  org_ids.each do |id|
    OrganizationId.find_or_create_by_name(id)
  end
  
  user = User.find_by_email("ethan.vizitei@gmail.com") || User.new
  
  user.update_attributes!(:email=>"ethan.vizitei@gmail.com",:organization_id=>"EV2067",:phone=>"15732395840",:password=>"firedistrict",:password_confirmation=>"firedistrict")
  

FasterCSV.foreach("#{Rails.root}/db/geotargets.csv") do |row|
  gt = GeoTarget.find_or_create_by_address(:address=>row[0].upcase.strip)
  gt.update_attributes!(:x_coord=>row[1],:y_coord=>row[2],:city=>row[3])
end