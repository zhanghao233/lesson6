package com.biz.lesson.model;

import com.biz.lesson.dao.student.StudentJpaSpecitificationRespository;
import com.biz.lesson.model.student.Student;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;

import javax.persistence.criteria.*;

/**
 *
 **/
public class StudentTest {

    private ApplicationContext applicationContext = null;
    private StudentJpaSpecitificationRespository studentJpaSpecitificationRespository = null;

    @Before
    public void  setup(){
        System.out.println("setup");
        applicationContext = new ClassPathXmlApplicationContext("classpath:application-content.xml");
        studentJpaSpecitificationRespository = applicationContext.getBean(StudentJpaSpecitificationRespository.class);
    }

    @After
    public  void  tearDown(){
        applicationContext = null;
        System.out.println("teardown");
    }

    @Test
    public void testPageAndSortAndQuery(){
        Sort.Order order = new Sort.Order(Sort.Direction.DESC,"id");
        Sort sort = new Sort(order);
        Pageable pageable = new PageRequest(0,6 ,sort );

        /*
         * root:就是我们要查询的类型（Employee）
         * criteriaQuery：添加查询条件：年龄大于74的employee
         * criteriaBuilder：构件Predicate
         * */
        Specification<Student> specification = new Specification<Student>() {
            @Override
            public Predicate toPredicate(Root<Student> root,
                                         CriteriaQuery<?> criteriaQuery,
                                         CriteriaBuilder criteriaBuilder) {
                Path path = root.get("id");
                return criteriaBuilder.gt(path,0);
            }
        };

        Page<Student> page = studentJpaSpecitificationRespository.findAll(specification,pageable);

        System.out.println("getTotalElements--查询的总记录数:"+page.getTotalElements());
        System.out.println("getTotalPages--查询的总页数:"+page.getTotalPages());
        System.out.println("getContent--当前页面的集合："+page.getContent());
        System.out.println("getNumber--当前第几页:"+page.getNumber() + 1);
        System.out.println("getNumberOfElements--查询的当前页面的记录数:"+page.getNumberOfElements());

    }


}
