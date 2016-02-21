<!-- #include file="function.asp" -->
<!-- #include file="cookie.asp" --><%
myfilename="contentads.asp"
thisttime=Now()
dim econtentads, outmsg
if action="contentads" and Request.ServerVariables("request_method") = "POST" then
econtentads=Request.form("econtentads")
econtentads=replace(econtentads,";","")
econtentads=replace(econtentads,"'","")
sql="update contentads set contentads='"&econtentads&"' where id=1"
conn.execute(sql)
outmsg=""
econtentads=replace(econtentads,vbCrlf,"")
outmsg="contentads.innerHTML ='';"&vbCrlf&"contentads.innerHTML +='"&econtentads&"';"&vbCrlf&"contentads.innerHTML +='';"
set fileobject = Server.CreateObject("Scripting.FileSystemObject")
set addhtmlfile = fileobject.CreateTextFile(Server.MapPath(".")&"\images\contentads.js")
addhtmlfile.writeline outmsg

message="<li>帖子广告设置成功</li><br><br><li><a href=main.asp>返回管理首页</a></li>"
succeed(""&message&"<meta http-equiv=refresh content=2;url="&myfilename&">")
Response.End
end if
Set Rs=Conn.Execute("contentads")
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>帖子广告</title>
<style type=text/css>a,td{font-size: 12px; text-decoration:none; color:#444}
a:hover{LEFT:1px;position:relative;top:1px;TEXT-DECORaTION:underline;color:#ff0000;font-size:12px}
input{height:21;border:1px solid #C0C0C0;line-height:17px;}
</style>
</head>

<body>

<form name="FORM" action="<%=myfilename%>" method="post">
	<input type="hidden" name="action" value="contentads">
	<table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#C0C0C0" align="center">
		<tr>
			<td bgcolor="#FFFFFF">
			<textarea name="econtentads" cols="80" rows="20"><%=rs("contentads")%></textarea></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF">
			<input type="submit" name="Submit" value="提交">&nbsp;
			<input type="reset" name="Submit" value="重置">  [帖子广告支持html]</td>
		</tr>
	</table>
</form>

</body>

</html>