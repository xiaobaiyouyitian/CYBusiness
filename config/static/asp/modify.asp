<!-- #include file="function.asp" -->
<!-- #include file="code.asp" --><%
myfilename="modify.asp"
username=Request.Cookies("username")
userpass=Request.Cookies("userpass")
id=int(Request("id"))
thisttime=Now()
dim listid, modifytimeout
if Request.Cookies("username")=empty or Request.Cookies("userpass")=empty then
error("����δ��¼��̳")
message="<li>����δ��¼��̳<li><a href=./ulogin.asp>���ص�¼��</a>"
succeed(""&message&"<meta http-equiv=refresh content=1;url=./ulogin.asp>")
Response.End
end if
set rs=server.createobject("ADODB.Recordset")
sql="select distinction,userface from [user] where username='"&username&"'"
rs.Open sql,Conn,1,1
distinction=Rs("distinction")
userface=Rs("userface")
rs.close
qqwmcopayout=""
sql="select txttitle,username,upid,content,posttime from list,forum where list.id="&id&" and forum.listid=list.id"
rs.Open sql,Conn,1,1
txttitle=rs("txttitle")
upid=rs("upid")
zzname=rs("username")
content=rs("content")
posttime=rs("posttime")
rs.close
if distinction<3 and zzname<>username then error("��û�б༭�����µ�Ȩ��")


if action="modify" and Request.ServerVariables("request_method") = "POST" then
icon=Request("icon")
txttitle=HTMLEncode(Trim(Request.Form("txttitle")))
content=ContentEncode(RTrim(Request.Form("content")))
if Len(txttitle)<3 then error("���±��ⲻ��С�� 3 �ַ�")
if Len(content)>contentlen then error("����̫��,���ܳ���"&contentlen&"�ֽ�")
if Len(content)<3 then error("<�������ݲ���С�� 3 �ַ�")
if badwords<>empty then
filtrate=split(badwords,"|")
for i = 0 to ubound(filtrate)
txttitle=ReplaceText(txttitle,""&filtrate(i)&"",string(len(filtrate(i)),"*"))
content=ReplaceText(content,""&filtrate(i)&"",string(len(filtrate(i)),"*"))
next
end if
'''''''''''''''''''''''''''''''''''
sql="select * from [list] where id="&id
rs.Open sql,Conn,1,3
rs("icon")=icon
rs("txttitle")=txttitle
rs.update
rs.close
sql="select * from [forum] where listid="&id
rs.Open sql,Conn,1,3
rs("content")=content
rs.update
rs.close
'''''''''
Set rs=Nothing
''''''''''''''''''''''
htmlfilename=id
if upid=0 or upid=empty then upid=id
content = ubb(content)
modifytimeout=""
if ifmodifytime=1 then modifytimeout="<br><br><hr align=""left"" width=""250"" size=""0"" color=""#B7DFF2""><font style=""font-size:12px;color:#800000"">������"&thisttime&"��"&username&"���±༭</font>"
set fileobject = Server.CreateObject("Scripting.FileSystemObject")
TempletTopPath=Server.MapPath("templet\top.html")
TempletBottomPath=Server.MapPath("templet\bottom.html")
set TOPTEMP=fileobject.openTextFile(TempletTopPath,,True)
set BOTTOMTEMP=fileobject.openTextFile(TempletBottomPath,,True)
topt=TOPTEMP.ReadAll 
bottomt=BOTTOMTEMP.ReadAll

topt=replace(topt,"<#title#>", txttitle)
topt=replace(topt,"<#username#>", username)
topt=replace(topt,"<#userface#>", userface)

bottomt=replace(bottomt,"<#posttime#>", posttime)

set addhtmlfile = fileobject.CreateTextFile(Server.MapPath(".")&"\html\"&upid&"\"&htmlfilename&wmhtmlkzn)
addhtmlfile.writeline topt
addhtmlfile.writeline("<table width=""100%""  border=""0"" cellspacing=""0"" cellpadding=""5"">")
addhtmlfile.writeline("<tr><td align=""right""><a href=""../../"">������ҳ</a> | �Ķ���<font color=""red""><script src=""../../count.asp?id="&id&"""></script></font> �� | <a href=""../../reply.asp?upid="&upid&""">�ظ�����</a> | <a href=""../../modify.asp?id="&id&""">���߱༭</a> | <a href=""javascript:window.close()"">�رձ�ҳ</a><hr align=""right"" width=""338"" size=""0"" color=""#B7DFF2""></td></tr>")
addhtmlfile.writeline("<tr><td valign=""top"" style=""font-size:14px"">"&content&""&modifytimeout&"<br><br></td></tr>")
addhtmlfile.writeline("<tr><td id=""contentads"" valign=""bottom""></td></tr>")
addhtmlfile.writeline("</table>")
addhtmlfile.writeline bottomt

Response.Cookies("posttime")=now'��COOKIE���¼����ʱ��

message="<li>�༭����ɹ�</li><br><br><li><a href=../bbs>������̳��ҳ</a></li>"
succeed(""&message&"<meta http-equiv=refresh content=3;url=html/"&upid&"/"&htmlfilename&wmhtmlkzn&">")
Response.End
end if'��������������HTML��ҳ
Set rs=Nothing'
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�༭���� - <%=forumname%></title>
<link href="images/css.css" rel="stylesheet" type="text/css">
</head>

<body>

<script>
function storeCaret(textEl) {if (textEl.createTextRange) textEl.caretPos = document.selection.createRange().duplicate();}
function HighlightAll(theField) {
var tempval=eval("document."+theField)
tempval.focus()
tempval.select()
therange=tempval.createTextRange()
therange.execCommand("Copy")}
function DoTitle(addTitle) {
var revisedTitle;var currentTitle = document.FORM.intopictitle.value;revisedTitle = addTitle+currentTitle;document.FORM.intopictitle.value=revisedTitle;document.FORM.intopictitle.focus();
return;}
</script>
<form name="FORM" action="<%=myfilename%>" method="post" onsubmit="if(this.name.value==''){alert('����д�û���');return false}else{if(this.pass.value==''){alert('����д����');return false}else{if(this.txttitle.value==''){alert('����д����');return false}else{if(this.content.value==''){alert('����������');return false}}}}">
	<input type="hidden" name="action" value="modify">
	<input type="hidden" name="id" value="<%=id%>">
	<table border="0" width="960" cellspacing="1" cellpadding="3" bgcolor="#43ABDE" align="center">
		<tr>
		<td colspan="3" class="list"><a href="/bbs">������ҳ</a> -> �༭����</td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" align="right">���±��⣺</td>
			<td bgcolor="#FFFFFF" colspan="2">
			<input maxlength="100" size="60" name="txttitle" value="<%=txttitle%>"></td>
		</tr>
		<%
if Request.Cookies("username")=empty or Request.Cookies("userpass")=empty then
%>
		<tr>
			<td bgcolor="#FFFFFF" align="right">�û���½��</td>
			<td bgcolor="#FFFFFF" colspan="2">�û�����<input maxlength="24" name="username" value="<%=username%>"> 
			���룺<input type="password" maxlength="20" name="userpass" value="<%=userpass%>">
			<font color="#FF0000">*ֱ�������û��������뼴��</font></td>
		</tr>
		<%
end if
%>
		<tr>
			<td bgcolor="#FFFFFF" align="right" valign="top">UBB��ǩ˵����<br>
			<font color="#FF0000">(ֱ�Ӹ���<br>
			��ǩ���뷢��)</font></td>
			<td bgcolor="#FFFFFF">[b]�Ӵ�[/b]<br>
			[i]��б[/i]<br>
			[u]�»���[/u]<br>
			[strike]ɾ����[/strike]<br>
			[align=center]����[/align]<br>
			[align=left]����[/align]<br>
			[align=right]����[/align]<br>
			[fly]�����ƶ�[/fly]<br>
			[move]������[/move]<br>
			[color=��ɫ����]������ɫ[/color]</td>
			<td bgcolor="#FFFFFF">[bgcolor=��ɫ����]���屳����ɫ[/bgcolor]<br>
			[size=1��7]�ֺŴ�С[/size]<br>
			[img]����ͼƬ[/img]<br>
			[url=������ַ]����˵��[/url]<br>
			[sound]���뱳������[/sound]<br>
			[ra]mp3��ַ���ǵ�̨��ַ[/ra]<br>
			[flash=���,�߶�]flash��ַ[/flash]<br>
			[flv=���,�߶�]flv��Ƶ�ļ�[/flv]<br>
			[iframe=���,�߶�]������ҳ��ַ[/iframe]<br>
			[mp=���,�߶�]media��Ƶ��ַ[/mp]<br>
			[rm=���,�߶�]raplay��Ƶ��ַ[/rm]</td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" align="right">�������飺</td>
			<td bgcolor="#FFFFFF" colspan="2">
				<input type="radio" CHECKED value="1" name="icon"> <img src="images/icon/1.gif"> 
				<input type="radio" value="2" name="icon"> <img src="images/icon/2.gif"> 
				<input type="radio" value="3" name="icon"> <img src="images/icon/3.gif"> 
				<input type="radio" value="4" name="icon"> <img src="images/icon/4.gif"> 
				<input type="radio" value="5" name="icon"> <img src="images/icon/5.gif">
				<input type="radio" value="6" name="icon"> <img src="images/icon/6.gif">
				<input type="radio" value="7" name="icon"> <img src="images/icon/7.gif">
				<input type="radio" value="8" name="icon"> <img src="images/icon/8.gif">
				<input type="radio" value="9" name="icon"> <img src="images/icon/9.gif">
				<input type="radio" value="10" name="icon"> <img src="images/icon/10.gif">
				<input type="radio" value="11" name="icon"> <img src="images/icon/11.gif"></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" align="right" valign="top">�������ݣ�</td>
			<td bgcolor="#FFFFFF" colspan="2">
			<textarea name="content" rows="15" cols="75" onselect="storeCaret(this);" onclick="storeCaret(this);" onkeyup="storeCaret(this);"><%=content%></textarea></td>
		</tr>
		<tr>
			<td bgcolor="#FFFFFF" colspan="3" align="center">
			<input type="submit" value="�� ��" name="button">
			<input type="reset" name="Submit" value="�� ��"></td>
		</tr>
	</table>
</form>

</body>

</html>
