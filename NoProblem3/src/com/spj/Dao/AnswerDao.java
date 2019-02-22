package com.spj.Dao;

import com.spj.entity.Answer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AnswerDao {
    @Autowired
    private JdbcTemplate jdbcTemplate;


    public boolean insertAnswer(Answer answer){
        String sql = "insert into answer values(?,?,?,?)";
        int f = jdbcTemplate.update(sql,answer.getObj());
        return f>0;
    }

    public boolean deleteAnswer(Answer answer){
        String sql ="delete from answer where answername=? and proName=? and answertime=? and content=? ";
        int f =jdbcTemplate.update(sql,answer.getObj());
        return f>0;
    }

    public List<Answer> queryAnswerByProName(String proName){
        String sql = "select * from answer where proname=? order by answertime desc ";
        RowMapper<Answer> rm = new BeanPropertyRowMapper<>(Answer.class);
        List<Answer> ls = jdbcTemplate.query(sql,rm,proName);
        return ls;
    }

    public List<Answer> queryAnswerByAnswerName(String AnswerName){
        String sql = "select * from answer where answername=? order by answertime desc";
        RowMapper<Answer> rm = new BeanPropertyRowMapper<>(Answer.class);
        List<Answer> ls = jdbcTemplate.query(sql,rm,AnswerName);
        return ls;
    }

    public int queryByUserAndProName(String userName,String proName){
        String sql = "select count(*) from answer where answername=? and proname=? ";
        int f = jdbcTemplate.queryForObject(sql,int.class,userName,proName);
        return f;
    }

}
