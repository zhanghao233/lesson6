package com.biz.lesson.web.controller.manage;

import com.biz.lesson.model.student.Grade;
import com.biz.lesson.model.student.Student;
import com.biz.lesson.model.student.Subject;
import com.biz.lesson.service.StudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 **/
@Controller
@RequestMapping("manage/student")
public class StudentController {
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private StudentService studentService;
    private ModelAndView modelAndView = new ModelAndView();

    @RequestMapping("studentlist")
    public ModelAndView showList(){
        Integer number = 0;
        Page<Student> pageList = studentService.pageList(number);
        List<Student> studentList = pageList.getContent();
        System.out.println("getTotalElements--查询的总记录数:"+pageList.getTotalElements());
        System.out.println("getTotalPages--查询的总页数:"+pageList.getTotalPages());
        System.out.println("getContent--当前页面的集合："+pageList.getContent());
        System.out.println("getNumber--当前第几页:"+(pageList.getNumber() + 1));
        System.out.println("getNumberOfElements--查询的当前页面的记录数:"+pageList.getNumberOfElements());
        request.setAttribute("TotalElements",pageList.getTotalElements());
        request.setAttribute("TotalPages",pageList.getTotalPages());
        request.setAttribute("Number",pageList.getNumber());
        request.setAttribute("NumberOfElements",pageList.getNumberOfElements());
        request.setAttribute("studentList",studentList);
        modelAndView.setViewName("manage/student/studentlist");
        return modelAndView;
    }
    @RequestMapping("studentlistPage")
    public ModelAndView pageList(){
        Integer number = Integer.parseInt(request.getParameter("Number"));
        if(number < 0){
            number =0;
        }
        System.out.println("--------number-------"+number);
        Page<Student> pageList = studentService.pageList(number);
        if (number >= pageList.getTotalPages()){
            pageList = studentService.pageList(pageList.getTotalPages()-1);
        }
        List<Student> studentList = pageList.getContent();

        request.setAttribute("TotalElements",pageList.getTotalElements());
        request.setAttribute("TotalPages",pageList.getTotalPages());
        request.setAttribute("Number",pageList.getNumber());
        request.setAttribute("NumberOfElements",pageList.getNumberOfElements());
        request.setAttribute("studentList",studentList);
        modelAndView.setViewName("manage/student/studentlist");
        return modelAndView;
    }
    @RequestMapping("SearchCode")
    public ModelAndView searchCode() throws ServletException, IOException {
        String code = request.getParameter("code");
        List<Student> studentList = studentService.findByCodeStartWith(code);
        for (Student student : studentList) {
            System.out.println(student + "----------------lx----------");
        }
        Integer currentPage = 0;
        int NumberOfElements = 0;//当前页有几条信息
        int TotalPages = 0;//页数
        int pageSize = 10;//每页总数为10条
        int TotalElements = studentList.size();
        int total = TotalElements % pageSize;
        if (total > 0) {
            TotalPages = TotalElements / pageSize + 1;
        } else {
            TotalPages = TotalElements / pageSize;
        }
        if(total == 0){
            if(TotalPages == 0){
                studentList = null;
            }else {
            studentList = studentList.subList((currentPage) * pageSize, pageSize * (currentPage + 1));
            }
        }else{
            if(TotalElements > pageSize){
            studentList = studentList.subList((currentPage) * pageSize, pageSize * (currentPage + 1));
            }else {
            studentList = studentList.subList(currentPage,TotalElements);
            }
        }
        NumberOfElements = studentList.size();
        request.setAttribute("code", code);
        request.setAttribute("NumberOfElements", NumberOfElements);
        request.setAttribute("TotalPages", TotalPages);
        request.setAttribute("TotalElements", TotalElements);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("studentList", studentList);
        //request.getRequestDispatcher("/studentMessage.jsp").forward(request, response);

                modelAndView.setViewName("manage/student/studentCode");
                return modelAndView;
    }
    @RequestMapping("SearchCodePage")
    public ModelAndView searchCodePage() throws ServletException, IOException {
        String code = request.getParameter("code");
            System.out.println(code + "--code--------------lx----------");
        List<Student> studentList1 = studentService.findByCodeStartWith(code);
        List<Student> studentList = null;
        Integer currentPage = Integer.parseInt(request.getParameter("currentPage"));
            System.out.println(currentPage + "--currentPage--------------lx----------");
        int NumberOfElements = 0;//当前页有几条信息
        int TotalPages = 0;//页数
        int pageSize = 10;//每页总数为10条
        int TotalElements = studentList1.size();
        int total = TotalElements % pageSize;
        System.out.println(total+"-<--------total-----------TotalElements---------->----"+TotalElements);
        if (total > 0) {
            TotalPages = TotalElements/pageSize + 1;
        } else {
            TotalPages = TotalElements/pageSize;
        }
        System.out.println("TotalPages---------------"+TotalPages);
        for (int j = 1; j <= TotalPages; j++) {
            if (total == 0) {
                if (currentPage <= 0) {
                    currentPage = 0;
                    studentList = studentList1.subList((0) * pageSize, pageSize * (0 + 1));
                    for (Student student : studentList1) {
                        System.out.println(student + "----------------lx----------");
                    }
                    System.out.println("------------------<=0-------------------");
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                    request.setAttribute("code", code);
                    modelAndView.setViewName("manage/student/studentMessageSearchPage");
                }
                if (currentPage >= TotalPages) {
                    studentList = studentList1.subList((currentPage - 1) * pageSize, TotalElements);
                    currentPage = TotalPages - 1;
                    System.out.println("currentPage=pageCount-1;" + currentPage + "/////" + TotalPages);
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                    request.setAttribute("code", code);
                    modelAndView.setViewName("manage/student/studentMessageSearchPage");

                }
                if (0 < currentPage && currentPage < TotalPages) {
                    studentList = studentList1.subList((currentPage) * pageSize, pageSize * (currentPage + 1));
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                    request.setAttribute("code", code);
                    modelAndView.setViewName("manage/student/studentMessageSearchPage");

                }
            }else {
                if(currentPage<=0) {
                    currentPage=0;
                    if((currentPage+1) == TotalPages){
                        studentList = studentList1.subList(currentPage,TotalElements);
                        NumberOfElements = studentList.size();
                        request.setAttribute("NumberOfElements", NumberOfElements);
                        request.setAttribute("TotalPages", TotalPages);
                        request.setAttribute("TotalElements", TotalElements);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("studentList", studentList);
                        request.setAttribute("code", code);
                        modelAndView.setViewName("manage/student/studentMessageSearchPage");
                    }else {
                    studentList = studentList1.subList((0)* pageSize, pageSize*(0+1));
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                    request.setAttribute("code", code);
                    modelAndView.setViewName("manage/student/studentMessageSearchPage");
                    }
                }
                if(currentPage>=TotalPages){
                    studentList = studentList1.subList((currentPage-1)* pageSize, TotalElements);
                    currentPage=TotalPages-1;
                    System.out.println("currentPage=pageCount-1;"+currentPage+"/////"+TotalPages);
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                    request.setAttribute("code", code);
                    modelAndView.setViewName("manage/student/studentMessageSearchPage");
                }
                if(0<currentPage&&currentPage<TotalPages) {
                    if(currentPage == (TotalPages-1)){

                    studentList = studentList1.subList((currentPage)* pageSize,TotalElements);
                    System.out.println(studentList+"--------------2");
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                        request.setAttribute("code", code);
                    modelAndView.setViewName("manage/student/studentMessageSearchPage");
                    }else{
                    studentList = studentList1.subList((currentPage-1)* pageSize, (currentPage)* pageSize);
                    System.out.println(studentList+"--------------2");
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                        request.setAttribute("code", code);
                    modelAndView.setViewName("manage/student/studentMessageSearchPage");

                    }

                }
            }
            }
                return modelAndView;
    }

    @RequestMapping("SearchName")
    public ModelAndView searchName(){
        String name = request.getParameter("name");
        List<Student> studentList = studentService.searchByName(name);

        Integer currentPage = 0;
        int NumberOfElements = 0;//当前页有几条信息
        int TotalPages = 0;//页数
        int pageSize = 10;//每页总数为10条
        int TotalElements = studentList.size();
        int total = TotalElements % pageSize;
        if (total > 0) {
            TotalPages = TotalElements / pageSize + 1;
        } else {
            TotalPages = TotalElements / pageSize;
        }
        if(total == 0){
            if(TotalPages == 0){
                studentList = null;
            }else {
                studentList = studentList.subList((currentPage) * pageSize, pageSize * (currentPage + 1));
            }
        }else{
            if(TotalElements > pageSize){
                studentList = studentList.subList((currentPage) * pageSize, pageSize * (currentPage + 1));
            }else {
                studentList = studentList.subList(currentPage,TotalElements);
            }
        }
        /*for (Student student : studentList) {
            System.out.println(student + "----------------lx----------");
        }*/
        NumberOfElements = studentList.size();
        request.setAttribute("name", name);
        request.setAttribute("NumberOfElements", NumberOfElements);
        request.setAttribute("TotalPages", TotalPages);
        request.setAttribute("TotalElements", TotalElements);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("studentList", studentList);

        modelAndView.setViewName("manage/student/studentName");
        return modelAndView;
    }

    @RequestMapping("SearchNamePage")
    public ModelAndView searchNamePage(){
        String name = request.getParameter("name");
        System.out.println(name + "--name--------------lx----------");
        List<Student> studentList1 = studentService.searchByName(name);
        List<Student> studentList = null;
        Integer currentPage = Integer.parseInt(request.getParameter("currentPage"));
        System.out.println(currentPage + "--currentPage--------------lx----------");
        int NumberOfElements = 0;//当前页有几条信息
        int TotalPages = 0;//页数
        int pageSize = 10;//每页总数为10条
        int TotalElements = studentList1.size();
        int total = TotalElements % pageSize;
        System.out.println(total+"-<--------total-----------TotalElements---------->----"+TotalElements);
        if (total > 0) {
            TotalPages = TotalElements/pageSize + 1;
        } else {
            TotalPages = TotalElements/pageSize;
        }
        System.out.println("TotalPages---------------"+TotalPages);
        for (int j = 1; j <= TotalPages; j++) {
            if (total == 0) {
                if (currentPage <= 0) {
                    currentPage = 0;
                    studentList = studentList1.subList((0) * pageSize, pageSize * (0 + 1));
                    for (Student student : studentList1) {
                        System.out.println(student + "----------------lx----------");
                    }
                    System.out.println("------------------<=0-------------------");
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                    request.setAttribute("name", name);
                    modelAndView.setViewName("manage/student/studentNameSearchPage");
                }
                if (currentPage >= TotalPages) {
                    studentList = studentList1.subList((currentPage - 1) * pageSize, TotalElements);
                    currentPage = TotalPages - 1;
                    System.out.println("currentPage=pageCount-1;" + currentPage + "/////" + TotalPages);
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                    request.setAttribute("name", name);
                    modelAndView.setViewName("manage/student/studentNameSearchPage");

                }
                if (0 < currentPage && currentPage < TotalPages) {
                    studentList = studentList1.subList((currentPage) * pageSize, pageSize * (currentPage + 1));
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                    request.setAttribute("name", name);
                    modelAndView.setViewName("manage/student/studentNameSearchPage");

                }
            }else {
                if(currentPage<=0) {
                    currentPage=0;
                    if((currentPage+1) == TotalPages){
                        studentList = studentList1.subList(currentPage,TotalElements);
                        NumberOfElements = studentList.size();
                        request.setAttribute("NumberOfElements", NumberOfElements);
                        request.setAttribute("TotalPages", TotalPages);
                        request.setAttribute("TotalElements", TotalElements);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("studentList", studentList);
                        request.setAttribute("name", name);
                        modelAndView.setViewName("manage/student/studentNameSearchPage");
                    }else {
                        studentList = studentList1.subList((0)* pageSize, pageSize*(0+1));
                        NumberOfElements = studentList.size();
                        request.setAttribute("NumberOfElements", NumberOfElements);
                        request.setAttribute("TotalPages", TotalPages);
                        request.setAttribute("TotalElements", TotalElements);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("studentList", studentList);
                        request.setAttribute("name", name);
                        modelAndView.setViewName("manage/student/studentNameSearchPage");
                    }
                }
                if(currentPage>=TotalPages){
                    studentList = studentList1.subList((currentPage-1)* pageSize, TotalElements);
                    currentPage=TotalPages-1;
                    System.out.println("currentPage=pageCount-1;"+currentPage+"/////"+TotalPages);
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                    request.setAttribute("name", name);
                    modelAndView.setViewName("manage/student/studentNameSearchPage");
                }
                if(0<currentPage&&currentPage<TotalPages) {
                    if(currentPage == (TotalPages-1)){

                        studentList = studentList1.subList((currentPage)* pageSize,TotalElements);
                        System.out.println(studentList+"--------------2");
                        NumberOfElements = studentList.size();
                        request.setAttribute("NumberOfElements", NumberOfElements);
                        request.setAttribute("TotalPages", TotalPages);
                        request.setAttribute("TotalElements", TotalElements);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("studentList", studentList);
                        request.setAttribute("name", name);
                        modelAndView.setViewName("manage/student/studentNameSearchPage");
                    }else{
                        studentList = studentList1.subList((currentPage-1)* pageSize, (currentPage)* pageSize);
                        System.out.println(studentList+"--------------2");
                        NumberOfElements = studentList.size();
                        request.setAttribute("NumberOfElements", NumberOfElements);
                        request.setAttribute("TotalPages", TotalPages);
                        request.setAttribute("TotalElements", TotalElements);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("studentList", studentList);
                        request.setAttribute("name", name);
                        modelAndView.setViewName("manage/student/studentNameSearchPage");

                    }

                }
            }
        }

        return modelAndView;
    }

    @RequestMapping("SearchBirthday")
    public ModelAndView searchBirthday(){
        String lastBirthday = request.getParameter("lastBirthday");
        String nextBirthday = request.getParameter("nextBirthday");
        System.out.println("------------------->>"+lastBirthday);
        System.out.println("------------------->>"+nextBirthday);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //SimpleDateFormat sdfmat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.US);
        Date lastDate = null;
        Date nextDate = null;
        try {
            lastDate = sdf.parse(lastBirthday);
            nextDate = sdf.parse(nextBirthday);
        System.out.println("-------------44------>>"+lastDate);
        System.out.println("------------------->>"+nextDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<Student> studentList = studentService.findByBirthdayBetween(lastDate,nextDate);
        for (Student student: studentList){
            System.out.println(student);
        }

        Integer currentPage = 0;
        int NumberOfElements = 0;//当前页有几条信息
        int TotalPages = 0;//页数
        int pageSize = 10;//每页总数为10条
        int TotalElements = studentList.size();
        int total = TotalElements % pageSize;
        if (total > 0) {
            TotalPages = TotalElements / pageSize + 1;
        } else {
            TotalPages = TotalElements / pageSize;
        }
        System.out.println("num--"+NumberOfElements+"total"+total+"TotalElements"+TotalElements);
        System.out.println("TotalPages--"+TotalPages);
        if(total == 0){
            if(TotalPages == 0){
                studentList = null;
            }else {
                studentList = studentList.subList((currentPage) * pageSize, pageSize * (currentPage + 1));
            }
        }else{
            if(TotalElements > pageSize){
                studentList = studentList.subList((currentPage) * pageSize, pageSize * (currentPage + 1));
            }else {
                studentList = studentList.subList(currentPage,TotalElements);
            }
        }
        if(studentList.size()!=0){
            for (Student student : studentList) {
                System.out.println(student + "----------------lx----------");
            }
        }
        NumberOfElements = studentList.size();
        request.setAttribute("lastBirthday", lastBirthday);
        request.setAttribute("nextBirthday", nextBirthday);
        request.setAttribute("NumberOfElements", NumberOfElements);
        request.setAttribute("TotalPages", TotalPages);
        request.setAttribute("TotalElements", TotalElements);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("studentList", studentList);

        modelAndView.setViewName("manage/student/studentBirthday");
        return modelAndView;
    }

    @RequestMapping("SearchBirthdayPage")
    public ModelAndView searchBirthdayPage(){
        String lastBirthday = request.getParameter("lastBirthday");
        String nextBirthday = request.getParameter("nextBirthday");
        Integer currentPage = Integer.parseInt(request.getParameter("currentPage"));
        System.out.println(currentPage + "--currentPage--------------lx----------");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //SimpleDateFormat sdfmat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss",Locale.US);
        Date lastDate = null;
        Date nextDate = null;
        try {
            lastDate = sdf.parse(lastBirthday);
            nextDate = sdf.parse(nextBirthday);
            System.out.println("-------------44------>>"+lastDate);
            System.out.println("------------------->>"+nextDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<Student> studentList1 = studentService.findByBirthdayBetween(lastDate,nextDate);
        List<Student> studentList = null;
        int NumberOfElements = 0;//当前页有几条信息
        int TotalPages = 0;//页数
        int pageSize = 10;//每页总数为10条
        int TotalElements = studentList1.size();
        int total = TotalElements % pageSize;
        System.out.println(total+"-<--------total-----------TotalElements---------->----"+TotalElements);
        if (total > 0) {
            TotalPages = TotalElements/pageSize + 1;
        } else {
            TotalPages = TotalElements/pageSize;
        }
        System.out.println("TotalPages---------------"+TotalPages);

        if (total > 0) {
            TotalPages = TotalElements/pageSize + 1;
        } else {
            TotalPages = TotalElements/pageSize;
        }
        System.out.println("TotalPages---------------"+TotalPages);
        for (int j = 1; j <= TotalPages; j++) {
            if (total == 0) {
                if (currentPage <= 0) {
                    currentPage = 0;
                    studentList = studentList1.subList((0) * pageSize, pageSize * (0 + 1));
                    for (Student student : studentList1) {
                        System.out.println(student + "----------------lx----------");
                    }
                    System.out.println("------------------<=0-------------------");
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                    request.setAttribute("lastBirthday", lastBirthday);
                    request.setAttribute("nextBirthday", nextBirthday);
                    modelAndView.setViewName("manage/student/studentBirthdaySearchPage");
                }
                if (currentPage >= TotalPages) {
                    studentList = studentList1.subList((currentPage - 1) * pageSize, TotalElements);
                    currentPage = TotalPages - 1;
                    System.out.println("currentPage=pageCount-1;" + currentPage + "/////" + TotalPages);
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                    request.setAttribute("lastBirthday", lastBirthday);
                    request.setAttribute("nextBirthday", nextBirthday);
                    modelAndView.setViewName("manage/student/studentBirthdaySearchPage");

                }
                if (0 < currentPage && currentPage < TotalPages) {
                    studentList = studentList1.subList((currentPage) * pageSize, pageSize * (currentPage + 1));
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                    request.setAttribute("lastBirthday", lastBirthday);
                    request.setAttribute("nextBirthday", nextBirthday);
                    modelAndView.setViewName("manage/student/studentBirthdaySearchPage");

                }
            }else {
                if(currentPage<=0) {
                    currentPage=0;
                    if((currentPage+1) == TotalPages){
                        studentList = studentList1.subList(currentPage,TotalElements);
                        NumberOfElements = studentList.size();
                        request.setAttribute("NumberOfElements", NumberOfElements);
                        request.setAttribute("TotalPages", TotalPages);
                        request.setAttribute("TotalElements", TotalElements);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("studentList", studentList);
                        request.setAttribute("lastBirthday", lastBirthday);
                        request.setAttribute("nextBirthday", nextBirthday);
                        modelAndView.setViewName("manage/student/studentBirthdaySearchPage");
                    }else {
                        studentList = studentList1.subList((0)* pageSize, pageSize*(0+1));
                        NumberOfElements = studentList.size();
                        request.setAttribute("NumberOfElements", NumberOfElements);
                        request.setAttribute("TotalPages", TotalPages);
                        request.setAttribute("TotalElements", TotalElements);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("studentList", studentList);
                        request.setAttribute("lastBirthday", lastBirthday);
                        request.setAttribute("nextBirthday", nextBirthday);
                        modelAndView.setViewName("manage/student/studentBirthdaySearchPage");
                    }
                }
                if(currentPage>=TotalPages){
                    studentList = studentList1.subList((currentPage-1)* pageSize, TotalElements);
                    currentPage=TotalPages-1;
                    System.out.println("currentPage=pageCount-1;"+currentPage+"/////"+TotalPages);
                    NumberOfElements = studentList.size();
                    request.setAttribute("NumberOfElements", NumberOfElements);
                    request.setAttribute("TotalPages", TotalPages);
                    request.setAttribute("TotalElements", TotalElements);
                    request.setAttribute("currentPage", currentPage);
                    request.setAttribute("studentList", studentList);
                    request.setAttribute("lastBirthday", lastBirthday);
                    request.setAttribute("nextBirthday", nextBirthday);
                    modelAndView.setViewName("manage/student/studentBirthdaySearchPage");
                }
                if(0<currentPage&&currentPage<TotalPages) {
                    if(currentPage == (TotalPages-1)){

                        studentList = studentList1.subList((currentPage)* pageSize,TotalElements);
                        System.out.println(studentList+"--------------2");
                        NumberOfElements = studentList.size();
                        request.setAttribute("NumberOfElements", NumberOfElements);
                        request.setAttribute("TotalPages", TotalPages);
                        request.setAttribute("TotalElements", TotalElements);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("studentList", studentList);
                        request.setAttribute("lastBirthday", lastBirthday);
                        request.setAttribute("nextBirthday", nextBirthday);
                        modelAndView.setViewName("manage/student/studentBirthdaySearchPage");
                    }else{
                        studentList = studentList1.subList((currentPage-1)* pageSize, (currentPage)* pageSize);
                        System.out.println(studentList+"--------------2");
                        NumberOfElements = studentList.size();
                        request.setAttribute("NumberOfElements", NumberOfElements);
                        request.setAttribute("TotalPages", TotalPages);
                        request.setAttribute("TotalElements", TotalElements);
                        request.setAttribute("currentPage", currentPage);
                        request.setAttribute("studentList", studentList);
                        request.setAttribute("lastBirthday", lastBirthday);
                        request.setAttribute("nextBirthday", nextBirthday);
                        modelAndView.setViewName("manage/student/studentBirthdaySearchPage");

                    }

                }
            }
        }
        return  modelAndView;

    }


    @RequestMapping("studentAdd")
    public ModelAndView add(){
        modelAndView.setViewName("manage/student/studentAdd");
        return modelAndView;
    }
    @RequestMapping("/doStudentAdd")
    public ModelAndView doAdd() throws ParseException {
        String name = request.getParameter("name");
        String code = request.getParameter("code");
        String birthday = request.getParameter("birthday");
        Date date = null;
        if(birthday!=null&&birthday!=""){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        date = sdf.parse(birthday);
        }
        System.out.println("----------"+birthday+"llllllllll"+date);
        String gradeName = request.getParameter("grade");
        String sex = (request.getParameter("sex").equals("M")?"男":"女");
        String subjectName = request.getParameter("subject");
        System.out.println(name+code+birthday+sex+gradeName);
        List<Student> studentList = new ArrayList<Student>();
        Student student = new Student();
        student.setCode(code);
        student.setName(name);
        student.setSex(sex);
        student.setBirthday(date);
        Grade grade = new Grade();
        grade.setGradeName(gradeName);
        student.setGrade(grade);
        List<Subject> subjectList =new ArrayList<Subject>();
        Subject subject =new Subject();
        subject.setName(subjectName);
        subjectList.add(subject);
        student.setSubjectList(subjectList);
        studentList.add(student);
        studentService.save(studentList);
        modelAndView=showList();
        return modelAndView;
    }

    @RequestMapping("/studentDel")
    public ModelAndView deleteStudentById(){
        Integer id = Integer.parseInt(request.getParameter("id"));
        studentService.deleteById(id);
        modelAndView = showList();
        return modelAndView;
    }

}
