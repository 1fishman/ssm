package com.spj.controller;

import com.spj.Dao.UserDao;
import com.spj.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@SessionAttributes("name")
@Controller
public class LoginController {
    @Autowired
    UserDao userDao;


    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @RequestMapping("/ToRegister")
    public String ToRegister(){
        return "register";
    }

    @RequestMapping(value = "/register.do",method = RequestMethod.POST)
    public ModelAndView Register(User user){
        if(userDao.hasUser(user)>0){
            return new ModelAndView("register","error","The User already exist");
        }else{
            if(userDao.insertUser(user)){
                return new ModelAndView("login","user",user);
            }else{
                return new ModelAndView("register","error","未知错误");
            }
        }
    }

    @RequestMapping(value = "login.do",method = RequestMethod.POST)
    public ModelAndView login(HttpServletRequest request,ModelMap map ,User user){
        if(userDao.judgeUser(user)){
            HttpSession hs = request.getSession();
            hs.setAttribute("name",user.getName());
            map.put("name",user.getName());
            return new ModelAndView("redirect:main");
        }else{
            System.out.println("error");
            return new ModelAndView("login","error","用户名或密码错误");

        }
    }
}
