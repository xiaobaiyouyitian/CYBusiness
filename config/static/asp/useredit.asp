<!-- #include file="function.asp" -->
<!-- #include file="MD5.asp" -->
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�޸����� - <%=forumname%></title>
<link href="images/css.css" rel="stylesheet" type="text/css">
</head>

<body>

<%
myfilename="useredit.asp"
dim newuserpass
username=Request.Cookies("username")
userpass=Request.Cookies("userpass")
if Request.Cookies("username")=empty or Request.Cookies("userpass")=empty then
error("����δ��¼��̳") 
end if
set rs=server.createobject("ADODB.Recordset")
sql="select distinction,userface,userpass from [user] where username='"&username&"'"
rs.Open sql,Conn,1,1
'distinction=Rs("distinction")
zuserface=Rs("userface")
zuserpass=Rs("userpass")
rs.close 

if action="useredit" and Request.ServerVariables("request_method") = "POST" then 
userpass=md5(Trim(Request.Form("userpass"))) 
newuserpass=Trim(Request.Form("newuserpass")) 
userface=HTMLEncode(Request.Form("userhead")) 
if userpass=empty then error("��û����д������") 

if instr(userface,";")>0 then error("����ͷ��ѡ���д�") 
If conn.Execute("Select id From [user] where username='"&username&"' and userpass='"&userpass&"' " ).eof Then error("����д�ľ������д�") 

sql="select * from [user] where username='"&username&"'" 
rs.Open sql,Conn,1,3 
if newuserpass<>empty then rs("userpass")=md5(newuserpass) 
rs("userface")=userface 
rs.update 
rs.close 
Set rs=Nothing 
Response.Cookies("username")=username 
if newuserpass<>empty then  
Response.Cookies("userpass")=md5(newuserpass) 
else 
Response.Cookies("userpass")=userpass 
end if

message="<li>�û������޸ĳɹ�</li><br><br><li><a href=../bbs>������̳��ҳ</a></li>"
succeed(""&message&"<meta http-equiv=refresh content=3;url=./>")
Response.End
end if
%>
<form name="form" onsubmit="return VerifyInput();" action="<%=myfilename%>" method="post">
	<input type="hidden" name="action" value="useredit">
	<table border="0" width="960" cellspacing="1" cellpadding="3" bgcolor="#43ABDE" align="center">
		<tr>
		<td colspan="3" class="list"><a href="/bbs">������ҳ</a> -> �޸�����</td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" rowspan="5" align="center">
			<img src="images/face/<%=zuserface%>.gif" name="tus"></td>
			<td bgcolor="#FFFFFF" align="right">�û�����</td>
			<td bgcolor="#FFFFFF">
			<input name="username" type="text" size="20" maxlength="24" value="<%=username%>" disabled></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" align="right">�����룺</td>
			<td bgcolor="#FFFFFF">
			<input name="userpass" type="password" size="20" maxlength="20"></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" align="right">�����룺</td>
			<td bgcolor="#FFFFFF">
			<input name="newuserpass" type="password" size="20" maxlength="20">
			<font color="#FF0000">����������������</font></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" align="right">ͷ�����ã�</td>
			<td bgcolor="#FFFFFF">
			<script>function showimage(){document.images.tus.src="images/face/"+document.form.userhead.options[document.form.userhead.selectedIndex].value+".gif";}</script>
			��ѡ��<select name="userhead" size="1" onchange="showimage()">
			<option value="<%=zuserface%>">����</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
			<option value="9">9</option>
			<option value="10">10</option>
			<option value="11">11</option>
			<option value="12">12</option>
			<option value="13">13</option>
			<option value="14">14</option>
			<option value="15">15</option>
			<option value="16">16</option>
			<option value="17">17</option>
			<option value="18">18</option>
			<option value="19">19</option>
			<option value="20">20</option>
			<option value="21">21</option>
			<option value="22">22</option>
			<option value="23">23</option>
			<option value="24">24</option>
			</select></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" colspan="2" align="center">
			<input type="submit" name="button" value=" �� �� "></td>
		</tr>
	</table>
</form>

</body>

</html>
<script>
function VerifyInput()
{
username=document.form.username.value

if (username == "")
{
alert("�����������û���");
document.form.username.focus();
return false;
}
return true;
}
</script>