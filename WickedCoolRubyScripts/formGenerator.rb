require 'cgi'

cgi = CGI.new("html4Tr")

print "Podaj tytuł strony: "
title = gets.chomp
print "Podaj nagłówek formularza: "
input_title = gets.chomp
print "Podaj etykietę pola wyboru: "
value = gets.chomp
print "Podaj grupę: "
group = gets.chomp

$stdout = File.new("form.html", "w")
cgi.out {
  CGI.pretty(
    cgi.html {
	cgi.head{ "\n"+cgi.title{title}}+
	cgi.body{"\n" + 
	cgi.form{"\n"+
	cgi.hr +
	cgi.h1 {"#{input_title}:"} + "\n"
	cgi.br +
	cgi.checkbox(group, value) + value + cgi.br + cgi.rb + cgi.textarea("input", 80, 5) + "\n" + cgi.br + cgi.submit("Wyślij")
	}
	}
	}
  )
  }
$stdout.close