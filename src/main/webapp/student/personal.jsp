<%@ page import="entity.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>main</title>
    <link rel="stylesheet" href="../resources/css/jquery-ui-1.10.4.custom.min.css">
    <script src="../resources/js/jquery-1.10.2.js"></script>
    <script src="../resources/js/jquery-ui-1.10.4.custom.min.js"></script>
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
                <li class="current_page_item"><a href="personal.jsp">学生信息</a></li>
                <li><a href="main.jsp">学生成绩</a></li>
                <li><a href="stuclass.jsp">课程安排</a></li>
                <li><a onclick="return confirm('确认退出?');" href="../exit">退出登录</a></li>
            </ul>
        </div>
    </div>
    <div id="main">
        <div class="top">
            <h2>学生信息</h2>
            <hr/>
        </div>
        <div class="infoT">
            <div class="picture">
                <img src="../userImg/<%=student.getId()%>.jpeg" class="personalImg" onerror="this.src='../userImg/default.jpeg';this.onerror = 'null'"><br><br><br>
                <form action="../upload_studentImg" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="<%=student.getId()%>">
                    <input type="file" name="img">
                    <input type="submit" value="上传头像">
                </form>
            </div>

            <div class="sPersonalForm">
                <form action="../update_student_email" method="post">
                    <table width="400">
                        <tr>
                            <td style="font-size: 25px;font-weight: bold">学号</td>
                            <td style="font-size: 25px;font-weight: bold"><%=student.getId()%></td>
                        </tr>
                        <tr>
                            <td style="font-size: 25px;font-weight: bold">姓名</td>
                            <td style="font-size: 25px;font-weight: bold"><%=student.getName()%></td>
                        </tr>
                        <tr>
                            <td style="font-size: 25px;font-weight: bold">性别</td>
                            <td style="font-size: 25px;font-weight: bold"><%=student.getSex()%></td>
                        </tr>
                        <tr>
                            <td style="font-size: 25px;font-weight: bold">专业</td>
                            <td style="font-size: 25px;font-weight: bold"><%=student.getMajor()%></td>
                        </tr>
                    </table>
                </form><br><br>
                <button class="password-btn" style="height: 30px">修改安全信息</button>
            </div>

        </div>
    </div>
</div>

<%--修改密码对话框--%>
<div id="password-dialog" title="修改安全信息">
    <form id="password-form" method="post" >
        <input type="hidden" name="id" value="<%=student.getId()%>">
        邮箱: &nbsp;<input type="email" name="email" value="<%=student.getEmail()%>"><br>
        新密码:<input type="password" name="password"><br>
        <hr>
        <input style="float: right" type="submit" value="取消" onclick="function x() {
          $('#password-dialog').dialog('close');
        }">
        <input style="float: right; margin-right: 25px" type="submit" value="保存"
               onclick="return check(this.form)">
    </form>
</div>

<script>
    $('#password-dialog').dialog({
        width: 340,
        autoOpen: false,
        draggable: false,
        modal: true,
        resizable: false
    });
    $('.password-btn').click(function () {
        $('#password-dialog').dialog('open');
    });

    function check(form){

        if (form.password.value.length === 0 ) {
            alert("请输入密码！");
            return false;
        }
        form.action='../update_student_security';
        return true;
    }
</script>

<style>
    .ui-dialog-titlebar-close {
        display: none
    }
</style>
</body>
</html>

