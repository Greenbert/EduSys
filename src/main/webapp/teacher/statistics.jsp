<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Teacher" %>
<%@ page import="entity.ClassInfo" %>
<%@ page import="java.util.HashMap" %>
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
    int sumIndex = (int) session.getAttribute("sumIndex");
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
            <h2>课程数据</h2>
            <hr/>
            <button class="btn-add" onclick="window.open('statistics.jsp')">统计课程数据</button>
            <div class="find">
                <form action="../one_page_class" method="post">
                    <input id="find-text" type="text" name="key" placeholder="输入教师ID或姓名搜索">
                    <input class="find-btn" type="submit" value="搜索">
                </form>
            </div>

        </div>
        <div class="table">
            <table id="table" width="800" frame="void" align="center">
                <tr>
                    <th height="35">课程编号</th>
                    <th>课程名称</th>
                    <th>学分</th>
                    <th>教师</th>
                    <th>上课地点</th>
                </tr>
                <%
                    for (ClassInfo cl : cls ) {

                %>
                <tr>

                    <td height="35"><%=cl.getClass_id()%></td>
                    <td height="35"><%=cl.getName()%></td>
                    <td height="35"><%=cl.getCredit()%></td>
                    <td height="35"><%=teas.get(cl.getTeacher_id())%></td>
                    <td height="35"><%=cl.getRoom()%></td>

                </tr>
                <%

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

