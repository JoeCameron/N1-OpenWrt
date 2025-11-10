#!/bin/bash

# Adjust source code
patch -p1 -f < $(dirname "$0")/luci.patch

# 移除 openwrt feeds 自带的核心库
rm -rf feeds/packages/net/{xray-core,v2ray-geodata,sing-box,chinadns-ng,dns2socks,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev,simple-obfs,tcping,trojan-plus,tuic-client,v2ray-plugin,xray-plugin,geoview,shadow-tls}
rm -rf feeds/luci/applications/luci-app-passwall


# Add packages
git clone https://github.com/ophub/luci-app-amlogic --depth=1 clone/amlogic
git clone https://github.com/xiaorouji/openwrt-passwall --depth=1 clone/passwall
git clone https://github.com/xiaorouji/openwrt-passwall-packages --depth=1 clone/passwall-packages
git clone https://github.com/vernesong/OpenClash --depth=1 clone/OpenClash
git clone https://github.com/jerrykuku/luci-theme-argon --depth=1 clone/luci-theme-argon

# Update packages
cp -rf clone/amlogic/luci-app-amlogic feeds/luci/applications/
cp -rf clone/passwall/luci-app-passwall feeds/luci/applications/
cp -rf clone/OpenClash/luci-app-openclash feeds/luci/applications/
cp -rf clone/passwall-packages package/
cp -rf clone/luci-theme-argon feeds/luci/applications/

#mosdns
rm -rf feeds/packages/lang/golang
git clone https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang

# remove v2ray-geodata package from feeds (openwrt-22.03 & master)
rm -rf feeds/packages/net/v2ray-geodata

git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata




# Clean packages
rm -rf clone
