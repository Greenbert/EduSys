<%@ page import="dao.StudentD" %>
<%@ page import="entity.Student" %>
<%@ page import="dao.ScoreD" %>
<%@ page import="entity.Score" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>main</title>
    <link href="../resources/css/default.css" rel="stylesheet"/>
</head>
<body>
<%
    Student student = (Student) session.getAttribute("info");
%>
<div id="page" class="container">
    <div id="header">
        <div id="logo">
            <img src="../userImg/<%=student.getId()%>.jpeg" onerror="this.src='../userImg/default.jpeg';this.onerror = 'null'"/>
            <h1><%=student.getName()%></h1>
        </div>
        <div id="menu">
            <ul>
                <li><a href="personal.jsp">学生信息</a></li>
                <li class="current_page_item"><a href="main.jsp">学生成绩</a></li>
                <li><a href="stuclass.jsp">课程安排</a></li>
                <li><a onclick="return confirm('确认退出?');" href="../exit">退出登录</a></li>
            </ul>
        </div>
    </div>
    <div id="main">
        <div class="top">
            <h2>学生成绩</h2>
            <hr/>
        </div>
        <div class="table">
            <table width="800" frame="void" align="center">
                <tr>
                    <th height="35">学号</th>
                    <th>姓名</th>
                    <th>专业</th>
                    <th>JavaWeb</th>
                    <th>操作系统</th>
                    <th>数据库</th>
                    <th>操作</th>
                </tr>
                <%
                    try {
                        ScoreD scoD = new ScoreD();
                        StudentD stuD = new StudentD();
                        Score stu = scoD.findWithId(student.getId());
                        String name = stuD.findWithId(student.getId()).getName();
                        String major = stuD.findWithId(student.getId()).getMajor();
                %>
                <tr>
                    <td height="35"><%=stu.getId()%></td>
                    <td><%=name%></td>
                    <td><%=major%></td>
                    <td><%=stu.getWeb()%></td>
                    <td><%=stu.getOs()%></td>
                    <td><%=stu.getDb()%></td>
                    <td><a href="pdf.jsp?id=<%=stu.getId()%>&name=<%=name%>&major=<%=major%>&web=<%=stu.getWeb()%>&os=<%=stu.getOs()%>&db=<%=stu.getDb()%>">PDF</a></td>
                </tr>
                <%
                    }
                    catch (Exception e){
                        out.print(e);
                    }
                %>
            </table>
        </div>
    </div>
</div>
</body>
</html>

