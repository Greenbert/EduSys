package dao;

import entity.Score;
import utils.JDBCUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

public class ScoreD {

    private Connection conn = null;

    public boolean insertScore(String id) throws Exception{
        initConnection();
        String sql = "insert into score(id) values(?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, id);
        int i = ps.executeUpdate();
        closeConnection();
        return i == 1;
    }

    public boolean deleteScore(String id) throws Exception{
        initConnection();
        Statement stat = conn.createStatement();
        String sql = "delete from score where id='"+id+"'";
        int i = stat.executeUpdate(sql);
        closeConnection();
        return i==1;
    }

    public void updateScoreInfo(String id, String web, String os, String db) throws Exception{

        initConnection();
        String sql = "update score set web=?, os=?, db=? where id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, web);
        ps.setString(2, os);
        ps.setString(3, db);
        ps.setString(4, id);
        ps.executeUpdate();
        closeConnection();
    }

    public Score findWithId(String id) throws Exception{
        initConnection();
        Statement stat = conn.createStatement();
        String sql = "select * from score where id = '" + id + "'";
        ResultSet rs = stat.executeQuery(sql);
        Score stu = getScore(rs);
        closeConnection();
        return stu;
    }

    public ArrayList<Score> getOnePage(int page, int size) throws Exception{
        ArrayList<Score> al = new ArrayList<>();
        initConnection();
        String sql = "SELECT * FROM score limit ?, ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, (page-1)*size);
        ps.setInt(2, size);
        ResultSet rs =  ps.executeQuery();
        getMoreScore(al, rs);
        closeConnection();
        return al;
    }

    public int getScoreCount() throws Exception{
        initConnection();
        String sql = "select count(*) from score";
        Statement stat = conn.createStatement();
        ResultSet rs = stat.executeQuery(sql);
        rs.next();
        int count = rs.getInt(1);
        closeConnection();
        return count;
    }

    private Score getScore(ResultSet rs) throws SQLException {
        Score stu = null;
        if (rs.next()){
            stu = new Score();
            stu.setId(rs.getString("id"));
            stu.setWeb(rs.getString("web"));
            stu.setOs(rs.getString("os"));
            stu.setDb(rs.getString("db"));
        }
        return stu;
    }

    public ArrayList<Score> getScoreList() throws Exception{
        ArrayList<Score> al = new ArrayList<>();
        initConnection();
        String sql = "SELECT * FROM score";
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs =  ps.executeQuery();
        getMoreScore(al, rs);
        closeConnection();
        return al;
    }

    private void getMoreScore(ArrayList<Score> al, ResultSet rs) throws SQLException {
        while (rs.next()){
            Score score = new Score();
            score.setId(rs.getString("id"));
            score.setWeb(rs.getString("web"));
            score.setOs(rs.getString("os"));
            score.setDb(rs.getString("db"));
            al.add(score);
        }
    }

    private void initConnection() throws Exception {
        conn = JDBCUtils.getConnection();
    }

    private void closeConnection() throws Exception{
        JDBCUtils.close(conn);
    }
}
