package com.biz.lesson.dao.student;

import com.biz.lesson.model.student.Subject;
import org.springframework.data.repository.CrudRepository;

/**
 *
 **/
public interface SubjectCrudRepository extends CrudRepository<Subject,Integer> {
}
