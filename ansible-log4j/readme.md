ansible-script-scan-kyndryl-log4j

wget -O - https://raw.githubusercontent.com/dxfullv2/bashrepo/Log4j/ansible-log4j/install.sh | sh

==========================

>Ansible Playbook Preparation<

Download and unzip Kyndryl's scanners on /[installpath]/scan/
Prepare WinOS if needed using /[installpath]/scan/ConfigureRemotingForAnsible.ps1
Extra packages: git, pexpect (vcfix), sshpass (vcfix)

 = = = = = = = = = = = = =

 Execution:

 Input linux and windows reachable hostnames/IPs on /[installpath]/inventory file
 Include username/password on inventery file or use Ansible-vault
 Check: ansible-playbook --check scan_play.yml (or vcfix_play.yml)
 Run using: ansible-playbook scan_play.yml (or vcfix_play.yml)

 ==========================
