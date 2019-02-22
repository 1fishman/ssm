package com.spj.controller;

import com.spj.Dao.AnswerDao;
import com.spj.Dao.ProblemDao;
import com.spj.entity.Answer;
import com.spj.entity.Article;
import com.spj.entity.Problem;
import jdk.nashorn.internal.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jca.cci.InvalidResultSetAccessException;
import org.springframework.stereotype.Controller;
import org.springframework.web.HttpRequestHandler;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class ProblemController {
    @Autowired
    ProblemDao problemDao;
    @Autowired
    AnswerDao answerDao;

    @Autowired
    HttpServletRequest request;

    @RequestMapping("fabuPro")
    @ResponseBody
    public Map<String,Object> insertPro( String title, String content) throws ParseException {
        java.util.Date date = new java.util.Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String strDate =sdf.format(date);
        Timestamp time = new Timestamp(sdf.parse(strDate).getTime());
        Problem problem = new Problem((String) request.getSession().getAttribute("name"), title, strDate, content);

        Map<String, Object> mm = new HashMap<>();
        try{
            problemDao.insertPro(problem);
            mm.put("info", "成功");
        }catch (InvalidResultSetAccessException e){
            mm.put("info", "你已经发布过此问题了");
        }catch (DataAccessException e){
            mm.put("info","你已经发布过此问题了");
        }
        finally {
            return mm;
        }

    }

    @RequestMapping(value = "AllProblem",method = RequestMethod.POST)
    public @ResponseBody HashMap getAllProblem(){
        List<Problem> lsp=problemDao.getAll();
        int a =lsp.size();
        HashMap mm1=new HashMap<>();


        for(Problem problem1 : lsp){
            List<Answer> lsa = answerDao.queryAnswerByProName(problem1.getProName());
            List ls =new ArrayList();
            ls.add(problem1);
            ls.add(lsa);
            mm1.put(problem1.getProName(),ls);

        }
        return mm1;
    }

    @RequestMapping("getMyPro")
    @ResponseBody
    public HashMap getMyPro(){
        String userName = (String) request.getSession().getAttribute("name");
        List<Problem> lsp = problemDao.queryByUserName(userName);
        HashMap mm1=new HashMap<>();
        for(Problem problem1 : lsp){
            List<Answer> lsa = answerDao.queryAnswerByProName(problem1.getProName());

            List ls =new ArrayList();
            ls.add(problem1);
            ls.add(lsa);
            mm1.put(problem1.getProName(),ls);
        }
        return mm1;
    }

    @RequestMapping("queryByMoHu")
    @ResponseBody
    public HashMap queryByMoHu(String content){
        if(content==null||content.equals(""))
            return getAllProblem();
        List<Problem> ls = problemDao.getProblemByMoHu(content);
        /*Set<Character> ss = new HashSet<>();

        System.out.println(ls.size());
        System.out.println(content);
        System.out.println(ls);
        for(int i=0;i<ls.size();i++){

            System.out.println(ls.get(i));
            if(!ls.get(i).contains(content))
                ls.remove(i);
        }*/
        HashMap mm1=new HashMap<>();
        for(Problem problem1 : ls){
            System.out.println(problem1.getProName());
            List<Answer> lsa = answerDao.queryAnswerByProName(problem1.getProName());
            Problem pro = problemDao.getByName(problem1.getProName());
            if(pro==null){
                continue;
            }
            System.out.println(problem1);
            System.out.println(lsa.size());
            List ls2 =new ArrayList();
            ls2.add(pro);
            ls2.add(lsa);
            mm1.put(problem1.getProName(),ls2);
        }
        return mm1;
    }


    @RequestMapping("deletePro")
    @ResponseBody
    public HashMap deletePro(String proName){
        HashMap mm=new HashMap();
        try{
            problemDao.deleteProByName(proName);
            mm.put("info", "成功");
        }catch (InvalidResultSetAccessException e){
            mm.put("info", "删除失败1");
        }catch (DataAccessException e){
            mm.put("info","删除失败2");
        }
        finally {
            return mm;
        }
    }

}