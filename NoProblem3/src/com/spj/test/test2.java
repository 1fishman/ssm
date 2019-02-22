package com.spj.test;

import java.lang.reflect.Array;
import java.util.ArrayList;

public class test2 {


    public static void main(String args[]){
        ArrayList ls = new ArrayList();
        int[] array = new int[20];
        for(int i=0;i<20;i++){
            array[i]=i;
        }

        ls.add(1);
        ls.add(new test1());
        ls.add("asfd");
        System.out.println(array);
        System.out.println(ls);
    }
}
