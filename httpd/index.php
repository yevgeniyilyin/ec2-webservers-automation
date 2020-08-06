<html>
<title> WEB SERVER </title>
<body>
<h1>
<center>
<IMG SRC="pic.jpg" ALT="omg"><br>
<?php
$eip = file_get_contents('http://169.254.169.254/latest/meta-data/public-ipv4');
echo $eip;
?>
</center>
</h1>
</body>
</html>