package servlet;

import dao.ClassDao;
import dao.ScoreD;
import dao.TeacherD;
import entity.ClassInfo;
import entity.Score;

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
import java.util.List;
import java.util.regex.Pattern;



@WebServlet("/statistics_class")
public class statistics_class extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        this.doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");

        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        HashMap<String,int[]> calRes = new HashMap<>();
        ScoreD sd = new ScoreD();
        List<Integer> webList = new ArrayList<>();
        List<Integer> osList = new ArrayList<>();
        List<Integer> dbList = new ArrayList<>();
        try {
            List<Score> scs = sd.getScoreList();
            for (Score s : scs){
                webList.add(Integer.parseInt(s.getWeb()));
                osList.add(Integer.parseInt(s.getOs()));
                dbList.add(Integer.parseInt(s.getDb()));
            }

            int web[] = new int[3];
            web = count(webList);
            int os[] = new int[3];
            os = count(osList);
            int db[] = new int[3];
            db = count(dbList);

            calRes.put("web",web);
            calRes.put("os",os);
            calRes.put("db",db);
            int calNum = sd.getScoreCount();

            session.setAttribute("getClassCalculate",calRes);
            session.setAttribute("classNum",calNum);
            response.sendRedirect("teacher/calculateRes.jsp");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    private int max(List<Integer> list){
        Integer tmp = 0;
        for (Integer i : list){
            if (i>tmp){
                tmp = i;
            }
        }
        return tmp;
    }

    private int min(List<Integer> list){
        Integer tmp = 100;
        for (Integer i : list){
            if (i<tmp){
                tmp = i;
            }
        }
        return tmp;
    }

    private int avg(List<Integer> list){
        Integer tmp = 0;
        Integer total = list.size();
        for (Integer i : list){
            tmp = tmp + i;
        }
        return tmp/total;
    }

    private int[] count(List<Integer> list){
        int[] tmp = new int[3];
        tmp[0] = max(list);
        tmp[1] = avg(list);
        tmp[2] = min(list);
        return tmp;
    }
}

