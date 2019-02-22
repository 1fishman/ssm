package com.spj.entity;

import org.springframework.stereotype.Component;

@Component
public class User {
    private String name;
    private String pass;

    public User(){

    }

    public User(String name, String pass) {
        this.name = name;
        this.pass = pass;

    }

    public Object[] getObj(){
        Object[] objects= new Object[2];
        objects[0]=name;
        objects[1]=pass;
        return objects;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }
}
