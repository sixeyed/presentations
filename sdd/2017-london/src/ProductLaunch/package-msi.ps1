$wixPath = 'C:\Program Files (x86)\WiX Toolset v3.11\bin'

& "$wixPath\candle.exe"  -out .\Output\ProductLaunch.wixobj .\ProductLaunch.Web.Setup\Product.wxs -ext WixIIsExtension -ext WixUiExtension -ext WixUtilExtension
& "$wixPath\light.exe" -out .\Output\ProductLaunch.msi .\Output\ProductLaunch.wixobj -ext WixIISExtension -ext WixUiExtension  -ext WixUtilExtension -cultures:en-us 
