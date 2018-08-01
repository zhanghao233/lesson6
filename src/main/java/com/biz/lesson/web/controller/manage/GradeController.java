package com.biz.lesson.web.controller.manage;

import com.biz.lesson.model.student.Grade;
import com.biz.lesson.service.GradeService;
import com.biz.lesson.web.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;


import javax.servlet.http.HttpServletRequest;

import java.util.List;

/**
 *
 **/
@Controller
@RequestMapping("manage/student")
public class GradeController extends BaseController {

    private HttpServletRequest request;
    @Autowired
    private GradeService gradeService;

    private ModelAndView modelAndView = new ModelAndView();

    @RequestMapping("gradelist")
    public ModelAndView showList(){
        Integer number = 0;
        Page<Grade> pageList = gradeService.pageList(number);
        List<Grade> gradeList = pageList.getContent();
        System.out.println("getTotalElements--查询的总记录数:"+pageList.getTotalElements());
        System.out.println("getTotalPages--查询的总页数:"+pageList.getTotalPages());
        System.out.println("getContent--当前页面的集合："+pageList.getContent());
        System.out.println("getNumber--当前第几页:"+pageList.getNumber() + 1);
        System.out.println("getNumberOfElements--查询的当前页面的记录数:"+pageList.getNumberOfElements());
        request.setAttribute("TotalElements1",pageList.getTotalElements());
        request.setAttribute("TotalPages1",pageList.getTotalPages());
        request.setAttribute("Number1",pageList.getNumber());
        request.setAttribute("NumberOfElements1",pageList.getNumberOfElements());
        request.setAttribute("gradeList1",gradeList);
        modelAndView.setViewName("manage/student/gradeList");
        return modelAndView;
    }

}
