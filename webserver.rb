require 'socket'
serwer = TCPServer.new('127.0.0.1', 7125) #buduje serwer poprzez klasę wbudowaną w socket
while (sesja = serwer.accept) 
   sesja.print "HTTP/1.1 200/OK\r\nTyp:tekst/html\r\n\r\n" #informacja dla klarowności co dzieje się właśnie w konsoli
   zadanie = sesja.gets #np kliknięcia na linki w indexie
   sformatowane_zadanie = zadanie.gsub(/GET\ \//, '').gsub(/\ HTTP.*/, '') #podmienia metody, serwer nie połączy się z bazą danych
   plik = sformatowane_zadanie.chomp #getsy sesji oddzielone \n
   if plik == ""
      plik = "index.html"
   end
   begin
      wyswietl = File.open(plik, 'r') #html jak zwyczajny plik
      content = wyswietl.read() #ten read jest raczej z biblioteki socket
      sesja.print content
   rescue Errno::ENOENT
      sesja.print "Nie odnaleziono pliku index.html."
   end
   sesja.close #zamyka przepływ danych
end