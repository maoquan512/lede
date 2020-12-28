cd lede
# 替换默认Argon主题（最新版本适配好像有问题,暂取
# rm -rf package/lean/luci-theme-argon && git clone https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon
cat feeds.conf.default

# 更新并安装源
./scripts/feeds clean
./scripts/feeds update -a && ./scripts/feeds install -a

# 添加第三方软件包
git clone https://github.com/tindy2013/openwrt-subconverter package/openwrt-subconverter
git clone https://github.com/fw876/helloworld package/helloworld
git clone -b master https://github.com/vernesong/OpenClash package/OpenClash
#git clone https://github.com/maoquan512/core package/OpenClash/luci-app-openclash/files/etc/openclash/core

# 自定义定制选项
sed -i 's#192.168.1.1#192.168.2.1#g' package/base-files/files/bin/config_generate #定制默认IP
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' package/lean/default-settings/files/zzz-default-settings #取消系统默认密码

# 替换更新haproxy默认版本
#rm -rf feeds/packages/net/haproxy && svn co https://github.com/Lienol/openwrt-packages/trunk/net/haproxy feeds/packages/net/haproxy

#创建自定义配置文件 - OpenWrt-x86-64

rm -f ./.config*
touch ./.config
# 第三方插件选择:
cat >> .config <<EOF
CONFIG_PACKAGE_subconverter=y #转换
CONFIG_PACKAGE_luci-app-openclash=y #OpenClash
EOF
sed -i 's/^[ \t]*//g' ./.config
