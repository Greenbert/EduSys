<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Teacher" %>
<%@ page import="entity.ClassInfo" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="entity.Score" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="../resources/css/jquery-ui-1.10.4.custom.min.css">
  <script src="../resources/js/jquery-1.10.2.js"></script>
  <script src="../resources/js/jquery-ui-1.10.4.custom.min.js"></script>
  <title>class</title>
  <link href="../resources/css/default.css" rel="stylesheet"/>
</head>
<body>
<%
  Teacher teacher = (Teacher) session.getAttribute("info");

  ArrayList<ClassInfo> cls = (ArrayList<ClassInfo>) session.getAttribute("onePageClass");
  HashMap<String,String> teas = (HashMap<String,String>) session.getAttribute("getTeacherList");
  HashMap<String,int[]> calRes = (HashMap<String,int[]>) session.getAttribute("getClassCalculate");
  int sumIndex = (int) session.getAttribute("sumIndex");
  int calNum = (int) session.getAttribute("classNum");
  String[] types = new String[]{"web","os","db"};
%>
<div id="page" class="container">
  <div id="header">
    <div id="logo">
      <img src="../userImg/<%=teacher.getId()%>.jpeg" onerror="this.src='../userImg/default.jpeg';this.onerror = 'null'"/>
      <h1><%=teacher.getId()%>
      </h1>
    </div>
    <div id="menu">
      <ul>
        <li><a href="personal.jsp">教师信息</a></li>
        <li><a href="../one_page_student">学籍管理</a></li>
        <li><a href="../one_page_score">成绩管理</a></li>
        <li class="current_page_item"><a href="../one_page_class">课程安排</a></li>
        <li><a onclick="return confirm('确认退出?');" href="../exit">退出登录</a></li>
      </ul>
    </div>
  </div>
  <div id="main">
    <div class="top">
      <h2>课程统计数据</h2>
      <hr/>

    </div>
    <div class="table">
      <table id="table" width="800" frame="void" align="center">
        <tr>
          <th height="35">课程编号</th>
          <th>课程名称</th>
          <th>课程人数</th>
          <th>最高分</th>
          <th>平均分</th>
          <th>最低分</th>
        </tr>
        <%
          int k = 0;
          int m = 0;
          for (ClassInfo cl : cls ) {

        %>
        <tr>

          <td height="35"><%=cl.getClass_id()%></td>
          <td height="35"><%=cl.getName()%></td>
          <td height="35"><%=calNum%></td>
          <td height="35"><%=calRes.get(types[m])[k]%></td>
          <td height="35"><%=calRes.get(types[m])[k+1]%></td>
          <td height="35"><%=calRes.get(types[m])[k+2]%></td>

        </tr>
        <%

            m++;
          }
        %>
      </table>
    </div>
    <%
      if (sumIndex > 1){
    %>
    <div id="index">
      <a class="btnDo" href="../one_page_student?index=1">首页</a>
      <%
        for (int i=1; i<=sumIndex; i++){
      %>
      <a class="btnDo" href="../one_page_student?index=<%=i%>">第<%=i%>页</a>
      <%
        }
      %>
      <a class="btnDo" href="../one_page_student?index=<%=sumIndex%>">尾页</a>
    </div>
    <%
      }
    %>
  </div>
</div>


</body>
</html>

