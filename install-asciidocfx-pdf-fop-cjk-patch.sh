#!/bin/bash
INSTALL_DIR=`pwd`
cd ..

MAIN_APP_OPTIONS=AsciidocFX.vmoptions

if [ ! -f "${MAIN_APP_OPTIONS}" ]; then
  echo "NOT UNDER A AsciidocFX DIR!"
  echo "PLEASE COPY THIS FOLDER TO AsciidocFX DIR"
  exit 1
else
  echo "IS A AsciidocFX DIR"
  ASCIIDOCFX_DIR="`pwd`"
fi

ASCIIDOCFX_FONTS_DIR="${ASCIIDOCFX_DIR}/conf/fonts"
ASCIIDOCFX_FOP_CONFIG_DIR="${ASCIIDOCFX_DIR}/conf/docbook-config"
FONT_DOWNLOAD_BASE=https://github.com/life888888/cjk-fonts-ttf/releases/download/v0.1.0


# FONT LANGUAGE CODE
# sc (Simplified Chinese)
# tc (Traditional Chinese)
# hk (Hong Kong)
# jp (Japanese)
# kr (Korean)

#FONT_LANG=tc

if [ -z "$1" ]
then
      echo "PLEASE GIVE LANGUAGE CODE - EX: 'tc'"
      echo "### FONT LANGUAGE CODE ###"
      echo " sc (Simplified Chinese)"
      echo " tc (Traditional Chinese)"
      echo " hk (Hong Kong)"
      echo " jp (Japanese)"
      echo " kr (Korean)"
      echo ""      
      echo "Usage:"
      echo "./install-asciidocfx-pdf-fop-cjk-patch.sh tc"
      exit 2
else
      FONT_LANG=$1
      echo "SET FONT_LANG=$1"
fi

mkdir -p "${ASCIIDOCFX_FONTS_DIR}/NotoCJK"
cd "${ASCIIDOCFX_FONTS_DIR}/NotoCJK"

TTF_FILE_LIST=("NotoSansCJK${FONT_LANG}-BoldItalic.ttf" "NotoSansCJK${FONT_LANG}-Bold.ttf" "NotoSansCJK${FONT_LANG}-Italic.ttf" "NotoSansCJK${FONT_LANG}-Regular.ttf" "NotoSansMonoCJK${FONT_LANG}-BoldItalic.ttf" "NotoSansMonoCJK${FONT_LANG}-Bold.ttf" "NotoSansMonoCJK${FONT_LANG}-Italic.ttf" "NotoSansMonoCJK${FONT_LANG}-Regular.ttf" "NotoSerifCJK${FONT_LANG}-BoldItalic.ttf" "NotoSerifCJK${FONT_LANG}-Bold.ttf" "NotoSerifCJK${FONT_LANG}-Italic.ttf" "NotoSerifCJK${FONT_LANG}-Regular.ttf" )




for TTF_FILE in ${TTF_FILE_LIST[@]}; do
  echo ${TTF_FILE}
  if [ ! -f "${ASCIIDOCFX_FONTS_DIR}/NotoCJK/${TTF_FILE}" ]; then
     wget "${FONT_DOWNLOAD_BASE}/${TTF_FILE}"
  fi
done


cd "${ASCIIDOCFX_FOP_CONFIG_DIR}"

mv fop.xconf.xml fop.xconf.xml.org.bak
cp "${INSTALL_DIR}/fop.xconf.xml" ./

mv fo-pdf.xsl fo-pdf.xsl.org.bak
cp "${INSTALL_DIR}/fo-pdf.xsl.${FONT_LANG}" ./fo-pdf.xsl

echo "DONE!"
