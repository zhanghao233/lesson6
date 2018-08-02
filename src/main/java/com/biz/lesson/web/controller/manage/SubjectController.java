package com.biz.lesson.web.controller.manage;

import com.biz.lesson.model.student.Subject;
import com.biz.lesson.service.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.math.BigInteger;
import java.util.List;

/**
 *
 **/
@Controller
@RequestMapping("manage/subject")
public class SubjectController {
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private SubjectService subjectService;

    private ModelAndView modelAndView = new ModelAndView();
    @RequestMapping("subjectlist")
    public ModelAndView showList(){
        Integer number = 0;
        Page<Subject> pageList = subjectService.pageList(number);
        List<Subject> subjectList = pageList.getContent();
        System.out.println("getTotalElements--查询的总记录数:"+pageList.getTotalElements());
        System.out.println("getTotalPages--查询的总页数:"+pageList.getTotalPages());
        System.out.println("getContent--当前页面的集合："+pageList.getContent());
        System.out.println("getNumber--当前第几页:"+(pageList.getNumber() + 1));
        System.out.println("getNumberOfElements--查询的当前页面的记录数:"+pageList.getNumberOfElements());
        request.setAttribute("TotalElements",pageList.getTotalElements());
        request.setAttribute("TotalPages",pageList.getTotalPages());
        request.setAttribute("Number",pageList.getNumber());
        request.setAttribute("NumberOfElements",pageList.getNumberOfElements());
        request.setAttribute("subjectList",subjectList);
        modelAndView.setViewName("manage/student/subjectList");
        return modelAndView;
    }
    @RequestMapping("sublistnum")
    public ModelAndView shownumList() {

        List<String> sublist =subjectService.findAllname();
        List<BigInteger> numlist =subjectService.findNumByName();

        for (String sub:sublist){
            System.out.println(sub);
        }
        for (BigInteger num:numlist){
            System.out.println(num);
        }
        request.setAttribute("sublist", sublist);
        request.setAttribute("numlist", numlist);
        modelAndView.setViewName("manage/student/courselist");
        return modelAndView;

    }
}
