package com.spj.Dao;

import com.spj.entity.Problem;
import com.sun.rowset.internal.Row;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;


@Repository
public class ProblemDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    private RowMapper<Problem> rm = new BeanPropertyRowMapper<>(Problem.class);

    public boolean insertPro(Problem problem){
        String sql = "insert into problem values(?,?,?,?)";
        int f = jdbcTemplate.update(sql,problem.getObj());
        return f>0;
    }

    public List<Problem> getAll(){
        String sql = "select * from problem";
        RowMapper<Problem> rm = new BeanPropertyRowMapper<>(Problem.class);
        List<Problem> ls =jdbcTemplate.query(sql,rm);
        return ls;
    }

    public List<Problem> queryByUserName(String userName){
        String sql = "select * from problem where username=?";
        RowMapper<Problem> rm = new BeanPropertyRowMapper<>(Problem.class);
        List<Problem> ls = jdbcTemplate.query(sql,rm,userName);
        return ls;
    }

    public boolean deleteProByName(String name){
        String sql ="delete from problem where proName=?";
        String sql1 = "delete from answer where proname=?";
        int f = jdbcTemplate.update(sql1,name);
        int c = jdbcTemplate.update(sql,name);
        return f>0||c>0;
    }

    public boolean UpdataPro(String name){
        String sql = "update problem set content=?,publishTime=?";
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        Timestamp ts = (Timestamp) new java.util.Date();
        int f = jdbcTemplate.update(sql,name,ts);
        return f>0;
    }

    public Problem getByName(String name){
        String sql = "select * from problem where proName=?";
        RowMapper<Problem> rm = new BeanPropertyRowMapper<>(Problem.class);
        Problem pro = jdbcTemplate.queryForObject(sql,rm,name);
        System.out.println(1234);
        return pro;

    }


    public List<Problem> getProblemByMoHu(String proName){
        String sql = "select * from problem where proName like ?";
        proName = "%"+proName+"%";
        RowMapper<Problem> rm = new BeanPropertyRowMapper<>(Problem.class);
        List<Problem> ls =jdbcTemplate.query(sql,rm,proName);
        return ls;
    }

    public List<String> getAllTitle(){
        String sql = "select proName from problem";
        RowMapper<String> rm = new BeanPropertyRowMapper<>(String.class);
        List<String> ls= jdbcTemplate.query(sql,rm);
        System.out.println(ls);
        return ls;
    }

}
