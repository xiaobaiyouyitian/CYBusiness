<!-- #include file="function.asp" -->
<!-- #include file="MD5.asp" --><%
myfilename="ulogin.asp"
if action="userlogin" and Request.ServerVariables("request_method") = "POST" then
username=HTMLEncode(Trim(Request.Form("login_username")))
userpass=md5(Trim(Request.Form("login_userpass")))
period=int(Request.Form("period"))
if username=empty or userpass=empty then error("����д����")
set rs=server.createobject("ADODB.Recordset")
If conn.Execute("Select id From [user] where username='"&username&"' and userpass='"&userpass&"' " ).eof Then error("����д���û��������������")

Response.Cookies("username")=username
Response.Cookies("userpass")=userpass
if period<>0 then
Response.Cookies("username").Expires=date+period
Response.Cookies("userpass").Expires=date+period
end if
message="<li>��̳��½�ɹ�</li><br><br><li><a href=../bbs>������̳��ҳ</a></li>"
succeed(""&message&"<meta http-equiv=refresh content=1;url=./>")
Response.End
end if
if action="outlogin" and Request.ServerVariables("request_method") = "GET" then
Response.Cookies("username")=""
Response.Cookies("userpass")=""
message="<li>�˳���̳�ɹ�</li><br><br><li><a href=../bbs>������̳��ҳ</a></li>"
succeed(""&message&"<meta http-equiv=refresh content=1;url=./>")
Response.End
end if

%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�û���½ - <%=forumname%></title>
<link href="images/css.css" rel="stylesheet" type="text/css">
</head>

<body>

<form name="form" onsubmit="return VerifyInput();" action="<%=myfilename%>" method="post">
	<input type="hidden" name="action" value="userlogin">
	<table border="0" width="960" cellspacing="1" cellpadding="3" bgcolor="#43ABDE" align="center">
		<tr>
		<td colspan="3" class="list"><a href="/bbs">������ҳ</a> -> �û���¼</td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" align="right">�û�����</td>
			<td bgcolor="#FFFFFF">
			<input name="login_username" type="text" maxlength="24"></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" align="right">���룺</td>
			<td bgcolor="#FFFFFF"><input type="password" name="login_userpass"></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" align="right">��Ч�ڣ�</td>
			<td bgcolor="#FFFFFF"><select name="period">
			<option value="0" selected>������</option>
			<option value="1">һ��</option>
			<option value="30">һ��</option>
			<option value="360">����</option>
			</select> ���õ��Խ��鲻����</td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" colspan="2" align="center">
			<input type="submit" name="button" value="�� ½"></td>
		</tr>
	</table>
</form>

</body>

</html>
