require 'nokogiri'
require 'open-uri'
require 'rest-client'

module Parser
    class Movie
        def naver
            # 네이버 현재상영영화중 하나를 랜덤으로 뽑아주는 코드
        
            doc = Nokogiri::HTML(open("http://movie.naver.com/movie/running/current.nhn"))
            movie_title = Array.new
            
            doc.css("ul.lst_detail_t1 dt a").each do |title|
            	movie_title << title.text
            end
            
            title = movie_title.sample
            return "<" + title + ">"
        end
    end
    
    class Animal
        def cat
            cat_xml = RestClient.get 'http://thecatapi.com/api/images/get?format=xml&type=jpg'
            doc = Nokogiri::XML(cat_xml)
            cat_url = doc.xpath("//url").text
            
            return cat_url
        end
    end
    
    class Lotto
        def num
            # 로또 번호 뽑아주주는 코드 
            lotto_num = (1..45).to_a.sample(6).to_s
            return lotto_num
        end
    end
    
    class Menu
        def food
         lunch = ["규동", "삼겹살", "초밥", "떡볶이", "연어덮밥", "소갈비", "냉면", "아무거나 먹어"].sample
         return lunch
        end
    end
        
    
end
