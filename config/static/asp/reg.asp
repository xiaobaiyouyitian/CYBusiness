<!-- #include file="function.asp" -->
<!-- #include file="MD5.asp" --><%
myfilename="reg.asp"

if adduseryn = 1 then error("����̳��ʱ���������û�ע�ᣡ")
if action="adduser" and Request.ServerVariables("request_method") = "POST" then
if Request.Cookies("regusertime")<>empty then
if DateDiff("s",Request.Cookies("regusertime"),Now()) < RegTime then error("��̳��������ע��ʱ����"&RegTime&"�룡")
end if
username=HTMLEncode(Trim(Request.Form("username")))
errorchar=array(" ","��","	","#","`","|","%","&","","+",";")
for i=0 to ubound(errorchar)
if instr(username,errorchar(i))>0 then error("�û����в��ܺ����������")
next

userpass=Trim(Request.Form("userpass"))
userrpass=Trim(Request.Form("userrpass"))
userface=HTMLEncode(Request.Form("userhead"))
if username="" then  error("�����û���û����д")
if Len(username)<3 then error("�����û����в�������3�ֽ�")
if Len(username)>15 then error("�����û����в��ܳ���15�ֽ�")
set rs=server.createobject("ADODB.Recordset")
If not conn.Execute("Select id From [user] where username='"&username&"'" ).eof Then error("����д���û�������ע����")
if userpass=empty then error("��û����д����")
if Len(userpass)<6 then error("�������벻������6�ֽ�")
if userpass<>userrpass then error("��������������벻��ͬ")
if instr(userface,";")>0 then error("����ͷ��ѡ���д�")

rs.Open "[user]",conn,1,3
rs.addnew
rs("username")=username
rs("userpass")=md5(userpass)
rs("userface")=userface
rs("userip")=remoteaddr
rs.update
rs.close
Set rs=Nothing

Response.Cookies("username")=username
Response.Cookies("userpass")=md5(userpass)
Response.Cookies("regusertime")=Now()
message="<li>�û�ע��ɹ�</li><br><br><li><a href=../bbs>������̳��ҳ</a></li>"
succeed(""&message&"<meta http-equiv=refresh content=2;url=../bbs>")

Response.End
end if'''''''''''
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�û�ע�� - <%=forumname%></title>
<link href="images/css.css" rel="stylesheet" type="text/css">
</head>

<body>

<form name="form" onsubmit="return VerifyInput();" action="<%=myfilename%>" method="post">
	<input type="hidden" name="action" value="adduser">
	<table border="0" width="960" cellspacing="1" cellpadding="3" bgcolor="#43ABDE" align="center">
		<tr>
		<td colspan="3" class="list"><a href="../bbs">������ҳ</a> ->�û�ע��</td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" rowspan="5" align="center">
			<img src="images/face/1.gif" name="tus"></td>
			<td bgcolor="#FFFFFF" align="right">�û�����</td>
			<td bgcolor="#FFFFFF">
			<input name="username" type="text" size="20" maxlength="24"></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" align="right">���룺</td>
			<td bgcolor="#FFFFFF">
			<input name="userpass" type="password" size="20" maxlength="20"></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" align="right">ȷ�����룺</td>
			<td bgcolor="#FFFFFF">
			<input name="userrpass" type="password" size="20" maxlength="20"></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" align="right">ͷ�����ã�</td>
			<td bgcolor="#FFFFFF">
			<script>function showimage(){document.images.tus.src="images/face/"+document.form.userhead.options[document.form.userhead.selectedIndex].value+".gif";}</script>
			��ѡ��<select name="userhead" size="1" onchange="showimage()">
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
			<td bgcolor="#FFFFFF" align="center" colspan="2">
			<input type="submit" name="button" value="ע ��"></td>
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
