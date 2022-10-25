package dao;

import entity.Tutor;
import utils.JDBCUtils;

import java.sql.*;
import java.util.ArrayList;

public class TutorDao {

    private Connection conn = null;

    public Tutor findWithId(String id) throws Exception{
        initConnection();
        Statement stat = conn.createStatement();
        String sql = "select * from tutor where id = '" + id + "'";
        ResultSet rs = stat.executeQuery(sql);
        Tutor tu = getTutor(rs);
        closeConnection();
        return tu;
    }

    public ArrayList<Tutor> getOnePage(int page, int size) throws Exception{
        ArrayList<Tutor> al = new ArrayList<>();
        initConnection();
        String sql = "SELECT * FROM tutor limit ?, ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, (page-1)*size);
        ps.setInt(2, size);
        ResultSet rs =  ps.executeQuery();
        getMoreTutor(al, rs);
        closeConnection();
        return al;
    }

    public int getTutorCount() throws Exception{
        initConnection();
        String sql = "select count(*) from tutor";
        Statement stat = conn.createStatement();
        ResultSet rs = stat.executeQuery(sql);
        rs.next();
        int count = rs.getInt(1);
        closeConnection();
        return count;
    }

    private Tutor getTutor(ResultSet rs) throws SQLException {
        Tutor tu = null;
        if (rs.next()){
            tu = new Tutor();
            tu.setId(rs.getString("id"));
            tu.setTeacherId(rs.getString("teacher_id"));
            tu.setStuId(rs.getString("stu_id"));
            tu.setClassId(rs.getString("class_id"));
        }
        return tu;
    }

    private void getMoreTutor(ArrayList<Tutor> al, ResultSet rs) throws SQLException {
        while (rs.next()){
            Tutor tu = new Tutor();
            tu.setId(rs.getString("id"));
            tu.setTeacherId(rs.getString("teacher_id"));
            tu.setStuId(rs.getString("stu_id"));
            tu.setClassId(rs.getString("class_id"));
            al.add(tu);
        }
    }

    private void initConnection() throws Exception {
        conn = JDBCUtils.getConnection();
    }

    private void closeConnection() throws Exception{
        JDBCUtils.close(conn);
    }
}
