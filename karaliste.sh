#!/bin/bash

# Engellenen IP'leri listeleme scripti

echo "=== Fail2Ban Tarafından Engellenen IP'ler ==="
sudo fail2ban-client status sshd | grep "Banned IP list"

echo -e "\n=== iptables Tarafından Engellenen IP'ler ==="
sudo iptables -L -n | grep "DROP"

echo -e "\n=== Son 10 Başarısız Giriş Denemesi ==="
sudo grep "Failed password" /var/log/auth.log | tail -n 10

echo -e "\nRapor oluşturulma tarihi: $(date)"
