<!-- #include file="conn.asp" --><%
dim action
action=Request.Form("action")
if action = empty then action = Request("action")
set rs=server.createobject("ADODB.Recordset")
sql="select * FROM forumconfig"
rs.open sql,conn,1,1
forumname=rs("forumname")
perpage=rs("perpage")
wmhtmlkzn=rs("wmhtmlkzn")
badwords=rs("badwords")'��������|�ֿ�
badip=rs("badip")'��ֹ��IP��|�ֿ�
adduseryn=rs("adduseryn")
contentlen=rs("contentlen")
PostTime=rs("PostTime")
RegTime=rs("RegTime")
ifmodifytime=rs("ifmodifytime")
rs.Close
set rs=nothing

if Request.ServerVariables("HTTP_X_FORWARDED_FOR")=empty then
remoteaddr=Request.ServerVariables("REMOTE_ADDR")
else
remoteaddr=Request.ServerVariables("HTTP_X_FORWARDED_FOR")
end if

if badip<>empty then
filtrate=split(badip,"|")
for i = 0 to ubound(filtrate)
if instr("|"&remoteaddr&"","|"&filtrate(i)&"") > 0 then error("<li>���IP����ֹ�鿴����̳")
next
end if
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Function ReplaceText(fString,patrn, replStr)
Set regEx = New RegExp  ' ����������ʽ��
regEx.Pattern = patrn   ' ����ģʽ��
regEx.IgnoreCase = True ' �����Ƿ����ִ�Сд��
regEx.Global = True     ' ����ȫ�ֿ����ԡ� 
ReplaceText = regEx.Replace(fString, replStr) ' ���滻��
End Function
function HTMLEncode(fString)
fString=replace(fString,";","&#59;")
fString=replace(fString,"<","&lt;")
fString=replace(fString,">","&gt;")
fString=replace(fString,"\","&#92;")
fString=replace(fString,"--","&#45;&#45;")
fString=replace(fString,"'","&#39;")
fString=replace(fString,CHR(9),"&nbsp")    'table
fString=replace(fString,CHR(32),"&nbsp;")
fString=replace(fString,CHR(34),"&quot;")
fString=replace(fString,vbCrlf,"<br>")
HTMLEncode=fString
end function
function ContentEncode(fString)

'fString=replace(fString,vbCrlf, "")
fString=replace(fString,"\","&#92;")
fString=replace(fString,"'","&#39;")
fString=ReplaceText(fString,"<(.[^>]*)(&#|cookie|window.|Document.|javascript:|js:|vbs:|about:|file:|on(blur|click|change|Exit|error|focus|finish|key|load|mouse))", "&lt;$1$2$3")
fString=ReplaceText(fString,"<(\/|)(iframe|object|SCRIPT|form|style|meta)", "&lt;$1$2")
ContentEncode=fString
end function

sub error(message)
%><script>alert('<%=message%>');history.back();</script><script>window.close();</script>
<%
responseend
end sub

sub responseend
set rs=nothing
set rs1=nothing
set conn=nothing
Response.End
end sub

Function Lenc(num1,num2)	'���num1��num2������λ��
	Dim n1,n2,n
	Dim str1,str2
	str1="abc"
	str2="abc"
	'On Error Resume Next
	
	n=Instr(1,num1,".")
	If n=0 then
		n1=0
	Else
		n1=Len(num1)-n
	End If
	
	n=Instr(1,num2,".")
	If n=0 then
		n2=0
	Else
		n2=Len(num2)-n
	End If
	
	Lenc=n1-n2
	If Lenc<0 then
		Lenc=0
	End If
	Lenc=fix(Lenc/2)
End Function
Function Cnum(str)		'ǿ��ת��Ϊ����
	If isnumeric(str)=false then
		Cnum=0
	Else
		Cnum=clng(str)
	End If
End Function

Function mint(str)	'ȡ���ڻ���ڴ�������С����
	If str-fix(str)<>0 then
		mint=fix(str)+1
	Else
		mint=fix(str)
	End If
End Function

sub succeed(message)
%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ϵͳ��Ϣ</title>
<link href="images/css.css" rel="stylesheet" type="text/css">
</head>

<body>

<table border="0" width="40%" cellspacing="1" cellpadding="20" bgcolor="#43ABDE" align="center">
	<tr>
		<td bgcolor="#FFFFFF"><%=message%></td>
	</tr>
</table>

</body>

</html>
<%
Response.End
end sub
%>