package com.spj.controller;

import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class Filter extends OncePerRequestFilter {
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String userName = (String) request.getSession().getAttribute("name");
        String[] notFilter = new String[]{"login", "Register","register","css","'js"};
        String uri = request.getRequestURI();
        if ("".equals(userName) || userName == null) {
            System.out.println("123412512315");
            boolean doFilter = true;
            for (String s : notFilter) {
                if (uri.contains(s)) {
                    doFilter = false;
                    break;
                }
            }
            System.out.println(doFilter);
            if (doFilter) {
                request.setCharacterEncoding("UTF-8");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                String loginPage = "login";
                StringBuilder builder = new StringBuilder();
                builder.append("<script type=\"text/javascript\">");
                builder.append("alert(\'You haven\\'t login yet\');");
                builder.append("window.location.href='");
                builder.append(loginPage);
                builder.append("';");
                builder.append("</script>");
                out.print(builder.toString());
            }else{
                filterChain.doFilter(request, response);
            }
        } else {
            filterChain.doFilter(request, response);
        }
    }
}
