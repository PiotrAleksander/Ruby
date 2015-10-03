require 'win32ole'

ie = WIN32OLE.new('InternetExplorer.Application')
ie.navigate("http://toolbar.google.com/send/sms/index.php")

ie.visible = true
sleep 1 until ie.readyState() == 4

ie.document.all["mobile_user_id"].value = "5712013623"
ie.document.all["carrier"].value = "TMOBILE"
ie.document.all["subject"].value = "***Ruby wysyła wszystkich do piachu!***"
ie.document.all.tags("textarea").each do |i|
  i.value = "Dzięki za dobrą robotęYukihiro!"
end

ie.document.all.send_button.click