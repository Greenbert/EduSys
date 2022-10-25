<%@ page import="dao.ScoreD" %>
<%@ page import="entity.Score" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.StudentD" %>
<%@ page contentType="application/msexcel" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>main</title>
</head>
<body>
<%
    out.clearBuffer();
    response.setHeader("Content-Disposition", "attachment;filename=excel.xls");
%>
<table align="center" border="1">
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
            ScoreD scoD = new ScoreD();
            StudentD stuD = new StudentD();
            ArrayList<Score> stus = scoD.getOnePage(1, 10000);
            for (Score stu : stus) {
                String name = stuD.findWithId(stu.getId()).getName();
                String major = stuD.findWithId(stu.getId()).getMajor();
    %>
    <tr>
            <td align="center"><%=stu.getId()%></td>
            <td align="center"><%=name%></td>
            <td align="center"><%=major%></td>
            <td align="center"><%=stu.getWeb()%></td>
            <td align="center"><%=stu.getOs()%></td>
            <td align="center"><%=stu.getDb()%></td>
    </tr>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</table>
</body>
</html>

