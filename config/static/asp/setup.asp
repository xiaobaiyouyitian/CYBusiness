<!-- #include file="function.asp" -->
<!-- #include file="cookie.asp" --><%
myfilename="setup.asp"
thisttime=Now()
if action="editsetup" and Request.ServerVariables("request_method") = "POST" then
filtrate=split(Request("badip"),"|")
for i = 0 to ubound(filtrate)
if instr("|"&remoteaddr&"","|"&filtrate(i)&"") > 0 then error("�����������IP��ַ�Ƿ���ȷ")
next
set rs=server.createobject("ADODB.Recordset")
rs.Open "forumconfig",Conn,1,3
rs("forumname")=Request("eforumname")
rs("adduseryn")=Request("eadduseryn")
rs("RegTime")=Request("eRegTime")
rs("PostTime")=Request("ePostTime")
rs("contentlen")=Request("econtentlen")
rs("perpage")=Request("eperpage")
rs("wmhtmlkzn")=Request("ewmhtmlkzn")
rs("badwords")=Request("ebadwords")
rs("badip")=Request("ebadip")
rs("ifmodifytime")=Request("eifmodifytime")
rs.update
rs.close
set rs=nothing
message="<li>ϵͳ�������óɹ�</li><br><br><li><a href=main.asp>���ع�����ҳ</a></li>"
succeed(""&message&"<meta http-equiv=refresh content=2;url="&myfilename&">")
Response.End
end if
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ϵͳ����</title>
<style type=text/css>a,td{font-size: 12px; text-decoration:none; color:#444}
a:hover{LEFT:1px;position:relative;top:1px;TEXT-DECORaTION:underline;color:#ff0000;font-size:12px}
input{height:21;border:1px solid #C0C0C0;line-height:17px;}
</style>
</head>

<body>

<form name="form" action="<%=myfilename%>" method="post">
	<input type="hidden" name="action" value="editsetup">
	<table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#C0C0C0">
		<tr bgcolor="#EEEEEE">
			<td align="right" width="18%" bgcolor="#FFFFFF">��̳���ƣ�</td>
			<td bgcolor="#FFFFFF">
			<input name="eforumname" type="text" value="<%=forumname%>"></td>
		</tr>
		<tr bgcolor="#EEEEEE">
			<td align="right" bgcolor="#FFFFFF">�Ƿ�����ע���û���</td>
			<td bgcolor="#FFFFFF"><select name="eadduseryn"><%
	dim adduserynselect
	adduserynselect="<option value=0>����</option><option value=1>������</option>"
	adduserynselect=replace(adduserynselect,"value="&adduseryn,"value="&adduseryn&" selected")
	%> <%=adduserynselect%></select></td>
		</tr>
		<tr bgcolor="#EEEEEE">
			<td align="right" bgcolor="#FFFFFF">�û�ע����ʱ��(��)��</td>
			<td bgcolor="#FFFFFF">
			<input name="eRegTime" type="text" value="<%=RegTime%>" size="8"> ����費�������0</td>
		</tr>
		<tr bgcolor="#EEEEEE">
			<td align="right" bgcolor="#FFFFFF">�������ʱ��(��)��</td>
			<td bgcolor="#FFFFFF">
			<input name="ePostTime" type="text" value="<%=PostTime%>" size="8"> 
			�������ˮ����Ϊ0</td>
		</tr>
		<tr bgcolor="#EEEEEE">
			<td align="right" bgcolor="#FFFFFF">�޶����ݵĳ��ȣ�</td>
			<td bgcolor="#FFFFFF">
			<input name="econtentlen" type="text" value="<%=contentlen%>" size="8"> 
			�ֽ�</td>
		</tr>
		<tr bgcolor="#EEEEEE">
			<td align="right" bgcolor="#FFFFFF">ÿҳ��ʾ���������⣺</td>
			<td bgcolor="#FFFFFF">
			<input name="eperpage" type="text" value="<%=perpage%>" size="8"></td>
		</tr>
		<tr bgcolor="#EEEEEE">
			<td align="right" bgcolor="#FFFFFF">�ļ���չ����</td>
			<td bgcolor="#FFFFFF"><select name="ewmhtmlkzn"><%
	dim wmhtmlkznselect
	wmhtmlkznselect="<option value=.html selected>.html</option><option value=.shtml>.shtml</option><option value=.xhtml>.xhtml</option>"
	wmhtmlkznselect=replace(wmhtmlkznselect,"value="&wmhtmlkzn,"value="&wmhtmlkzn&" selected")
	%> <%=wmhtmlkznselect%></select> ��װʱ�趨���벻Ҫ���ٶ�������֮ǰ����������չ����ͬ���޷��鿴</td>
		</tr>
		<tr bgcolor="#EEEEEE">
			<td align="right" bgcolor="#FFFFFF">�޸ĺ�ʱ����ʾ�޸��߼�ʱ�䣺</td>
			<td bgcolor="#FFFFFF"><select name="eifmodifytime"><%
	dim ifmodifytimeselect
	ifmodifytimeselect="<option value=0>����ʾ</option><option value=1>��ʾ</option>"
	ifmodifytimeselect=replace(ifmodifytimeselect,"value="&ifmodifytime,"value="&ifmodifytime&" selected")
	%> <%=ifmodifytimeselect%></select> </td>
		</tr>
		<tr bgcolor="#EEEEEE">
			<td align="right" bgcolor="#FFFFFF">�����ʻ㣺</td>
			<td bgcolor="#FFFFFF">
			<input name="ebadwords" type="text" value="<%=badwords%>" size="40"> 
			�õ�����&quot;|&quot;����</td>
		</tr>
		<tr bgcolor="#EEEEEE">
			<td align="right" bgcolor="#FFFFFF">��ֹIP��</td>
			<td bgcolor="#FFFFFF">
			<input name="ebadip" type="text" value="<%=badip%>" size="40"> �õ�����&quot;|&quot;����</td>
		</tr>
		<tr bgcolor="#EEEEEE">
			<td bgcolor="#FFFFFF">��</td>
			<td bgcolor="#FFFFFF"><input type="submit" name="Submit" value="�ύ">
			<input type="reset" name="Submit" value="����"></td>
		</tr>
	</table>
</form>

</body>

</html>