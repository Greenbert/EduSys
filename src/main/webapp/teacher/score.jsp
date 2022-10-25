<%@ page import="entity.Teacher" %>
<%@ page import="entity.Score" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.StudentD" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>main</title>
    <link href="../resources/css/default.css" rel="stylesheet"/>
</head>
<body>
<%
    Teacher teacher = (Teacher) session.getAttribute("info");
    ArrayList<Score> stus = (ArrayList<Score>) session.getAttribute("onePageScore");
    int sumIndex = (int) session.getAttribute("sumScoreIndex");
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
                <li class="current_page_item"><a href="../one_page_score">成绩管理</a></li>
                <li><a href="../one_page_class">课程安排</a></li>
                <li><a onclick="return confirm('确认退出?');" href="../exit">退出登录</a></li>
            </ul>
        </div>
    </div>
    <div id="main">
        <div class="top">
            <h2>学生成绩管理</h2>
            <hr/>
        </div>
        <form method="post" action="../update_score" style="height: 525px; margin-top: 20px">
            <div class="table" style="margin-top: 20px; height: 525px">
                <table id="table" width="800" frame="void" align="center">
                    <tr>
                        <th height="35">学号</th>
                        <th>姓名</th>
                        <th>专业</th>
                        <th>JavaWeb</th>
                        <th>操作系统</th>
                        <th>数据库</th>
                    </tr>
                    <%
                        try {
                            StudentD stuD = new StudentD();
                            for (Score stu : stus) {
                                String name = stuD.findWithId(stu.getId()).getName();
                                String major = stuD.findWithId(stu.getId()).getMajor();
                    %>
                    <tr>
                        <td height="35"><%=stu.getId()%></td>
                        <td><%=name%></td>
                        <td><%=major%></td>
                        <td><input value="<%=stu.getWeb()%>" name="web" class="table-input"></td>
                        <td><input value="<%=stu.getOs()%>" name="os" class="table-input"></td>
                        <td><input value="<%=stu.getDb()%>" name="db" class="table-input"></td>
                        <input value="<%=stu.getId()%>" name="id" type="hidden">
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </table>
                <%
                    if (sumIndex > 1){
                %>
                <div id="index">
                    <a class="btnDo" href="../one_page_score?index=1">首页</a>
                    <%
                        for (int i = 1; i <= sumIndex; i++) {
                    %>
                    <a class="btnDo" href="../one_page_score?index=<%=i%>">第<%=i%>页</a>
                    <%
                        }
                    %>
                    <a class="btnDo" href="../one_page_score?index=<%=sumIndex%>">尾页</a>
                </div>
                <%
                    }
                %>

            </div>
            <input type="button" class="btn-excel" onclick="location.href='score_excel.jsp';" value="导出EXCEL">
            <input type="submit" class="btn-change" value="修改">
        </form>

    </div>
</div>
</body>
</html>

