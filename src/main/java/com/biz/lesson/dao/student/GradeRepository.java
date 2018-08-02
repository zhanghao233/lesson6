package com.biz.lesson.dao.student;

import com.biz.lesson.model.student.Grade;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;

import java.math.BigInteger;
import java.util.List;

/**
 *
 **/
public interface GradeRepository extends Repository<Grade,Integer> {


    @Query("select g.gradeName from Grade g group by g.gradeName")
    public List<String> findAllname();

    @Query(nativeQuery = true,value = "SELECT COUNT( gradename ) FROM `grade` GROUP BY gradename HAVING COUNT( gradename )>=0")
    public List<BigInteger>findNumByGradeName();
}
