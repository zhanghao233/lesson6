package com.biz.lesson.dao.student;

import com.biz.lesson.model.student.Student;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;

/**
 *
 **/
public interface StudentRepository extends Repository<Student,Integer> {




    public  Student findByName(String name);

    public List<Student> findByCodeStartingWith(String code);

    public List<Student> findByBirthdayBetween(Date lastBirthday,Date nextBirthday);


    @Query("select s from Student s where s.id=(select max(id) from Student) ")
    public  Student getStudentById();

    @Query("select e from Student e where e.name=?1 and e.id=?2")
    public  List<Student> queryParamsl(String name,Integer id);

    @Query("select e from Student e where e.name=:name and e.id=:id")
    public  List<Student> queryParams2(@Param("name") String name, @Param("id") Integer id);


    @Query("select e from Student e where e.name like %?1% ")
    public  List<Student> queryLike1(String name);

    @Query("select e from Student e where e.name like %:userName% ")
    public  List<Student> queryLike2(@Param("userName") String name);

    //employee为表
    @Query(nativeQuery = true,value = "select count(1) from student")
    public  long getCount();

    @Modifying
    @Query("update Student set name = :name where id = :id")
    public void update(@Param("id") Integer id,@Param("name") String name);

    @Modifying
    @Query("update Student set name = ?2 where id = ?1")
    public void update1(Integer id,String name);

    @Modifying
    @Query("delete  from Student where id = :id")
    public void  deleteById(@Param("id") Integer id);

    @Modifying
    @Query("delete  from Student where id = ?1")
    public void  deleteById1(Integer id);
}

