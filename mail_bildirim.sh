#!/bin/bash

# Fail2Ban ile engellenen IP'ler
BANNED_IPS=$(sudo fail2ban-client status sshd | grep 'Banned IP list')

# auth.log'daki son 5 başarısız giriş
FAILED_ATTEMPTS=$(sudo grep "Failed password" /var/log/auth.log | tail -n 5 | \
awk '{ 
    user=""; ip="";
    for(i=1;i<=NF;i++) {
        if($i=="for") user=$(i+1);
        if($i=="from") ip=$(i+1);
    }
    print "Zaman: "$1" "$2" "$3", IP: "ip", Kullanıcı: "user
}')

# Mail içeriği
MAIL_CONTENT="Fail2Ban SSH Güvenlik Raporu\n\n"
MAIL_CONTENT+="[ENGELLENEN IP'LER]\n$BANNED_IPS\n\n"
MAIL_CONTENT+="[SON 5 BAŞARISIZ GİRİŞ]\n$FAILED_ATTEMPTS\n\n"
MAIL_CONTENT+="Rapor oluşturulma zamanı: $(date)"

# Mail gönderimi
echo -e "$MAIL_CONTENT" | mail -s "SSH Güvenlik Uyarısı - $(date +%d.%m.%Y)" kaan

