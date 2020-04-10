# README

This application scrapes content from https://hamrobazar.com and displays the product in this application.Please visit 


The application has the following dependencies:

* Rails(5.1.7)

* Redis

* Chrome Driver binaries and chrome browser

* Database(SQLITE)

* ...

Working:
* The application uses Selenium with chrome or firefox webdriver
* Selenium is used as the CloudFlare URL restricts OPENURI

Installation:
* sudo apt-get install xvfb
* sudo apt-get install redis
* git clone https://github.com/abhiyan52/bazargo.git
* bundle install
* rails db:migrate
