package servlet;

import dao.ClassDao;
import dao.StudentD;
import dao.TeacherD;
import entity.ClassInfo;
import entity.Student;
import entity.Teacher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Pattern;
/**
 学生课程分页 检索
 */

@WebServlet("/one_page_class")
public class one_page_class extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");

        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        String key = request.getParameter("key");

        TeacherD tdao = new TeacherD();
        HashMap<String,String> teas = null;
        try {
            teas = tdao.getTeacherList();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        session.setAttribute("getTeacherList", teas);

        if (key == null || key.equals("")){
            int currentIndex, count, size = 10;
            String index = request.getParameter("index");
            if (index == null)
                index = "1";
            currentIndex = Integer.parseInt(index);

            try {
                ClassDao cdao = new ClassDao();
                ArrayList<ClassInfo> cls = cdao.getOnePage(currentIndex, size);
                count = cdao.getClassCount();
                int sumIndex = count % size == 0 ? count / size : count / size + 1;
                session.setAttribute("onePageClass", cls);
                session.setAttribute("sumIndex", sumIndex);
                response.sendRedirect("teacher/claInfo.jsp");
            } catch (Exception e) {
                out.print(e);
            }
        }else {

            ClassDao cdao = new ClassDao();
            String pattern = "^\\d+";
            boolean isMatch = Pattern.matches(pattern, key);
            if (isMatch) {
                try {

                    ClassInfo cla = cdao.findWithId(key);
                    ArrayList<ClassInfo> cls = new ArrayList<>();
                    cls.add(cla);
                    session.setAttribute("onePageClass", cls);
                    session.setAttribute("sumIndex", 1);
                    response.sendRedirect("teacher/claInfo.jsp");
                } catch (Exception e) {
                    out.print(e);
                }
            } else {
                try {
                    ArrayList<ClassInfo> cls = cdao.findWithName(key);
                    session.setAttribute("onePageClass", cls);
                    session.setAttribute("sumIndex", 1);
                    response.sendRedirect("teacher/claInfo.jsp");
                } catch (Exception e) {
                    out.print(e);
                }
            }

        }

    }
}
