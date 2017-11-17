$wixPath = 'C:\Program Files (x86)\WiX Toolset v3.11\bin'

& "$wixPath\candle.exe"  -out .\Output\SignUp.wixobj .\SignUp.Web.Setup\Product.wxs -ext WixIIsExtension -ext WixUiExtension -ext WixUtilExtension
& "$wixPath\light.exe" -out .\Output\SignUp.msi .\Output\SignUp.wixobj -ext WixIISExtension -ext WixUiExtension  -ext WixUtilExtension -cultures:en-us 
