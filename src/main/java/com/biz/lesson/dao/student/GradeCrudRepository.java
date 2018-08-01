package com.biz.lesson.dao.student;

import com.biz.lesson.model.student.Grade;
import org.springframework.data.repository.CrudRepository;

/**
 *
 **/
public interface GradeCrudRepository extends CrudRepository<Grade,Integer> {
}
