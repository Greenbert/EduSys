package dao;

import entity.ClassInfo;
import entity.Student;
import utils.JDBCUtils;

import java.sql.*;
import java.util.ArrayList;

public class ClassDao {

    private Connection conn = null;


    public ClassInfo findWithId(String id) throws Exception{
        initConnection();
        String sql = "select * from tutor,classinfo,teacher where teacher_id like CONCAT('%',?,'%') group by class_id";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();
        ClassInfo cla = getClassIF(rs);
        closeConnection();
        return cla;
    }

    public ArrayList<ClassInfo> findWithName(String name) throws Exception{
        ArrayList<ClassInfo> cal = new ArrayList<>();
        initConnection();
        String sql = "select class_id,stu_id,classinfo.id,classinfo.name,classinfo.credit,teacher_id,classinfo.room from tutor,teacher,classinfo WHERE tutor.teacher_id = teacher.id AND classinfo.id = tutor.class_id AND teacher.name LIKE CONCAT('%',?,'%') group by class_id";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1,name);
        ResultSet rs = ps.executeQuery();
        getMoreClass(cal, rs);
        closeConnection();
        return cal;
    }

    public ArrayList<ClassInfo> getOnePage(int page, int size) throws Exception{
        ArrayList<ClassInfo> al = new ArrayList<>();
        initConnection();
        String sql = "SELECT * FROM tutor,classinfo WHERE tutor.class_id=classinfo.id group by class_id limit ?, ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, (page-1)*size);
        ps.setInt(2, size);
        ResultSet rs =  ps.executeQuery();
        getMoreClass(al, rs);
        closeConnection();
        return al;
    }

    public ArrayList<ClassInfo> getOnePageStu(int page, int size) throws Exception{
        ArrayList<ClassInfo> al = new ArrayList<>();
        initConnection();
        String sql = "SELECT * FROM tutor,classinfo WHERE tutor.class_id=classinfo.id group by stu_id limit ?, ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, (page-1)*size);
        ps.setInt(2, size);
        ResultSet rs =  ps.executeQuery();
        getMoreClass(al, rs);
        closeConnection();
        return al;
    }

    public int getClassCount() throws Exception{
        initConnection();
        String sql = "select count(*) from classinfo";
        Statement stat = conn.createStatement();
        ResultSet rs = stat.executeQuery(sql);
        rs.next();
        int count = rs.getInt(1);
        closeConnection();
        return count;
    }

    private ClassInfo getClassIF(ResultSet rs) throws SQLException {
        ClassInfo cla = null;
        if (rs.next()){
            cla = new ClassInfo();
            cla.setId(rs.getString("id"));
            cla.setTeacher_id(rs.getString("teacher_id"));
            cla.setStu_id(rs.getString("stu_id"));
            cla.setClass_id(rs.getString("class_id"));
            cla.setName(rs.getString("name"));
            cla.setRoom(rs.getString("room"));
            cla.setCredit(rs.getString("credit"));
        }
        return cla;
    }

    private void getMoreClass(ArrayList<ClassInfo> al, ResultSet rs) throws SQLException {
        while (rs.next()){
            ClassInfo cla = new ClassInfo();
            cla.setId(rs.getString("id"));
            cla.setTeacher_id(rs.getString("teacher_id"));
            cla.setStu_id(rs.getString("stu_id"));
            cla.setClass_id(rs.getString("class_id"));
            cla.setName(rs.getString("name"));
            cla.setRoom(rs.getString("room"));
            cla.setCredit(rs.getString("credit"));
            al.add(cla);
        }
    }

    private void initConnection() throws Exception {
        conn = JDBCUtils.getConnection();
    }

    private void closeConnection() throws Exception{
        JDBCUtils.close(conn);
    }
}
