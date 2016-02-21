<!-- #include file="function.asp" -->
<!-- #include file="cookie.asp" --><%
myfilename="topads.asp"
thisttime=Now()
dim etopads, outmsg
if action="topads" and Request.ServerVariables("request_method") = "POST" then
etopads=Request.form("etopads")
etopads=replace(etopads,";","")
etopads=replace(etopads,"'","")
sql="update topads set topads='"&etopads&"' where id=1"
conn.execute(sql)
outmsg=""
etopads=replace(etopads,vbCrlf,"")
outmsg="topads.innerHTML ='';"&vbCrlf&"topads.innerHTML +='"&etopads&"';"&vbCrlf&"topads.innerHTML +='';"
set fileobject = Server.CreateObject("Scripting.FileSystemObject")
set addhtmlfile = fileobject.CreateTextFile(Server.MapPath(".")&"\images\topads.js")
addhtmlfile.writeline outmsg

message="<li>顶部广告设置成功</li><br><br><li><a href=main.asp>返回管理首页</a></li>"
succeed(""&message&"<meta http-equiv=refresh content=2;url="&myfilename&">")
Response.End
end if
Set Rs=Conn.Execute("topads")
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>顶部广告设置</title>
<style type=text/css>a,td{font-size: 12px; text-decoration:none; color:#444}
a:hover{LEFT:1px;position:relative;top:1px;TEXT-DECORaTION:underline;color:#ff0000;font-size:12px}
input{height:21;border:1px solid #C0C0C0;line-height:17px;}
</style>
</head>

<body>

<form name="FORM" action="<%=myfilename%>" method="post">
	<input type="hidden" name="action" value="topads">
	<table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#C0C0C0" align="center">
		<tr>
			<td bgcolor="#FFFFFF">
			<textarea name="etopads" cols="80" rows="20"><%=rs("topads")%></textarea></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF">
			<input type="submit" name="Submit" value="提交">&nbsp;
			<input type="reset" name="Submit" value="重置">  [页面顶部支持html]</td>
		</tr>
	</table>
</form>

</body>

</html>