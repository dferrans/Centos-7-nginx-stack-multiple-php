--TEST--
Phar front controller with custom 404 php script
--INI--
default_charset=UTF-8
detect_unicode=0
--SKIPIF--
<?php if (!extension_loaded("phar")) die("skip"); ?>
--ENV--
SCRIPT_NAME=/frontcontroller24.php
REQUEST_URI=/frontcontroller24.php/unknown/file
PATH_INFO=/unknown/file
--FILE_EXTERNAL--
files/frontcontroller8.phar
--EXPECTHEADERS--
Content-type: text/html; charset=UTF-8
--EXPECTF--
My 404 is rawesome
