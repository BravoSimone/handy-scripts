require 'net/ftp'

ftp = Net::FTP.new('Your.ftp.server')
ftp.login(user = "anonymous", passwd = nil, acct = nil)
ftp.chdir("Path/where/your/file/will/be/stored")
fake_file = StringIO.new("Your string")
ftp.storlines('STOR file_name', fake_file)
ftp.quit()
