<!-- #include file="function.asp" -->
<!-- #include file="MD5.asp" -->
<!-- #include file="cookie.asp" --><%
dim delid, count, TotalPage, PageCount,wheresearch
myfilename="member.asp"
thisttime=Now()
set rs=server.createobject("ADODB.Recordset")
if action="member" and Request.ServerVariables("request_method") = "POST" then
if HTMLEncode(request.form("edituser"))="�޸�" then
memberid=int(Request.Form("memberid"))
euserpass=Trim(Request.Form("euserpass"))
euserface=HTMLEncode(Request.Form("euserhead"))
edistinction=HTMLEncode(Request.Form("edistinction"))
sql="select * from [user] where id="&memberid
rs.Open sql,Conn,1,3
rs("distinction")=edistinction
if euserface<>empty then rs("userface")=euserface
if euserpass<>empty then rs("userpass")=md5(euserpass)
rs.update
rs.close
Set rs=Nothing
euserpass=md5(euserpass)
message="<li>�û��޸ĳɹ�</li><br><br><li><a href=main.asp>���ع�����ҳ</a></li>"
succeed(""&message&"<meta http-equiv=refresh content=2;url="&myfilename&">")
Response.End
elseif HTMLEncode(request.form("deluser"))="ɾ��" then
memberid=int(Request.Form("memberid"))
memberid=HTMLEncode(memberid)
conn.execute("delete from [user] where id="&memberid)
message="<li>�û�ɾ���ɹ�</li><br><br><li><a href=main.asp>���ع�����ҳ</a></li>"
succeed(""&message&"<meta http-equiv=refresh content=2;url="&myfilename&">")
Response.End
else
error("��������")
Response.End
end if
Response.End
end if
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�û�����</title>
<style type=text/css>a,td{font-size: 12px; text-decoration:none; color:#444}
a:hover{LEFT:1px;position:relative;top:1px;TEXT-DECORaTION:underline;color:#ff0000;font-size:12px}
input{height:21;border:1px solid #C0C0C0;line-height:17px;}
</style>
</head>

<body>

<script>
function CheckAll(form){for (var i=0;i<form.elements.length;i++){var e = form.elements[i];if (e.name != 'chkall')e.checked = form.chkall.checked;}}
function checkclick(msg){if(confirm(msg)){event.returnValue=true;}else{event.returnValue=false;}}
</script>
<table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="#C0C0C0" align="center">
	<tr align="center">
		<td width="5%" bgcolor="#FFFFFF">ͷ��</td>
		<td width="30%" bgcolor="#FFFFFF">�û���</td>
		<td width="15%" bgcolor="#FFFFFF">����</td>
		<td width="15%" bgcolor="#FFFFFF">����</td>
		<td width="15%" bgcolor="#FFFFFF">����</td>
	</tr>
	<%
wheresearch=""
searchkey=HTMLEncode(Request("searchkey"))
if searchkey<>empty then wheresearch=" where username like '%"&searchkey&"%'"
count=conn.execute("Select count(id) from [user]"&wheresearch&"")(0)
TotalPage=cint(count/20)
if TotalPage < count/20 then TotalPage=TotalPage+1
PageCount = cint(Request.QueryString("P"))
if PageCount < 1 or PageCount = empty then PageCount = 1
if PageCount > TotalPage then PageCount = TotalPage
sql="select * from [user]"&wheresearch&" order by distinction Desc,id"
if PageCount>100 then
rs.Open sql,Conn,1
else
Set Rs=Conn.Execute(sql)
end if
if TotalPage>1 then RS.Move (PageCount-1) * 20
i=0
Do While Not RS.EOF and i<20
i=i+1
if Not Response.IsClientConnected then responseend
  %>
	<form method="post" name="form" action="<%=myfilename%>">
		<input type="hidden" name="action" value="member">
		<input type="hidden" name="memberid" value="<%=rs("id")%>">
		<tr>
			<td bgcolor="#FFFFFF" align="center">
			<input name="euserhead" type="text" value="<%=rs("userface")%>" size="2"></td>
			<td bgcolor="#FFFFFF">
			<input name="eusername" type="text" size="15" value="<%=rs("username")%>" disabled> 
			ע��IP��:<%=rs("userip")%></td>
			<td bgcolor="#FFFFFF" align="center">
			<input name="euserpass" type="text" size="15" value></td>
			<%
	dim distinctionselect
	distinctionselect="<option value=0>��ͨ��Ա</option><option style=color:#339933 value=3>���α༭</option><option style=color:#ff0000 value=10>վ��</option>"
	distinctionselect=replace(distinctionselect,"value="&rs("distinction"),"value="&rs("distinction")&" selected")
	%>
			<td bgcolor="#FFFFFF" align="center"><select name="edistinction"><%=distinctionselect%>
			</select></td>
			<td bgcolor="#FFFFFF" align="center">
			<input type="submit" name="edituser" value="�޸�">
			<input type="submit" onclick="checkclick('��ȷ��Ҫɾ�����û�?');" name="deluser" value="ɾ��"></td>
		</tr>
	</form>
	<%
RS.MoveNext
loop
RS.Close
Set RS=Nothing
%>
<form method="post" name="form" action="<%=myfilename%>"><tr>
		<td bgcolor="#FFFFFF" colspan="3">���� <%=TotalPage%> ҳ [<b>
		<script>
TotalPage=<%=TotalPage%>
PageCount=<%=PageCount%>
for (var i=1; i <= TotalPage; i++) {
if (i <= PageCount+3 && i >= PageCount-3 || i==1 || i==TotalPage){
if (i > PageCount+4 || i < PageCount-2 && i!=1 && i!=2 ){document.write(" ... ");}
if (PageCount==i){document.write(" "+ i +" ");}
else{
document.write("<a href=?p="+i+"&searchkey=<%=Request("searchkey")%>>"+ i +"</a> ");
}
}
}
</script>
		</b>]</td>
		<td bgcolor="#FFFFFF" colspan="2" align="right">
			<input type="hidden" name="action" value="search">���ٲ����û��� 
			<input name="searchkey" type="text" size="15" value="<%=Request("searchkey")%>">
			<input type="submit" name="Submit" value="����">
		</td>
	</tr>
		</form>
</table>

</body>

</html>