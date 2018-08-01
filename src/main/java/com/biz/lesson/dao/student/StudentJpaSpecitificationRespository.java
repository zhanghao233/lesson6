package com.biz.lesson.dao.student;

import com.biz.lesson.model.student.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

/**
 *
 **/
public interface StudentJpaSpecitificationRespository extends JpaRepository<Student,Integer>,JpaSpecificationExecutor<Student> {
}
