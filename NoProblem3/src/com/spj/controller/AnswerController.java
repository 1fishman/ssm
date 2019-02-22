package com.spj.controller;

import com.spj.Dao.AnswerDao;
import com.spj.entity.Answer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jca.cci.InvalidResultSetAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

@Controller
public class AnswerController {
    @Autowired
    AnswerDao answerDao;
    @Autowired
    HttpServletRequest request;

    @RequestMapping("reply")
    @ResponseBody
    public HashMap replyPro(String title,String content){
        HashMap mm = new HashMap();
        java.util.Date date = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String strDate =sdf.format(date);
        String userName = (String) request.getSession().getAttribute("name");
            try{
                Answer answer= new Answer(userName,title,strDate,content);
                answerDao.insertAnswer(answer);
                // 使用JdbcTemplate访问数据库
                mm.put("info", "成功");
            }catch (InvalidResultSetAccessException e){
                mm.put("info", "失败1");
            }catch (DataAccessException e) {
                mm.put("info", "失败2");
            }finally {
                return mm;
            }
    }


}
