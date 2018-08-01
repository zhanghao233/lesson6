package com.biz.lesson.dao.student;

import com.biz.lesson.model.student.Grade;
import org.springframework.data.repository.Repository;

/**
 *
 **/
public interface GradeRepository extends Repository<Grade,Integer> {

    public Grade findBygradeName(String gradeName);
}
