package com.spj.Dao;

import com.spj.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

@Repository
public class UserDao  {
    @Autowired
    public JdbcTemplate jdbcTemplate;


    public boolean insertUser(User user){
        System.out.println(111);
        String sql ="insert into user values(?,?)";
        int f =jdbcTemplate.update(sql,user.getName(),user.getPass());
        System.out.println("insert user");
        return f>0;
    }

    public int hasUser(User user){
        String sql = "select count(*) from user where name=?";
        return jdbcTemplate.queryForObject(sql,int.class,user.getName());
    }

    public boolean judgeUser(User user){
        String sql = "select count(*) from user where name=? and pass=?";
        int f =jdbcTemplate.queryForObject(sql,int.class,user.getObj());
        return f>0;
    }

    public boolean updateInfo(User user){
        String sql = "update user set pass=? where name=?";
        int f = jdbcTemplate.update(sql,user.getPass(),user.getName());
        return f>0;
    }


}
