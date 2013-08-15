<cfwebsocket 
    name = "chatter"
    onOpen = "startWeatherAlerts"
    onMessage = "showWeatherAlert"
    onClose = "closeWeatherAlerts"
    subscribeTo = "chat" />

<script>
var startWeatherAlerts = function(){
	alert('Starting weather monitoring');
}

var closeWeatherAlerts = function(){
	alert('Ending weather monitoring');
}

// 'alert' is object passed in from from recevied message
var showWeatherAlert = function(alert){
	messageTxt = alert.data;
	if((messageTxt != '') && (alert.type == 'data')){
	    alert('Weather alert: ' + messageTxt);
	}
}

</script>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Untitled Document</title>
</head>

<body>
</body>
</html>