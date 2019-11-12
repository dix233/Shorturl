<%@ page import="java.sql.*" %>
<%@ page import="java.util.Random" %>
<%--
  Created by IntelliJ IDEA.
  User: kyj20
  Date: 11/11/2019
  Time: 下午 3:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>返回结果</title>
</head>
<body>
<%!
    private static String getRandomString(int length) { //length表示生成字符串的长度
        String base = "abcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < length; i++) {
            int number = random.nextInt(base.length());
            sb.append(base.charAt(number));
        }
        return sb.toString();
    }
%>
<%
    String isurl=request.getParameter("url");
    if(isurl==null) isurl="";
    if(isurl.isEmpty()) {
        response.sendRedirect("404.html");
        return ;
    }
%>
<%

    String  url1  =  "http://"  +  request.getServerName()  +  ":"  +  request.getServerPort()  +  request.getContextPath()+request.getServletPath().substring(0,request.getServletPath().lastIndexOf("/")+1);

%>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/url","root","locked1234");
    String surl=getRandomString(5);
    String url=request.getParameter("url");
%>
<%
    int r=1;
    while(r!=0) {
        String presql = "select count(url) from surl where surlid=?";
        PreparedStatement pps = con.prepareStatement(presql);
        pps.setString(1, surl);
        ResultSet result = pps.executeQuery();
        while (result.next()) {
            r = result.getInt(1);
        }
        if(r!=0) {
            surl = getRandomString(5);
        }
        pps.close();
    }
%>
<%
    String sql="insert into surl values(?,?)";
    PreparedStatement ps=con.prepareStatement(sql);
    ps.setString(1,surl);
    ps.setString(2,url);
    int row=ps.executeUpdate();
%>
<table align="center">
    <tr>
        <th>短域名</th>
    </tr>
    <tr>
        <td><a href="index.jsp?id=<%=surl %>"><%=url1%>index.jsp?id=<%out.println(surl);%></a></td>
    </tr>
    <tr>
        <td>
            <%
                if(row>0){
                    out.println("短域名添加成功！");
                }
                else out.println("短域名添加失败！");
            %>
        </td>
    </tr>
    <tr>
        <td><a href="index.jsp">返回首页</a></td>
    </tr>
</table>

<%
    ps.close();
    con.close();
%>
</body>
</html>
