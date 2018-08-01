package com.biz.lesson.dao.student;

import com.biz.lesson.model.student.Student;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 **/
public interface StudentJpaRepository extends JpaRepository<Student,Integer> {
}
