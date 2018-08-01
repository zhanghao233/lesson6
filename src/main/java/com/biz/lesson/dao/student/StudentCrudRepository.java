package com.biz.lesson.dao.student;

import com.biz.lesson.model.student.Student;
import org.springframework.data.repository.CrudRepository;

/**
 *
 **/
public interface StudentCrudRepository extends CrudRepository<Student,Integer> {
}
