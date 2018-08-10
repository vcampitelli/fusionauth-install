#!/usr/bin/env bash

VERSION=$(curl https://www.inversoft.com/latest-passport-version)

SUFFIX=""
case $(uname -s) in
    Linux*)     install_linux;;
    CYGWIN*)    install_zip;;
    Darwin*)    SUFFIX="macos-"; install_zip;;
    *)          echo "Unsupported platform, will attempt the zip install"; install_zip;;
esac

echo "Done. Time for tacos."

install_linux() {
  # Detect dpkg and rpm, fallback to zip
  if hash dpkg; then
    install_deb;
  elif hash yum; then
    install_rpm;
  else
    install_zip;
  fi
}

install_deb() {
  curl -o /tmp/fusionAuth-backend.deb "https://storage.googleapis.com/inversoft_products_j098230498/products/passport/${VERSION}/passport-backend-${VERSION}-1_all.deb"
  curl -o /tmp/fusionAuth-search-engine.deb "https://storage.googleapis.com/inversoft_products_j098230498/products/passport/${VERSION}/passport-search-engine-${VERSION}-1_all.deb"

  sudo dpkg -i /tmp/fusionAuth-backend.deb /tmp/fusionAuth-search-engine.deb
}

install_rpm() {
  curl -o /tmp/fusionAuth-backend.rpm "https://storage.googleapis.com/inversoft_products_j098230498/products/passport/${VERSION}/passport-backend-${VERSION}-1.noarch.rpm"
  curl -o /tmp/fusionAuth-search-engine.rpm "https://storage.googleapis.com/inversoft_products_j098230498/products/passport/${VERSION}/passport-search-engine-${VERSION}-1.noarch.rpm"

  sudo rpm -i /tmp/fusionAuth-backend.deb /tmp/fusionAuth-search-engine.rpm
}

install_zip() {
  curl -o /tmp/fusionAuth-backend.zip "https://storage.googleapis.com/inversoft_products_j098230498/products/passport/${VERSION}/passport-backend-${SUFFIX}${VERSION}.zip"
  curl -o /tmp/fusionAuth-search-engine.zip "https://storage.googleapis.com/inversoft_products_j098230498/products/passport/${VERSION}/passport-search-engine-${SUFFIX}${VERSION}.zip"

  #TODO
}

