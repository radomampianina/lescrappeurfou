require 'nokogiri'
require 'open-uri'

class  Ville_email

# les adresses email des mairies du Val d'Oise
def emails(ville)
   @mairies = []
   doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{ville}.html"))
   doc.css('a.lientxt').each do |link|
    @mairies.push(link.content.downcase.gsub(/[[:blank:]]/, '-'))
  end
  @mairies.each { |x| get_the_email_of_a_townhal_from_its_webpage(x) }
end

# récupère l'adresse email à partir de l'url d'une mairie, par exemple celle de Vauréal
def get_the_email_of_a_townhal_from_its_webpage(ml)
    @mml = []
             doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/95/#{ml}"))
             doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |node|
             @mml.push(node.text)
         end
         puts @mml
end

# récupère toutes les url de villes du Val d'Oise
def get_all_the_urls_of_val_doise_townhalls
  emails('val-d-oise')
  le_hash = Hash.new
  for ttt in 0..@mairies.length do
    le_hash["#{@mairies[ttt]}"] = @mml[ttt]
  end
  print le_hash
end

end

# trader de lobsucre
def extract_currencies
  crypto_list = {}
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  crypto_list = {}
  elements = page.css('#currencies-all tbody tr')
#on créé l'array curriences que l'on veut récupérer
  currencies = []
  elements.each do |element|
    currencies.push({
      #dans l'array currencies les 2 seuls qui nous intéresse sont price et name
      "name" => element.css('.currency-name-container').text,
      "price" => element.css('.price').text
    })
  end
#on rappelle la currencies uniquement
  return currencies
end
while 1 do
  puts extract_currencies
  # relancer toute les 1 heure
  sleep 3600
end

affiche = Ville_email.new
# les addresse email des mairies de Val d'Oise
  # affiche.emails('val-d-oise')
# récupère l'adresse email à partir de l'url d'une mairie, par exemple celle de Vauréal
  # affiche.get_the_email_of_a_townhal_from_its_webpage('vaureal')

# Affiche le hash
  # affiche.get_all_the_urls_of_val_doise_townhalls
