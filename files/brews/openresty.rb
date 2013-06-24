require 'formula'

class Openresty < Formula
  homepage 'http://openresty.org/'
  url 'http://openresty.org/download/ngx_openresty-1.2.8.6.tar.gz'
  sha1 '4b47862a77577d06447d17c935e94dc935c279e5'
  version '1.2.8.6-boxen1'

  depends_on 'pcre'
  depends_on 'luajit'

  skip_clean 'logs'

  def install
    args = [
        "--prefix=#{prefix}",
        "--with-http_ssl_module",
        "--with-pcre",
        "--with-ipv6",
        "--with-cc-opt='-I#{HOMEBREW_PREFIX}/include'",
        "--with-ld-opt='-L#{HOMEBREW_PREFIX}/lib'",
        "--conf-path=/opt/boxen/config/nginx/nginx.conf",
        "--pid-path=/opt/boxen/data/nginx/nginx.pid",
        "--lock-path=/opt/boxen/data/nginx/nginx.lock",
        "--error-log-path=/opt/boxen/log/nginx/error.log",
        "--with-luajit",
        "--with-http_gzip_static_module",
    ]

    system "./configure", *args
    system "make"
    system "make install"

    # Openresty installs nginx into a nginx/ subdirectory. Need to manually
    # copy the binary into sbin/.
    sbin.install prefix/"nginx/sbin/nginx"

    # remove unnecessary config files
    system "rm -rf #{etc}/nginx"
  end
end
