# Changelog

* v1.3.4:
	* Better initialization state handling
* v1.3.3:
	* Fix getInt/Short/Float config value when set to empty-string
* v1.3.2:
	* Added spiffsFormatted config flag
	* Return spiffsInitialized flag in getinfo JSON-RPC command
	* Send response for restart JSON-RPC command
* v1.3.1:
	* Fix randomly failing platform WebSocket connection
* v1.3.0:
	* Added "onlineOnly" configuration option
	* Fixed TLS connection problems
		* "platformCACert" configuration option can contain the CA cert for TLS
	* Improved logging
	* Simplify network/platform.cpp and SD card usage
	* Use SPIFFS file system to store logs
	* JSON-RPC via serial - echo, getconfig, setconfig, getlogs, deletelogs, spiffs_reformat, restart
	* Button delay to fix issue re: accidental clearing of QR code
	* Move bill/coin/button build flags to configuration options
	* Fix excessive memory usage (RAM) by i18n/locale
* v1.2.0:
	* Tagged release version
