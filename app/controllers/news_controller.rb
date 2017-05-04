# encoding: utf-8
class NewsController < ApplicationController

  def crawl
    agent = Mechanize.new
    #agent.content_encoding_hooks << Proc.new do |s, uri, response, body_io|
    #    if %r|text/html| =~ response["Content-Type"]
 #	body_io.rewind #念のため巻き戻し（多分不要)
#	tmp=NKF.nkf("-wm0",body_io.read);# readで読み込んでEUCからUTF-8にnkfで変換
#	tmp.force_encoding("utf-8");
#	body_io.rewind #巻き戻して、utf-8で書き直す
#	body_io.write(tmp);
#		response["Content-Type"]="text/html; charset=utf-8"
#	end
 #   end
    #page = agent.get("http://qiita.com")
    bacardpage = agent.get("http://www.bacardijapan.jp/information/2017/")
    @bacardinews = bacardpage.search('div.read')

    suntorypage = agent.get("http://www.suntory.co.jp/whatsnew/rss.xml?fromid=top")
    #agent.page.encoding="Shift_JIS"
    #suntorypage.page.encoding = 'Shift_JIS'          
    suntory_doc = Nokogiri::HTML(suntorypage.body)    
    suntory_doc.encoding= "UTF-8"
   
    #sundoc_euc = NKF.nkf("-wm0",suntory_doc).sub(/euc-jp/,"utf-8")
    #@suntorynews = sundoc_euc
    @suntorynews = suntory_doc

    kirinpage = agent.get("http://www.kirin.co.jp/rss/news/release.rdf")
    kirin_doc = Nokogiri::HTML(kirinpage.body)    
    @kirinnews = kirin_doc


    asahipage = agent.get("http://www.asahibeer.co.jp/news.rdf")
    asahi_doc = Nokogiri::HTML(asahipage.body)    
    @asahinews = asahi_doc
  end
end
