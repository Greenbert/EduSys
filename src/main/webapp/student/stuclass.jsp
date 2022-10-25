<%@ page import="dao.StudentD" %>
<%@ page import="entity.Student" %>
<%@ page import="dao.ScoreD" %>
<%@ page import="entity.Score" %>
<%@ page import="entity.ClassInfo" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.ClassDao" %>
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
    ClassDao classDao = new ClassDao();
    ArrayList<ClassInfo> cls = classDao.getOnePageStu(1,10);
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
                <li><a href="main.jsp">学生成绩</a></li>
                <li class="current_page_item"><a href="stuclass.jsp">课程安排</a></li>
                <li><a onclick="return confirm('确认退出?');" href="../exit">退出登录</a></li>
            </ul>
        </div>
    </div>
    <div id="main">
        <div class="top">
            <h2>学生课程安排</h2>
            <hr/>
        </div>
        <div class="table">
            <table width="800" frame="void" align="center">
                <tr>
                    <th height="35">课程编号</th>
                    <th>课程名称</th>
                    <th>学分</th>
                    <th>上课地点</th>
                </tr>
                <%
                    try {
                        ScoreD scoD = new ScoreD();
                        StudentD stuD = new StudentD();
                        Score stu = scoD.findWithId(student.getId());
                        String name = stuD.findWithId(student.getId()).getName();
                        String major = stuD.findWithId(student.getId()).getMajor();
                        for (ClassInfo cla : cls){
                            if (cla.getStu_id().equals(student.getId())){
                %>
                <tr>
                    <td height="35"><%=cla.getClass_id()%></td>
                    <td><%=cla.getName()%></td>
                    <td><%=cla.getCredit()%></td>
                    <td><%=cla.getRoom()%></td>
                </tr>
                <%
                            }
                        }
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

