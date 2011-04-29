namespace :asterisk do
    desc """Prepare Asterisk configuration"""
    task :prepare do
        sh "sudo cp contrib/meetme-manager.conf /etc/asterisk/manager.d"
        sh "sudo cp contrib/sip.conf /etc/asterisk/"
        sh "sudo asterisk -rx 'manager reload'"
        sh "sudo asterisk -rx 'sip reload'"
    end
    
    desc """Launch a verbose Asterisk console"""
    task :console do
        sh "bash -c 'sudo asterisk -rvvvvvvvvd'"
    end
end
