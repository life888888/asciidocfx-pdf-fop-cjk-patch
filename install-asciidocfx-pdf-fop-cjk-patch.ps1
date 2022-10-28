$INSTALL_DIR=Get-Location

Write-Host "$INSTALL_DIR"

cd ..

$MAIN_APP_OPTIONS="AsciidocFX.vmoptions"	


if (-not(Test-Path -Path $MAIN_APP_OPTIONS -PathType Leaf)) {
     try {
         Write-Host "$MAIN_APP_OPTIONS Not exists."
         Write-Host "NOT UNDER A AsciidocFX DIR!"
         Write-Host "PLEASE COPY THIS FOLDER TO AsciidocFX DIR"
         exit 1
     }
     catch {
         throw $_.Exception.Message
     }
 }
# If the file already exists, show the message and do nothing.
 else {
     Write-Host "$MAIN_APP_OPTIONS already exists."
     Write-Host "IS A AsciidocFX DIR"
     $ASCIIDOCFX_DIR=Get-Location
 }

$ASCIIDOCFX_FONTS_DIR="${ASCIIDOCFX_DIR}\conf\fonts"
$ASCIIDOCFX_FOP_CONFIG_DIR="${ASCIIDOCFX_DIR}\conf\docbook-config"
$FONT_DOWNLOAD_BASE="https://github.com/life888888/cjk-fonts-ttf/releases/download/v0.1.0"

Write-Host "$ASCIIDOCFX_FONTS_DIR"
Write-Host "$ASCIIDOCFX_FOP_CONFIG_DIR"
Write-Host "$FONT_DOWNLOAD_BASE"

# FONT LANGUAGE CODE
# sc (Simplified Chinese)
# tc (Traditional Chinese)
# hk (Hong Kong)
# jp (Japanese)
# kr (Korean)

if ($args[0] -ne $null){
       $FONT_LANG=$args[0]
       Write-Host "SET FONT_LANG=$args[0]"
     }
 else {
     Write-Output "FONT_LANG It's empty"
      Write-Host  "PLEASE GIVE LANGUAGE CODE - EX: 'tc'"
      Write-Host  "### FONT LANGUAGE CODE ###"
      Write-Host  " sc (Simplified Chinese)"
      Write-Host  " tc (Traditional Chinese)"
      Write-Host  " hk (Hong Kong)"
      Write-Host  " jp (Japanese)"
      Write-Host  " kr (Korean)"
      Write-Host  ""      
      Write-Host  "Usage: Open Power Shell"
      Write-Host  "install-asciidocfx-pdf-fop-cjk-patch.ps1 tc"
      exit 2
   }

mkdir -p "${ASCIIDOCFX_FONTS_DIR}\NotoCJK"
cd "${ASCIIDOCFX_FONTS_DIR}\NotoCJK"

$TTF_FILE_LIST=("NotoSansCJK${FONT_LANG}-BoldItalic.ttf", "NotoSansCJK${FONT_LANG}-Bold.ttf", "NotoSansCJK${FONT_LANG}-Italic.ttf", "NotoSansCJK${FONT_LANG}-Regular.ttf", "NotoSansMonoCJK${FONT_LANG}-BoldItalic.ttf", "NotoSansMonoCJK${FONT_LANG}-Bold.ttf", "NotoSansMonoCJK${FONT_LANG}-Italic.ttf", "NotoSansMonoCJK${FONT_LANG}-Regular.ttf", "NotoSerifCJK${FONT_LANG}-BoldItalic.ttf", "NotoSerifCJK${FONT_LANG}-Bold.ttf", "NotoSerifCJK${FONT_LANG}-Italic.ttf", "NotoSerifCJK${FONT_LANG}-Regular.ttf" )


foreach ($TTF_FILE in $TTF_FILE_LIST) {
      Write-Host  "$TTF_FILE"

if (-not(Test-Path -Path $MAIN_APP_OPTIONS -PathType Leaf)) {
      Write-Host "NOT EXIST ${ASCIIDOCFX_FONTS_DIR}\NotoCJK\${TTF_FILE}"
      Write-Host "wget ${FONT_DOWNLOAD_BASE}/${TTF_FILE}"
(new-object System.Net.WebClient).DownloadFile("${FONT_DOWNLOAD_BASE}/${TTF_FILE}","${ASCIIDOCFX_FONTS_DIR}\NotoCJK\${TTF_FILE}")

 }
 
}

cd "${ASCIIDOCFX_FOP_CONFIG_DIR}"

mv fop.xconf.xml fop.xconf.xml.org.bak
cp "${INSTALL_DIR}\fop.xconf.xml" fop.xconf.xml

mv fo-pdf.xsl fo-pdf.xsl.org.bak
cp "${INSTALL_DIR}\fo-pdf.xsl.${FONT_LANG}" fo-pdf.xsl

Write-Host "DONE!"
