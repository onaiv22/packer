#!/bin/bash -eux

# Clean up
yum clean all

# Clean up scripts
rm -rf /home/centos/script_*.sh
rm -rf /home/centos/ansible-staging

# Remove unused locales
rm -rf /usr/share/locale/{af,am,ar,as,ast,az,bal,be,bg,bn,bn_IN,br,bs,byn,ca,cr,cs,csb,cy,da,de,de_AT,dz,el,en_AU,en_CA,eo,es,et,et_EE,eu,fa,fi,fo,fr,fur,ga,gez,gl,gu,haw,he,hi,hr,hu,hy,id,is,it,ja,ka,kk,km,kn,ko,kok,ku,ky,lg,lt,lv,mg,mi,mk,ml,mn,mr,ms,mt,nb,ne,nl,nn,no,nso,oc,or,pa,pl,ps,pt,pt_BR,qu,ro,ru,rw,si,sk,sl,so,sq,sr,sr*latin,sv,sw,ta,te,th,ti,tig,tk,tl,tr,tt,ur,urd,ve,vi,wa,wal,wo,xh,zh,zh_HK,zh_CN,zh_TW,zu}

# Remove docs
rm -rf /usr/share/doc

# Remove man pages
rm -rf /usr/share/man/??
rm -rf /usr/share/man/??_*

# remove files from cache
find /var/cache -type f -delete

# Remove history file
unset HISTFILE
rm -f ~/.bash_history /root/.bash_history /home/centos/.bash_history

dd if=/dev/zero of=/EMPTY bs=1M || echo "dd exit code $? is suppressed"
rm -f /EMPTY
# Block until the empty file has been removed, otherwise, Packer
# will try to kill the box while the disk is still full and that's bad
sync

echo "==> Disk usage after cleanup"
df -h
