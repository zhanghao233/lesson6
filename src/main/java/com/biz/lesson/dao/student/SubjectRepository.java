package com.biz.lesson.dao.student;

import com.biz.lesson.model.student.Subject;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;

import java.math.BigInteger;
import java.util.List;

/**
 *
 **/
public interface SubjectRepository extends Repository<Subject,Integer> {
    @Query("select s.name from Subject s group by s.name")
    public List<String> findAllname();

    @Query(nativeQuery = true,value = "SELECT COUNT( name ) FROM `subject` GROUP BY name HAVING COUNT( name )>=0")
    public List<BigInteger>findNumByName();
}
