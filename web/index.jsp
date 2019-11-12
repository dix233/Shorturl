<%@ page import="java.sql.*" %>
<%--
  Created by IntelliJ IDEA.
  User: kyj20
  Date: 11/11/2019
  Time: 下午 2:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>短域名</title>
    <script type="text/javascript" src="chk.js"></script>
  </head>
  <body>
  <%
      Class.forName("com.mysql.cj.jdbc.Driver");
      Connection con= DriverManager.getConnection("jdbc:mysql://localhost:3306/url","root","locked1234");
  %>
  <%
      String id1=request.getParameter("id");
      if(id1==null) id1="";
      if(!id1.isEmpty()) {
          String sqlpre="select url from surl where surlid=?";
          PreparedStatement ps1=con.prepareStatement(sqlpre);
          String temp=request.getParameter("id");
          ps1.setString(1,temp);
          ResultSet rs = ps1.executeQuery();
          while(rs.next()){
              String a = rs.getString("url");
              ps1.close();
              con.close();
              response.sendRedirect(a);
              return ;
          }
          ps1.close();
          con.close();
          response.sendRedirect("404.html");
          return ;
      }
  %>
  <form action="in.jsp" name="form1" method="post" onsubmit="return check()">
  <table align="center">
    <tr>
      <th>短域名</th>
    </tr>
    <tr>
      <td>请输入原域名：</td><td><input type="text" name="url"></td>
    </tr>
    <tr>
      <td><input type="submit" value="提交"></td>
    </tr>
  </table>
  </form>
  </body>
</html>
